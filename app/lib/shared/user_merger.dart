// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:pool/pool.dart';

import '../account/models.dart';
import '../history/models.dart';
import '../package/models.dart';
import '../publisher/models.dart';

/// Utility class to merge user data.
class UserMerger {
  final DatastoreDB _db;
  final int _concurrency;
  final bool _deleteUsers;

  UserMerger({DatastoreDB db, int concurrency = 1, bool deleteUsers})
      : _db = db,
        _concurrency = concurrency,
        _deleteUsers = deleteUsers ?? false;

  /// Fixes all OAuthUserID issues.
  Future fixAll() async {
    final ids = await scanOauthUserIdsWithProblems();
    for (String id in ids) {
      await fixOAuthUserID(id);
    }
  }

  /// Returns the OAuth userIds that have more than one User.
  Future<List<String>> scanOauthUserIdsWithProblems() async {
    print('Scanning Users...');
    final query = _db.query<User>();
    final counts = <String, int>{};
    await for (final user in query.run()) {
      if (user.oauthUserId == null) continue;
      counts[user.oauthUserId] ??= 0;
      counts[user.oauthUserId]++;
    }
    final result = counts.keys.where((k) => counts[k] > 1).toList();
    print('$result OAuthUserID with more than one User.');
    return result;
  }

  /// Runs user merging on the [oauthUserId] for each non-primary [User].
  Future fixOAuthUserID(String oauthUserId) async {
    print('Fixing OAuthUserID=$oauthUserId');

    final query = _db.query<User>()..filter('oauthUserId =', oauthUserId);
    final users = await query.run().toList();
    print('Users: ${users.map((u) => u.userId).join(', ')}');

    final mappings = await _db.lookup<OAuthUserID>([
      _db.emptyKey.append(OAuthUserID, id: oauthUserId),
    ]);
    final mapping = mappings.single;
    print('Primary User: ${mapping.userId}');
    if (!users.any((u) => u.userId == mapping.userId)) {
      throw Exception('Primary User is missing!');
    }

    for (User user in users) {
      if (user.userId == mapping.userId) continue;
      await mergeUser(user.userId, mapping.userId);
    }
  }

  /// Migrates data for User merge.
  Future mergeUser(String fromUserId, String toUserId) async {
    print('Merging User: $fromUserId -> $toUserId');

    // Package
    await _processConcurrently(
      _db.query<Package>()..filter('uploaders =', fromUserId),
      (Package m) async {
        await _db.withTransaction((tx) async {
          final p = (await tx.lookup<Package>([m.key])).single;
          if (p.containsUploader(fromUserId)) {
            p.removeUploader(fromUserId);
            p.addUploader(toUserId);
            tx.queueMutations(inserts: [p]);
            await tx.commit();
          } else {
            await tx.rollback();
          }
        });
      },
    );

    // PackageVersion
    await _processConcurrently(
      _db.query<PackageVersion>()..filter('uploader =', fromUserId),
      (PackageVersion m) async {
        await _db.withTransaction((tx) async {
          final pv = (await tx.lookup<PackageVersion>([m.key])).single;
          if (pv.uploader == fromUserId) {
            pv.uploader = toUserId;
            tx.queueMutations(inserts: [pv]);
            await tx.commit();
          } else {
            await tx.rollback();
          }
        });
      },
    );

    // UserSession
    final fromUserKey = _db.emptyKey.append(User, id: fromUserId);
    final toUserKey = _db.emptyKey.append(User, id: toUserId);
    await _processConcurrently(
      _db.query<UserSession>()..filter('userIdKey =', fromUserKey),
      (UserSession m) async {
        await _db.withTransaction((tx) async {
          final session = (await tx.lookup<UserSession>([m.key])).single;
          if (session.userId == fromUserId) {
            session.userIdKey = toUserKey;
            tx.queueMutations(inserts: [session]);
            await tx.commit();
          } else {
            await tx.rollback();
          }
        });
      },
    );

    // Consent of the User
    await _processConcurrently(
      _db.query<Consent>(ancestorKey: fromUserKey),
      (Consent m) async {
        await _db.withTransaction((tx) async {
          tx.queueMutations(
              inserts: [m.changeParentUserId(toUserId)], deletes: [m.key]);
          await tx.commit();
        });
      },
    );

    // Consent's fromUserId attribute
    await _processConcurrently(
      _db.query<Consent>()..filter('fromUserId =', fromUserId),
      (Consent m) async {
        await _db.withTransaction((tx) async {
          final consent = (await tx.lookup<Consent>([m.key])).single;
          if (consent.fromUserId == fromUserId) {
            consent.fromUserId = toUserId;
            tx.queueMutations(inserts: [consent]);
            await tx.commit();
          } else {
            await tx.rollback();
          }
        });
      },
    );

    // PublisherMember
    await _processConcurrently(
      _db.query<PublisherMember>()..filter('userId =', fromUserId),
      (PublisherMember m) async {
        await _db.withTransaction((tx) async {
          tx.queueMutations(
              inserts: [m.changeParentUserId(toUserId)], deletes: [m.key]);
          await tx.commit();
        });
      },
    );

    // WARNING
    //
    // Updating history entries blindly, without parsing the event structure.
    // This only works because user ids are random UUIDs, and in the events we
    // always use them separately, either as a String property, or as a String
    // list item.
    await _processConcurrently(
      _db.query<History>(),
      (History m) async {
        if (!m.eventJson.contains('"$fromUserId"')) return;
        await _db.withTransaction((tx) async {
          final h = (await tx.lookup<History>([m.key])).single;
          final fromJson = h.eventJson;
          h.eventJson = fromJson.replaceAll('"$fromUserId"', '"$toUserId"');
          tx.queueMutations(inserts: [h]);
          await tx.commit();
          print('Updated History(${h.id})');
          print(fromJson);
          print(h.eventJson);
        });
      },
    );

    if (_deleteUsers) {
      await _db.commit(deletes: [fromUserKey]);
    }
  }

  Future _processConcurrently<T extends Model>(
      Query<T> query, Future Function(T) fn) async {
    final pool = Pool(_concurrency);
    final futures = <Future>[];
    await for (final m in query.run()) {
      final f = pool.withResource(() => fn(m));
      futures.add(f);
    }
    await Future.wait(futures);
    await pool.close();
  }
}
