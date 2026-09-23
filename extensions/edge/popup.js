(function () {
  const COMMON_SIZES = new Set([
    2 * 1024 * 1024,
    4 * 1024 * 1024,
    8 * 1024 * 1024,
    16 * 1024 * 1024,
  ]);
  const CHUNK = 1024 * 1024;

  const dropzone = document.getElementById("dropzone");
  const fileInput = document.getElementById("fileInput");
  const pickBtn = document.getElementById("pickBtn");
  const clearBtn = document.getElementById("clearBtn");
  const progress = document.getElementById("progress");
  const barFill = document.getElementById("barFill");
  const errorEl = document.getElementById("error");
  const results = document.getElementById("results");
  const expectedHash = document.getElementById("expectedHash");
  const compareOut = document.getElementById("compareOut");

  let lastResult = null;
  let busy = false;

  function formatSize(bytes) {
    if (bytes < 1024) return bytes + " B";
    const kib = bytes / 1024;
    if (kib < 1024) return kib.toFixed(2) + " KB";
    return (kib / 1024).toFixed(2) + " MB";
  }

  function hexFromBuffer(buffer) {
    return Array.from(new Uint8Array(buffer))
      .map(function (b) { return b.toString(16).padStart(2, "0"); })
      .join("");
  }

  function validateSize(sizeBytes) {
    if (sizeBytes <= 0) {
      return {
        kind: "err",
        summary: "File is empty",
        detail: "An empty file cannot be used as a BIOS image. This is a basic check only.",
      };
    }
    if (COMMON_SIZES.has(sizeBytes)) {
      return {
        kind: "ok",
        summary: "Basic checks passed",
        detail:
          "The file size matches a commonly reported PS2 BIOS dump size. This is not proof the file is authentic or complete.",
      };
    }
    return {
      kind: "warn",
      summary: "File size does not match common BIOS sizes",
      detail:
        "Common reported sizes are 2, 4, 8, or 16 MiB. An unexpected size may mean the file is incomplete, compressed, or not a BIOS dump.",
    };
  }

  function showError(message) {
    errorEl.textContent = message;
    errorEl.classList.add("visible");
  }

  function clearError() {
    errorEl.textContent = "";
    errorEl.classList.remove("visible");
  }

  function setBusy(isBusy, ratio) {
    busy = isBusy;
    pickBtn.disabled = isBusy;
    clearBtn.disabled = isBusy;
    progress.classList.toggle("visible", isBusy);
    if (typeof ratio === "number") {
      barFill.style.width = Math.max(0, Math.min(100, ratio * 100)).toFixed(1) + "%";
    }
    if (!isBusy) barFill.style.width = "0%";
  }

  function normalizeHash(value) {
    return String(value || "").trim().toLowerCase().replace(/[^a-f0-9]/g, "");
  }

  function updateCompare() {
    if (!lastResult) {
      compareOut.textContent = "";
      return;
    }
    var expected = normalizeHash(expectedHash.value);
    if (!expected) {
      compareOut.textContent = "";
      return;
    }
    if (expected === lastResult.md5) {
      compareOut.innerHTML = '<span class="status-ok">Matches MD5</span>';
      return;
    }
    if (expected === lastResult.sha1) {
      compareOut.innerHTML = '<span class="status-ok">Matches SHA-1</span>';
      return;
    }
    compareOut.innerHTML =
      '<span class="status-err">No match</span> <span class="note">Does not match this file’s MD5 or SHA-1.</span>';
  }

  function renderResult(result) {
    lastResult = result;
    document.getElementById("fileName").textContent = result.fileName;
    document.getElementById("fileSize").textContent = formatSize(result.sizeBytes);
    document.getElementById("md5").textContent = result.md5;
    document.getElementById("sha1").textContent = result.sha1;

    var status = document.getElementById("status");
    var detail = document.getElementById("statusDetail");
    status.textContent = result.validation.summary;
    status.className = "value plain status-" + result.validation.kind;
    detail.textContent = result.validation.detail;

    results.classList.add("visible");
    updateCompare();
  }

  async function hashFile(file) {
    var md5 = new Md5Hasher();
    var size = file.size;
    var offset = 0;
    var parts = [];

    while (offset < size) {
      var end = Math.min(offset + CHUNK, size);
      var blob = file.slice(offset, end);
      var buf = await blob.arrayBuffer();
      var bytes = new Uint8Array(buf);
      md5.update(bytes);
      parts.push(bytes);
      offset = end;
      setBusy(true, offset / Math.max(size, 1));
    }

    var total = new Uint8Array(size);
    var pos = 0;
    for (var i = 0; i < parts.length; i++) {
      total.set(parts[i], pos);
      pos += parts[i].length;
    }

    if (!(window.crypto && crypto.subtle)) {
      throw new Error("SHA-1 is not available in this browser.");
    }

    var digest = await crypto.subtle.digest("SHA-1", total);

    return {
      fileName: file.name || "selected file",
      sizeBytes: size,
      md5: md5.digest(),
      sha1: hexFromBuffer(digest),
      validation: validateSize(size),
    };
  }

  async function processFile(file) {
    if (!file || busy) return;
    clearError();
    results.classList.remove("visible");
    lastResult = null;
    compareOut.textContent = "";

    if (file.size > 64 * 1024 * 1024) {
      showError("This file is larger than 64 MB. Choose a BIOS dump instead.");
      return;
    }

    setBusy(true, 0);
    try {
      var result = await hashFile(file);
      renderResult(result);
    } catch (err) {
      showError("Couldn't process this file. Please select the file again.");
    } finally {
      setBusy(false);
    }
  }

  function openPicker() {
    fileInput.click();
  }

  pickBtn.addEventListener("click", openPicker);
  dropzone.addEventListener("click", openPicker);
  dropzone.addEventListener("keydown", function (e) {
    if (e.key === "Enter" || e.key === " ") {
      e.preventDefault();
      openPicker();
    }
  });

  fileInput.addEventListener("change", function () {
    var file = fileInput.files && fileInput.files[0];
    if (file) processFile(file);
    fileInput.value = "";
  });

  ["dragenter", "dragover"].forEach(function (evt) {
    dropzone.addEventListener(evt, function (e) {
      e.preventDefault();
      e.stopPropagation();
      dropzone.classList.add("dragover");
    });
  });

  ["dragleave", "drop"].forEach(function (evt) {
    dropzone.addEventListener(evt, function (e) {
      e.preventDefault();
      e.stopPropagation();
      dropzone.classList.remove("dragover");
    });
  });

  dropzone.addEventListener("drop", function (e) {
    var file = e.dataTransfer && e.dataTransfer.files && e.dataTransfer.files[0];
    if (file) processFile(file);
  });

  clearBtn.addEventListener("click", function () {
    if (busy) return;
    lastResult = null;
    results.classList.remove("visible");
    clearError();
    expectedHash.value = "";
    compareOut.textContent = "";
  });

  expectedHash.addEventListener("input", updateCompare);

  document.querySelectorAll("[data-copy]").forEach(function (btn) {
    btn.addEventListener("click", async function () {
      if (!lastResult) return;
      var key = btn.getAttribute("data-copy");
      var text = lastResult[key];
      try {
        await navigator.clipboard.writeText(text);
        var old = btn.textContent;
        btn.textContent = "Copied";
        setTimeout(function () { btn.textContent = old; }, 900);
      } catch (_) {
        showError("Couldn't copy to the clipboard.");
      }
    });
  });
})();
