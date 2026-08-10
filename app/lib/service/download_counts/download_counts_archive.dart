// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/data/download_counts_data.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/storage.dart';
import 'package:googleapis/storage/v1.dart' show DetailedApiRequestError;
import 'package:indexed_blob/indexed_blob.dart';
import 'package:logging/logging.dart';
import 'package:pub_dev/shared/cached_value.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/redis_cache.dart';
import 'package:pub_dev/shared/storage.dart';

final _logger = Logger('pub.download_counts.archive');

/// Relative path to daily downloads blob file in the reports bucket.
const dailyDownloadsBlobFileName = 'download-counts/daily-downloads.blob';

/// Relative path to daily downloads index file in the reports bucket.
const dailyDownloadsIndexFileName = 'download-counts/daily-downloads.index';

/// Sets the download counts archive service.
void registerDownloadCountsArchive(DownloadCountsArchive archive) =>
    ss.register(#_downloadCountsArchive, archive);

/// The active download counts archive service.
DownloadCountsArchive get downloadCountsArchive =>
    (ss.lookup(#_downloadCountsArchive) as DownloadCountsArchive?) ??
    DownloadCountsArchive();

/// Service for reading and writing consolidated download count archives
/// stored as an indexed blob in Google Cloud Storage.
final class DownloadCountsArchive {
  final Bucket? _bucket;
  late final CachedValue<BlobIndexReader?> _cachedIndexReader;

  DownloadCountsArchive({Bucket? bucket}) : _bucket = bucket {
    _cachedIndexReader = CachedValue<BlobIndexReader?>(
      name: 'downloadCountsArchiveIndex',
      interval: const Duration(minutes: 30),
      updateFn: _loadIndexReader,
    );
  }

  Bucket get _reportsBucket =>
      _bucket ?? storageService.bucket(activeConfiguration.reportsBucketName!);

  Future<void> start() async {
    await _cachedIndexReader.update();
  }

  Future<void> close() async {
    await _cachedIndexReader.close();
  }

  BlobSliceReader _blobSliceReader() {
    return (int start, int end) async {
      try {
        return await _reportsBucket.readAsBytes(
          dailyDownloadsBlobFileName,
          offset: start,
          length: end - start,
        );
      } on DetailedApiRequestError catch (e) {
        if (e.status == 404) {
          return null;
        }
        rethrow;
      }
    };
  }

  Future<BlobIndexReader?> _loadIndexReader() async {
    try {
      final indexBytes = await _reportsBucket.readAsBytes(
        dailyDownloadsIndexFileName,
      );
      return BlobIndexReader.fromBytes(indexBytes, _blobSliceReader());
    } on DetailedApiRequestError catch (e) {
      if (e.status == 404) {
        return null;
      }
      rethrow;
    } catch (e, st) {
      _logger.warning('Failed to load daily downloads archive index', e, st);
      return null;
    }
  }

  /// Path used inside the indexed blob for a given package and version.
  static String pathForVersion(String package, String version) =>
      'packages/$package/versions/$version/daily-downloads.json';

  /// Returns [VersionDailyDownloadCounts] for [package] and [version], or `null`
  /// if not present in the archive.
  Future<VersionDailyDownloadCounts?> lookupVersionDailyDownloads(
    String package,
    String version,
  ) async {
    return await cache.versionDailyDownloadCounts(package, version).get(
      () async {
        if (!_cachedIndexReader.isAvailable) {
          await _cachedIndexReader.update();
        }
        final reader = _cachedIndexReader.value;
        if (reader == null) {
          return null;
        }

        final path = pathForVersion(package, version);
        final bytes = await reader.fetch(path);
        if (bytes == null) {
          return null;
        }

        try {
          final jsonMap =
              json.decode(utf8.decode(bytes)) as Map<String, dynamic>;
          return VersionDailyDownloadCounts.fromJson(jsonMap);
        } catch (e, st) {
          _logger.warning(
            'Failed to parse version daily downloads JSON',
            e,
            st,
          );
          return null;
        }
      },
    );
  }

  /// Builds a [BlobIndexPair] containing daily downloads for all package versions
  /// in [packageVersionCounts].
  static Future<BlobIndexPair> buildArchive({
    required Map<String, Map<String, List<int>>> packageVersionCounts,
    required DateTime newestDate,
    String blobId = dailyDownloadsBlobFileName,
  }) async {
    return await BlobIndexPair.build(blobId, (addFile) async {
      for (final packageEntry in packageVersionCounts.entries) {
        final package = packageEntry.key;
        for (final versionEntry in packageEntry.value.entries) {
          final version = versionEntry.key;
          final counts = versionEntry.value;
          final data = VersionDailyDownloadCounts(
            package: package,
            version: version,
            newestDate: newestDate,
            totalDailyDownloads: counts,
          );
          final path = pathForVersion(package, version);
          final jsonBytes = utf8.encode(json.encode(data.toJson()));
          await addFile(path, Stream.value(jsonBytes));
        }
      }
    });
  }

  /// Uploads [pair] to the reports bucket.
  Future<void> uploadArchive(BlobIndexPair pair) async {
    await uploadBytesWithRetry(
      _reportsBucket,
      dailyDownloadsBlobFileName,
      pair.blob,
    );
    await uploadBytesWithRetry(
      _reportsBucket,
      dailyDownloadsIndexFileName,
      pair.index.asBytes(),
    );
    await _cachedIndexReader.update();
  }
}
