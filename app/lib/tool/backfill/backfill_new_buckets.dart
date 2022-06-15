// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/shared/configuration.dart';
import '../../package/models.dart';
import '../../shared/datastore.dart';
import '../../shared/storage.dart';

final _logger = Logger('backfill_new_buckets');

/// Backfills the new package archive buckets:
/// - canonical package archives
/// - public package archives
///
/// Returns the statistics of the backfill.
Future<Map<String, int>> backfillNewArchiveBuckets() async {
  _logger.info('Starting archive bucket backfill.');
  final oldBucket =
      storageService.bucket(activeConfiguration.packageBucketName!);
  final canonicalBucket =
      storageService.bucket(activeConfiguration.canonicalPackagesBucketName!);
  final publicBucket =
      storageService.bucket(activeConfiguration.publicPackagesBucketName!);

  final counts = <String, int>{};
  void increment(String key) {
    counts[key] = (counts[key] ?? 0) + 1;
  }

  await for (final pv in dbService.query<PackageVersion>().run()) {
    // ignore: invalid_use_of_visible_for_testing_member
    final objectName = tarballObjectName(pv.package, pv.version!);
    final oldInfo = await oldBucket.info(objectName);

    Future<void> backfill(String label, Bucket bucket) async {
      final info = await bucket.tryInfo(objectName);
      increment('$label-checked');
      if (info == null) {
        await storageService.copyObject(
          oldBucket.absoluteObjectName(objectName),
          bucket.absoluteObjectName(objectName),
        );
        increment('$label-copied');
      } else {
        if (!info.hasSameSignatureAs(oldInfo)) {
          increment('$label-invalid');
          _logger.severe(
              '${pv.qualifiedVersionKey} has different archive in $label bucket.');
        } else {
          increment('$label-unchanged');
        }
      }
    }

    await backfill('canonical', canonicalBucket);
    await backfill('public', publicBucket);
  }

  _logger.info('Archive bucket backfill completed. Status: $counts');
  return counts;
}
