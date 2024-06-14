// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:pub_package_reader/pub_package_reader.dart';
import 'package:test/test.dart';

void main() {
  group('Bad archive', () {
    final archiveFile = File(
        '${Directory.systemTemp.path}/${DateTime.now().millisecondsSinceEpoch}.tar.gz');

    tearDownAll(() async {
      if (!await archiveFile.exists()) {
        await archiveFile.delete();
      }
    });

    test('file does not exists', () async {
      final summary = await summarizePackageArchive(archiveFile.path);
      expect(summary.issues, isNotEmpty);
      expect(summary.issues.single.message,
          'Package archive is empty (size = 0).');
    });

    test('file has zero bytes', () async {
      await archiveFile.writeAsBytes(<int>[]);
      final summary = await summarizePackageArchive(archiveFile.path);
      expect(summary.issues, isNotEmpty);
      expect(summary.issues.single.message,
          'Package archive is empty (size = 0).');
    });

    test('file has zero gzip-encoded bytes', () async {
      await archiveFile.writeAsBytes(gzip.encode(<int>[]));
      final summary = await summarizePackageArchive(archiveFile.path);
      expect(summary.issues, isNotEmpty);
      expect(summary.issues.single.message,
          'Uncompressed archive is empty (size = 0).');
    });

    test('file has garbage bytes', () async {
      await archiveFile.writeAsBytes(<int>[1, 2, 3, 4, 5, 6, 7]);
      final summary = await summarizePackageArchive(archiveFile.path);
      expect(summary.issues, isNotEmpty);
      expect(summary.issues.single.message,
          'gzip decoder failed: FormatException: Filter error, bad data.');
    });

    test('file has garbage gzip-encoded bytes', () async {
      await archiveFile.writeAsBytes(gzip.encode(<int>[1, 2, 3, 4, 5, 6, 7]));
      final summary = await summarizePackageArchive(archiveFile.path);
      expect(summary.issues, isNotEmpty);
      expect(summary.issues.single.message, 'Failed to scan tar archive.');
    });

    test('file is too large', () async {
      await archiveFile.writeAsBytes(List.filled(200000, 0));
      final summary = await summarizePackageArchive(archiveFile.path,
          maxArchiveSize: 199999);
      expect(summary.issues, isNotEmpty);
      expect(summary.issues.single.message,
          'Package archive is too large (size > 199999).');
    });

    test('uncompressed file is too large', () async {
      await archiveFile.writeAsBytes(gzip.encode(List.filled(200000, 0)));
      expect(archiveFile.lengthSync(), lessThan(1000));

      final summary = await summarizePackageArchive(archiveFile.path,
          maxArchiveSize: 199999);
      expect(summary.issues, isNotEmpty);
      expect(summary.issues.single.message,
          'Uncompressed package archive is too large (size > 199999).');
    });
  });
}
