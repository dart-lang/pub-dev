// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show DetailedApiRequestError;
import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:pool/pool.dart';
import 'package:retry/retry.dart';

import 'package:pub_dartdoc_data/pub_dartdoc_data.dart';

import '../dartdoc/models.dart' show DartdocEntry;
import '../package/backend.dart';
import '../package/models.dart' show Package, PackageVersion;
import '../scorecard/backend.dart';
import '../shared/datastore.dart';
import '../shared/redis_cache.dart' show cache;
import '../shared/storage.dart';
import '../shared/versions.dart' as shared_versions;

import 'models.dart';
import 'storage_path.dart' as storage_path;

final Logger _logger = Logger('pub.dartdoc.backend');

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

  /// If the server crashed, the pending GC tasks will disappear. This is
  /// acceptable, as - eventually - new dartdoc will be generated in the future,
  /// which will trigger another GC for the package/version, and hopefully
  /// we'll catch up on these files.
  final _gcTasks = <_GCTask>{};

  DartdocBackend(this._db, this._storage)
      : _sdkStorage =
            VersionedJsonStorage(_storage, storage_path.dartSdkDartdocPrefix());

  /// Whether the storage bucket has a usable extracted data file.
  /// Only the existence of the file is checked.
  // TODO: decide whether we should re-generate the file after a certain age
  Future<bool> hasValidDartSdkDartdocData() => _sdkStorage.hasCurrentData();

  /// Upload the generated dartdoc data file for the Dart SDK to the storage bucket.
  Future<void> uploadDartSdkDartdocData(File file) async {
    final map = json.decode(await file.readAsString()) as Map<String, dynamic>;
    await _sdkStorage.uploadDataAsJsonMap(map);
  }

  /// Read the generated dartdoc data file for the Dart SDK.
  Future<PubDartdocData> getDartSdkDartdocData() async {
    final map = await _sdkStorage.getContentAsJsonMap();
    return PubDartdocData.fromJson(map);
  }

  /// Deletes old data files in SDK storage (for old runtimes that are more than
  /// half a year old).
  Future<void> deleteOldData() async {
    await _sdkStorage.deleteOldData(minAgeThreshold: Duration(days: 182));
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
  Future<void> updateOldEntry(DartdocEntry old, DartdocEntry current) async {
    final newEntry = old.replace(
      isLatest: current.isLatest,
      isObsolete: current.isObsolete,
    );
    await _storage.writeBytes(newEntry.entryObjectName, newEntry.asBytes());
  }

  /// Uploads a directory to the storage bucket.
  Future<void> uploadDir(DartdocEntry entry, String dirPath) async {
    final record =
        DartdocRecord.fromEntry(entry, status: DartdocRecordStatus.uploading);
    // store record's upload status
    await withRetryTransaction(_db, (tx) async {
      tx.insert(record);
    });

    // upload is in progress
    await uploadBytesWithRetry(
        _storage, entry.inProgressObjectName, entry.asBytes());

    // upload all files
    final dir = Directory(dirPath);
    final Stream<File> fileStream = dir
        .list(recursive: true)
        .where((fse) => fse is File)
        .map((fse) => fse as File);

    int count = 0;
    Future<void> upload(File file) async {
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

    final sw = Stopwatch()..start();
    final uploadPool = Pool(_concurrentUploads);
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
    await withRetryTransaction(_db, (tx) async {
      final r = await tx.lookupValue<DartdocRecord>(record.key);
      if (r.status == DartdocRecordStatus.uploading) {
        r.status = DartdocRecordStatus.ready;
        tx.insert(r);
      }
    });

    await uploadBytesWithRetry(
        _storage, entry.entryObjectName, entry.asBytes());

    // there is a small chance that the process is interrupted before this gets
    // deleted, but the [removeObsolete] should be able to validate it.
    await deleteFromBucket(_storage, entry.inProgressObjectName);

    await Future.wait([
      cache.dartdocEntry(entry.packageName, entry.packageVersion).purge(),
      cache.dartdocEntry(entry.packageName, 'latest').purge(),
      cache.dartdocApiSummary(entry.packageName).purge(),
    ]);
  }

  /// Return the latest entries that should be used to serve the content.
  ///
  /// If the entry is missing for the current runtimeVersion, the method will
  /// try to load the relevant entry for earlier runtimeVersions.
  Future<List<DartdocEntry>> getEntriesForVersions(
      String package, List<String> versions) async {
    final entries = <String, DartdocEntry>{};

    final pool = Pool(8);
    await Future.wait(versions.map((v) => pool.withResource(() async {
          final cachedEntry = await cache.dartdocEntry(package, v).get();
          if (cachedEntry != null) {
            entries[v] = cachedEntry;
          }
        })));

    final cacheUpdateFutures = <Future>[];
    for (final rv in shared_versions.acceptedRuntimeVersions) {
      final queryVersions =
          versions.where((v) => !entries.containsKey(v)).toList();
      if (queryVersions.isEmpty) break;

      final reports = await scoreCardBackend.loadReportForAllVersions(
        package,
        queryVersions,
        reportType: ReportType.dartdoc,
        runtimeVersion: rv,
      );
      for (var i = 0; i < queryVersions.length; i++) {
        final r = reports[i];
        if (r != null) {
          final version = queryVersions[i];
          final entry = (r as DartdocReport).dartdocEntry;
          if (entry != null) {
            entries[version] = entry;
            cacheUpdateFutures.add(pool.withResource(
                () => cache.dartdocEntry(package, version).set(entry)));
          }
        }
      }
    }
    await Future.wait(cacheUpdateFutures);
    await pool.close();
    return versions.map((v) => entries[v]).toList();
  }

  /// Return the latest entry that should be used to serve the content.
  Future<DartdocEntry> getEntry(String package, String version) async {
    final cachedEntry = await cache.dartdocEntry(package, version).get();
    if (cachedEntry != null) {
      return cachedEntry;
    }

    Future<DartdocEntry> loadVersion(String v) async {
      final entries = await getEntriesForVersions(package, [v]);
      return entries.single;
    }

    DartdocEntry entry;
    if (version != 'latest') {
      entry = await loadVersion(version);
    } else {
      final latestVersion = await packageBackend.getLatestVersion(package);
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

    // Only cache, if this is the latest runtime version
    if (entry != null &&
        entry.runtimeVersion == shared_versions.runtimeVersion) {
      await cache.dartdocEntry(package, version).set(entry);
    }
    return entry;
  }

  /// Returns the file's header from the storage bucket
  Future<FileInfo> getFileInfo(DartdocEntry entry, String relativePath) async {
    final objectName = entry.objectName(relativePath);
    return cache.dartdocFileInfo(objectName).get(
          () async => retry(
            () async {
              try {
                final info = await _storage.info(objectName);
                return FileInfo(lastModified: info.updated, etag: info.etag);
              } catch (e) {
                // TODO: Handle exceptions / errors
                _logger.info('Requested path $objectName does not exists.');
                return null;
              }
            },
            maxAttempts: 2,
          ),
        );
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
  Future<void> removeAll(String package,
      {String version, int concurrency}) async {
    final prefix = version == null ? '$package/' : '$package/$version/';
    await _deleteAllWithPrefix(prefix, concurrency: concurrency);
  }

  /// Scan the Datastore for [DartdocRecord]s and remove the ones that
  /// predate [shared_versions.gcBeforeRuntimeVersion]. This will delete
  /// both the Datastore entity and the Storage Bucket's content.
  Future<void> deleteOldRecords() async {
    final query = _db.query<DartdocRecord>()
      ..filter('runtimeVersion <', shared_versions.gcBeforeRuntimeVersion);
    await for (final r in query.run()) {
      await _deleteAll(r.entry);
    }
  }

  /// Schedules the garbage collection of the [package] and [version].
  ///
  /// The wait queue is in-memory, it is not persisted, and only only works as a
  /// best-effort method to clean up obsolete files.
  /// TODO: implement weekly cleanup process outside of the job processing
  void scheduleGC(String package, String version) {
    _gcTasks.add(_GCTask(package, version));
  }

  /// Runs obsolete GC of old dartdoc files with low overhead (concurrency = 1).
  ///
  /// The function never returns.
  Future<void> processScheduledGCTasks() async {
    for (;;) {
      if (_gcTasks.isEmpty) {
        await Future.delayed(Duration(seconds: 30));
        continue;
      }
      final task = _gcTasks.first;
      _gcTasks.remove(task);
      try {
        await _removeObsolete(task.package, task.version, concurrency: 1);
      } catch (e, st) {
        _logger.warning(
            'Unable to GC files of ${task.package} ${task.version}.', e, st);
      }
    }
  }

  /// Removes incomplete uploads and old outputs from the bucket.
  Future<void> _removeObsolete(String package, String version,
      {int concurrency}) async {
    final completedList =
        await _listEntries(storage_path.entryPrefix(package, version));
    final inProgressList =
        await _listEntries(storage_path.inProgressPrefix(package, version));

    final deleteEntries = [
      ...completedList
          .where((e) => (shared_versions.shouldGCVersion(e.runtimeVersion))),
      ...inProgressList
          .where((e) => (shared_versions.shouldGCVersion(e.runtimeVersion)))
    ];

    // delete everything else
    for (var entry in deleteEntries) {
      await _deleteAll(entry, concurrency: concurrency);
    }
  }

  Future<List<DartdocEntry>> _listEntries(String prefix) async {
    if (!prefix.endsWith('/')) {
      throw ArgumentError('Directory prefix must end with `/`.');
    }
    return retry(
      () async {
        final List<DartdocEntry> list = [];
        await for (final entry in _storage.list(prefix: prefix)) {
          if (entry.isDirectory) continue;
          if (!entry.name.endsWith('.json')) continue;
          final dartdocEntry = await _tryLoadEntryFromBucket(entry.name);
          if (dartdocEntry != null) {
            list.add(dartdocEntry);
          }
        }
        return list;
      },
      maxAttempts: 2,
    );
  }

  /// Tries to load the entry from the storage bucket.
  /// Returns null if the entry was missing or unable to parse.
  Future<DartdocEntry> _tryLoadEntryFromBucket(String objectName) async {
    try {
      return await DartdocEntry.fromStream(_storage.read(objectName));
    } catch (e, st) {
      if (e is DetailedApiRequestError && e.status == 404) {
        // ignore exception: entry was removed by another cleanup process during the listing
      } else {
        _logger.warning('Unable to read entry: $objectName.', e, st);
      }
    }
    return null;
  }

  Future<void> _deleteAll(DartdocEntry entry, {int concurrency}) async {
    await withRetryTransaction(_db, (tx) async {
      final r = await tx.lookupValue<DartdocRecord>(
        _db.emptyKey.append(DartdocRecord, id: entry.uuid),
        orElse: () => null,
      );
      if (r != null) {
        r.status = DartdocRecordStatus.deleting;
        tx.insert(r);
      }
    });

    await _deleteAllWithPrefix(entry.contentPrefix, concurrency: concurrency);
    await deleteFromBucket(_storage, entry.entryObjectName);
    await deleteFromBucket(_storage, entry.inProgressObjectName);
    await withRetryTransaction(_db, (tx) async {
      final r = await tx.lookupValue<DartdocRecord>(
        _db.emptyKey.append(DartdocRecord, id: entry.uuid),
        orElse: () => null,
      );
      if (r != null) {
        tx.delete(r.key);
      }
    });
  }

  Future<void> _deleteAllWithPrefix(String prefix, {int concurrency}) async {
    final Stopwatch sw = Stopwatch()..start();
    final count = await deleteBucketFolderRecursively(_storage, prefix,
        concurrency: concurrency ?? _concurrentDeletes);
    sw.stop();
    _logger.info('$prefix: $count files deleted in ${sw.elapsed}.');
  }
}

class _GCTask {
  final String package;
  final String version;

  _GCTask(this.package, this.version);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _GCTask &&
          runtimeType == other.runtimeType &&
          package == other.package &&
          version == other.version;

  @override
  int get hashCode => package.hashCode ^ version.hashCode;
}
