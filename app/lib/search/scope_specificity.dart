// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../shared/tags.dart';

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
