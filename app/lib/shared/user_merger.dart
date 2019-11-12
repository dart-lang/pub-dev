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
/// Specifically for the case where a two [User] entities exists with the same [User.oauthUserId].
class UserMerger {
  final DatastoreDB _db;
  final int _concurrency;
  final bool _omitEmailCheck;

  UserMerger({
    DatastoreDB db,
    int concurrency = 1,
    bool omitEmailCheck,
  })  : _db = db,
        _concurrency = concurrency,
        _omitEmailCheck = omitEmailCheck ?? false;

  /// Fixes all OAuthUserID issues.
  Future<void> fixAll() async {
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
  Future<void> fixOAuthUserID(String oauthUserId) async {
    print('Fixing OAuthUserID=$oauthUserId');

    final query = _db.query<User>()..filter('oauthUserId =', oauthUserId);
    final users = await query.run().toList();
    print('Users: ${users.map((u) => u.userId).join(', ')}');

    final mapping = await _db.lookupValue<OAuthUserID>(
        _db.emptyKey.append(OAuthUserID, id: oauthUserId));
    print('Primary User: ${mapping.userId}');
    if (!users.any((u) => u.userId == mapping.userId)) {
      throw StateError('Primary User is missing!');
    }

    // WARNING
    //
    // We only update user ids, we do not change e-mails.
    // The tool will NOT merge Users with non-matching e-mail addresses.
    if (!_omitEmailCheck) {
      for (int i = 1; i < users.length; i++) {
        if (users[0].email != users[i].email) {
          throw StateError(
              'User e-mail does not match: ${users[0].email} != ${users[i].email}');
        }
      }
    }

    for (User user in users) {
      if (user.userId == mapping.userId) continue;
      await mergeUser(user.userId, mapping.userId);
    }
  }

  /// Migrates data for User merge.
  Future<void> mergeUser(String fromUserId, String toUserId) async {
    print('Merging User: $fromUserId -> $toUserId');

    // Package
    await _processConcurrently(
      _db.query<Package>()..filter('uploaders =', fromUserId),
      (Package m) async {
        await _db.withTransaction((tx) async {
          final p = await tx.lookupValue<Package>(m.key);
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
          final pv = await tx.lookupValue<PackageVersion>(m.key);
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
          final session = await tx.lookupValue<UserSession>(m.key);
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

    // Consent's userId attribute
    await _processConcurrently(
      _db.query<Consent>()..filter('userId =', fromUserId),
      (Consent m) async {
        if (m?.parentKey?.id != null) {
          throw StateError('Old Consent entity: ${m.consentId}.');
        }
        await _db.withTransaction((tx) async {
          final consent = await tx.lookupValue<Consent>(m.key);
          if (consent.userId == fromUserId) {
            consent.userId = toUserId;
            tx.queueMutations(inserts: [consent]);
            await tx.commit();
          } else {
            await tx.rollback();
          }
        });
      },
    );

    // Consent's fromUserId attribute
    await _processConcurrently(
      _db.query<Consent>()..filter('fromUserId =', fromUserId),
      (Consent m) async {
        if (m?.parentKey?.id != null) {
          throw StateError('Old Consent entity: ${m.consentId}.');
        }
        await _db.withTransaction((tx) async {
          final consent = await tx.lookupValue<Consent>(m.key);
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
          final h = await tx.lookupValue<History>(m.key);
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

    await _db.commit(deletes: [fromUserKey]);
  }

  Future<void> _processConcurrently<T extends Model>(
      Query<T> query, Future<void> Function(T) fn) async {
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
