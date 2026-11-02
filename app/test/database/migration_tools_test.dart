// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:pub_dev/src/database/migration_tools.dart';
import 'package:test/test.dart';

void main() {
  group('buildSha256sum', () {
    test('sorts by name and uses two spaces as separator', () {
      final a = utf8.encode('a');
      final b = utf8.encode('b');
      expect(
        buildSha256sum([
          (name: '000002_b.sql', bytes: b),
          (name: '000001_a.sql', bytes: a),
        ]),
        '${sha256.convert(a)}  000001_a.sql\n'
        '${sha256.convert(b)}  000002_b.sql\n',
      );
    });

    test('matches the checked-in migrations/sha256sum.txt', () {
      final files = [
        for (final f in Directory('migrations').listSync().whereType<File>())
          if (f.path.endsWith('.sql'))
            (name: f.uri.pathSegments.last, bytes: f.readAsBytesSync()),
      ];
      expect(
        buildSha256sum(files),
        File('migrations/sha256sum.txt').readAsStringSync(),
      );
    });
  });
}
