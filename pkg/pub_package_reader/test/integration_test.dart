// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:pub_package_reader/pub_package_reader.dart';
import 'package:test/test.dart';

import '_tar_writer.dart';

void main() {
  group('integration', () {
    late Directory tempDir;
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
      await writeTarGzFile(tarFile, textFiles: files);
      return tarFile.path;
    }

    test('Minimal working package', () async {
      final summary = await summarizePackageArchive(
        await makeTar({
          'pubspec.yaml': '''
name: mypkg
version: 1.0.0
description: mypkg is awesome
environment:
  sdk: '>=2.10.0 <3.0.0'
''',
          'LICENSE': 'All rights reserved...',
        }),
      );

      expect(summary.issues, isEmpty);
    });

    test('YAML aliases / anchors not allowed', () async {
      final summary = await summarizePackageArchive(
        await makeTar({
          'pubspec.yaml': '''
name: foo
version: &v 1.0.0
description: foo is awesome
dev_dependencies:
  bar: *v
''',
          'LICENSE': 'All rights reserved...',
        }),
      );

      expect(
        summary.issues,
        contains(predicate<ArchiveIssue>(
          (i) => i.message.contains('pubspec.yaml may not use references'),
        )),
      );
    });

    test('malformed version', () async {
      final summary = await summarizePackageArchive(
        await makeTar({
          'pubspec.yaml': '''
name: foo
version: 1.0,0
description: foo is awesome
environment:
  sdk: ^2.14,0
dependencies:
  bar: ^1-0-0
dev_dependencies:
  test: ^1:0-0
dependency_overrides:
  test: ^1:0:0
''',
          'LICENSE': 'All rights reserved...',
        }),
      );

      expect(
        summary.issues.map((e) => e.message).first,
        contains('Error parsing pubspec.yaml'),
      );
    });
  });
}
