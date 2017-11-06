// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
library code_transformers.src.async_benchmark_base;

import 'dart:async';

/// An adaptation of [BenchmarkBase] from the `benchmark_harness` package that
/// works for async benchmarks.
/// TODO(jakemac): Get this merged into `benchmark_harness`.
class AsyncBenchmarkBase {
  // Empty constructor.
  const AsyncBenchmarkBase();

  // The benchmark code.
  // This function is not used, if both [warmup] and [exercise] are overwritten.
  Future run() => new Future.value();

  // Runs a short version of the benchmark. By default invokes [run] once.
  Future warmup() => run();

  // Exercices the benchmark. By default invokes [run] 10 times.
  Future exercise({int iterations: 10}) {
    var i = 0;
    return Future.doWhile(() {
      if (i >= iterations) return new Future.value(false);
      i++;
      return run().then((_) => true);
    });
  }

  // Not measured setup code executed prior to the benchmark runs.
  Future setup() => new Future.value();

  // Not measures teardown code executed after the benchark runs.
  Future teardown() => new Future.value();

  // Measures the score for this benchmark by executing it repeatedly until
  // time minimum has been reached.
  static Future<double> measureFor(Function f, int minimumMillis) {
    int minimumMicros = minimumMillis * 1000;
    int iter = 0;
    Stopwatch watch = new Stopwatch();
    watch.start();
    int elapsed = 0;
    return Future.doWhile(() {
      if (elapsed > minimumMicros) return new Future.value(false);
      return f().then((_) {
        elapsed = watch.elapsedMicroseconds;
        iter++;
        return true;
      });
    }).then((_) => elapsed / iter);
  }

  // Measures the average time to call `run` once and returns it.
  Future<double> measure({int iterations: 10}) async {
    // Unmeasured setup code.
    await setup();
    // Warmup for at least 100ms. Discard result.
    await measureFor(() => warmup(), 100);
    // Run the benchmark for at least 2000ms.
    var result = await measureFor(() => exercise(iterations: iterations), 2000);
    // Tear down the test (unmeasured) and return the result divided by the
    // number of iterations.
    await teardown();
    return result / iterations;
  }
}
