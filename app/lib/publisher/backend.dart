// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:client_data/publisher_api.dart' as api;
import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';

import '../account/backend.dart';
import '../shared/exceptions.dart';

import 'models.dart';

final _logger = Logger('pub.publisher.backend');

/// Sets the publisher backend service.
void registerPublisherBackend(PublisherBackend backend) =>
    ss.register(#_publisherBackend, backend);

/// The active publisher backend service.
PublisherBackend get publisherBackend =>
    ss.lookup(#_publisherBackend) as PublisherBackend;

/// Represents the backend for the publisher handling and related utilities.
class PublisherBackend {
  final DatastoreDB _db;

  PublisherBackend(this._db);

  /// Loads a publisher (or returns null if it does not exists).
  Future<Publisher> _getPublisher(String publisherId) async {
    final pKey = _db.emptyKey.append(Publisher, id: publisherId);
    return (await _db.lookup<Publisher>([pKey])).single;
  }

  /// Checks whether the current authenticated user has admin role of the
  /// publisher, and executes [fn] if it does.
  /// Otherwise, it throws [AuthorizationException].
  Future<R> _withPublisherAdmin<R>(
      String publisherId, Future<R> fn(Publisher p)) async {
    return await withAuthenticatedUser((user) async {
      final p = await _getPublisher(publisherId);
      if (p == null) {
        throw NotFoundException('Publisher $publisherId does not exists.');
      }

      final member = (await _db.lookup<PublisherMember>(
              [p.key.append(PublisherMember, id: user.userId)]))
          .single;
      if (member == null || member.role != PublisherMemberRole.admin) {
        _logger.info(
            'Unauthorized access of Publisher($publisherId) from ${user.email}.');
        throw AuthorizationException.userIsNotAdminForPublisher(publisherId);
      }
      return await fn(p);
    });
  }

  /// Gets the publisher data
  Future<api.PublisherInfo> getPublisher(String publisherId) async {
    final p = await _getPublisher(publisherId);
    if (p == null) {
      throw NotFoundException('Publisher $publisherId does not exists.');
    }
    return _asPublisherInfo(p);
  }

  /// Updates the publisher data.
  Future<api.PublisherInfo> updatePublisher(
      String publisherId, api.UpdatePublisherRequest update) async {
    if (update.description != null) {
      ArgumentError.checkNotNull(update.description, 'description');
      if (update.description.length > 64 * 1024) {
        throw ArgumentError('Description too long.');
      }
    }
    if (update.contact != null) {
      throw ArgumentError('Contact change is not implemented.');
    }
    final p = await _withPublisherAdmin(publisherId, (_) async {
      return await _db.withTransaction((tx) async {
        final key = _db.emptyKey.append(Publisher, id: publisherId);
        final p = (await tx.lookup<Publisher>([key])).single;
        p.description = update.description ?? p.description;
        tx.queueMutations(inserts: [p]);
        await tx.commit();
        return p;
      }) as Publisher;
    });
    return _asPublisherInfo(p);
  }

  /// List the members of a publishers
  Future<api.PublisherMembers> listPublisherMembers(String publisherId) async {
    return await _withPublisherAdmin(publisherId, (p) async {
      final query = _db.query<PublisherMember>(ancestorKey: p.key);
      final members = <api.PublisherMember>[];
      await for (final pm in query.run()) {
        final member = api.PublisherMember(
          userId: pm.userId,
          email: await accountBackend.getEmailOfUserId(pm.userId),
          role: pm.role,
        );
        members.add(member);
      }
      return api.PublisherMembers(members: members);
    });
  }

  /// Returns the membership info of a user.
  Future<api.PublisherMember> publisherMemberInfo(
      String publisherId, String userId) async {
    return await _withPublisherAdmin(publisherId, (p) async {
      final key = p.key.append(PublisherMember, id: userId);
      final pm = (await _db.lookup<PublisherMember>([key])).single;
      if (pm == null) {
        throw NotFoundException.resource('member: $userId');
      }
      return await _asPublisherMember(pm);
    });
  }

  /// Updates the membership info of a user.
  Future<api.PublisherMember> updatePublisherMember(
    String publisherId,
    String userId,
    api.UpdatePublisherMemberRequest update,
  ) async {
    if (userId == authenticatedUser?.userId) {
      throw ConflictException.cantUpdateSelf();
    }
    return await _withPublisherAdmin(publisherId, (p) async {
      final key = p.key.append(PublisherMember, id: userId);
      final pm = (await _db.lookup<PublisherMember>([key])).single;
      if (pm == null) {
        throw NotFoundException.resource('member: $userId');
      }
      if (update.role != null && update.role != pm.role) {
        if (pm.role == PublisherMemberRole.pending) {
          throw ConflictException.invitePending();
        }
        await _db.withTransaction((tx) async {
          final current = (await tx.lookup<PublisherMember>([key])).single;
          current.role = update.role;
          tx.queueMutations(inserts: [current]);
          await tx.commit();
        });
      }
      final updated = (await _db.lookup<PublisherMember>([key])).single;
      return await _asPublisherMember(updated);
    });
  }

  api.PublisherInfo _asPublisherInfo(Publisher p) =>
      api.PublisherInfo(description: p.description, contact: p.contactEmail);

  Future<api.PublisherMember> _asPublisherMember(PublisherMember pm) async {
    return api.PublisherMember(
      userId: pm.userId,
      role: pm.role,
      email: await accountBackend.getEmailOfUserId(pm.userId),
    );
  }
}
