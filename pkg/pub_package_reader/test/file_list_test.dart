// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:pub_package_reader/pub_package_reader.dart';
import 'package:test/test.dart';

import '_tar_writer.dart';

void main() {
  final minimalTextFiles = {
    'pubspec.yaml': 'name: abc\n'
        'version: 1.0.0\n'
        'description: abc is awesome\n'
        'environment:\n  sdk: \'>=2.10.0 <3.0.0\'\n',
    'LICENSE': 'Copyright (c) 2021',
    'README.md': 'Example content',
    'CHANGELOG.md': 'Changes',
  };

  group('Symlink', () {
    final archiveFile = File(
        '${Directory.systemTemp.path}/${DateTime.now().microsecondsSinceEpoch}.tar.gz');

    tearDownAll(() async {
      if (!await archiveFile.exists()) {
        await archiveFile.delete();
      }
    });

    void testAllowedLink(String from, String to) {
      test('`$from` -> `$to`', () async {
        await writeTarGzFile(
          archiveFile,
          textFiles: minimalTextFiles,
          symlinks: {from: to},
        );

        final summary = await summarizePackageArchive(archiveFile.path);
        expect(summary.hasIssues, isFalse);
      });
    }

    void testBrokenLink(String from, String to) {
      test('`$from` -> `$to`', () async {
        await writeTarGzFile(
          archiveFile,
          textFiles: minimalTextFiles,
          symlinks: {from: to},
        );

        final summary = await summarizePackageArchive(archiveFile.path);
        expect(summary.issues.single.message,
            'Package archive contains a broken symlink: `$from` -> `$to`.');
      });
    }

    testAllowedLink('README.txt', 'README.md');
    // This test-case should fail, but it for simplicity it is accepted by pub.
    // TODO: fix verification to detect circular links
    testAllowedLink('README.txt', 'README.txt');

    testBrokenLink('README.txt', 'not-a-file.txt');
    testBrokenLink('README.txt', '../README.txt');
    testBrokenLink('README.txt', '/README.txt');
  });

  group('Duplicate entries', () {
    final archiveFile = File(
        '${Directory.systemTemp.path}/${DateTime.now().microsecondsSinceEpoch}.tar.gz');

    tearDownAll(() async {
      if (!await archiveFile.exists()) {
        await archiveFile.delete();
      }
    });

    test('duplicate files', () async {
      await writeTarGzFile(
        archiveFile,
        textFiles: minimalTextFiles,
        symlinks: {'README.md': 'CHANGELOG.md'},
      );

      final summary = await summarizePackageArchive(archiveFile.path);
      expect(summary.issues.single.message,
          'Failed to scan tar archive. (Duplicate tar entry: `README.md`.)');
    });
  });
}
