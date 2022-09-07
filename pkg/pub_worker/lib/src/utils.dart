import 'dart:typed_data' show Uint8List, BytesBuilder;

/// Convert chunked [stream] to [Uint8List].
Future<Uint8List> streamToBuffer(Stream<List<int>> stream) async {
  final b = BytesBuilder();
  await for (final chunk in stream) {
    b.add(chunk);
  }
  return b.takeBytes();
}

/// Remove trailing slashes from [u].
String stripTrailingSlashes(String u) {
  while (u.endsWith('/')) {
    u = u.substring(0, u.length - 1);
  }
  return u;
}
