// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:mime/mime.dart' as mime;

class StaticsCache {
  final Map<String, StaticFile> staticFiles = <String, StaticFile>{};

  StaticsCache(String staticPath) {
    final Directory staticsDirectory = new Directory(staticPath);
    final files = staticsDirectory
        .listSync(recursive: true)
        .where((fse) => fse is File)
        .map((file) => file.absolute);

    for (final File file in files) {
      final contentType = mime.lookupMimeType(file.path) ?? 'octet/binary';
      final bytes = file.readAsBytesSync();
      final lastModified = file.lastModifiedSync();
      staticFiles[file.path] = new StaticFile(contentType, bytes, lastModified);
    }
  }
}

class StaticFile {
  final String contentType;
  final List<int> bytes;
  final DateTime lastModified;

  StaticFile(this.contentType, this.bytes, this.lastModified);
}
