// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/storage.dart';

final _logger = Logger('update_public_buckets');

/// Updates the public package archive:
/// - copies missing archive objects from canonical to public
///
/// Return the number of objects that were updated.
Future<int> updatePublicArchiveBucket() async {
  _logger.info('Scanning PackageVersions for public bucket updates...');

  var updated = 0;
  final canonicalBucket =
      storageService.bucket(activeConfiguration.canonicalPackagesBucketName!);
  final publicBucket =
      storageService.bucket(activeConfiguration.publicPackagesBucketName!);

  await for (final pv in dbService.query<PackageVersion>().run()) {
    // ignore: invalid_use_of_visible_for_testing_member
    final objectName = tarballObjectName(pv.package, pv.version!);
    final publicInfo = await publicBucket.tryInfo(objectName);

    if (publicInfo == null) {
      _logger.warning('Updating missing object in public bucket: $objectName');
      await storageService.copyObject(
        canonicalBucket.absoluteObjectName(objectName),
        publicBucket.absoluteObjectName(objectName),
      );
      updated++;
    }
  }
  return updated;
}
