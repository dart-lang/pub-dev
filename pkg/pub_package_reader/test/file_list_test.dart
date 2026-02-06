// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:pub_package_reader/pub_package_reader.dart';
import 'package:pub_package_reader/src/tar_utils.dart';
import 'package:test/test.dart';

import '_tar_writer.dart';

void main() {
  final minimalTextFiles = {
    'pubspec.yaml':
        'name: abc\n'
        'version: 1.0.0\n'
        'description: abc is awesome\n'
        'environment:\n  sdk: \'>=2.10.0 <3.0.0\'\n',
    'LICENSE': 'Copyright (c) 2021',
    'README.md': 'Example content',
    'CHANGELOG.md': 'Changes',
  };

  group('Symlink', () {
    final archiveFile = File(
      '${Directory.systemTemp.path}/${DateTime.now().microsecondsSinceEpoch}.tar.gz',
    );

    tearDownAll(() async {
      if (!await archiveFile.exists()) {
        await archiveFile.delete();
      }
    });

    void testBrokenLink(String from, String to) {
      test('`$from` -> `$to`', () async {
        await writeTarGzFile(
          archiveFile,
          textFiles: minimalTextFiles,
          symlinks: {from: to},
        );

        final summary = await summarizePackageArchive(archiveFile.path);
        expect(
          summary.issues.single.message,
          'Failed to scan tar archive. (Symlinks not allowed: `$from`.)',
        );
      });
    }

    testBrokenLink('README.txt', 'README.md');
    testBrokenLink('README.txt', 'README.txt');
    testBrokenLink('README.txt', 'not-a-file.txt');
    testBrokenLink('README.txt', '../README.txt');
    testBrokenLink('README.txt', '/README.txt');
  });

  group('Duplicate entries', () {
    final archiveFile = File(
      '${Directory.systemTemp.path}/${DateTime.now().microsecondsSinceEpoch}.tar.gz',
    );

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
      expect(
        summary.issues.single.message,
        'Failed to scan tar archive. (Duplicate tar entry: `README.md`.)',
      );
    });
  });

  group('tar entry test', () {
    test('absolue path in the tar entry', () async {
      final alternatives = [
        '/abc/def',
        '/abc/../../def',
        '/abc/./abc/../../def',
      ];
      for (final path in alternatives) {
        await _withTempDir((tempDir) async {
          final file = File(p.join(tempDir, 'x.tar.gz'));
          await writeTarGzFile(file, textFiles: {path: 'content'});
          await expectLater(
            TarArchive.scan(file.path),
            throwsA(
              isA<TarException>().having(
                (e) => e.message,
                'message',
                contains('absolute name'),
              ),
            ),
          );
        });
      }
    });

    test('pointing outside of the archive', () async {
      final alternatives = [
        '../abc',
        'abc/../..',
        'abc/../def/../../ghi',
        './abc/.../../../..',
      ];
      for (final path in alternatives) {
        await _withTempDir((tempDir) async {
          final file = File(p.join(tempDir, 'x.tar.gz'));
          await writeTarGzFile(file, textFiles: {path: 'content'});
          await expectLater(
            TarArchive.scan(file.path),
            throwsA(
              isA<TarException>().having(
                (e) => e.message,
                'message',
                contains('points outside'),
              ),
            ),
          );
        });
      }
    });
  });
}

Future<K> _withTempDir<K>(Future<K> Function(String tempDir) fn) async {
  final dir = await Directory.systemTemp.createTemp();
  try {
    return await fn(dir.path);
  } finally {
    await dir.delete(recursive: true);
  }
}
