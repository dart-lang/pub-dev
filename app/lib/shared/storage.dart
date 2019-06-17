// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show DetailedApiRequestError;
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:retry/retry.dart';

import 'utils.dart' show contentType, retryAsync;
import 'versions.dart' as versions;

final _gzip = GZipCodec();
final _logger = Logger('shared.storage');
final _random = math.Random.secure();

/// Returns a valid `gs://` URI for a given [bucket] + [path] combination.
String bucketUri(Bucket bucket, String path) =>
    'gs://${bucket.bucketName}/$path';

Future<Bucket> getOrCreateBucket(Storage storage, String name) async {
  if (!await storage.bucketExists(name)) {
    await storage.createBucket(name);
  }
  return RetryingBucket(storage.bucket(name));
}

Future deleteFromBucket(Bucket bucket, String objectName) async {
  try {
    await bucket.delete(objectName);
  } on DetailedApiRequestError catch (e) {
    if (e.status != 404) {
      rethrow;
    }
  }
}

/// Uploads content from [openStream] to the [bucket] as [objectName].
Future uploadWithRetry(Bucket bucket, String objectName, int length,
    Stream<List<int>> openStream()) async {
  await retryAsync(
    () async {
      final sink = bucket.write(objectName,
          length: length, contentType: contentType(objectName));
      await sink.addStream(openStream());
      await sink.close();
    },
    description: 'Upload to $objectName',
    shouldRetryOnError: (e) {
      if (e is DetailedApiRequestError) {
        return e.status == 502 || e.status == 503;
      }
      return false;
    },
    sleep: Duration(seconds: 10),
  );
}

/// Uploads content from [bytes] to the [bucket] as [objectName].
Future uploadBytesWithRetry(
        Bucket bucket, String objectName, List<int> bytes) =>
    uploadWithRetry(
        bucket, objectName, bytes.length, () => Stream.fromIterable([bytes]));

/// Utility class to access versioned JSON data that follows the name pattern:
/// "/path-prefix/runtime-version.json.gz".
class VersionedJsonStorage {
  final Bucket _bucket;
  final String _prefix;
  final String _extension = '.json.gz';

  VersionedJsonStorage(Bucket bucket, String prefix)
      : _bucket = bucket,
        _prefix = prefix {
    assert(prefix.endsWith('/'));
  }

  /// Whether the storage bucket has a data file for the current runtime version.
  /// TODO: decide whether we should re-generate the file after a certain age
  Future<bool> hasCurrentData() async {
    try {
      final info = await _bucket.info(_objectName());
      return info != null;
    } catch (e) {
      if (e is DetailedApiRequestError && e.status == 404) {
        return false;
      }
      rethrow;
    }
  }

  /// Upload the current data to the storage bucket.
  Future uploadDataAsJsonMap(Map<String, dynamic> map) async {
    final objectName = _objectName();
    final bytes = _gzip.encode(utf8.encode(json.encode(map)));
    try {
      await uploadBytesWithRetry(_bucket, objectName, bytes);
    } catch (e, st) {
      _logger.warning('Unable to upload data file: $objectName', e, st);
    }
  }

  /// Gets the content of the data file decoded as JSON Map.
  Future<Map<String, dynamic>> getContentAsJsonMap(
      [String version = versions.runtimeVersion]) async {
    final objectName = _objectName(version);
    final map = await _bucket
        .read(objectName)
        .transform(_gzip.decoder)
        .transform(utf8.decoder)
        .transform(json.decoder)
        .single;
    return map as Map<String, dynamic>;
  }

  /// Returns the latest version of the data file matching the current version
  /// or created earlier.
  Future<String> detectLatestVersion() async {
    final currentPath = _objectName();
    final targetLength = currentPath.length;
    final list = await _bucket
        .list(prefix: _prefix)
        .map((entry) => entry.name)
        .where((name) => name.length == targetLength)
        .where((name) => name.endsWith(_extension))
        .where((name) => name.compareTo(currentPath) <= 0)
        .map((name) => name.substring(_prefix.length, _prefix.length + 10))
        .where((version) => versions.runtimeVersionPattern.hasMatch(version))
        .toList();
    if (list.isEmpty) {
      return null;
    }
    if (list.length == 1) {
      return list.single;
    }
    return list.fold<String>(list.first, (a, b) => a.compareTo(b) < 0 ? b : a);
  }

