// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pool/pool.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/shared/exceptions.dart';

import '../account/models.dart';
import '../audit/models.dart';
import '../package/models.dart';
import '../publisher/models.dart';
import 'datastore.dart';

/// Utility class to merge user data.
/// Specifically for the case where a two [User] entities exists with the same [User.oauthUserId].
class UserMerger {
  final DatastoreDB _db;
  final int? _concurrency;
  final bool _omitEmailCheck;

  UserMerger({
    required DatastoreDB db,
    int? concurrency = 1,
    bool? omitEmailCheck,
  })  : _db = db,
        _concurrency = concurrency,
        _omitEmailCheck = omitEmailCheck ?? false;

  /// Fixes all OAuthUserID issues.
  Future<int> fixAll() async {
    final ids = await scanOauthUserIdsWithProblems();
    for (final id in ids) {
      await fixOAuthUserID(id);
    }
    return ids.length;
  }

  /// Returns the OAuth userIds that have more than one User.
  Future<List<String>> scanOauthUserIdsWithProblems() async {
    print('Scanning Users...');
    final query = _db.query<User>();
    final counts = <String, int>{};
    await for (final user in query.run()) {
      if (user.oauthUserId == null) continue;
      counts[user.oauthUserId!] = (counts[user.oauthUserId!] ?? 0) + 1;
    }
    final result = counts.keys.where((k) => counts[k]! > 1).toList();
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

    for (final user in users) {
      if (user.userId == mapping.userId) continue;
      await mergeUser(user.userId, mapping.userId);
    }
  }

  /// Migrates data for User merge.
  Future<void> mergeUser(String fromUserId, String toUserId) async {
    print('Merging User: $fromUserId -> $toUserId');
    final fromUserKey = _db.emptyKey.append(User, id: fromUserId);
    final toUserKey = _db.emptyKey.append(User, id: toUserId);
    final fromUser = await _db.lookupOrNull<User>(fromUserKey);
    InvalidInputException.checkNotNull(fromUser, 'fromUser');
    final toUser = await _db.lookupOrNull<User>(toUserKey);
    InvalidInputException.checkNotNull(toUser, 'toUser');
    final fromUserMapping = fromUser!.oauthUserId == null
        ? null
        : await _db.lookupOrNull<OAuthUserID>(
            _db.emptyKey.append(OAuthUserID, id: fromUser.oauthUserId));
    final toUserMapping = toUser!.oauthUserId == null
        ? null
        : await _db.lookupOrNull<OAuthUserID>(
            _db.emptyKey.append(OAuthUserID, id: toUser.oauthUserId));

    // Package
    await _processConcurrently(
      _db.query<Package>()..filter('uploaders =', fromUserId),
      (Package m) async {
        await withRetryTransaction(_db, (tx) async {
          final p = await tx.lookupValue<Package>(m.key);
          if (p.containsUploader(fromUserId)) {
            p.removeUploader(fromUserId);
            p.addUploader(toUserId);
            tx.insert(p);
          }
        });
      },
    );

    // PackageVersion
    await _processConcurrently(
      _db.query<PackageVersion>()..filter('uploader =', fromUserId),
      (PackageVersion m) async {
        await withRetryTransaction(_db, (tx) async {
          final pv = await tx.lookupValue<PackageVersion>(m.key);
          if (pv.uploader == fromUserId) {
            pv.uploader = toUserId;
            tx.insert(pv);
          }
        });
      },
    );

    // Like
    await _processConcurrently(
      _db.query<Like>(ancestorKey: fromUserKey),
      (Like like) async {
        await withRetryTransaction(_db, (tx) async {
          tx.queueMutations(
            inserts: [like.changeParentUser(toUserKey)],
            deletes: [like.key],
          );
        });
      },
    );

    // UserSession
    await _processConcurrently(
      _db.query<UserSession>()..filter('userId =', fromUserId),
      (UserSession m) async {
        await withRetryTransaction(_db, (tx) async {
          final session = await tx.lookupValue<UserSession>(m.key);
          if (session.userId == fromUserId) {
            session.userId = toUserId;
            tx.insert(session);
          }
        });
      },
    );

    // Consent's fromUserId attribute
    await _processConcurrently(
      _db.query<Consent>()..filter('fromUserId =', fromUserId),
      (Consent m) async {
        if (m.parentKey?.id != null) {
          throw StateError('Old Consent entity: ${m.consentId}.');
        }
        await withRetryTransaction(_db, (tx) async {
          final consent = await tx.lookupValue<Consent>(m.key);
          if (consent.fromUserId == fromUserId) {
            consent.fromUserId = toUserId;
            consent.fromAgent = toUserId;
            tx.insert(consent);
          }
        });
      },
    );

    // PublisherMember
    await _processConcurrently(
      _db.query<PublisherMember>()..filter('userId =', fromUserId),
      (PublisherMember m) async {
        await withRetryTransaction(_db, (tx) async {
          tx.queueMutations(
            inserts: [m.changeParentUserId(toUserId)],
            deletes: [m.key],
          );
        });
      },
    );

    // AuditLogRecord: agent
    await _processConcurrently(
        _db.query<AuditLogRecord>()..filter('agent =', fromUserId),
        (AuditLogRecord alr) async {
      await withRetryTransaction(_db, (tx) async {
        final r = await _db.lookupValue<AuditLogRecord>(alr.key);
        r.agent = toUserId;
        r.data = r.data?.map((key, value) => MapEntry<String, dynamic>(
            key, value == fromUserId ? toUserId : value));
        tx.insert(r);
      });
    });

    // AuditLogRecord: users
    await _processConcurrently(
        _db.query<AuditLogRecord>()..filter('users =', fromUserId),
        (AuditLogRecord alr) async {
      await withRetryTransaction(_db, (tx) async {
        final r = await _db.lookupValue<AuditLogRecord>(alr.key);
        r.users!.remove(fromUserId);
        r.users!.add(toUserId);
        r.data = r.data?.map(
          (key, value) => MapEntry<String, dynamic>(
              key, value == fromUserId ? toUserId : value),
        );
        tx.insert(r);
      });
    });

    await withRetryTransaction(_db, (tx) async {
      final u = await _db.lookupValue<User>(toUserKey);
      if (toUser.created!.isAfter(fromUser.created!)) {
        u.created = fromUser.created;
      }
      if (toUserMapping == null) {
        u.oauthUserId = null;
      }
      if (fromUserMapping?.userId == toUserId) {
        u.oauthUserId = fromUserMapping!.oauthUserId;
      }
      tx.insert(u);
      tx.delete(fromUserKey);
      if (fromUserMapping?.userId == fromUserId) {
        tx.delete(fromUserMapping!.key);
      }
    });

    await purgeAccountCache(userId: fromUserId);
    await purgeAccountCache(userId: toUserId);
  }

  Future<void> _processConcurrently<T extends Model>(
      Query<T> query, Future<void> Function(T) fn) async {
    final pool = Pool(_concurrency!);
    final futures = <Future>[];
    await for (final m in query.run()) {
      final f = pool.withResource(() => fn(m));
      futures.add(f);
    }
    await Future.wait(futures);
    await pool.close();
  }
}
