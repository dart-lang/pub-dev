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
      final summary =
          await summarizePackageArchive(archiveFile.path, maxFileCount: 1024);
      expect(summary.hasIssues, isFalse);
    });

    test('above the limit', () async {
      await _writeWithFiles(1025);
      final summary =
          await summarizePackageArchive(archiveFile.path, maxFileCount: 1024);
      expect(summary.issues.single.message,
          'Failed to scan tar archive. (Maximum file count reached: 1024.)');
    });
  });
}
