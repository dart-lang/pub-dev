import 'dart:convert' show json;
import 'dart:typed_data' show Uint8List, BytesBuilder;

import 'package:pub_semver/pub_semver.dart';

/// Parses the `SANDBOX_OUTPUT` environment variable value into a list of
/// directory paths.
///
/// Supports both a JSON-encoded list of strings (e.g. `["/tmp/a", "/tmp/b"]`)
/// and a legacy colon-separated string (e.g. `/tmp/a:/tmp/b`).
///
/// Throws a [FormatException] if [rawSandboxOutput] starts with `[` but is not
/// a valid JSON list of strings.
List<String> parseSandboxOutput(String? rawSandboxOutput) {
  if (rawSandboxOutput == null || rawSandboxOutput.isEmpty) {
    return const <String>[];
  }
  if (rawSandboxOutput.startsWith('[')) {
    final decoded = json.decode(rawSandboxOutput);
    if (decoded is List && decoded.every((e) => e is String)) {
      return decoded.cast<String>();
    }
    throw FormatException(
      'Expected a JSON list of strings in SANDBOX_OUTPUT',
      rawSandboxOutput,
    );
  }
  return rawSandboxOutput.split(':').where((e) => e.isNotEmpty).toList();
}

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
