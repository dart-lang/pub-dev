// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
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
import '../shared/storage.dart';
import '../shared/versions.dart' as shared_versions;

import 'models.dart';
import 'pub_dartdoc_data.dart';
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
  final DatastoreDB _db;
  final Bucket _storage;
  final VersionedJsonStorage _sdkStorage;

  DartdocBackend(this._db, this._storage)
      : _sdkStorage = new VersionedJsonStorage(
            _storage, '${storage_path.dartSdkDartdocPrefix()}/');

  /// Whether the storage bucket has a usable extracted data file.
  /// Only the existence of the file is checked.
  // TODO: decide whether we should re-generate the file after a certain age
  Future<bool> hasValidDartSdkDartdocData() => _sdkStorage.hasCurrentData();

  /// Upload the generated dartdoc data file for the Dart SDK to the storage bucket.
  Future uploadDartSdkDartdocData(File file) async {
    final map = json.decode(await file.readAsString()) as Map<String, dynamic>;
    await _sdkStorage.uploadDataAsJsonMap(map);
  }

  /// Read the generated dartdoc data file for the Dart SDK.
  Future<PubDartdocData> getDartSdkDartdocData() async {
    final map = await _sdkStorage.getContentAsJsonMap();
    return new PubDartdocData.fromJson(map);
  }

  /// Schedules the delete of old data files.
  void scheduleOldDataGC() {
    _sdkStorage.scheduleOldDataGC();
  }

  /// Returns the latest stable version of a package.
  Future<String> getLatestVersion(String package) async {
    final list = await _db.lookup([_db.emptyKey.append(Package, id: package)]);
    final Package p = list.single;
    return p?.latestVersion;
  }

  Future<List<String>> getLatestVersions(String package,
      {int limit = 10}) async {
    final query = _db.query<PackageVersion>(
        ancestorKey: _db.emptyKey.append(Package, id: package));
    final versions = await query.run().cast<PackageVersion>().toList();
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

  /// Updates the [old] entry with the status fields from the [current] one.
  Future updateOldEntry(DartdocEntry old, DartdocEntry current) async {
    final newEntry = old.replace(
      isLatest: current.isLatest,
      isObsolete: current.isObsolete,
    );
    await _storage.writeBytes(newEntry.entryObjectName, newEntry.asBytes());
  }

  /// Uploads a directory to the storage bucket.
  Future uploadDir(DartdocEntry entry, String dirPath) async {
    // upload is in progress
    await uploadBytesWithRetry(
        _storage, entry.inProgressObjectName, entry.asBytes());

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
      await uploadWithRetry(
          _storage, objectName, file.lengthSync(), () => file.openRead());
      count++;
      if (count % 100 == 0) {
        _logger.info('Upload completed: $objectName (item #$count)');
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
    await uploadBytesWithRetry(
        _storage, entry.entryObjectName, entry.asBytes());

    // there is a small chance that the process is interrupted before this gets
    // deleted, but the [removeObsolete] should be able to validate it.
    await deleteFromBucket(_storage, entry.inProgressObjectName);

    await dartdocMemcache?.invalidate(entry.packageName, entry.packageVersion);
  }

  /// Return the latest entry that should be used to serve the content.
  Future<DartdocEntry> getServingEntry(String package, String version) async {
    final cachedEntry = await dartdocMemcache?.getEntry(package, version);
    if (cachedEntry != null) {
      return cachedEntry;
    }

    Future<DartdocEntry> loadVersion(String v) async {
      final List<DartdocEntry> entries =
          await _listEntries(storage_path.entryPrefix(package, v));
      // utility to remove anything not matching pred, unless that is everything
      void retainIfAny(bool pred(DartdocEntry entry)) {
        if (entries.any(pred)) {
          entries.retainWhere(pred);
        }
      }

      retainIfAny((e) => e.isServing && e.hasContent);
      retainIfAny((e) => e.hasContent);
      retainIfAny((e) => e.runtimeVersion == shared_versions.runtimeVersion);
      entries.sort((a, b) => -a.timestamp.compareTo(b.timestamp));
      return entries.isEmpty ? null : entries.first;
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

    await dartdocMemcache?.setEntry(entry);
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

  Future<String> getTextContent(DartdocEntry entry, String relativePath) async {
    final stream = readContent(entry, relativePath);
    return (await stream.transform(utf8.decoder).toList()).join();
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
        await deleteFromBucket(_storage, entry.inProgressObjectName);
      } else {
        final age = new DateTime.now().difference(entry.timestamp).abs();
        if (age > _contentDeleteThreshold) {
          await _deleteAll(entry);
          await deleteFromBucket(_storage, entry.inProgressObjectName);
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
          .where((s) => s != null) // protect against old entries without it
          .toSet()
          .map((String version) => new Version.parse(version))
          .toList();
      versions.sort();

      completedList.sort((a, b) => a.timestamp.compareTo(b.timestamp));

      // Keep the latest one with content.
      if (completedList.isNotEmpty) {
        final index = completedList.lastIndexWhere((entry) => entry.hasContent);
        if (index >= 0) {
          final entry = completedList[index];
          completedList.removeAt(index);
          versions.remove(new Version.parse(entry.runtimeVersion));
        }
      }

      // Keep the latest from the current runtime version.
      if (versions.contains(shared_versions.semanticRuntimeVersion)) {
        final index = completedList.lastIndexWhere(
            (entry) => entry.runtimeVersion == shared_versions.runtimeVersion);
        if (index >= 0) {
          completedList.removeAt(index);
          versions.remove(shared_versions.semanticRuntimeVersion);
        }
      }

      // Keep the otherwise latest version (may be an ongoing release).
      if (versions.isNotEmpty) {
        if (versions.isEmpty) return;
        final version = versions.removeLast();
        final index = completedList.lastIndexWhere(
            (entry) => entry.runtimeVersion == version.toString());
        if (index >= 0) {
          completedList.removeAt(index);
        }
      }
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
    await deleteFromBucket(_storage, entry.entryObjectName);
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
        final pooledDelete = deletePool
            .withResource(() => deleteFromBucket(_storage, item.name));
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
