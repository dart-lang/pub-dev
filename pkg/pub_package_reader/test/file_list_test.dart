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

    test('duplicate directory with and without trailing slash', () async {
      await _withTempDir((tempDir) async {
        final file = File(p.join(tempDir, 'x.tar.gz'));
        await writeTarGzFile(
          file,
          directories: ['dir', 'dir/'],
          textFiles: {'dir/file.txt': 'content'},
        );
        await expectLater(
          TarArchive.scan(file.path),
          throwsA(
            isA<TarException>().having(
              (e) => e.message,
              'message',
              contains('Duplicate tar entry: `dir/`.'),
            ),
          ),
        );
      });
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

    test('non-normalized path in the tar entry', () async {
      final alternatives = [
        './abc',
        './pubspec.yaml',
        'abc/./def',
        'abc//def',
        'abc/def/',
        'abc/../abc/def',
        'abc/def ',
        ' abc/def',
        '.',
        './',
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
                contains('Tar entry name is not normalized: `$path`.'),
              ),
            ),
          );
        });
      }
    });

    test('valid normalized paths and directories', () async {
      await _withTempDir((tempDir) async {
        final file = File(p.join(tempDir, 'x.tar.gz'));
        await writeTarGzFile(
          file,
          directories: ['dir1/', 'dir2'],
          textFiles: {
            'pubspec.yaml': 'name: abc',
            'lib/foo.dart': 'void main() {}',
            '.gitignore': 'build/',
          },
        );
        final archive = await TarArchive.scan(file.path);
        expect(
          archive.fileNames,
          containsAll([
            'dir1',
            'dir2',
            'pubspec.yaml',
            'lib/foo.dart',
            '.gitignore',
          ]),
        );
      });
    });

    test('non-normalized entry in summarizePackageArchive', () async {
      await _withTempDir((tempDir) async {
        final file = File(p.join(tempDir, 'x.tar.gz'));
        await writeTarGzFile(
          file,
          textFiles: {'./pubspec.yaml': minimalTextFiles['pubspec.yaml']!},
        );
        final summary = await summarizePackageArchive(file.path);
        expect(
          summary.issues.single.message,
          'Failed to scan tar archive. (Tar entry name is not normalized: `./pubspec.yaml`.)',
        );
      });
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
