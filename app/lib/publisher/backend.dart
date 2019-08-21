// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:client_data/account_api.dart' as account_api;
import 'package:client_data/publisher_api.dart' as api;
import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';

import '../account/backend.dart';
import '../account/consent_backend.dart';
import '../shared/email.dart';
import '../shared/exceptions.dart';
import 'domain_verifier.dart' show domainVerifier;

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
  /// TODO: remove this and migrate to use withPublisherAdmin
  Future<R> _withPublisherAdmin<R>(
      String publisherId, Future<R> fn(Publisher p)) async {
    return await withAuthenticatedUser((user) async {
      return await withPublisherAdmin(publisherId, user.userId, fn);
    });
  }

  /// Create publisher.
  Future<api.PublisherInfo> createPublisher(
    String publisherId,
    api.CreatePublisherRequest body,
  ) async {
    // Sanity check that domains are:
    //  - lowercase (because we want that in pub.dev)
    //  - consist of a-z, 0-9 and dashes
    // We do not care if they end in dash, as such domains can't be verified.
    InvalidInputException.checkMatchPattern(
      publisherId,
      'publisherId',
      RegExp(r'^[a-z0-9-]{1,63}\.[a-z0-9-]{1,63}$'),
    );
    InvalidInputException.checkStringLength(
      publisherId,
      'publisherId',
      maximum: 255, // Some upper limit for sanity.
    );
    InvalidInputException.checkNotNull(body.accessToken, 'accessToken');
    InvalidInputException.checkStringLength(
      body.accessToken,
      'accessToken',
      minimum: 1,
      maximum: 4096,
    );

    // Verify ownership of domain.
    final isOwner = await domainVerifier.verifyDomainOwnership(
      publisherId,
      body.accessToken,
    );
    if (!isOwner) {
      throw AuthorizationException.userIsNotDomainOwner(publisherId);
    }

    // Create the publisher
    final now = DateTime.now().toUtc();
    await _db.withTransaction((tx) async {
      final key = _db.emptyKey.append(Publisher, id: publisherId);
      final p = (await tx.lookup<Publisher>([key])).single;
      if (p != null) {
        // Check that publisher is the same as what we would create.
        if (p.created.isBefore(now.subtract(Duration(minutes: 10))) ||
            p.updated.isBefore(now.subtract(Duration(minutes: 10))) ||
            p.contactEmail != authenticatedUser.email ||
            p.description != '' ||
            p.websiteUrl != 'https://$publisherId') {
          throw ConflictException.publisherAlreadyExists(publisherId);
        }
        // Avoid creating the same publisher again, this end-point is idempotent
        // if we just do nothing here.
        return;
      }

      // Create publisher
      tx.queueMutations(inserts: [
        Publisher()
          ..parentKey = _db.emptyKey
          ..id = publisherId
          ..created = now
          ..description = ''
          ..contactEmail = authenticatedUser.email
          ..updated = now
          ..websiteUrl = 'https://$publisherId',
        PublisherMember()
          ..parentKey = _db.emptyKey.append(Publisher, id: publisherId)
          ..id = authenticatedUser.userId
          ..created = now
          ..updated = now
          ..role = PublisherMemberRole.admin
      ]);
      await tx.commit();
    });

    // Return publisher as it was created
    final key = _db.emptyKey.append(Publisher, id: publisherId);
    final p = (await _db.lookup<Publisher>([key])).single;
    return _asPublisherInfo(p);
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
    final p = await _withPublisherAdmin(publisherId, (_) async {
      return await _db.withTransaction((tx) async {
        final key = _db.emptyKey.append(Publisher, id: publisherId);
        final p = (await tx.lookup<Publisher>([key])).single;

        if (update.contactEmail != null &&
            p.contactEmail != update.contactEmail) {
          final user =
              await accountBackend.lookupUserByEmail(update.contactEmail);
          InvalidInputException.check(user != null,
              'Only administrator e-mail can be used as contact e-mail.');
          final members = await tx.lookup<PublisherMember>(
              [p.key.append(PublisherMember, id: user.userId)]);
          final member = members.single;
          InvalidInputException.check(member?.role == PublisherMemberRole.admin,
              'Only administrator e-mail can be used as contact e-mail.');
        }

        p.description = update.description ?? p.description;
        p.contactEmail = update.contactEmail ?? p.contactEmail;
        p.updated = DateTime.now().toUtc();

        tx.queueMutations(inserts: [p]);
        await tx.commit();
        return p;
      }) as Publisher;
    });
    return _asPublisherInfo(p);
  }

  /// Invites a user to become a publisher admin.
  Future<account_api.InviteStatus> invitePublisherMember(
      String publisherId, api.InviteMemberRequest invite) async {
    return await _withPublisherAdmin(publisherId, (p) async {
      InvalidInputException.checkNotNull(invite.email, 'email');
      InvalidInputException.checkStringLength(invite.email, 'email',
          maximum: 4096);
      InvalidInputException.check(
          isValidEmail(invite.email), 'Invalid e-mail: `${invite.email}`');
      final user = await accountBackend.lookupOrCreateUserByEmail(invite.email);

      final userId = user.userId;
      final key = p.key.append(PublisherMember, id: userId);
      final pm = (await _db.lookup<PublisherMember>([key])).single;
      InvalidInputException.checkNull(pm, 'User is already a member.');

      return await consentBackend.invite(
        userId: userId,
        kind: 'PublisherMember',
        args: [p.publisherId],
      );
    });
  }

  /// List the members of a publishers
  Future<api.PublisherMembers> listPublisherMembers(String publisherId) async {
    return await _withPublisherAdmin(publisherId, (p) async {
      // TODO: add caching
      final query = _db.query<PublisherMember>(ancestorKey: p.key);
      final members = <api.PublisherMember>[];
      await for (final pm in query.run()) {
        members.add(await _asPublisherMember(pm));
      }
      return api.PublisherMembers(members: members);
    });
  }

  /// The list of e-mail addresses of the members with admin roles. The list
  /// should be used to notify admins on upload events.
  Future<List<String>> getAdminMemberEmails(String publisherId) async {
    final result = <String>[];
    final key = _db.emptyKey.append(Publisher, id: publisherId);
    final query = _db.query<PublisherMember>(ancestorKey: key)
      ..filter('role =', PublisherMemberRole.admin);
    await for (final m in query.run()) {
      final email = await accountBackend.getEmailOfUserId(m.userId);
      result.add(email);
    }
    return result;
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
    return await _withPublisherAdmin(publisherId, (p) async {
      final key = p.key.append(PublisherMember, id: userId);
      final pm = (await _db.lookup<PublisherMember>([key])).single;
      if (pm == null) {
        throw NotFoundException.resource('member: $userId');
      }
      if (update.role != null && update.role != pm.role) {
        // user is not allowed to update their own role
        if (userId == authenticatedUser.userId) {
          throw ConflictException.cantUpdateOwnRole();
        }
        // role needs to be from the allowed set of values
        InvalidInputException.checkAnyOf(
            update.role, 'role', PublisherMemberRole.values);
        await _db.withTransaction((tx) async {
          final current = (await tx.lookup<PublisherMember>([key])).single;
          // fall back to current role if role is not updated
          current.role = update.role ?? current.role;
          current.updated = DateTime.now().toUtc();
          tx.queueMutations(inserts: [current]);
          await tx.commit();
        });
      }
      final updated = (await _db.lookup<PublisherMember>([key])).single;
      return await _asPublisherMember(updated);
    });
  }

  /// Deletes a publisher's member.
  Future deletePublisherMember(String publisherId, String userId) async {
    return await _withPublisherAdmin(publisherId, (p) async {
      if (userId == authenticatedUser.userId) {
        throw ConflictException.cantUpdateSelf();
      }

      final key = p.key.append(PublisherMember, id: userId);
      final pm = (await _db.lookup<PublisherMember>([key])).single;
      if (pm != null) {
        await _db.commit(deletes: [pm.key]);
      }
    });
  }

  /// A callback from consent backend, when a consent is granted.
  /// Note: this will be retried when transaction fails due race conditions.
  Future inviteConsentGranted(String publisherId, String userId) async {
    await _db.withTransaction((tx) async {
      final key = _db.emptyKey
          .append(Publisher, id: publisherId)
          .append(PublisherMember, id: userId);
      final list = await tx.lookup<PublisherMember>([key]);
      final member = list.single;
      if (member != null) return;
      final now = DateTime.now().toUtc();
      tx.queueMutations(inserts: [
        PublisherMember()
          ..parentKey = key.parent
          ..id = userId
          ..created = now
          ..updated = now
          ..role = PublisherMemberRole.admin
      ]);
      await tx.commit();
    });
  }

  /// A callback from consent backend, when a consent is not granted, or expired.
  /// Note: this will be retried when transaction fails due race conditions.
  Future inviteDeleted(String publisherId, String userId) async {
    // nothing to do
  }

  Future<api.PublisherMember> _asPublisherMember(PublisherMember pm) async {
    return api.PublisherMember(
      userId: pm.userId,
      role: pm.role,
      email: await accountBackend.getEmailOfUserId(pm.userId),
    );
  }
}

api.PublisherInfo _asPublisherInfo(Publisher p) =>
    api.PublisherInfo(description: p.description, contactEmail: p.contactEmail);

/// Loads [publisherId] and checks if [userId] is an admin of the publisher, and
/// runs the callback [fn] with it.
///
/// Throws AuthenticationException if the user is provided.
/// Throws AuthorizationException if the user is not an admin for the publisher.
Future<R> withPublisherAdmin<R>(
    String publisherId, String userId, FutureOr<R> fn(Publisher p)) async {
  ArgumentError.checkNotNull(userId, 'userId');
  final p = await publisherBackend._getPublisher(publisherId);
  if (p == null) {
    throw NotFoundException('Publisher $publisherId does not exists.');
  }

  final member = (await publisherBackend._db
          .lookup<PublisherMember>([p.key.append(PublisherMember, id: userId)]))
      .single;
  if (member == null || member.role != PublisherMemberRole.admin) {
    _logger.info(
        'Unauthorized access of Publisher($publisherId) from User($userId).');
    throw AuthorizationException.userIsNotAdminForPublisher(publisherId);
  }
  return await fn(p);
}
