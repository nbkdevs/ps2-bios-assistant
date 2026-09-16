import 'dart:io';

import 'package:file_picker/file_picker.dart';

class SelectedBiosFile {
  const SelectedBiosFile({
    required this.fileName,
    required this.openStream,
  });

  final String fileName;
  final Stream<List<int>> Function() openStream;
}

class BiosFilePicker {
  const BiosFilePicker();

  /// Returns null when the user cancels the system picker.
  Future<SelectedBiosFile?> pick() async {
    final result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Select a BIOS file',
      type: FileType.any,
      allowMultiple: false,
      withData: false,
      withReadStream: true,
    );

    if (result == null || result.files.isEmpty) {
      return null;
    }

    final file = result.files.single;
    final name = file.name.trim().isEmpty ? 'selected file' : file.name;

    final stream = file.readStream;
    if (stream != null) {
      return SelectedBiosFile(
        fileName: name,
        openStream: () => stream,
      );
    }

    final path = file.path;
    if (path != null && path.isNotEmpty) {
      return SelectedBiosFile(
        fileName: name,
        openStream: () => File(path).openRead(),
      );
    }

    throw const FileAccessException();
  }
}

class FileAccessException implements Exception {
  const FileAccessException();
}
