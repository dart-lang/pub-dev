// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import '../../shared/utils.dart';

/// Collects the last 1000 samples of event loop latency measurements.
final eventLoopLatencyTracker = LastNTracker<Duration>();

/// Starts a timer to measure event loop latencies.
void trackEventLoopLatency() {
  final samplePeriod = const Duration(seconds: 3);
  void measure() {
    final sw = Stopwatch()..start();
    Timer(samplePeriod, () {
      sw.stop();
      final diff = sw.elapsed - samplePeriod;
      final latency = diff.isNegative ? Duration.zero : diff;
      eventLoopLatencyTracker.add(latency);
      measure();
    });
  }

  Zone.root.run(() {
    measure();
  });
}
