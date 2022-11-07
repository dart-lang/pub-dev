// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;

import '../package/models.dart';
import '../shared/datastore.dart';
import '../shared/exceptions.dart';
import '../shared/redis_cache.dart' show cache;

import 'backend.dart' show purgeAccountCache;
import 'models.dart';

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
  ///  [user] likes.
  Future<List<LikeData>> listPackageLikes(User user) async {
    return (await cache.userPackageLikes(user.userId).get(() async {
      // TODO(zarah): Introduce pagination and/or migrate this to search.
      final query = _db.query<Like>(ancestorKey: user.key)
        ..order('-created')
        ..limit(1000);
      final likes = await query.run().toList();
      return likes.map((Like l) => LikeData.fromModel(l)).toList();
    }))!;
  }

  /// Creates and returns a package like entry for the given [user] and
  /// [package], and increments the 'likes' property on [package].
  Future<Like> likePackage(User user, String package) async {
    final res = await withRetryTransaction<Like>(_db, (tx) async {
      final packageKey = _db.emptyKey.append(Package, id: package);
      final p = await tx.lookupOrNull<Package>(packageKey);
      if (p == null) {
        throw NotFoundException.resource(package);
      }

      final key =
          _db.emptyKey.append(User, id: user.id).append(Like, id: package);
      final oldLike = await tx.lookupOrNull<Like>(key);

      if (oldLike != null) {
        return oldLike;
      }

      p.likes++;
      final newLike = Like()
        ..parentKey = user.key
        ..id = p.id
        ..created = clock.now().toUtc()
        ..packageName = p.name;

      tx.queueMutations(inserts: [p, newLike]);
      return newLike;
    });
    await purgeAccountCache(userId: user.userId);
    return res;
  }

  /// Delete a package like entry for the given [user] and [package] if it
  /// exists, and decrements the 'likes' property on [package].
  Future<void> unlikePackage(User user, String package) async {
    await withRetryTransaction<void>(_db, (tx) async {
      final packageKey = _db.emptyKey.append(Package, id: package);
      final p = await tx.lookupOrNull<Package>(packageKey);
      if (p == null) {
        throw NotFoundException.resource(package);
      }

      final likeKey =
          _db.emptyKey.append(User, id: user.id).append(Like, id: package);
      final like = await tx.lookupOrNull<Like>(likeKey);

      if (like == null) {
        return;
      }

      p.likes--;
      tx.queueMutations(inserts: [p], deletes: [likeKey]);
    });
    await cache.userPackageLikes(user.userId).purge();
  }
}
