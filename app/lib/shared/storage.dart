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
  return storage.bucket(name);
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
    Stream<List<int>> Function() openStream) async {
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
  Future<void> uploadDataAsJsonMap(Map<String, dynamic> map) async {
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
    _logger.info('Loading snapshot: $objectName');
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
    final list = await _bucket
        .list(prefix: _prefix)
        .map((entry) => entry.name)
        .where((name) => name.endsWith(_extension))
        .where((name) => name.compareTo(currentPath) <= 0)
        .map((name) =>
            name.substring(_prefix.length, name.length - _extension.length))
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
  Future<void> deleteOldData({Duration minAgeThreshold}) async {
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
