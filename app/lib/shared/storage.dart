// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show DetailedApiRequestError;
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

import 'utils.dart' show contentType, retryAsync;
import 'versions.dart' as versions;

final _gzip = new GZipCodec();
final _logger = new Logger('shared.storage');

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
    uploadWithRetry(bucket, objectName, bytes.length,
        () => new Stream.fromIterable([bytes]));

/// Utility class to access versioned data file that follows the pattern:
/// "/path-prefix/runtime-version.ext". The extension must use .gz as the
/// storage uses transparent gzip on the data stream.
class VersionedDataStorage {
  final Bucket _bucket;
  final String _prefix;
  final String _extension;

  VersionedDataStorage(Bucket bucket, String prefix, String extension)
      : _bucket = bucket,
        _prefix = prefix,
        _extension = extension {
    assert(extension.endsWith('.gz'));
  }

  /// Whether the storage bucket has a data file for the current runtime version.
  /// TODO: decide whether we should re-generate the file after a certain age
  Future<bool> hasCurrentData() async {
    try {
      final info = await _bucket.info(_objectName());
      return info != null;
    } catch (_) {
      return false;
    }
  }

  /// Upload the current data file to the storage bucket.
  Future uploadDataFile(File file) async {
    final objectName = _objectName();
    try {
      // Prevents edge cases like double compression.
      assert(!file.path.endsWith('.gz'));
      await uploadWithRetry(_bucket, objectName, file.lengthSync(),
          () => file.openRead().transform(_gzip.encoder));
    } catch (e, st) {
      _logger.warning('Unable to upload data file: $objectName', e, st);
    }
  }

  /// Gets the content of the data file decoded as JSON Map.
  Future<Map<String, dynamic>> getContentAsJsonMap() async {
    final objectName = _objectName();
    final map = await _bucket
        .read(objectName)
        .transform(_gzip.decoder)
        .transform(utf8.decoder)
        .transform(json.decoder)
        .single;
    return map as Map<String, dynamic>;
  }

  /// Deletes the old entries that predate [versions.gcBeforeRuntimeVersion].
  Future deleteOldData({Duration ageThreshold}) async {
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
        final age = new DateTime.now().difference(info.updated);
        if (ageThreshold == null || age > ageThreshold) {
          await deleteFromBucket(_bucket, entry.name);
        }
      }
    }
  }

  String _objectName() => '$_prefix${versions.runtimeVersion}$_extension';
}
