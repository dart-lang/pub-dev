// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../../account/backend.dart';
import '../../account/models.dart';
import '../../package/backend.dart';
import '../../shared/datastore.dart';
import '../../shared/utils.dart';

final _logger = Logger('remove_orphaned_likes');
final _minAgeThreshold = Duration(days: 1);

/// Removes Like entities with non-existing Package or User.
/// Only removes entities that are present for more than a day.
Future<DeleteCounts> removeOrphanedLikes({
  @visibleForTesting Duration? minAgeThreshold,
}) async {
  _logger.info('Scanning for orphaned likes...');
  final existingUserIds = <String>{};
  final existingPackages = <String>{};

  Future<bool> isUserIdMissing(String userId) async {
    if (existingUserIds.contains(userId)) {
      return false;
    }
    final user = await accountBackend.lookupUserById(userId);
    if (user != null) {
      existingUserIds.add(userId);
      return false;
    } else {
      return true;
    }
  }

  Future<bool> isPackageMissing(String package) async {
    if (existingPackages.contains(package)) {
      return false;
    }
    final p = await packageBackend.lookupPackage(package);
    if (p != null) {
      existingPackages.add(package);
      return false;
    } else {
      return true;
    }
  }

  final counts = await dbService.deleteWithQuery<Like>(
    dbService.query<Like>(),
    where: (like) async {
      final age = clock.now().difference(like.created!);
      if (age < (minAgeThreshold ?? _minAgeThreshold)) {
        // Do not check likes that are younger than the threshold to prevent eventual consistency issues.
        return false;
      }

      if (await isUserIdMissing(like.userId)) {
        // TODO: investigate if we need to recalculate the like count for the packages.
        _logger.info(
            'Removing like for package `${like.package}` because userId `${like.userId}` is missing.');
        return true;
      }
      if (await isPackageMissing(like.package)) {
        _logger.info(
            'Removing like for userId `${like.userId}` because package `${like.package}` is missing.');
        return true;
      }
      return false;
    },
  );
  _logger.info('Removed ${counts.deleted} orphaned likes.');
  return counts;
}
