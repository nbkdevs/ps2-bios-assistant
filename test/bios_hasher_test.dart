import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ps2_bios_assistant/services/bios_hasher.dart';

void main() {
  const hasher = BiosHasher();

  test('MD5 of empty input matches the public test vector', () {
    expect(
      hasher.hashBytes(<int>[]).md5Hex,
      'd41d8cd98f00b204e9800998ecf8427e',
    );
  });

  test('SHA-1 of empty input matches the public test vector', () {
    expect(
      hasher.hashBytes(<int>[]).sha1Hex,
      'da39a3ee5e6b4b0d3255bfef95601890afd80709',
    );
  });

  test('MD5 of abc matches the public test vector', () {
    expect(
      hasher.hashBytes(utf8.encode('abc')).md5Hex,
      '900150983cd24fb0d6963f7d28e17f72',
    );
  });

  test('SHA-1 of abc matches the public test vector', () {
    expect(
      hasher.hashBytes(utf8.encode('abc')).sha1Hex,
      'a9993e364706816aba3e25717850c26c9cd0d89d',
    );
  });

  test('file size is the byte length of the input', () {
    expect(hasher.hashBytes(List<int>.filled(4096, 1)).sizeBytes, 4096);
  });

  test('streaming hashes match in-memory hashes', () async {
    final bytes = List<int>.generate(8000, (i) => i % 256);
    final fromBytes = hasher.hashBytes(bytes);
    final fromStream = await hasher.hashStream(
      Stream<List<int>>.fromIterable([
        bytes.sublist(0, 1000),
        bytes.sublist(1000, 4500),
        bytes.sublist(4500),
      ]),
    );

    expect(fromStream.md5Hex, fromBytes.md5Hex);
    expect(fromStream.sha1Hex, fromBytes.sha1Hex);
    expect(fromStream.sizeBytes, bytes.length);
  });
}
