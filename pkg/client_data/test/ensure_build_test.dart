// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// TODO(kevmoo): replace with a common utility
//               https://github.com/dart-lang/build/issues/716
@Tags(['presubmit-only'])

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

final _pub = p.join(p.dirname(Platform.resolvedExecutable), 'pub');

void main() {
  test('ensure local build succeeds with no changes', () {
    // 1 - get a list of modified `.g.dart` files - should be empty
    expect(_changedGeneratedFiles(), isEmpty);

    // 2 - run build - should be no output, since nothing should change
    final result = _runProc(
        _pub, ['run', 'build_runner', 'build', '--delete-conflicting-outputs']);
    expect(result,
        contains(RegExp(r'Succeeded after( \S+){1,2} with \d+ outputs')));

    // 3 - get a list of modified `.g.dart` files - should still be empty
    expect(_changedGeneratedFiles(), isEmpty);
  });
}

final _whitespace = RegExp(r'\s');

Set<String> _changedGeneratedFiles() {
  final output = _runProc('git', ['status', '--porcelain']);

  return LineSplitter.split(output)
      .map((line) => line.split(_whitespace).last)
      .where((path) => path.endsWith('.dart'))
      .toSet();
}

String _runProc(String proc, List<String> args) {
  final result = Process.runSync(proc, args);

  if (result.exitCode != 0) {
    throw ProcessException(
        proc, args, result.stderr as String, result.exitCode);
  }

  return (result.stdout as String).trim();
}
