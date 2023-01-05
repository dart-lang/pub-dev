// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: prefer_final_locals

// This library contains the package:pub_semver parsing logic as of v2.1.0.
// We keep this around to parse and normalize versions and version constraints
// as they were recognized prior to the fix in package:pub_semver.

import 'package:pub_semver/pub_semver.dart';

/// Parses a comparison operator ("<", ">", "<=", or ">=") at the beginning of
/// a string.
final _startComparison = RegExp(r'^[<>]=?');

/// The "compatible with" operator.
const _compatibleWithChar = '^';

/// Regex that matches a version number at the beginning of a string.
final _startVersion = RegExp(r'^' // Start at beginning.
    r'(\d+).(\d+).(\d+)' // Version number.
    r'(-([0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*))?' // Pre-release.
    r'(\+([0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*))?'); // Build.

/// Like [_startVersion] but matches the entire string.
final _completeVersion = RegExp('${_startVersion.pattern}\$');

/// Creates a new [Version] by parsing [text].
///
/// Following rules from `package:pub_semver <= 2.1.0`.
Version parsePossiblyBrokenVersion(String text) {
  final match = _completeVersion.firstMatch(text);
  if (match == null) {
    throw FormatException('Could not parse "$text".');
  }

  try {
    var major = int.parse(match[1]!);
    var minor = int.parse(match[2]!);
    var patch = int.parse(match[3]!);

    var preRelease = match[5];
    var build = match[8];

    return Version(major, minor, patch, pre: preRelease, build: build);
  } on FormatException {
    throw FormatException('Could not parse "$text".');
  }
}

/// Parses a version constraint.
///
/// Following rules from `package:pub_semver <= 2.1.0`.
VersionConstraint parsePossiblyBrokenVersionConstraint(String text) {
  var originalText = text;

  void skipWhitespace() {
    text = text.trim();
  }

  skipWhitespace();

  // Handle the "any" constraint.
  if (text == 'any') return VersionConstraint.any;

  // Try to parse and consume a version number.
  Version? matchVersion() {
    var version = _startVersion.firstMatch(text);
    if (version == null) return null;

    text = text.substring(version.end);
    return parsePossiblyBrokenVersion(version[0]!);
  }

  // Try to parse and consume a comparison operator followed by a version.
  VersionRange? matchComparison() {
    var comparison = _startComparison.firstMatch(text);
    if (comparison == null) return null;

    var op = comparison[0];
    text = text.substring(comparison.end);
    skipWhitespace();

    var version = matchVersion();
    if (version == null) {
      throw FormatException('Expected version number after "$op" in '
          '"$originalText", got "$text".');
    }

    switch (op) {
      case '<=':
        return VersionRange(max: version, includeMax: true);
      case '<':
        return VersionRange(
            max: version, includeMax: false, alwaysIncludeMaxPreRelease: true);
      case '>=':
        return VersionRange(min: version, includeMin: true);
      case '>':
        return VersionRange(min: version, includeMin: false);
    }

    throw FormatException('Expected one of "<=", "<", ">=", or ">" '
        'as the operator in "$originalText", got "$op".');
  }

  // Try to parse the "^" operator followed by a version.
  VersionConstraint? matchCompatibleWith() {
    if (!text.startsWith(_compatibleWithChar)) return null;

    text = text.substring(_compatibleWithChar.length);
    skipWhitespace();

    var version = matchVersion();
    if (version == null) {
      throw FormatException('Expected version number after '
          '"$_compatibleWithChar" in "$originalText", got "$text".');
    }

    if (text.isNotEmpty) {
      throw FormatException('Cannot include other constraints with '
          '"$_compatibleWithChar" constraint in "$originalText".');
    }

    return VersionConstraint.compatibleWith(version);
  }

  var compatibleWith = matchCompatibleWith();
  if (compatibleWith != null) return compatibleWith;

  Version? min;
  var includeMin = false;
  Version? max;
  var includeMax = false;

  for (;;) {
    skipWhitespace();

    if (text.isEmpty) break;

    var newRange = matchVersion() ?? matchComparison();
    if (newRange == null) {
      throw FormatException('Could not parse version "$originalText". '
          'Unknown text at "$text".');
    }

    if (newRange.min != null) {
      if (min == null || newRange.min! > min) {
        min = newRange.min;
        includeMin = newRange.includeMin;
      } else if (newRange.min == min && !newRange.includeMin) {
        includeMin = false;
      }
    }

    if (newRange.max != null) {
      if (max == null || newRange.max! < max) {
        max = newRange.max;
        includeMax = newRange.includeMax;
      } else if (newRange.max == max && !newRange.includeMax) {
        includeMax = false;
      }
    }
  }

  if (min == null && max == null) {
    throw const FormatException('Cannot parse an empty string.');
  }

  if (min != null && max != null) {
    if (min > max) return VersionConstraint.empty;
    if (min == max) {
      if (includeMin && includeMax) return min;
      return VersionConstraint.empty;
    }
  }

  return VersionRange(
      min: min, includeMin: includeMin, max: max, includeMax: includeMax);
}
