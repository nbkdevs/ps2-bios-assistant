import 'package:flutter_test/flutter_test.dart';
import 'package:ps2_bios_assistant/models/bios_check_result.dart';
import 'package:ps2_bios_assistant/services/bios_checker_service.dart';
import 'package:ps2_bios_assistant/services/bios_file_picker.dart';

class _FakePicker extends BiosFilePicker {
  const _FakePicker({this.selected, this.throwAccess = false});

  final SelectedBiosFile? selected;
  final bool throwAccess;

  @override
  Future<SelectedBiosFile?> pick() async {
    if (throwAccess) {
      throw const FileAccessException();
    }
    return selected;
  }
}

void main() {
  test('canceling the picker returns null', () async {
    final service = BiosCheckerService(picker: const _FakePicker());
    expect(await service.checkSelectedFile(), isNull);
  });

  test('inaccessible files surface a friendly error', () async {
    final service = BiosCheckerService(
      picker: const _FakePicker(throwAccess: true),
    );
    expect(
      () => service.checkSelectedFile(),
      throwsA(
        isA<BiosCheckException>().having(
          (error) => error.userMessage,
          'userMessage',
          "Couldn't read this file. Please select the file again.",
        ),
      ),
    );
  });

  test('hashes a selected stream and applies basic validation', () async {
    final payload = List<int>.filled(4 * 1024 * 1024, 7);
    final service = BiosCheckerService(
      picker: _FakePicker(
        selected: SelectedBiosFile(
          fileName: 'dump.bin',
          openStream: () => Stream<List<int>>.fromIterable([payload]),
        ),
      ),
    );

    final result = await service.checkSelectedFile();
    expect(result, isNotNull);
    expect(result!.fileName, 'dump.bin');
    expect(result.sizeBytes, payload.length);
    expect(result.md5.length, 32);
    expect(result.sha1.length, 40);
    expect(result.validation.kind, BiosValidationKind.sizeMatchesCommon);
  });
}
