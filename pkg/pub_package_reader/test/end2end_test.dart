// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:http/http.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'package:pub_package_reader/pub_package_reader.dart';

void main() {
  group('end2end', () {
    Directory tempDir;

    setUpAll(() async {
      tempDir = await Directory.systemTemp.createTemp();
    });

    tearDownAll(() async {
      await tempDir.delete(recursive: true);
    });

    Future<String> download(String package, String version) async {
      final file = File(p.join(tempDir.path, '$package-$version.tar.gz'));
      final rs = await get(Uri.parse(
          'https://pub.dartlang.org/packages/$package/versions/$version.tar.gz'));
      await file.writeAsBytes(rs.bodyBytes);
      return file.path;
    }

    Future<void> expandWithBytes(String path, List<int> bytes) async {
      final compressed = await File(path).readAsBytes();
      final uncompressed = gzip.decode(compressed);
      await File(path).writeAsBytes([...uncompressed, ...bytes]);
    }

    test('pana 0.12.19', () async {
      void verify(PackageSummary summary) {
        expect(summary.issues, isEmpty);
        expect(summary.pubspecContent, contains('pana'));
        expect(summary.readmePath, 'README.md');
        expect(summary.readmeContent,
            contains('image links in markdown content are insecure'));
        expect(summary.changelogPath, 'CHANGELOG.md');
        expect(summary.changelogContent,
            contains('penalize outdated package constraints'));
        expect(summary.examplePath, isNull);
        expect(summary.exampleContent, isNull);
        expect(summary.libraries, <String>['models.dart', 'pana.dart']);
      }

      final path = await download('pana', '0.12.19');
      verify(await summarizePackageArchive(path, maxContentLength: 128 * 1024));
      verify(await summarizePackageArchive(path,
          maxContentLength: 128 * 1024, useNative: true));

      await expandWithBytes(path, <int>[1]);
      await expectLater(
          () => summarizePackageArchive(path, maxContentLength: 128 * 1024),
          throwsA(isA<Exception>()));
      await expectLater(
          () => summarizePackageArchive(path,
              maxContentLength: 128 * 1024, useNative: true),
          throwsA(isA<Exception>()));
    });

    test('maxContentLength', () async {
      void verify(PackageSummary summary) {
        expect(summary.readmeContent, '[![Build Status][...]\n\n');
        expect(summary.changelogContent, '## 0.12.19\n\n* Fi[...]\n\n');
      }

      final path = await download('pana', '0.12.19');
      verify(await summarizePackageArchive(path, maxContentLength: 16));
      verify(await summarizePackageArchive(path,
          maxContentLength: 16, useNative: true));

      await expandWithBytes(path, <int>[1]);
      await expectLater(
          () => summarizePackageArchive(path, maxContentLength: 16),
          throwsA(isA<Exception>()));
      await expectLater(
          () => summarizePackageArchive(path,
              maxContentLength: 16, useNative: true),
          throwsA(isA<Exception>()));
    });
  });
}
