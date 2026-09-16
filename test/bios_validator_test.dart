import 'package:flutter_test/flutter_test.dart';
import 'package:ps2_bios_assistant/models/bios_check_result.dart';
import 'package:ps2_bios_assistant/services/bios_validator.dart';

void main() {
  const validator = BiosValidator();

  test('empty files fail the basic check', () {
    final result = validator.validate(sizeBytes: 0);
    expect(result.kind, BiosValidationKind.empty);
    expect(result.passedBasicChecks, isFalse);
    expect(result.summary, 'File is empty');
  });

  test('negative sizes are treated as empty', () {
    final result = validator.validate(sizeBytes: -1);
    expect(result.kind, BiosValidationKind.empty);
    expect(result.passedBasicChecks, isFalse);
  });

  test('common 4 MiB size passes the basic size check', () {
    final result = validator.validate(sizeBytes: 4 * 1024 * 1024);
    expect(result.kind, BiosValidationKind.sizeMatchesCommon);
    expect(result.passedBasicChecks, isTrue);
    expect(result.summary, 'Basic checks passed');
  });

  test('other common dump sizes also pass', () {
    for (final size in const [2, 8, 16]) {
      final result = validator.validate(sizeBytes: size * 1024 * 1024);
      expect(result.passedBasicChecks, isTrue, reason: '$size MiB');
    }
  });

  test('unexpected sizes do not claim a valid BIOS', () {
    final result = validator.validate(sizeBytes: 12345);
    expect(result.kind, BiosValidationKind.sizeUnexpected);
    expect(result.passedBasicChecks, isFalse);
    expect(result.summary, 'File size does not match common BIOS sizes');
  });

  test('formatFileSize reports MB for BIOS-sized files', () {
    expect(formatFileSize(4 * 1024 * 1024), '4.00 MB');
    expect(formatFileSize(0), '0 B');
    expect(formatFileSize(512), '512 B');
  });
}
