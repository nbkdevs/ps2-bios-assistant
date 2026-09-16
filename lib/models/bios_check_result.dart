enum BiosValidationKind {
  empty,
  sizeUnexpected,
  sizeMatchesCommon,
}

class BiosValidation {
  const BiosValidation({
    required this.kind,
    required this.summary,
    required this.detail,
  });

  final BiosValidationKind kind;
  final String summary;
  final String detail;

  bool get passedBasicChecks => kind == BiosValidationKind.sizeMatchesCommon;
}

class BiosCheckResult {
  const BiosCheckResult({
    required this.fileName,
    required this.sizeBytes,
    required this.md5,
    required this.sha1,
    required this.validation,
  });

  final String fileName;
  final int sizeBytes;
  final String md5;
  final String sha1;
  final BiosValidation validation;
}