  /// Deletes the old entries that predate [versions.gcBeforeRuntimeVersion].
  ///
  /// When [minAgeThreshold] is specified, only older files will be deleted. The
  /// process assumes that if an old runtimeVersion is still active, it will
  /// update it periodically, and a cleanup should preserve such files.
  Future deleteOldData({Duration minAgeThreshold}) async {
    await for (BucketEntry entry in _bucket.list(prefix: _prefix)) {
      if (entry.isDirectory) {
        continue;
      }
      final name = p.basename(entry.name);
      if (!name.endsWith(_extension)) {
        continue;
      }
      final version = name.substring(0, name.length - _extension.length);
      final matchesPattern = version.length == 10 &&
          versions.runtimeVersionPattern.hasMatch(version);
      if (matchesPattern &&
          version.compareTo(versions.gcBeforeRuntimeVersion) < 0) {
        final info = await _bucket.info(entry.name);
        final age = DateTime.now().difference(info.updated);
        if (minAgeThreshold == null || age > minAgeThreshold) {
          await deleteFromBucket(_bucket, entry.name);
        }
      }
    }
  }

  /// Schedules a GC of old data files to be run in the next 6 hours.
  void scheduleOldDataGC({Duration minAgeThreshold}) {
    // Run GC in the next 6 hours (randomized wait to reduce race).
    Timer(Duration(minutes: _random.nextInt(360)), () async {
      try {
        await deleteOldData(
            minAgeThreshold: minAgeThreshold ?? const Duration(days: 182));
      } catch (e, st) {
        _logger.warning('Error while deleting old data.', e, st);
      }
    });
  }

  String getBucketUri([String version = versions.runtimeVersion]) =>
      bucketUri(_bucket, _objectName(version));

  String _objectName([String version = versions.runtimeVersion]) {
    assert(version != null);
    return '$_prefix$version$_extension';
  }
}

/// A [Bucket] wrapper that retries failed read attempts.
class RetryingBucket implements Bucket {
  final Bucket _bucket;
  final RetryOptions _retryOptions;
  RetryingBucket(this._bucket, [RetryOptions options])
      : _retryOptions = options ?? RetryOptions();

  @override
  String absoluteObjectName(String objectName) {
    return _bucket.absoluteObjectName(objectName);
  }

  @override
  String get bucketName => _bucket.bucketName;

  @override
  Future delete(String name) {
    return _retry(() => _bucket.delete(name));
  }

  @override
  Future<ObjectInfo> info(String name) => _retry(() => _bucket.info(name));

  @override
  Stream<BucketEntry> list({String prefix}) async* {
    final entries = await _retry(() => _bucket.list(prefix: prefix).toList());
    for (final entry in entries) {
      yield entry;
    }
  }

  @override
  Future<Page<BucketEntry>> page({String prefix, int pageSize = 50}) =>
      // TODO: use retry and also wrap Page.next
      _bucket.page(prefix: prefix, pageSize: pageSize);

  @override
  Stream<List<int>> read(String objectName, {int offset, int length}) async* {
    final chunks = await _retry(() =>
        _bucket.read(objectName, offset: offset, length: length).toList());
    for (final chunk in chunks) {
      yield chunk;
    }
  }

  @override
  Future updateMetadata(String objectName, ObjectMetadata metadata) =>
      _retry(() => _bucket.updateMetadata(objectName, metadata));

  @override
  StreamSink<List<int>> write(String objectName,
      {int length,
      ObjectMetadata metadata,
      Acl acl,
      PredefinedAcl predefinedAcl,
      String contentType}) {
    // TODO: Buffer sinked bytes and use retry to upload them.
    return _bucket.write(
      objectName,
      length: length,
      metadata: metadata,
      acl: acl,
      predefinedAcl: predefinedAcl,
      contentType: contentType,
    );
  }

  @override
  Future<ObjectInfo> writeBytes(String name, List<int> bytes,
      {ObjectMetadata metadata,
      Acl acl,
      PredefinedAcl predefinedAcl,
      String contentType}) {
    return _retry(() => _bucket.writeBytes(
          name,
          bytes,
          metadata: metadata,
          acl: acl,
          predefinedAcl: predefinedAcl,
          contentType: contentType,
        ));
  }

  Future<T> _retry<T>(FutureOr<T> Function() fn) {
    return _retryOptions.retry(
      () async {
        try {
          return await fn();
        } on DetailedApiRequestError catch (e) {
          if (e.status >= 500) {
            throw _RetryException();
          } else {
            rethrow;
          }
        }
      },
      retryIf: (ex) => ex is _RetryException,
    );
  }
}

class _RetryException implements Exception {}
