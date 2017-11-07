// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library isolate.test.isolaterunner_test;

import 'dart:async' show Future;
import 'dart:isolate' show Capability;

import 'package:isolate/isolate_runner.dart';
import 'package:test/test.dart';

const MS = const Duration(milliseconds: 1);

void main() {
  test("create-close", testCreateClose);
  test("create-run-close", testCreateRunClose);
  test("separate-isolates", testSeparateIsolates);
  group('isolate functions', testIsolateFunctions);
}

Future testCreateClose() {
  return IsolateRunner.spawn().then((IsolateRunner runner) {
    return runner.close();
  });
}

Future testCreateRunClose() {
  return IsolateRunner.spawn().then((IsolateRunner runner) {
    return runner.run(id, "testCreateRunClose").then((v) {
      expect(v, "testCreateRunClose");
      return runner.close().then((_) => runner.onExit);
    });
  });
}

Future testSeparateIsolates() {
  // Check that each isolate has its own _global variable.
  return Future
      .wait(new Iterable.generate(2, (_) => IsolateRunner.spawn()))
      .then((runners) {
    Future runAll(action(IsolateRunner runner, int index)) {
      var indices = new Iterable.generate(runners.length);
      return Future.wait(indices.map((i) => action(runners[i], i)));
    }

    return runAll((runner, i) => runner.run(setGlobal, i + 1)).then((values) {
      expect(values, [1, 2]);
      expect(_global, null);
      return runAll((runner, _) => runner.run(getGlobal, null));
    }).then((values) {
      expect(values, [1, 2]);
      expect(_global, null);
      return runAll((runner, _) => runner.close());
    });
  });
}

void testIsolateFunctions() {
  test("pause", () {
    bool mayComplete = false;
    return IsolateRunner.spawn().then((isolate) {
      isolate.pause();
      new Future.delayed(MS * 500, () {
        mayComplete = true;
        isolate.resume();
      });
      isolate.run(id, 42).then((v) {
        expect(v, 42);
        expect(mayComplete, isTrue);
      }).whenComplete(isolate.close);
    });
  });
  test("pause2", () {
    Capability c1 = new Capability();
    Capability c2 = new Capability();
    int mayCompleteCount = 2;
    return IsolateRunner.spawn().then((isolate) {
      isolate.pause(c1);
      isolate.pause(c2);
      new Future.delayed(MS * 500, () {
        mayCompleteCount--;
        isolate.resume(c1);
      });
      new Future.delayed(MS * 500, () {
        mayCompleteCount--;
        isolate.resume(c2);
      });
      isolate.run(id, 42).then((v) {
        expect(v, 42);
        expect(mayCompleteCount, 0);
      }).whenComplete(isolate.close);
    });
  });
  test("ping", () {
    return IsolateRunner.spawn().then((isolate) {
      return isolate.ping().then((v) {
        expect(v, isTrue);
        return isolate.close();
      });
    });
  });
  test("kill", () {
    return IsolateRunner.spawn().then((isolate) {
      return isolate.kill();
    });
  });
}

id(x) => x;

var _global;
getGlobal(_) => _global;
setGlobal(v) => _global = v;
