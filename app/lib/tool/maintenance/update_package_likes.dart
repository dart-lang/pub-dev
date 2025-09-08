// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/datastore.dart';

final _logger = Logger('adjust_like_counts');

/// Updates the like count of packages, fixing eventual consistency issues.
///
/// Return the number of packages that were updated.
Future<int> updatePackageLikes() async {
  _logger.info('Scanning packages for like count consistency...');

  var updatedCount = 0;
  await for (final p in dbService.query<Package>().run()) {
    final query = dbService.query<Like>()..filter('packageName =', p.name!);
    final count = await query.run().fold<int>(0, (sum, like) => sum + 1);
    if (p.likes == count) {
      continue;
    }
    _logger.info(
      'Updating likes for package "${p.name}" changing from ${p.likes} to $count.',
    );
    await withRetryTransaction(dbService, (tx) async {
      final pkg = await tx.lookupValue<Package>(p.key);
      if (pkg.updated != p.updated || pkg.likes != p.likes) {
        _logger.info(
          'Skipping like update for package "${p.name}": changed since the like verification started.',
        );
        return;
      }
      pkg.likes = count;
      tx.insert(pkg);
    });
    updatedCount++;
  }
  return updatedCount;
}
