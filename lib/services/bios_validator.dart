import '../models/bios_check_result.dart';

/// Conservative size checks only. Matching a common size is not proof of
/// authenticity, origin, or that a file is a complete BIOS image.
class BiosValidator {
  const BiosValidator();

  /// Common reported sizes for PlayStation 2 BIOS dumps, in bytes.
  static const Set<int> commonBiosSizes = {
    2 * 1024 * 1024,
    4 * 1024 * 1024,
    8 * 1024 * 1024,
    16 * 1024 * 1024,
  };

  BiosValidation validate({required int sizeBytes}) {
    if (sizeBytes <= 0) {
      return const BiosValidation(
        kind: BiosValidationKind.empty,
        summary: 'File is empty',
        detail:
            'This is a basic check only. An empty file cannot be used as a BIOS image.',
      );
    }

    if (commonBiosSizes.contains(sizeBytes)) {
      return const BiosValidation(
        kind: BiosValidationKind.sizeMatchesCommon,
        summary: 'Basic checks passed',
        detail:
            'The file size matches a commonly reported PS2 BIOS dump size. '
            'This is not proof that the file is authentic, complete, or suitable for any emulator.',
      );
    }

    return BiosValidation(
      kind: BiosValidationKind.sizeUnexpected,
      summary: 'File size does not match common BIOS sizes',
      detail:
          'Common reported sizes are 2, 4, 8, or 16 MiB. This file is '
          '${_describeSize(sizeBytes)}. An unexpected size may mean the file is '
          'incomplete, compressed, or not a BIOS dump. This check cannot confirm authenticity.',
    );
  }

  static String _describeSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes bytes';
    }
    final kib = bytes / 1024;
    if (kib < 1024) {
      return '${kib.toStringAsFixed(2)} KB ($bytes bytes)';
    }
    final mib = kib / 1024;
    return '${mib.toStringAsFixed(2)} MB ($bytes bytes)';
  }
}

String formatFileSize(int bytes) {
  if (bytes < 1024) {
    return '$bytes B';
  }
  final kib = bytes / 1024;
  if (kib < 1024) {
    return '${kib.toStringAsFixed(2)} KB';
  }
  final mib = kib / 1024;
  if (mib < 1024) {
    return '${mib.toStringAsFixed(2)} MB';
  }
  return '${(mib / 1024).toStringAsFixed(2)} GB';
}
