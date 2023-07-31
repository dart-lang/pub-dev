// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';

void main() {
  group('file limits', () {
    test('--max-file-count', () async {
      final tempDir = await Directory.systemTemp.createTemp();
      try {
        final pr = await Process.run('dart', [
          'pub',
          'run',
          'pub_dartdoc',
          '--input',
          Directory.current.absolute.path,
          '--output',
          tempDir.absolute.path,
          '--max-file-count',
          '2',
        ]);
        expect(pr.stderr.toString(), contains('Maximum file count reached: 2'));
      } finally {
        await tempDir.delete(recursive: true);
      }
    });

    test('--max-total-size', () async {
      final tempDir = await Directory.systemTemp.createTemp();
      try {
        final pr = await Process.run('dart', [
          'pub',
          'run',
          'pub_dartdoc',
          '--input',
          Directory.current.absolute.path,
          '--output',
          tempDir.absolute.path,
          '--max-total-size',
          '200000',
        ]);
        expect(pr.stderr.toString(),
            contains('Maximum total size reached: 200000 bytes'));
      } finally {
        await tempDir.delete(recursive: true);
      }
    });
  }, timeout: Timeout(const Duration(minutes: 5)));
}
