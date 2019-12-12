// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../shared/tags.dart';

/// Calculates the specificity weight for a package given the search query's
/// scope (currently only the sdk part is considered).
///
/// Scores are biased towards more specific packages (e.g. if somebody is
/// filtering for Flutter, we prefer Flutter-specific packages vs. generic packages).
double scoreScopeSpecificity(String sdk, List<String> tags) {
  if (sdk == null || sdk.isEmpty) return 1.0;

  final sdkCount = tags?.where((t) => t.startsWith('sdk:'))?.length ?? 0;

  if (sdk == SdkTagValue.flutter) {
    /// Heavy bias towards a single platform: ['a'] >> ['a', 'b'] >> ['a', 'b', 'c'].
    if (sdkCount == 1) {
      return 1.0;
    } else if (sdkCount == 2) {
      return 0.90;
    } else {
      return 0.80;
    }
  } else {
    /// Light bias towards a single platform: ['a'] >> ['a', 'b'] >> ['a', 'b', 'c'].
    if (sdkCount == 1) {
      return 1.0;
    } else if (sdkCount == 2) {
      return 0.95;
    } else {
      return 0.90;
    }
  }
}
