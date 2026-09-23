import test from "node:test";
import assert from "node:assert/strict";
import { hashBuffer, validateBiosSize, formatFileSize } from "../src/index.js";

test("md5 and sha1 of empty buffer", () => {
  const result = hashBuffer(Buffer.alloc(0));
  assert.equal(result.md5, "d41d8cd98f00b204e9800998ecf8427e");
  assert.equal(result.sha1, "da39a3ee5e6b4b0d3255bfef95601890afd80709");
  assert.equal(result.validation.ok, false);
});

test("common 4 MiB size passes basic check", () => {
  const result = validateBiosSize(4 * 1024 * 1024);
  assert.equal(result.ok, true);
});

test("formatFileSize", () => {
  assert.equal(formatFileSize(4 * 1024 * 1024), "4.00 MB");
});
