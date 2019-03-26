// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../shared/platform.dart';

double scorePlatformSpecificity(List<String> platforms, String p) {
  _SpecificityFn fn;
  if (p != null && p.isNotEmpty) {
    fn = _platformFns[p] ?? _lightSingle;
  } else {
    fn = _defaultScore;
  }
  return fn(platforms);
}

/// Returns the platform specificity score given the package's platforms.
typedef _SpecificityFn = double Function(List<String> platforms);

final _platformFns = const <String, _SpecificityFn>{
  KnownPlatforms.flutter: _heavySingle,
  KnownPlatforms.web: _lightSingle,
  KnownPlatforms.other: _nonGeneric,
};

double _defaultScore(List<String> platforms) => 1.0;

/// Heavy bias towards a single platform: ['a'] >> ['a', 'b'] >> ['a', 'b', 'c'].
double _heavySingle(List<String> platforms) {
  final int count = platforms?.length ?? 0;
  if (count == 1) {
    return 1.0;
  } else if (count == 2) {
    return 0.90;
  } else {
    return 0.80;
  }
}

/// Light bias towards single platform: ['a'] > ['a', 'b'] > ['a', 'b', 'c'].
double _lightSingle(List<String> platforms) {
  final int count = platforms?.length ?? 0;
  if (count == 1) {
    return 1.0;
  } else if (count == 2) {
    return 0.95;
  } else {
    return 0.90;
  }
}

/// Bias towards being non-generic (one step below all-platforms):
/// - ['a', 'b'] > ['a', 'b', 'c']
/// - ['a', 'b'] > ['a']
double _nonGeneric(List<String> platforms) {
  final int count = platforms?.length ?? 0;
  final int diff = (KnownPlatforms.all.length - 1 - count).abs();
  if (diff == 0) {
    return 1.0;
  } else if (diff == 1) {
    return 0.95;
  } else {
    return 0.90;
  }
}
