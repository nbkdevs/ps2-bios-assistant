import 'dart:io';

import '../models/bios_check_result.dart';
import 'bios_file_picker.dart';
import 'bios_hasher.dart';
import 'bios_validator.dart';

class BiosCheckException implements Exception {
  const BiosCheckException(this.userMessage);

  final String userMessage;
}

class BiosCheckerService {
  BiosCheckerService({
    BiosFilePicker picker = const BiosFilePicker(),
    BiosHasher hasher = const BiosHasher(),
    BiosValidator validator = const BiosValidator(),
  })  : _picker = picker,
        _hasher = hasher,
        _validator = validator;

  final BiosFilePicker _picker;
  final BiosHasher _hasher;
  final BiosValidator _validator;

  Future<BiosCheckResult?> checkSelectedFile() async {
    SelectedBiosFile selected;
    try {
      final picked = await _picker.pick();
      if (picked == null) {
        return null;
      }
      selected = picked;
    } on FileAccessException {
      throw const BiosCheckException(
        "Couldn't read this file. Please select the file again.",
      );
    } catch (_) {
      throw const BiosCheckException(
        "Couldn't open the file picker. Please try again.",
      );
    }

    try {
      final hashes = await _hasher.hashStream(selected.openStream());
      final validation = _validator.validate(sizeBytes: hashes.sizeBytes);
      return BiosCheckResult(
        fileName: selected.fileName,
        sizeBytes: hashes.sizeBytes,
        md5: hashes.md5Hex,
        sha1: hashes.sha1Hex,
        validation: validation,
      );
    } on PathNotFoundException {
      throw const BiosCheckException(
        "Couldn't find this file. Please select the file again.",
      );
    } on FileSystemException {
      throw const BiosCheckException(
        "Couldn't read this file. It may have been moved, or the app may not have access to it.",
      );
    } catch (_) {
      throw const BiosCheckException(
        "Couldn't process this file. Please select the file again.",
      );
    }
  }
}
