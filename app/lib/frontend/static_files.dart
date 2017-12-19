// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:mime/mime.dart' as mime;
import 'package:path/path.dart' as path;

/// Stores binary data for /static
final StaticsCache staticsCache = new StaticsCache();

class StaticsCache {
  final Map<String, StaticFile> _staticFiles = <String, StaticFile>{};

  StaticsCache() {
    final staticPath = Platform.script.resolve('../../static').toFilePath();
    final staticsDirectory = new Directory(staticPath).absolute;
    final files = staticsDirectory
        .listSync(recursive: true)
        .where((fse) => fse is File)
        .map((file) => file.absolute as File);

    final staticFiles = files
        .map((File file) => _loadFile(staticsDirectory.path, file))
        .toList();

    for (StaticFile file in staticFiles) {
      final requestPath = '/static/${file.relativePath}';
      _staticFiles[requestPath] = file;
    }
  }

  StaticFile _loadFile(String rootPath, File file) {
    final contentType = mime.lookupMimeType(file.path) ?? 'octet/binary';
    final bytes = file.readAsBytesSync();
    final lastModified = file.lastModifiedSync();
    final String relativePath = path.relative(file.path, from: rootPath);
    return new StaticFile(relativePath, contentType, bytes, lastModified);
  }

  StaticFile getFile(String requestedPath) => _staticFiles[requestedPath];
}

class StaticFile {
  final String relativePath;
  final String contentType;
  final List<int> bytes;
  final DateTime lastModified;

  StaticFile(
      this.relativePath, this.contentType, this.bytes, this.lastModified);
}
