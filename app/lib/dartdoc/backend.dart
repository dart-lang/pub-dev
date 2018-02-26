// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:pool/pool.dart';

import '../frontend/models.dart' show Package;

import '../shared/task_scheduler.dart' show Task;
import '../shared/utils.dart' show contentType;

import 'models.dart';

final Logger _logger = new Logger('pub.dartdoc.backend');

final Duration entryUpdateThreshold = const Duration(days: 90);
final Duration _contentDeleteThreshold = const Duration(days: 1);
final int concurrentUploads = 4;
final int concurrentDeletes = 4;

/// Sets the dartdoc backend.
void registerDartdocBackend(DartdocBackend backend) =>
    ss.register(#_dartdocBackend, backend);

/// The active dartdoc backend.
DartdocBackend get dartdocBackend => ss.lookup(#_dartdocBackend);

class DartdocBackend {
  DatastoreDB _db;
  Bucket _storage;

  DartdocBackend(this._db, this._storage);

  /// Returns the latest stable version of a package.
  Future<String> getLatestVersion(String package) async {
    final list = await _db.lookup([_db.emptyKey.append(Package, id: package)]);
    final Package p = list.single;
    return p?.latestVersion;
  }

  /// Uploads a directory to the storage bucket.
  Future uploadDir(DartdocEntry entry, String dirPath) async {
    // upload is in progress
    await _storage.writeBytes(entry.inProgressPath, entry.asBytes());

    // upload all files
    final objectPrefix = entry.contentPrefix;
    final dir = new Directory(dirPath);
    final Stream<File> fileStream = dir
        .list(recursive: true)
        .where((fse) => fse is File)
        .map((fse) => fse as File);

    Future upload(File file) async {
      final relativePath = p.relative(file.path, from: dir.path);
      final objectName = p.join(objectPrefix, relativePath);
      _logger.info('Uploading to $objectName...');
      try {
        final sink =
            _storage.write(objectName, contentType: contentType(objectName));
        await sink.addStream(file.openRead());
        await sink.close();
      } catch (e, st) {
        _logger.severe('Upload to $objectName failed with $e', st);
        rethrow;
      }
    }

    final uploadPool = new Pool(concurrentUploads);
    final List<Future> uploadFutures = [];
    await for (File file in fileStream) {
      final pooledUpload = uploadPool.withResource(() => upload(file));
      uploadFutures.add(pooledUpload);
    }
    await Future.wait(uploadFutures);
    await uploadPool.close();

    // upload was completed
    await _storage.writeBytes(entry.entryPath, entry.asBytes());

    // there is a small chance that the process is interrupted before this gets
    // deleted, but the [removeObsolete] should be able to validate it.
    await _storage.delete(entry.inProgressPath);
  }

  Future<bool> shouldRunTask(Task task) async {
    final entry = await getLatestEntry(task.package, task.version, false);
    if (entry == null) {
      return true;
    }
    if (entry.requiresNewRun()) {
      return true;
    }
    if (task.updated != null && task.updated.isAfter(entry.timestamp)) {
      return true;
    }
    final age = new DateTime.now().difference(entry.timestamp).abs();
    if (age > entryUpdateThreshold) {
      return true;
    }
    return false;
  }

  /// Return the latest entry that should be used to serve the content.
  Future<DartdocEntry> getLatestEntry(
      String package, String version, bool serving) async {
    // TODO: add caching with memcache
    final List<DartdocEntry> completedList =
        await _listEntries(DartdocEntryPaths.entryPrefix(package, version));
    if (serving) {
      completedList.removeWhere((entry) => !entry.isServing);
    }
    if (completedList.isEmpty) return null;
    completedList.sort((a, b) => -a.timestamp.compareTo(b.timestamp));
    return completedList.first;
  }

  /// Returns the file's header from the storage bucket
  Future<FileInfo> getFileInfo(DartdocEntry entry, String relativePath) async {
    final objectName = p.join(entry.contentPrefix, relativePath);
    try {
      final info = await _storage.info(objectName);
      if (info == null) return null;
      return new FileInfo(lastModified: info.updated, etag: info.etag);
    } catch (e) {
      _logger.info('Requested path $objectName does not exists.');
    }
    return null;
  }

  /// Returns a file's content from the storage bucket.
  Stream<List<int>> readContent(DartdocEntry entry, String relativePath) {
    final objectName = p.join(entry.contentPrefix, relativePath);
    // TODO: add caching with memcache
    _logger.info('Retrieving $objectName from bucket.');
    return _storage.read(objectName);
  }

  /// Removes incomplete uploads and old outputs from the bucket.
  Future removeObsolete(String package, String version) async {
    final List<DartdocEntry> completedList =
        await _listEntries(DartdocEntryPaths.entryPrefix(package, version));
    final List<DartdocEntry> inProgressList = await _listEntries(
        DartdocEntryPaths.inProgressPrefix(package, version));

    for (var entry in inProgressList) {
      if (completedList.any((e) => e.uuid == entry.uuid)) {
        // upload was interrupted between setting the final entry and removing
        // the in-progress indicator. Doing the later now.
        await _storage.delete(entry.inProgressPath);
      } else {
        final age = new DateTime.now().difference(entry.timestamp).abs();
        if (age > _contentDeleteThreshold) {
          await _deleteAll(entry);
          await _storage.delete(entry.inProgressPath);
        }
      }
    }

    // keep entries that are not serving (there is a coordinated upgrade in progress)
    completedList.removeWhere((entry) => !entry.isServing);

    // keep the latest serving
    if (completedList.isNotEmpty) {
      completedList.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      completedList.removeLast();
    }

    // delete everything else
    for (var entry in completedList) {
      final age = new DateTime.now().difference(entry.timestamp).abs();
      if (age > _contentDeleteThreshold) {
        await _deleteAll(entry);
      }
    }
  }

  Future<List<DartdocEntry>> _listEntries(String prefix) async {
    final List<DartdocEntry> list = [];
    await for (final entry in _storage.list(prefix: prefix)) {
      if (entry.isDirectory) continue;
      if (!entry.name.endsWith('.json')) continue;

      try {
        list.add(await DartdocEntry.fromStream(_storage.read(entry.name)));
      } catch (e, st) {
        _logger.warning('Unable to read entry: ${entry.name}.', st);
      }
    }
    return list;
  }

  Future _deleteAll(DartdocEntry entry) async {
    var page = await _storage.page(prefix: entry.contentPrefix);
    final deletePool = new Pool(concurrentDeletes);
    for (;;) {
      final List<Future> deleteFutures = [];
      for (var item in page.items) {
        final pooledDelete =
            deletePool.withResource(() => _storage.delete(item.name));
        deleteFutures.add(pooledDelete);
      }
      await Future.wait(deleteFutures);
      if (page.isLast) {
        break;
      } else {
        page = await page.next();
      }
    }
    await deletePool.close();
    await _storage.delete(entry.entryPath);
  }
}

class FileInfo {
  final DateTime lastModified;
  final String etag;
  FileInfo({@required this.lastModified, @required this.etag});
}
