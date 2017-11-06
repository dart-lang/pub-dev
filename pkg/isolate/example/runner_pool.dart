// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library isolate.example.runner_pool;

import 'dart:async' show Future;

import 'package:isolate/load_balancer.dart';
import 'package:isolate/isolate_runner.dart';

void main() {
  int N = 44;
  var sw = new Stopwatch()..start();
  // Compute fib up to 42 with 4 isolates.
  parfib(N, 4).then((v1) {
    var t1 = sw.elapsedMilliseconds;
    sw.stop();
    sw.reset();
    print("fib#4(${N}) = ${v1[N]}, ms: $t1");
    sw.start();
    // Then compute fib up to 42 with 2 isolates.
    parfib(N, 2).then((v2) {
      var t2 = sw.elapsedMilliseconds;
      sw.stop();
      print("fib#2(${N}) = ${v2[N]}, ms: $t2");
    });
  });
}

// Compute fibonacci 1..limit
Future<List<int>> parfib(int limit, int parallelity) {
  return LoadBalancer
      .create(parallelity, IsolateRunner.spawn)
      .then((LoadBalancer pool) {
    var fibs = new List<Future<int>>(limit + 1);
    // Schedule all calls with exact load value and the heaviest task
    // assigned first.
    schedule(a, b, i) {
      if (i < limit) {
        schedule(a + b, a, i + 1);
      }
      fibs[i] = pool.run<int, int>(fib, i, load: a);
    }

    schedule(0, 1, 0);
    // And wait for them all to complete.
    return Future.wait(fibs).whenComplete(pool.close);
  });
}

int computeFib(int n) {
  var result = fib(n);
  return result;
}

int fib(int n) {
  if (n < 2) return n;
  return fib(n - 1) + fib(n - 2);
}
