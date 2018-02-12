// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

final Logger _logger = new Logger('pub.dartdoc.backend');

/// Sets the dartdoc backend.
void registerDartdocBackend(DartdocBackend backend) =>
    ss.register(#_dartdocBackend, backend);

/// The active dartdoc backend.
DartdocBackend get dartdocBackend => ss.lookup(#_dartdocBackend);

class DartdocBackend {
  Bucket _storage;

  DartdocBackend(this._storage);

  /// Uploads a directory to the storage bucket.
  Future uploadDir(String dirPath, String objectPrefix) async {
    final dir = new Directory(dirPath);
    final Stream<File> fileStream = dir
        .list(recursive: true)
        .where((fse) => fse is File)
        .map((fse) => fse as File);
    await for (File file in fileStream) {
      final relativePath = p.relative(file.path, from: dir.path);
      final objectName = p.join(objectPrefix, relativePath);
      _logger.info('Uploading to $objectName...');
      try {
        final sink = _storage.write(objectName);
        await sink.addStream(file.openRead());
        await sink.close();
      } catch (e, st) {
        _logger.severe('Upload to $objectName failed with $e', st);
        rethrow;
      }
    }
  }

  /// Returns a file's content from the storage bucket.
  Stream<List<int>> read(String objectName) => _storage.read(objectName);
}
