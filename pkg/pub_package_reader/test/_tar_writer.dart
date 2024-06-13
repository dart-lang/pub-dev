// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:tar/tar.dart';

/// Creates a .tar.gz file with content.
Future<void> writeTarGzFile(
  File file, {
  Map<String, String>? textFiles,
  Map<String, String>? symlinks,
}) async {
  await () async* {
    if (textFiles != null) {
      for (final e in textFiles.entries) {
        yield TarEntry.data(
            TarHeader(
              name: e.key,
              mode: 420, // 644₈
            ),
            utf8.encode(e.value));
      }
    }
    if (symlinks != null) {
      for (final e in symlinks.entries) {
        yield TarEntry.data(
            TarHeader(
              name: e.key,
              linkName: e.value,
              typeFlag: TypeFlag.symlink,
              mode: 420, // 644₈
            ),
            Uint8List(0));
      }
    }
  }()
      .cast<TarEntry>()
      .transform(tarWriter)
      .transform(gzip.encoder)
      .pipe(file.openWrite());
}
