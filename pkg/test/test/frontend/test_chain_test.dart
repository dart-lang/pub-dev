// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn("vm")

import 'dart:convert';

import 'package:test_descriptor/test_descriptor.dart' as d;
import 'package:test/test.dart';

import '../io.dart';

void main() {
  setUp(() async {
    await d.file("test.dart", """
            import 'dart:async';

            import 'package:test/test.dart';

            void main() {
              test("failure", () async{
                await new Future((){});
                await new Future((){});
                throw "oh no";
              });
            }
            """).create();
  });
  test("folds packages contained in the except list", () async {
    await d
        .file(
            "dart_test.yaml",
            JSON.encode({
              "fold_stack_frames": {
                "except": ["stream_channel"]
              }
            }))
        .create();
    var test = await runTest(["test.dart"]);
    expect(test.stdoutStream(), neverEmits(contains('package:stream_channel')));
    await test.shouldExit(1);
  });

  test("by default folds both stream_channel and test packages", () async {
    var test = await runTest(["test.dart"]);
    expect(test.stdoutStream(), neverEmits(contains('package:test')));
    expect(test.stdoutStream(), neverEmits(contains('package:stream_channel')));
    await test.shouldExit(1);
  });

  test("folds all packages not contained in the only list", () async {
    await d
        .file(
            "dart_test.yaml",
            JSON.encode({
              "fold_stack_frames": {
                "only": ["test"]
              }
            }))
        .create();
    var test = await runTest(["test.dart"]);
    expect(test.stdoutStream(), neverEmits(contains('package:stream_channel')));
    await test.shouldExit(1);
  });

  test("does not fold packages in the only list", () async {
    await d
        .file(
            "dart_test.yaml",
            JSON.encode({
              "fold_stack_frames": {
                "only": ["test"]
              }
            }))
        .create();
    var test = await runTest(["test.dart"]);
    expect(test.stdoutStream(), emitsThrough(contains('package:test')));
    await test.shouldExit(1);
  });
}
