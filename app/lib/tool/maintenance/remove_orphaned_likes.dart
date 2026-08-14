// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../../account/backend.dart';
import '../../account/models.dart';
import '../../package/models.dart';
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

  var found = 0;
  var deleted = 0;

  final buffer = <Like>[];

  Future<void> processBuffer() async {
    if (buffer.isEmpty) return;

    // Filter likes by age
    final ageThreshold = minAgeThreshold ?? _minAgeThreshold;
    final oldLikes = buffer.where((like) {
      final age = clock.now().difference(like.created!);
      return age >= ageThreshold;
    }).toList();

    // 1. Batch lookup missing users
    final missingUserIds = oldLikes
        .map((l) => l.userId)
        .where((id) => !existingUserIds.contains(id))
        .toSet()
        .toList();

    if (missingUserIds.isNotEmpty) {
      for (var i = 0; i < missingUserIds.length; i += 100) {
        final batch = missingUserIds.skip(i).take(100).toList();
        final users = await accountBackend.lookupUsersById(batch);
        for (var j = 0; j < batch.length; j++) {
          if (users[j] != null) {
            existingUserIds.add(batch[j]);
          }
        }
      }
    }

    // 2. Batch lookup missing packages
    final missingPackages = oldLikes
        .map((l) => l.package)
        .where((p) => !existingPackages.contains(p))
        .toSet()
        .toList();

    if (missingPackages.isNotEmpty) {
      for (var i = 0; i < missingPackages.length; i += 100) {
        final batch = missingPackages.skip(i).take(100).toList();
        final keys = batch
            .map((p) => dbService.emptyKey.append(Package, id: p))
            .toList();
        final packages = await dbService.lookup<Package>(keys);
        for (var j = 0; j < batch.length; j++) {
          if (packages[j] != null) {
            existingPackages.add(batch[j]);
          }
        }
      }
    }

    // 3. Delete orphaned likes
    final deletes = <Like>[];
    for (final like in oldLikes) {
      if (!existingUserIds.contains(like.userId)) {
        _logger.info(
          'Removing like for package `${like.package}` because userId `${like.userId}` is missing.',
        );
        deletes.add(like);
      } else if (!existingPackages.contains(like.package)) {
        _logger.info(
          'Removing like for userId `${like.userId}` because package `${like.package}` is missing.',
        );
        deletes.add(like);
      }
    }

    if (deletes.isNotEmpty) {
      await dbService.commit(deletes: deletes.map((l) => l.key).toList());
      deleted += deletes.length;
    }

    buffer.clear();
  }

  await for (final like in dbService.query<Like>().run()) {
    found++;
    buffer.add(like);
    if (buffer.length >= 500) {
      await processBuffer();
    }
  }

  if (buffer.isNotEmpty) {
    await processBuffer();
  }

  _logger.info('Removed $deleted orphaned likes.');
  return DeleteCounts(found, deleted);
}
