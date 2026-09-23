import { createHash } from "node:crypto";
import { readFile } from "node:fs/promises";

/** Common reported PS2 BIOS dump sizes in bytes. */
export const COMMON_BIOS_SIZES = Object.freeze([
  2 * 1024 * 1024,
  4 * 1024 * 1024,
  8 * 1024 * 1024,
  16 * 1024 * 1024,
]);

export function formatFileSize(bytes) {
  if (bytes < 1024) return `${bytes} B`;
  const kib = bytes / 1024;
  if (kib < 1024) return `${kib.toFixed(2)} KB`;
  return `${(kib / 1024).toFixed(2)} MB`;
}

export function validateBiosSize(sizeBytes) {
  if (sizeBytes <= 0) {
    return {
      ok: false,
      summary: "File is empty",
      detail: "An empty file cannot be used as a BIOS image. Basic check only.",
    };
  }
  if (COMMON_BIOS_SIZES.includes(sizeBytes)) {
    return {
      ok: true,
      summary: "Basic checks passed",
      detail:
        "Size matches a commonly reported PS2 BIOS dump size. Not proof of authenticity.",
    };
  }
  return {
    ok: false,
    summary: "File size does not match common BIOS sizes",
    detail:
      "Common sizes are 2, 4, 8, or 16 MiB. Unexpected size may mean incomplete or non-BIOS data.",
  };
}

export function hashBuffer(buffer) {
  const bytes = Buffer.isBuffer(buffer) ? buffer : Buffer.from(buffer);
  return {
    sizeBytes: bytes.length,
    md5: createHash("md5").update(bytes).digest("hex"),
    sha1: createHash("sha1").update(bytes).digest("hex"),
    validation: validateBiosSize(bytes.length),
  };
}

export async function hashFile(path) {
  const buffer = await readFile(path);
  return { filePath: path, ...hashBuffer(buffer) };
}
