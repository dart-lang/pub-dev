// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:pub_dev/account/like_backend.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:typed_sql/typed_sql.dart';

final _logger = Logger('adjust_like_counts');

/// Updates the like count of packages, fixing eventual consistency issues.
///
/// SQL is the source of truth: the likes count of a package is recalculated
/// from the `package_likes` rows, and the Datastore copy follows it.
///
/// Both comparisons are done in bulk, and only the mismatching packages are
/// updated individually.
///
/// Return the number of packages that were updated.
Future<int> updatePackageLikes() async {
  _logger.info('Scanning packages for like count consistency...');

  final stored = {
    for (final (package, likesCount) in await primaryDatabase.withRetry(
      (db) => db.packages.select((p) => (p.name, p.likesCount)).fetch(),
    ))
      package: likesCount,
  };
  final counted = {
    for (final (package, count) in await primaryDatabase.withRetry(
      (db) => db.packageLikes
          .groupBy((l) => (l.package,))
          .aggregate((agg) => agg.count())
          .fetch(),
    ))
      package: count,
  };

  var updatedCount = 0;
  for (final MapEntry(key: package, value: likesCount) in stored.entries) {
    if (likesCount == (counted[package] ?? 0)) continue;
    if (await likeBackend.reconcileLikesCount(package)) {
      updatedCount++;
    }
  }

  // The Datastore copy is compared to the recalculated counts.
  await for (final p in packageBackend.datastoreAllPackages()) {
    if (!stored.containsKey(p.name)) continue;
    if (p.likes == (counted[p.name] ?? 0)) continue;
    await likeBackend.syncPackageEntity(p.name!);
  }
  return updatedCount;
}
