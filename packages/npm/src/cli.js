#!/usr/bin/env node
import { hashFile, formatFileSize } from "./index.js";

async function main() {
  const file = process.argv[2];
  if (!file) {
    console.error("Usage: ps2-bios-checksum <file>");
    process.exit(1);
  }
  const result = await hashFile(file);
  console.log(`File:   ${result.filePath}`);
  console.log(`Size:   ${formatFileSize(result.sizeBytes)}`);
  console.log(`MD5:    ${result.md5}`);
  console.log(`SHA-1:  ${result.sha1}`);
  console.log(`Status: ${result.validation.summary}`);
}

main().catch((err) => {
  console.error(err.message || String(err));
  process.exit(1);
});
