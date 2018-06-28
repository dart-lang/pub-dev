// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:pool/pool.dart';
import 'package:pub_semver/pub_semver.dart';

import '../frontend/models.dart' show Package, PackageVersion;

import '../shared/dartdoc_memcache.dart';
import '../shared/task_scheduler.dart' show TaskTargetStatus;
import '../shared/utils.dart' show contentType;

import 'models.dart';
import 'storage_path.dart' as storage_path;

final Logger _logger = new Logger('pub.dartdoc.backend');

final Duration _contentDeleteThreshold = const Duration(days: 1);
final int _concurrentUploads = 8;
final int _concurrentDeletes = 8;

/// Sets the dartdoc backend.
void registerDartdocBackend(DartdocBackend backend) =>
    ss.register(#_dartdocBackend, backend);

/// The active dartdoc backend.
DartdocBackend get dartdocBackend =>
    ss.lookup(#_dartdocBackend) as DartdocBackend;

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

  Future<List<String>> getLatestVersions(String package,
      {int limit: 10}) async {
    final query = _db.query(PackageVersion,
        ancestorKey: _db.emptyKey.append(Package, id: package));
    final versions = (await query.run().toList()).cast<PackageVersion>();
    versions.sort((a, b) {
      final isAPreRelease = a.semanticVersion.isPreRelease;
      final isBPreRelease = b.semanticVersion.isPreRelease;
      if (isAPreRelease != isBPreRelease) {
        return isAPreRelease ? 1 : -1;
      }
      return -a.created.compareTo(b.created);
    });
    return versions.map((pv) => pv.version).take(limit).toList();
  }

  /// Uploads a directory to the storage bucket.
  Future uploadDir(DartdocEntry entry, String dirPath) async {
    // upload is in progress
    await _storage.writeBytes(entry.inProgressObjectName, entry.asBytes());

    // upload all files
    final dir = new Directory(dirPath);
    final Stream<File> fileStream = dir
        .list(recursive: true)
        .where((fse) => fse is File)
        .map((fse) => fse as File);

    int count = 0;
    Future upload(File file) async {
      final relativePath = p.relative(file.path, from: dir.path);
      final objectName = entry.objectName(relativePath);
      final isShared = storage_path.isSharedAsset(relativePath);
      if (isShared) {
        final info = await getFileInfo(entry, relativePath);
        if (info != null) return;
      }
      try {
        final sink =
            _storage.write(objectName, contentType: contentType(objectName));
        await sink.addStream(file.openRead());
        await sink.close();
        count++;
        if (count % 100 == 0) {
          _logger.info('Upload completed: $objectName (item #$count)');
        }
      } catch (e, st) {
        _logger.severe('Upload to $objectName failed with $e', st);
        rethrow;
      }
    }

    final sw = new Stopwatch()..start();
    final uploadPool = new Pool(_concurrentUploads);
    final List<Future> uploadFutures = [];
    await for (File file in fileStream) {
      final pooledUpload = uploadPool.withResource(() => upload(file));
      uploadFutures.add(pooledUpload);
    }
    await Future.wait(uploadFutures);
    await uploadPool.close();
    sw.stop();
    _logger.info('${entry.packageName} ${entry.packageVersion}: '
        '$count files uploaded in ${sw.elapsed}.');

    // upload was completed
    await _storage.writeBytes(entry.entryObjectName, entry.asBytes());

    // there is a small chance that the process is interrupted before this gets
    // deleted, but the [removeObsolete] should be able to validate it.
    await _storage.delete(entry.inProgressObjectName);

    await dartdocMemcache?.invalidate(entry.packageName, entry.packageVersion);
  }

  Future<TaskTargetStatus> checkTargetStatus(String package, String version,
      DateTime updated, bool retryFailed) async {
    final entry = await getLatestEntry(package, version);
    if (entry == null) {
      return new TaskTargetStatus.ok();
    }
    if (updated != null && updated.isAfter(entry.timestamp)) {
      return new TaskTargetStatus.ok();
    }
    return entry.checkTargetStatus(retryFailed: retryFailed);
  }

  /// Return the latest entry that should be used to serve the content.
  Future<DartdocEntry> getServingEntry(String package, String version) async {
    final cachedContent =
        await dartdocMemcache?.getEntryBytes(package, version, true);
    if (cachedContent != null) {
      return new DartdocEntry.fromBytes(cachedContent);
    }

    Future<DartdocEntry> loadVersion(String v) async {
      final List<DartdocEntry> completedList =
          await _listEntries(storage_path.entryPrefix(package, v));
      if (completedList.isEmpty) return null;
      final hasServing = completedList.any((entry) => entry.isServing);
      // don't remove non-serving entries if they are the only ones left
      if (hasServing) {
        completedList.removeWhere((entry) => !entry.isServing);
      }
      completedList.sort((a, b) => -a.timestamp.compareTo(b.timestamp));
      return completedList.first;
    }

    DartdocEntry entry;
    if (version != 'latest') {
      entry = await loadVersion(version);
    } else {
      final latestVersion = await dartdocBackend.getLatestVersion(package);
      if (latestVersion == null) {
        return null;
      }
      entry = await loadVersion(latestVersion);

      if (entry == null) {
        final versions = await dartdocBackend.getLatestVersions(package);
        versions.remove(latestVersion);
        for (String v in versions.take(2)) {
          entry = await loadVersion(v);
          if (entry != null) break;
        }
      }
    }

    if (entry != null) {
      await dartdocMemcache?.setEntryBytes(
          package, version, true, entry.asBytes());
    }
    return entry;
  }

  /// Return the latest entry.
  Future<DartdocEntry> getLatestEntry(String package, String version) async {
    final List<DartdocEntry> completedList =
        await _listEntries(storage_path.entryPrefix(package, version));
    if (completedList.isEmpty) return null;
    completedList.sort((a, b) => -a.timestamp.compareTo(b.timestamp));
    return completedList.first;
  }

  /// Returns the file's header from the storage bucket
  Future<FileInfo> getFileInfo(DartdocEntry entry, String relativePath) async {
    final objectName = entry.objectName(relativePath);
    final cachedContent = await dartdocMemcache?.getFileInfoBytes(objectName);
    if (cachedContent != null) {
      return new FileInfo.fromBytes(cachedContent);
    }
    try {
      final info = await _storage.info(objectName);
      if (info == null) return null;
      final fileInfo =
          new FileInfo(lastModified: info.updated, etag: info.etag);
      dartdocMemcache?.setFileInfoBytes(objectName, fileInfo.asBytes());
      return fileInfo;
    } catch (e) {
      _logger.info('Requested path $objectName does not exists.');
    }
    return null;
  }

  /// Returns a file's content from the storage bucket.
  Stream<List<int>> readContent(DartdocEntry entry, String relativePath) {
    final objectName = entry.objectName(relativePath);
    // TODO: add caching with memcache
    _logger.info('Retrieving $objectName from bucket.');
    return _storage.read(objectName);
  }

  /// Removes all files related to a package.
  Future removeAll(String package, {String version}) async {
    final prefix = version == null ? '$package/' : '$package/$version/';
    await _deleteAllWithPrefix(prefix);
  }

  /// Removes incomplete uploads and old outputs from the bucket.
  Future removeObsolete(String package, String version) async {
    final List<DartdocEntry> completedList =
        await _listEntries(storage_path.entryPrefix(package, version));
    final List<DartdocEntry> inProgressList =
        await _listEntries(storage_path.inProgressPrefix(package, version));

    for (var entry in inProgressList) {
      if (completedList.any((e) => e.uuid == entry.uuid)) {
        // upload was interrupted between setting the final entry and removing
        // the in-progress indicator. Doing the later now.
        await _storage.delete(entry.inProgressObjectName);
      } else {
        final age = new DateTime.now().difference(entry.timestamp).abs();
        if (age > _contentDeleteThreshold) {
          await _deleteAll(entry);
          await _storage.delete(entry.inProgressObjectName);
        }
      }
    }

    // keep entries that are not serving (there is a coordinated upgrade in progress)
    completedList.removeWhere((entry) => !entry.isServing);

    // Keep the latest two (serving) runtime versions. It is assumed that the
    // newer is for this release, while the earlier is for the previous release.
    if (completedList.isNotEmpty) {
      final versions = completedList
          .map((entry) => entry.runtimeVersion)
          .toSet()
          .map((String version) => new Version.parse(version))
          .toList();
      versions.sort();

      void keepOneRuntimeVersion() {
        if (versions.isEmpty) return;
        final version = versions.removeLast();
        final index = completedList.lastIndexWhere(
            (entry) => entry.runtimeVersion == version.toString());
        if (index < 0) return;
        completedList.removeAt(index);
      }

      completedList.sort((a, b) => a.timestamp.compareTo(b.timestamp));

      keepOneRuntimeVersion(); // keeps current serving version
      keepOneRuntimeVersion(); // keeps previous serving version
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
    await _deleteAllWithPrefix(entry.contentPrefix);
    await _storage.delete(entry.entryObjectName);
  }

  Future _deleteAllWithPrefix(String prefix) async {
    final Stopwatch sw = new Stopwatch()..start();
    var page = await _storage.page(prefix: prefix);
    final deletePool = new Pool(_concurrentDeletes);
    int count = 0;
    for (;;) {
      final List<Future> deleteFutures = [];
      for (var item in page.items) {
        count++;
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
    sw.stop();
    _logger.info('$prefix: $count files deleted in ${sw.elapsed}.');
  }
}

// Tracks the disk space and network requirements of downloading the dartdoc
// package archive to the local disk and serving the content from there.
// TODO: remove after tracking confirmed size requirements
class ArchiveTracker {
  final _pvMap = <String, _TrackedEntry>{};
  final _sampleLines = <String>[];
  final bool trackRequests;

  ArchiveTracker({this.trackRequests: false}) {
    new Timer.periodic(const Duration(minutes: 10), (_) => _cleanup());
    new Timer.periodic(const Duration(minutes: 45), (_) => _logSample());
  }

  List<String> get samples => _sampleLines;

  void track(DartdocEntry entry) {
    final key = '${entry.packageName}/${entry.packageVersion}';
    final tracked = _pvMap.putIfAbsent(key, () => new _TrackedEntry());
    tracked.archiveSize = entry.archiveSize ?? 0;
    tracked.totalSize = entry.totalSize ?? 0;
    tracked.lastAccess = new DateTime.now().toUtc();
    if (trackRequests) {
      tracked.requestCount++;
    }
  }

  void _cleanup() {
    final now = new DateTime.now().toUtc();
    _pvMap.removeWhere((key, value) {
      final age = now.difference(value.lastAccess);
      return age.inMinutes > 90;
    });
  }

  void _logSample() {
    final now = new DateTime.now().toUtc();
    final count = _pvMap.length;

    final total = _pvMap.values.fold(0, (sum, tracked) {
      return sum + tracked.totalSize;
    });
    final totalMB = total ~/ _mb;
    final archive = _pvMap.values.fold(0, (sum, tracked) {
      return sum + tracked.archiveSize;
    });
    final archiveMB = archive ~/ _mb;
    // roughly one and half days of samples
    if (_sampleLines.length > 48) {
      _sampleLines.removeAt(0);
    }
    final requestCount =
        _pvMap.values.fold(0, (sum, tracked) => sum + tracked.requestCount);
    _sampleLines.add(
        '${now.toIso8601String()} count: $count, total: $totalMB MB, archive: $archiveMB MB, requests: $requestCount');
  }
}

class _TrackedEntry {
  int totalSize;
  int archiveSize;
  int requestCount = 0;
  DateTime lastAccess;
}

const _mb = 1024 * 1024;
