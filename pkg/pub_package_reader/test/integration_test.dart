// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tar/tar.dart';
import 'package:test/test.dart';

import 'package:pub_package_reader/pub_package_reader.dart';

void main() {
  group('integration', () {
    Directory tempDir;
    var count = 0;

    setUpAll(() async {
      tempDir = await Directory.systemTemp.createTemp();
    });

    tearDownAll(() async {
      await tempDir.delete(recursive: true);
    });

    // Make a tar archive  with files
    Future<String> makeTar(Map<String, String> files) async {
      count++;
      final tarFile = File.fromUri(tempDir.uri.resolve('pkg-$count.tar.gz'));

      await () async* {
        for (final e in files.entries) {
          yield TarEntry.data(TarHeader(name: e.key), utf8.encode(e.value));
        }
      }()
          .transform(tarWriter)
          .transform(gzip.encoder)
          .pipe(tarFile.openWrite());
      return tarFile.path;
    }

    test('Minimal working package', () async {
      final summary = await summarizePackageArchive(
        await makeTar({
          'pubspec.yaml': '''
name: mypkg
version: 1.0.0
''',
          'LICENSE': 'All rights reserved...',
        }),
        maxContentLength: 128 * 1024,
      );

      expect(summary.issues, isEmpty);
    });

    test('YAML aliases / anchors not allowed', () async {
      final summary = await summarizePackageArchive(
        await makeTar({
          'pubspec.yaml': '''
name: foo
version: &v 1.0.0
dev_dependencies:
  bar: *v
''',
          'LICENSE': 'All rights reserved...',
        }),
        maxContentLength: 128 * 1024,
      );

      expect(
        summary.issues,
        contains(predicate<ArchiveIssue>(
          (i) => i.message.contains('pubspec.yaml may not use references'),
        )),
      );
    });
  });
}
