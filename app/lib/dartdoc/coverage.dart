// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:meta/meta.dart';

import 'package:pub_dartdoc_data/pub_dartdoc_data.dart';

/// The documentation coverage numbers and the derived scores.
class Coverage {
  /// The number of API elements.
  final int total;

  /// The number of API elements with accepted documentation.
  final int documented;

  Coverage({
    @required this.total,
    @required this.documented,
  });

  /// The coverage percent [0.0 - 1.0].
  double get percent {
    if (total == documented) {
      // this also handles total == 0
      return 1.0;
    } else {
      return documented / total;
    }
  }

  /// The coverage score [0.0 - 1.0].
  double get score {
    // 0.01 percent -> 0.03 score -> 9.7 penalty
    // 0.02 percent -> 0.06 score -> 9.4 penalty
    // 0.03 percent -> 0.09 score -> 9.1 penalty
    // 0.05 percent -> 0.14 score -> 8.6 penalty
    // 0.10 percent -> 0.27 score -> 7.3 penalty
    // 0.20 percent -> 0.49 score -> 5.1 penalty
    // 0.30 percent -> 0.66 score -> 3.4 penalty
    // 0.50 percent -> 0.88 score -> 1.2 penalty
    // 0.75 percent -> 0.98 score -> 0.2 penalty
    return 1.0 - pow(1.0 - percent, 3);
  }

  /// The coverage penalty [0.0 - 10.0].
  double get penalty {
    // Reducing coverage penalty in order to ease-in the introduction of it.
    final fullPenalty = (1.0 - score) * 10.0;
    return max(0.0, fullPenalty - 9.0);
  }
}

/// Calculate coverage for the extracted dartdoc content [data].
Coverage calculateCoverage(PubDartdocData data) {
  final total = data?.apiElements?.length ?? 0;
  int documented = 0;

  if (data != null) {
    documented = data.apiElements
        .where((elem) =>
            elem.documentation != null &&
            elem.documentation.isNotEmpty &&
            elem.documentation.trim().length >= 5)
        .length;
  }

  return Coverage(total: total, documented: documented);
}
