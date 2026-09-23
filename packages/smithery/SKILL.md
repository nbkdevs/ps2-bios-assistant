---
name: ps2-bios-checksum
description: Hash a local PS2 BIOS dump (MD5/SHA-1) and run basic dump-size checks. Does not provide BIOS files.
license: MIT
metadata:
  homepage: https://allps2bios.com/ps2-bios-retroarch/
  author: AllPS2BIOS
---

# PS2 BIOS Checksum

## Purpose

Help agents and developers inspect a **local** PlayStation 2 BIOS dump. Calculate MD5 and SHA-1, format size, and compare against common dump sizes (2 / 4 / 8 / 16 MiB).

This skill does **not** download, host, or distribute BIOS files. Matching a size or checksum is a reference check only — not proof a file is authentic or legal.

## When to use

- User has a BIOS file path and wants checksums
- User wants to know if a file size looks like a common PS2 BIOS dump
- User is configuring RetroArch / PS2 emulator BIOS paths and needs verification helpers

## Inputs

- `path` (required): absolute or workspace-relative path to a local file
- Optional expected MD5 or SHA-1 string for comparison

## Procedure

1. Confirm the file exists and is readable.
2. Read the file locally (prefer streaming for large files; reject > 64 MiB unless the user insists).
3. Compute MD5 and SHA-1 hex digests.
4. Report size with a human-readable unit.
5. If size is 2, 4, 8, or 16 MiB, say **Basic checks passed**; otherwise report that size is unexpected.
6. If an expected hash was provided, compare case-insensitively after stripping non-hex characters.
7. Remind the user that results are on-device reference checks only.

## Outputs

- file name / path
- size
- MD5
- SHA-1
- status summary
- optional compare result

## Restrictions

- Do not fetch BIOS files from the internet.
- Do not claim a dump is official, genuine, or legal based on checksum alone.
- Do not provide Switch/Eden prod.keys or circumvention guidance.

## Reference

RetroArch PS2 BIOS notes: https://allps2bios.com/ps2-bios-retroarch/
