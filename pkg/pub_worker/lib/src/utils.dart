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

bool sdkMatchesConstraint({
  required Version? sdkVersion,
  required VersionConstraint? constraint,
}) {
  // SDK version is missing
  if (sdkVersion == null) {
    return true;
  }
  // any SDK will do
  if (constraint == null) {
    return true;
  }
  // SDK matches constraint
  if (!constraint.intersect(sdkVersion).isEmpty) {
    return true;
  }
  if (constraint is VersionRange) {
    final minVersion = constraint.min;
    // SDK version < minVersion
    if (minVersion != null && minVersion.compareTo(sdkVersion) >= 0) {
      return false;
    }
  }
  // Otherwise keep the current stable SDK.
  return true;
}
