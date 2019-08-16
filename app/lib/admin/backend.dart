// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:client_data/admin_api.dart' as api;
import 'package:continuation_token/continuation_token.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';

import '../account/backend.dart';
import '../account/models.dart';
import '../package/models.dart';
import '../publisher/models.dart';
import '../shared/configuration.dart';
import '../shared/exceptions.dart';

final _logger = Logger('pub.admin.backend');

/// Sets the admin backend service.
void registerAdminBackend(AdminBackend backend) =>
    ss.register(#_adminBackend, backend);

/// The active admin backend service.
AdminBackend get adminBackend => ss.lookup(#_adminBackend) as AdminBackend;

/// Represents the backend for the admin handling and authentication.
class AdminBackend {
  final DatastoreDB _db;
  AdminBackend(this._db);

  Future<R> _withAdmin<R>(Future<R> fn(AuthenticatedUser user)) async {
    return await withAuthenticatedUser((u) async {
      // TODO: remove once [withAuthenticatedUser] is using [User]
      final user = await accountBackend.lookupUserById(u.userId);
      if (!activeConfiguration.admins.contains(user.oauthUserId)) {
        throw AuthorizationException.userIsNotAdminForPubSite();
      }
      return await fn(u);
    });
  }

  /// List users.
  Future<api.AdminListUsersResponse> listUsers(
      {String continuationToken, int limit = 1000}) async {
    return await _withAdmin((user) async {
      final query = _db.query<User>()
        ..order('__key__')
        ..limit(limit);

      if (continuationToken != null) {
        Map<String, dynamic> map;
        try {
          map = _decodeContinuation(user.userId, continuationToken);
        } on FormatException catch (_) {
          throw InvalidInputException.continuationParseError();
        }
        InvalidInputException.checkNotNull(map, 'continuationToken');

        final id = map['id'] as String;
        // NOTE: we should fix https://github.com/dart-lang/gcloud/issues/23
        //       and remove the toDatastoreKey conversion here.
        final key =
            _db.modelDB.toDatastoreKey(_db.emptyKey.append(User, id: id));
        if (id != null) {
          query.filter('__key__ >', key);
        }
      }

      try {
        final users = await query.run().toList();
        return api.AdminListUsersResponse(
          users: users
              .map(
                (u) => api.AdminUserEntry(
                  userId: u.userId,
                  email: u.email,
                  oauthUserId: u.oauthUserId,
                ),
              )
              .toList(),
          continuationToken: users.length < limit
              ? null
              : _encodeContinuation(user.userId, {'id': users.last.userId}),
        );
      } catch (e, st) {
        print(e);
        print(st);
        rethrow;
      }
    });
  }

  /// Removes user from the Datastore and updates the packages and other
  /// entities they may have controlled.
  Future removeUser(String userId) async {
    await _withAdmin((u) async {
      // TODO: remove once [withAuthenticatedUser] is using [User]
      final user = await accountBackend.lookupUserById(userId);
      if (user == null) return;

      _logger.info(
          '${u.userId} (${u.email}) initiated the delete of ${user.userId} (${user.email})');

      // Package.uploaders
      final pkgQuery = _db.query<Package>()..filter('uploaders =', user.userId);
      await for (final p in pkgQuery.run()) {
        await _removeUploaderFromPackage(p.key, user.userId);
      }

      // PackageVersion.uploader
      final pvQuery = _db.query<PackageVersion>()
        ..filter('uploader =', user.userId);
      await for (final pv in pvQuery.run()) {
        await _removeUploaderFromVersion(pv.key, user.userId);
      }

      // PublisherMember
      // Publisher.contactEmail
      final memberQuery = _db.query<PublisherMember>()
        ..filter('userId =', user.userId);
      await for (final m in memberQuery.run()) {
        await _removeMember(user, m);
      }

      // OAuthUserID
      if (user.oauthUserId != null) {
        final key = _db.emptyKey.append(OAuthUserID, id: user.oauthUserId);
        final mapping = (await _db.lookup<OAuthUserID>([key])).single;
        if (mapping != null) {
          await _db.commit(deletes: [mapping.key]);
        }
      }

      // User
      await _db.commit(deletes: [user.key]);
    });
  }

  Future _removeUploaderFromPackage(Key pkgKey, String userId) async {
    await _db.withTransaction((tx) async {
      final p = (await tx.lookup<Package>([pkgKey])).single;
      p.removeUploader(userId);
      if (p.uploaders.isEmpty) {
        p.isDiscontinued = true;
      }
      tx.queueMutations(inserts: [p]);
      await tx.commit();
    });
  }

  Future _removeUploaderFromVersion(Key pvKey, String userId) async {
    await _db.withTransaction((tx) async {
      final pv = (await tx.lookup<PackageVersion>([pvKey])).single;
      pv.uploader = null;
      tx.queueMutations(inserts: [pv]);
      await tx.commit();
    });
  }

  Future _removeMember(User user, PublisherMember member) async {
    final seniorMember =
        await _remainingSeniorMember(member.publisherKey, member.userId);
    await _db.withTransaction((tx) async {
      final p = (await tx.lookup<Publisher>([member.publisherKey])).single;
      if (seniorMember == null) {
        p.contactEmail = null;
      } else if (p.contactEmail == user.email) {
        final seniorUser =
            await accountBackend.lookupUserById(seniorMember.userId);
        p.contactEmail = seniorUser.email;
      }
      tx.queueMutations(inserts: [p], deletes: [member.key]);
      await tx.commit();
    });
  }

  Future<PublisherMember> _remainingSeniorMember(
      Key publisherKey, String excludeUserId) async {
    final otherMembers = await _db
        .query<PublisherMember>(ancestorKey: publisherKey)
        .run()
        .where((m) => m.userId != excludeUserId)
        .toList();

    if (otherMembers.isEmpty) return null;

    // sort admins in the front, and on equal level sort by created time
    otherMembers.sort((a, b) {
      if (a.role == b.role) return a.created.compareTo(b.created);
      if (a.role == PublisherMemberRole.admin) return -1;
      if (b.role == PublisherMemberRole.admin) return 1;
      return a.created.compareTo(b.created);
    });

    return otherMembers.first;
  }
}

Map<String, dynamic> _decodeContinuation(String userId, String token) {
  return ContinuationTokenDecoder(secret: userId).convert(token);
}

String _encodeContinuation(String userId, Map<String, dynamic> map) {
  return ContinuationTokenEncoder(secret: userId).convert(map);
}
