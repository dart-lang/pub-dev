// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:client_data/admin_api.dart' as api;
import 'package:convert/convert.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:pool/pool.dart';

import '../account/backend.dart';
import '../account/models.dart';
import '../package/models.dart';
import '../publisher/models.dart';
import '../shared/configuration.dart';
import '../shared/exceptions.dart';

final _logger = Logger('pub.admin.backend');
final _continuationCodec = utf8.fuse(hex);

/// Sets the admin backend service.
void registerAdminBackend(AdminBackend backend) =>
    ss.register(#_adminBackend, backend);

/// The active admin backend service.
AdminBackend get adminBackend => ss.lookup(#_adminBackend) as AdminBackend;

/// Represents the backend for the admin handling and authentication.
class AdminBackend {
  final DatastoreDB _db;
  AdminBackend(this._db);

  Future<R> _withAdmin<R>(Future<R> fn(User user)) async {
    final user = await requireAuthenticatedUser();
    final admin = activeConfiguration.admins.firstWhere(
        (a) => a.oauthUserId == user.oauthUserId && a.email == user.email,
        orElse: () => null);
    if (admin == null) {
      _logger.warning(
          'User (${user.userId} / ${user.email}) is trying to access admin APIs.');
      throw AuthorizationException.userIsNotAdminForPubSite();
    }
    return await fn(user);
  }

  /// List users.
  ///
  ///
  Future<api.AdminListUsersResponse> listUsers({
    String email,
    String oauthUserId,
    String continuationToken,
    int limit = 1000,
  }) async {
    InvalidInputException.checkRange(limit, 'limit', minimum: 1, maximum: 1000);
    return await _withAdmin((user) async {
      final query = _db.query<User>()..limit(limit);

      if (email != null) {
        InvalidInputException.checkNull(oauthUserId, '?ouid=');
        InvalidInputException.checkNull(continuationToken, '?ct=');
        query.filter('email =', email);
      } else if (oauthUserId != null) {
        InvalidInputException.checkNull(continuationToken, '?ct=');
        query.filter('oauthUserId =', oauthUserId);
      } else if (continuationToken != null) {
        String lastId;
        try {
          lastId = _continuationCodec.decode(continuationToken);
        } on FormatException catch (_) {
          throw InvalidInputException.continuationParseError();
        }
        InvalidInputException.checkNotNull(lastId, '?ct=');

        // NOTE: we should fix https://github.com/dart-lang/gcloud/issues/23
        //       and remove the toDatastoreKey conversion here.
        final key =
            _db.modelDB.toDatastoreKey(_db.emptyKey.append(User, id: lastId));
        if (lastId != null) {
          query.filter('__key__ >', key);
        }
        query.order('__key__');
      } else {
        query.order('__key__');
      }

      final users = await query.run().toList();
      // We may return a page with users less then a limit, but we always
      // set the continuation token to the correct value.
      final newContinuationToken = users.length < limit
          ? null
          : _continuationCodec.encode(users.last.userId);
      users.removeWhere((u) => u.isDeleted);

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
        continuationToken: newContinuationToken,
      );
    });
  }

  /// Removes user from the Datastore and updates the packages and other
  /// entities they may have controlled.
  Future removeUser(String userId) async {
    await _withAdmin((u) async {
      final user = await accountBackend.lookupUserById(userId);
      if (user == null) return;
      if (user.isDeleted) return;

      _logger.info(
          '${u.userId} (${u.email}) initiated the delete of ${user.userId} (${user.email})');

      // Package.uploaders
      final pool = Pool(10);
      final futures = <Future>[];
      final pkgQuery = _db.query<Package>()..filter('uploaders =', user.userId);
      await for (final p in pkgQuery.run()) {
        final f = pool
            .withResource(() => _removeUploaderFromPackage(p.key, user.userId));
        futures.add(f);
      }
      await Future.wait(futures);
      await pool.close();

      // PublisherMember
      // Publisher.contactEmail
      final memberQuery = _db.query<PublisherMember>()
        ..filter('userId =', user.userId);
      await for (final m in memberQuery.run()) {
        await _removeMember(user, m);
      }

      // User
      // OAuthUserID
      // TODO: consider deleting User if there are no other references to it
      await _markUserDeleted(user);
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

  Future _removeMember(User user, PublisherMember member) async {
    final seniorMember =
        await _remainingSeniorMember(member.publisherKey, member.userId);
    await _db.withTransaction((tx) async {
      final p = (await tx.lookup<Publisher>([member.publisherKey])).single;
      if (seniorMember == null) {
        p.isAbandoned = true;
        p.contactEmail = null;
        // TODO: consider deleting Publisher if there are no other references to it
      } else if (p.contactEmail == user.email) {
        final seniorUser =
            await accountBackend.lookupUserById(seniorMember.userId);
        p.contactEmail = seniorUser.email;
      }
      tx.queueMutations(inserts: [p], deletes: [member.key]);
      await tx.commit();
    });
    if (seniorMember == null) {
      // mark packages under the publisher discontinued
      final query = _db.query<Package>()
        ..filter('publisherId =', member.publisherId);
      final pool = Pool(4);
      final futures = <Future>[];
      await for (final package in query.run()) {
        if (package.isDiscontinued) continue;
        final f = pool.withResource(
          () => _db.withTransaction((tx) async {
            final p = (await tx.lookup<Package>([package.key])).single;
            p.isDiscontinued = true;
            tx.queueMutations(inserts: [p]);
            await tx.commit();
          }),
        );
        futures.add(f);
      }
      await Future.wait(futures);
      await pool.close();
    }
  }

  /// Returns the member of the publisher that (a) is not removed,
  /// (b) preferably is an admin, and (c) is member of the publisher for the
  /// longest time.
  ///
  /// If there are no more admins left, the "oldest" non-admin member is returned.
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

  Future _markUserDeleted(User user) async {
    await _db.withTransaction((tx) async {
      final u = (await tx.lookup<User>([user.key])).single;
      final deleteKeys = <Key>[];
      if (user.oauthUserId != null) {
        final mappingKey =
            _db.emptyKey.append(OAuthUserID, id: user.oauthUserId);
        final mapping = (await tx.lookup<OAuthUserID>([mappingKey])).single;
        if (mapping != null) {
          deleteKeys.add(mappingKey);
        }
      }

      u
        ..oauthUserId = null
        ..created = null
        ..isDeleted = true;
      tx.queueMutations(inserts: [u], deletes: deleteKeys);
      await tx.commit();
    });
  }
}
