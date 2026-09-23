/// Local PS2 BIOS checksum and basic size-check helpers.
library ps2_bios_checksum;

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

/// Common reported PS2 BIOS dump sizes in bytes.
const Set<int> commonBiosSizes = {
  2 * 1024 * 1024,
  4 * 1024 * 1024,
  8 * 1024 * 1024,
  16 * 1024 * 1024,
};

class BiosValidation {
  const BiosValidation({
    required this.ok,
    required this.summary,
    required this.detail,
  });

  final bool ok;
  final String summary;
  final String detail;
}

class BiosChecksumResult {
  const BiosChecksumResult({
    required this.sizeBytes,
    required this.md5,
    required this.sha1,
    required this.validation,
    this.path,
  });

  final int sizeBytes;
  final String md5;
  final String sha1;
  final BiosValidation validation;
  final String? path;
}

String formatFileSize(int bytes) {
  if (bytes < 1024) return '$bytes B';
  final kib = bytes / 1024;
  if (kib < 1024) return '${kib.toStringAsFixed(2)} KB';
  return '${(kib / 1024).toStringAsFixed(2)} MB';
}

BiosValidation validateBiosSize(int sizeBytes) {
  if (sizeBytes <= 0) {
    return const BiosValidation(
      ok: false,
      summary: 'File is empty',
      detail: 'An empty file cannot be used as a BIOS image. Basic check only.',
    );
  }
  if (commonBiosSizes.contains(sizeBytes)) {
    return const BiosValidation(
      ok: true,
      summary: 'Basic checks passed',
      detail:
          'Size matches a commonly reported PS2 BIOS dump size. Not proof of authenticity.',
    );
  }
  return const BiosValidation(
    ok: false,
    summary: 'File size does not match common BIOS sizes',
    detail:
        'Common sizes are 2, 4, 8, or 16 MiB. Unexpected size may mean incomplete or non-BIOS data.',
  );
}

BiosChecksumResult hashBytes(List<int> bytes, {String? path}) {
  final data = bytes is Uint8List ? bytes : Uint8List.fromList(bytes);
  return BiosChecksumResult(
    sizeBytes: data.length,
    md5: md5.convert(data).toString(),
    sha1: sha1.convert(data).toString(),
    validation: validateBiosSize(data.length),
    path: path,
  );
}

Future<BiosChecksumResult> hashFile(String path) async {
  final bytes = await File(path).readAsBytes();
  return hashBytes(bytes, path: path);
}

BiosChecksumResult hashString(String value) =>
    hashBytes(utf8.encode(value));
