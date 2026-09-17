import 'dart:convert' show json;
import 'dart:typed_data' show Uint8List, BytesBuilder;

import 'package:pub_semver/pub_semver.dart';

/// Parses writable directory paths from the `SANDBOX_OUTPUT` or
/// `SANDBOX_OUTPUT_JSON` environment variables.
///
/// Only one of [sandboxOutput] (legacy colon-separated paths) or
/// [sandboxOutputJson] (JSON-encoded list of strings) may be non-empty at a
/// time.
///
/// Throws a [FormatException] if both are non-empty, or if
/// [sandboxOutputJson] is not a valid JSON list of strings.
List<String> parseSandboxOutput({
  String? sandboxOutput,
  String? sandboxOutputJson,
}) {
  final hasLegacy = sandboxOutput != null && sandboxOutput.isNotEmpty;
  final hasJson = sandboxOutputJson != null && sandboxOutputJson.isNotEmpty;
  if (hasLegacy && hasJson) {
    throw FormatException(
      'Only one of SANDBOX_OUTPUT or SANDBOX_OUTPUT_JSON may be configured at a time.',
    );
  }
  if (hasJson) {
    final decoded = json.decode(sandboxOutputJson);
    if (decoded is List && decoded.every((e) => e is String)) {
      return decoded.cast<String>();
    }
    throw FormatException(
      'Expected a JSON list of strings in SANDBOX_OUTPUT_JSON',
      sandboxOutputJson,
    );
  }
  if (hasLegacy) {
    return sandboxOutput.split(':').where((e) => e.isNotEmpty).toList();
  }
  return const <String>[];
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
