import 'dart:async';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

class FileHashes {
  const FileHashes({
    required this.md5Hex,
    required this.sha1Hex,
    required this.sizeBytes,
  });

  final String md5Hex;
  final String sha1Hex;
  final int sizeBytes;
}

class BiosHasher {
  const BiosHasher();

  FileHashes hashBytes(List<int> bytes) {
    return FileHashes(
      md5Hex: md5.convert(bytes).toString(),
      sha1Hex: sha1.convert(bytes).toString(),
      sizeBytes: bytes.length,
    );
  }

  Future<FileHashes> hashStream(Stream<List<int>> stream) async {
    final md5Out = AccumulatorSink<Digest>();
    final sha1Out = AccumulatorSink<Digest>();
    final md5In = md5.startChunkedConversion(md5Out);
    final sha1In = sha1.startChunkedConversion(sha1Out);
    var size = 0;

    try {
      await for (final chunk in stream) {
        if (chunk.isEmpty) {
          continue;
        }
        size += chunk.length;
        md5In.add(chunk);
        sha1In.add(chunk);
      }
    } catch (_) {
      md5In.close();
      sha1In.close();
      rethrow;
    }

    md5In.close();
    sha1In.close();

    return FileHashes(
      md5Hex: md5Out.events.single.toString(),
      sha1Hex: sha1Out.events.single.toString(),
      sizeBytes: size,
    );
  }
}
