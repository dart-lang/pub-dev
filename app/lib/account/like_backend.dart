// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:typed_sql/typed_sql.dart' hide AuthenticationException;

import '../database/database.dart';
import '../database/schema.dart';
import '../package/backend.dart' show packageBackend;
import '../package/models.dart';
import '../shared/datastore.dart';
import '../shared/exceptions.dart';
import '../shared/redis_cache.dart' show cache;

import 'backend.dart' show purgeAccountCache;
import 'models.dart';

final _logger = Logger('like_backend');

/// Sets the like backend service.
void registerLikeBackend(LikeBackend backend) =>
    ss.register(#_likeBackend, backend);

/// The active like backend service.
LikeBackend get likeBackend => ss.lookup(#_likeBackend) as LikeBackend;

/// Represents the backend for the like handling.
class LikeBackend {
  final DatastoreDB _db;
  LikeBackend(this._db);

  /// Returns the [PackageLike] if [userId] likes [package], otherwise returns
  /// `null`.
  Future<PackageLike?> getPackageLikeStatus(
    String userId,
    String package,
  ) async {
    return await primaryDatabase.withRetry(
      (db) => db.packageLikes.byKey(userId, package).fetch(),
    );
  }

  /// Returns a list with [LikeData] of all the packages that the given
  ///  user's likes.
  Future<List<LikeData>> listPackageLikes(String userId) async {
    return (await cache.userPackageLikes(userId).get(() async {
      // TODO(zarah): Introduce pagination and/or migrate this to search.
      final rows = await primaryDatabase.withRetry(
        (db) => db.packageLikes
            .where((l) => l.userId.equalsValue(userId))
            .orderBy((l) => [(l.createdAt, Order.descending)])
            .limit(1000)
            .fetch(),
      );
      return rows
          .map(
            (r) => LikeData(
              userId: r.userId,
              package: r.package,
              created: r.createdAt,
            ),
          )
          .toList();
    }))!;
  }

  /// Likes the [package] for [userId] (SQL first, then the Datastore copy).
  Future<PackageLike> likePackage(String userId, String package) async {
    final like = await primaryDatabase.transactWithRetry((db) async {
      if (await db.packages.byKey(package).fetch() == null) {
        throw NotFoundException.resource(package);
      }
      final inserted = await db.packageLikes
          .insertValue(
            userId: userId,
            package: package,
            createdAt: clock.now().toUtc(),
          )
          .onConflict(.primaryKey)
          .doNothing()
          .returnInserted()
          .executeAndFetch();
      if (inserted == null) {
        // Only the insert that created the row increments the count.
        return (await db.packageLikes.byKey(userId, package).fetch())!;
      }
      await _updateLikesCount(db, package, 1);
      return inserted;
    });
    await _tryWriteCopy(userId, package);
    await cache.packageView(package).purge();
    await purgeAccountCache(userId: userId);
    return like;
  }

  Future<void> unlikePackage(String userId, String package) async {
    await primaryDatabase.transactWithRetry((db) async {
      if (await db.packages.byKey(package).fetch() == null) {
        throw NotFoundException.resource(package);
      }
      await _deleteRow(db, userId, package);
    });
    await _afterRemove(userId, package);
  }

  /// Removes the like from SQL and Datastore (a failed Datastore delete is
  /// repaired by the backfill).
  Future<void> removeLike(String userId, String package) async {
    await primaryDatabase.transactWithRetry(
      (db) => _deleteRow(db, userId, package),
    );
    await _afterRemove(userId, package);
  }

  Future<void> _deleteRow(
    Database<PrimarySchema> db,
    String userId,
    String package,
  ) async {
    final deleted = await db.packageLikes
        .where(
          (l) => l.userId.equalsValue(userId) & l.package.equalsValue(package),
        )
        .delete()
        .returnDeleted()
        .executeAndFetch();
    if (deleted.isNotEmpty) {
      await _updateLikesCount(db, package, -1);
    }
  }

  Future<void> _afterRemove(String userId, String package) async {
    await _tryWriteCopy(userId, package);
    await cache.packageView(package).purge();
    await purgeAccountCache(userId: userId);
  }

  /// Moves the likes of [fromUserId] to [toUserId], dropping duplicates.
  Future<void> transferLikes(String fromUserId, String toUserId) async {
    if (fromUserId == toUserId) return;
    final packages = await primaryDatabase.withRetry(
      (db) => db.packageLikes
          .where((l) => l.userId.equalsValue(fromUserId))
          .select((l) => (l.package,))
          .fetch(),
    );
    for (final package in packages) {
      final countChanged = await primaryDatabase.transactWithRetry((db) async {
        final deleted = await db.packageLikes
            .where(
              (l) =>
                  l.userId.equalsValue(fromUserId) &
                  l.package.equalsValue(package),
            )
            .delete()
            .returnDeleted()
            .executeAndFetch();
        if (deleted.isEmpty) return false;
        // The target user may have liked it concurrently: drop the duplicate.
        final inserted = await db.packageLikes
            .insertValue(
              userId: toUserId,
              package: package,
              createdAt: deleted.single.createdAt,
            )
            .onConflict(.primaryKey)
            .doNothing()
            .returnInserted()
            .executeAndFetch();
        if (inserted != null) return false;
        await _updateLikesCount(db, package, -1);
        return true;
      });
      if (countChanged) {
        await cache.packageView(package).purge();
      }
      // SQL is already updated: a failed copy update is repaired by the
      // backfill.
      await _tryWriteCopy(fromUserId, package);
      await _tryWriteCopy(toUserId, package);
    }
    await purgeAccountCache(userId: fromUserId);
    await purgeAccountCache(userId: toUserId);
  }

  Future<void> _updateLikesCount(
    Database<PrimarySchema> db,
    String package,
    int delta,
  ) async {
    await db.packages
        .where((p) => p.name.equalsValue(package))
        .update((p, set) => set(likesCount: p.likesCount + delta.asExpr))
        .execute();
  }

  /// Writes the Datastore copy, logging failures (see
  /// [backfillDatastoreFromSql]).
  Future<void> _tryWriteCopy(String userId, String package) async {
    try {
      await _writeCopy(userId, package);
    } catch (e, st) {
      _logger.severe(
        'Failed to update the Datastore copy of the like of "$userId" on '
        '"$package".',
        e,
        st,
      );
    }
  }

  /// Makes the Datastore entities of the like match SQL.
  ///
  /// SQL is re-checked after the commit and the write is repeated if it
  /// changed, so a concurrent like/unlike cannot leave a stale copy behind.
  Future<void> _writeCopy(String userId, String package) async {
    const maxAttempts = 5;
    for (var attempt = 1; ; attempt++) {
      PackageLike? row;
      int? likesCount;
      Package? updatedPackage;
      await withRetryTransaction(_db, (tx) async {
        updatedPackage = null;
        row = await getPackageLikeStatus(userId, package);
        likesCount = await packageBackend.lookupLikesCount(package);
        final likeKey = _db.emptyKey
            .append(User, id: userId)
            .append(Like, id: package);
        final inserts = <Model>[];
        final deletes = <Key>[];
        if (row == null) {
          deletes.add(likeKey);
        } else {
          inserts.add(_likeEntity(row!));
        }
        final p = await _updatedPackageEntity(tx, package, likesCount);
        if (p != null) inserts.add(p);
        tx.queueMutations(inserts: inserts, deletes: deletes);
        updatedPackage = p;
      });
      if (updatedPackage != null) {
        await packageBackend.mirrorPackageToSql(updatedPackage!);
      }

      final currentRow = await getPackageLikeStatus(userId, package);
      final currentCount = await packageBackend.lookupLikesCount(package);
      final unchanged =
          currentCount == likesCount &&
          currentRow?.createdAt == row?.createdAt &&
          (currentRow == null) == (row == null);
      if (unchanged) return;
      if (attempt >= maxAttempts) {
        _logger.warning(
          'Datastore copy of the like of "$userId" on "$package" kept '
          'changing, giving up after $attempt attempts.',
        );
        return;
      }
    }
  }

  Like _likeEntity(PackageLike row) => Like()
    ..parentKey = _db.emptyKey.append(User, id: row.userId)
    ..id = row.package
    ..created = row.createdAt
    ..packageName = row.package;

  /// Returns the [Package] entity updated with [likesCount], or `null` if
  /// unchanged.
  Future<Package?> _updatedPackageEntity(
    TransactionWrapper tx,
    String package,
    int? likesCount,
  ) async {
    if (likesCount == null) return null;
    final p = await tx.lookupOrNull<Package>(
      _db.emptyKey.append(Package, id: package),
    );
    if (p == null || p.likes == likesCount) return null;
    p.likes = likesCount;
    p.updated = clock.now().toUtc();
    return p;
  }

  /// Updates the likes count of the [Package] entity from SQL, returns whether
  /// it was changed.
  Future<bool> _syncPackageEntity(String package) async {
    final likesCount = await packageBackend.lookupLikesCount(package);
    Package? updatedPackage;
    await withRetryTransaction(_db, (tx) async {
      updatedPackage = await _updatedPackageEntity(tx, package, likesCount);
      if (updatedPackage != null) tx.queueMutations(inserts: [updatedPackage!]);
    });
    if (updatedPackage == null) return false;
    await packageBackend.mirrorPackageToSql(updatedPackage!);
    return true;
  }

  /// Recalculates `packages.likesCount` from the like rows and syncs the
  /// Datastore copy. Returns whether the SQL count was changed.
  Future<bool> reconcileLikesCount(String package) async {
    final changed = await primaryDatabase.transactWithRetry((db) async {
      final stored = await db.packages
          .byKey(package)
          .select((p) => (p.likesCount,))
          .fetch();
      if (stored == null) return false;
      final counted =
          await db.packageLikes
              .where((l) => l.package.equalsValue(package))
              .count()
              .fetch() ??
          0;
      if (stored == counted) return false;
      final updated = await db.packages
          .where(
            (p) =>
                p.name.equalsValue(package) & p.likesCount.equalsValue(stored),
          )
          .update((p, set) => set(likesCount: counted.asExpr))
          .returnUpdated()
          .executeAndFetch();
      if (updated.isEmpty) {
        _logger.info(
          'Skipped updating likes for package "$package": '
          'the count was changed concurrently.',
        );
        return false;
      }
      _logger.info(
        'Updated likes for package "$package" changing from $stored to '
        '$counted.',
      );
      return true;
    });
    await _syncPackageEntity(package);
    if (changed) {
      await cache.packageView(package).purge();
    }
    return changed;
  }

  /// Syncs the Datastore like entities and counts with SQL (entities without
  /// a SQL row are deleted). Returns the number of changes.
  Future<int> backfillDatastoreFromSql() async {
    var count = 0;
    final packageNames = await primaryDatabase.withRetry(
      (db) => db.packages.select((p) => (p.name,)).fetch(),
    );
    for (final package in packageNames) {
      final entities = <String, DateTime?>{};
      final query = _db.query<Like>()..filter('packageName =', package);
      await for (final like in query.run()) {
        entities[like.userId] = like.created;
      }

      final rows = await primaryDatabase.withRetry(
        (db) => db.packageLikes
            .where((l) => l.package.equalsValue(package))
            .fetch(),
      );
      for (final row in rows) {
        final created = entities[row.userId];
        if (created != null && created.isAtSameMomentAs(row.createdAt)) {
          continue;
        }
        await _writeCopy(row.userId, package);
        count++;
      }

      final sqlUsers = {for (final row in rows) row.userId};
      for (final userId in entities.keys) {
        if (sqlUsers.contains(userId)) continue;
        await _writeCopy(userId, package);
        count++;
      }

      if (await _syncPackageEntity(package)) count++;
    }
    return count;
  }
}
