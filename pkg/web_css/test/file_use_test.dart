// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  test(
    'scss files in lib/ are exactly those referenced by style.scss ',
    () async {
      final references = (await File('lib/style.scss').readAsLines())
          .where((l) => l.startsWith(r'@use'))
          .map(
            (l) => l
                .substring(4)
                .trim()
                .split(';')
                .first
                .replaceAll("'", '')
                .trim(),
          )
          .where((v) => v.isNotEmpty)
          .toSet();
      expect(references, isNotEmpty);
      expect(references, contains('src/_tags'));

      final files = Directory('lib')
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.scss'))
          .map((f) => p.relative(f.path, from: 'lib'))
          .map(
            (n) => n.substring(0, n.length - 5),
          ) // without the .scss extension
          .toSet();
      files.removeAll(['dartdoc', 'style']);
      expect(files, isNotEmpty);
      expect(references, files);
    },
  );
}
