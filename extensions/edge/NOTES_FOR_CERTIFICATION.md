# Edge Add-ons — Notes for Certification (paste this)

Use this in **Submission Options → Notes for Certification** when resubmitting after policy **1.3 Product is Testable**.

---

## Primary purpose

PS2 BIOS Checker is a local file utility. Its only job is to let a user select a PlayStation 2 BIOS dump (or any local file) from their computer and calculate:

1. File name
2. File size
3. MD5 checksum
4. SHA-1 checksum
5. A basic size status (whether the size matches common BIOS dump sizes: 2 / 4 / 8 / 16 MiB)

Optionally, the user can paste an expected MD5 or SHA-1 to compare against the calculated hashes.

The extension does **not** browse websites, inject scripts into pages, download BIOS files, or upload user files. It declares **no permissions** and **no host permissions**.

## Exact test steps for reviewers

1. Install the extension in Microsoft Edge.
2. Pin it if needed, then click the **PS2 BIOS Checker** toolbar icon to open the popup.
3. In the popup, click **Select BIOS File**.
4. In the system file picker, choose **any local file** on the review machine:
   - Prefer a small file (for example a text file of a few KB), **or**
   - A `.bin` BIOS dump if available.
   - A real PS2 BIOS file is **not required** to verify core functionality.
5. Confirm the popup shows a progress state, then results:
   - BIOS File (file name)
   - File Size
   - MD5 (32 hex characters)
   - SHA-1 (40 hex characters)
   - Status text (basic size check)
6. Click **Copy** next to MD5 or SHA-1 and confirm the value copies.
7. Paste the same MD5 into **Compare with an expected MD5 or SHA-1** and confirm it shows **Matches MD5**.
8. Change one character in the compare field and confirm it shows **No match**.
9. Click **Clear** and confirm results are removed.
10. Confirm no website navigation or permissions prompts are required for the above steps.

## Expected results

- Hashing completes in the popup without network access.
- No account, login, or site access is required.
- Footer link to allps2bios.com is optional reading only; it is not required for the primary feature.

## Permissions

None. `permissions` is an empty array. No host permissions. No background service worker.

## Notes

This extension does not distribute BIOS files. Size/hash results are on-device reference checks only.
