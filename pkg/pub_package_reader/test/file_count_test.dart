// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';

import 'package:pub_package_reader/pub_package_reader.dart';

import '_tar_writer.dart';

void main() {
  final minimalTextFiles = {
    'pubspec.yaml': 'name: abc\nversion: 1.0.0',
    'LICENSE': 'Copyright (c) 2021',
    'README.md': 'Example content',
    'CHANGELOG.md': 'Changes',
  };

  group('File count', () {
    final archiveFile = File(
        '${Directory.systemTemp.path}/${DateTime.now().microsecondsSinceEpoch}.tar.gz');

    tearDownAll(() async {
      if (!await archiveFile.exists()) {
        await archiveFile.delete();
      }
    });

    Future<void> _writeWithFiles(int count) async {
      final files = {
        ...minimalTextFiles,
      };
      while (files.length < count) {
        files['lib/f${files.length}.dart'] = '// no-op';
      }
      await writeTarGzFile(archiveFile, textFiles: files);
    }

    test('below the limit', () async {
      await _writeWithFiles(1024);
      final s1 = await summarizePackageArchive(archiveFile.path,
          maxFileCount: 1024, useNative: false);
      expect(s1.hasIssues, isFalse);
      final s2 = await summarizePackageArchive(archiveFile.path,
          maxFileCount: 1024, useNative: true);
      expect(s2.hasIssues, isFalse);
    });

    test('above the limit', () async {
      await _writeWithFiles(1025);
      final s1 = await summarizePackageArchive(archiveFile.path,
          maxFileCount: 1024, useNative: false);
      expect(s1.issues.single.message,
          'Failed to scan tar archive. (Exception: Maximum file count reached: 1024.)');
      final s2 = await summarizePackageArchive(archiveFile.path,
          maxFileCount: 1024, useNative: true);
      expect(s2.issues.single.message,
          'Failed to scan tar archive. (Exception: Maximum file count reached: 1024.)');
    });
  });
}
