// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:pub_package_reader/pub_package_reader.dart' show ArchiveIssue;

/// Scans the archive.tar.gz before parsing the tar content:
/// - for zero length content
/// - for bad content (parse gzip)
/// - too large content (gzip or uncompressed)
Stream<ArchiveIssue> scanArchiveSurface(
  String archivePath, {
  required int maxArchiveSize,
}) async* {
  // Some platforms may not be able to create an archive, only an empty file.
  final file = File(archivePath);
  if (!file.existsSync() || file.lengthSync() == 0) {
    yield ArchiveIssue('Package archive is empty (size = 0).');
    return;
  }

  // compressed file size check
  if (file.lengthSync() > maxArchiveSize) {
    yield ArchiveIssue(
      'Package archive is too large (size > $maxArchiveSize).',
    );
    return;
  }

  int uncompressedLength = 0;
  try {
    uncompressedLength = await file
        .openRead()
        .transform(gzip.decoder)
        .fold<int>(0, (length, element) => length + element.length);
  } on FormatException catch (e) {
    yield ArchiveIssue('gzip decoder failed: $e.');
    return;
  }

  if (uncompressedLength <= 0) {
    yield ArchiveIssue('Uncompressed archive is empty (size = 0).');
    return;
  } else if (uncompressedLength > maxArchiveSize) {
    yield ArchiveIssue(
      'Uncompressed package archive is too large (size > $maxArchiveSize).',
    );
    return;
  }
}
