// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:pub_dev/account/like_backend.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:typed_sql/typed_sql.dart';

final _logger = Logger('adjust_like_counts');

/// Updates the like count of packages, fixing eventual consistency issues.
///
/// SQL is the source of truth: the likes count of a package is recalculated
/// from the `package_likes` rows, and the Datastore copy follows it.
///
/// Return the number of packages that were updated.
Future<int> updatePackageLikes() async {
  _logger.info('Scanning packages for like count consistency...');

  final packageNames = await primaryDatabase.withRetry(
    (db) => db.packages.select((p) => (p.name,)).fetch(),
  );
  var updatedCount = 0;
  for (final package in packageNames) {
    if (await likeBackend.reconcileLikesCount(package)) {
      updatedCount++;
    }
  }
  return updatedCount;
}
