// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' as math;

/// A weighted score that approximates the frequency of the releases of a package.
/// While the score reaches 1.0 on a daily release schedule, it is not a desired
/// state, therefore we do bucket the release days into weeks and months, also
/// making the older releases less relevant.
double scoreReleaseFrequency(Iterable<int> releasesInDays) {
  double score(Set<int> values, int maxValue) {
    double total = 0.0;
    double actual = 0.0;
    if (values.isEmpty) return 0.0;
    for (int i = 0; i <= maxValue; i++) {
      // fading weight: most recent = 1.00, half period = 0.61, full period = 0.37
      final double weight = math.exp(-i / maxValue);
      total += weight;
      if (values.contains(i)) {
        actual += weight;
      }
    }
    return actual / total;
  }

  final double weeklyScore =
      score(releasesInDays.map((int days) => (days / 7).round()).toSet(), 52);
  final double monthlyScore =
      score(releasesInDays.map((int days) => (days / 30.5).round()).toSet(), 11);
  return (weeklyScore + monthlyScore) / 2;
}
