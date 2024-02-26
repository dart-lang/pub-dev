import 'dart:typed_data' show Uint8List, BytesBuilder;

import 'package:pub_semver/pub_semver.dart';

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

bool needsNewerSdk({
  required Version? sdkVersion,
  required VersionConstraint? constraint,
}) {
  return sdkVersion != null &&
      constraint != null &&
      constraint.intersect(sdkVersion).isEmpty;
}
