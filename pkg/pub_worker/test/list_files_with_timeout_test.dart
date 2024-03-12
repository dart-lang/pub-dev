// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:clock/clock.dart';
import 'package:pub_worker/src/bin/dartdoc_wrapper.dart';
import 'package:test/test.dart';

void main() {
  test('list files with timeout', () async {
    final files = (await Directory.current.list(recursive: true).toList())
        .whereType<File>()
        .map((e) => e.path)
        .toSet();

    final list1 = (await listFilesWithTimeout(
                path: Directory.current.path,
                cutoffTimestamp: clock.now().add(Duration(minutes: 1)))
            .toList())
        .map((e) => e.path)
        .toSet();
    expect(list1, files);

    final list2 = (await listFilesWithTimeout(
                path: Directory.current.path,
                cutoffTimestamp: clock.now().add(Duration(milliseconds: 10)))
            .toList())
        .map((e) => e.path)
        .toSet();
    expect(list2, isNotEmpty);
    expect(list2, hasLength(lessThan(files.length)));
  });
}
