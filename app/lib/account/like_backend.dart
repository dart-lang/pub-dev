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

  /// Returns [Like] if [userId] likes [package], otherwise returns `null`.
  Future<Like?> getPackageLikeStatus(String userId, String package) async {
    final key = _db.emptyKey.append(User, id: userId).append(Like, id: package);
    return await _db.lookupOrNull<Like>(key);
  }

  /// Returns a list with [LikeData] of all the packages that the given
  ///  user's likes.
  Future<List<LikeData>> listPackageLikes(String userId) async {
    return (await cache.userPackageLikes(userId).get(() async {
      // TODO(zarah): Introduce pagination and/or migrate this to search.
      final query =
          _db.query<Like>(ancestorKey: _db.emptyKey.append(User, id: userId))
            ..order('-created')
            ..limit(1000);
      final likes = await query.run().toList();
      return likes.map((Like l) => LikeData.fromModel(l)).toList();
    }))!;
  }

  /// Creates and returns a package like entry for the given [user] and
  /// [package], and increments the 'likes' property on [package].
  Future<Like> likePackage(User user, String package) async {
    Package? updatedPackage;
    final res = await withRetryTransaction<Like>(_db, (tx) async {
      updatedPackage = null;
      final packageKey = _db.emptyKey.append(Package, id: package);
      final p = await tx.lookupOrNull<Package>(packageKey);
      if (p == null) {
        throw NotFoundException.resource(package);
      }

      final key = _db.emptyKey
          .append(User, id: user.id)
          .append(Like, id: package);
      final oldLike = await tx.lookupOrNull<Like>(key);

      if (oldLike != null) {
        return oldLike;
      }

      p.likes++;
      p.updated = clock.now().toUtc();
      final newLike = Like()
        ..parentKey = user.key
        ..id = p.id
        ..created = clock.now().toUtc()
        ..packageName = p.name;

      tx.queueMutations(inserts: [p, newLike]);
      updatedPackage = p;
      return newLike;
    });
    if (updatedPackage != null) {
      await packageBackend.mirrorPackageToSql(updatedPackage!);
      await mirrorToSql(res);
    }
    await cache.packageView(package).purge();
    await purgeAccountCache(userId: user.userId);
    return res;
  }

  /// Delete a package like entry for the given [user] and [package] if it
  /// exists, and decrements the 'likes' property on [package].
  Future<void> unlikePackage(User user, String package) async {
    Package? updatedPackage;
    await withRetryTransaction<void>(_db, (tx) async {
      updatedPackage = null;
      final packageKey = _db.emptyKey.append(Package, id: package);
      final p = await tx.lookupOrNull<Package>(packageKey);
      if (p == null) {
        throw NotFoundException.resource(package);
      }

      final likeKey = _db.emptyKey
          .append(User, id: user.id)
          .append(Like, id: package);
      final like = await tx.lookupOrNull<Like>(likeKey);

      if (like == null) {
        return;
      }

      p.likes--;
      p.updated = clock.now().toUtc();
      tx.queueMutations(inserts: [p], deletes: [likeKey]);
      updatedPackage = p;
    });
    if (updatedPackage != null) {
      await packageBackend.mirrorPackageToSql(updatedPackage!);
      await deleteFromSql(user.userId, package);
    }
    await cache.packageView(package).purge();
    await cache.userPackageLikes(user.userId).purge();
  }

  /// Upserts [like] into SQL. The user and the package must exist in SQL.
  ///
  /// A [Like] without `created` gets the current time, also stored in Datastore.
  Future<void> mirrorToSql(Like like) async {
    final created = like.created ?? await _setMissingCreated(like);
    await primaryDatabase.transactWithRetry(
      (db) => db.packageLikes
          .upsertValue(
            userId: like.userId,
            package: like.package,
            createdAt: created,
          )
          .execute(),
    );
  }

  /// Sets the missing `created` of [like] in Datastore, unless it was set
  /// concurrently, and returns the stored value.
  Future<DateTime> _setMissingCreated(Like like) async {
    final updated = await withRetryTransaction<Like?>(_db, (tx) async {
      final current = await tx.lookupOrNull<Like>(like.key);
      if (current == null) return null;
      current.created ??= clock.now().toUtc();
      tx.insert(current);
      return current;
    });
    // If the entity was removed concurrently, the next backfill drops the row.
    final created = updated?.created ?? clock.now().toUtc();
    like.created = created;
    return created;
  }

  /// Deletes the SQL row of the like of [userId] on [package].
  Future<void> deleteFromSql(String userId, String package) async {
    await primaryDatabase.withRetry(
      (db) => db.packageLikes.delete(userId, package).execute(),
    );
  }

  /// Syncs SQL with the [Like] entities: upserts the missing or changed likes,
  /// and removes the rows without a matching entity.
  ///
  /// Likes of users or packages that are missing from SQL are skipped.
  Future<int> backfillSqlFromDatastore() async {
    var count = 0;
    final remainingSqlRows = <(String, String), DateTime>{};
    final rows = await primaryDatabase.withRetry(
      (db) => db.packageLikes
          .select((l) => (l.userId, l.package, l.createdAt))
          .fetch(),
    );
    for (final (userId, package, createdAt) in rows) {
      remainingSqlRows[(userId, package)] = createdAt;
    }

    final hasUserInSqlCache = <String, bool>{};
    final hasPackageInSqlCache = <String, bool>{};
    Future<bool> hasUserInSql(String userId) async =>
        hasUserInSqlCache[userId] ??=
            await primaryDatabase.withRetry(
              (db) => db.users.byKey(userId).fetch(),
            ) !=
            null;
    Future<bool> hasPackageInSql(String package) async =>
        hasPackageInSqlCache[package] ??=
            await primaryDatabase.withRetry(
              (db) => db.packages.byKey(package).fetch(),
            ) !=
            null;

    await for (final like in _db.query<Like>().run()) {
      final key = (like.userId, like.package);
      final sqlCreated = remainingSqlRows.remove(key);
      final created = like.created;
      if (created != null &&
          sqlCreated != null &&
          sqlCreated.isAtSameMomentAs(created)) {
        continue;
      }
      if (!await hasUserInSql(like.userId) ||
          !await hasPackageInSql(like.package)) {
        _logger.warning(
          'Skipping like of "${like.userId}" on "${like.package}": '
          'user or package is missing in SQL.',
        );
        continue;
      }
      await mirrorToSql(like);
      count++;
    }

    // Rows left over have no Datastore entity.
    for (final (userId, package) in remainingSqlRows.keys) {
      await deleteFromSql(userId, package);
      count++;
    }
    return count;
  }
}
