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
  Future<Publisher> getPublisher(String publisherId) async {
    final pKey = _db.emptyKey.append(Publisher, id: publisherId);
    return (await _db.lookup<Publisher>([pKey])).single;
  }

  /// Checks whether the current authenticated user has admin role of the
  /// publisher, and executes [fn] if it does.
  /// Otherwise, it throws [AuthorizationException].
  Future<R> _withPublisherAdmin<R>(
      String publisherId, Future<R> fn(Publisher p)) async {
    return await withAuthenticatedUser((user) async {
      final p = await getPublisher(publisherId);
      if (p == null) {
        throw NotFoundException('Publisher $publisherId does not exists.');
      }

      final member = (await _db.lookup<PublisherMember>(
              [p.key.append(PublisherMember, id: user.userId)]))
          .single;
      if (member == null || member.role != PublisherMemberRole.admin) {
        _logger.info(
            'Unauthorized access of Publisher($publisherId) from ${user.email}.');
        throw AuthorizationException(
          'Insufficient permissions to perform administrative tasks',
        );
      }
      return await fn(p);
    });
  }

  /// Updates the publisher data.
  /// TODO: remove once publisher/backend_test.dart is migrated to use handlers.
  Future updatePublisherData(String publisherId, String description) async {
    await updatePublisher(
        publisherId, api.UpdatePublisherRequest(description: description));
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
    return api.PublisherInfo(
        description: p.description, contact: p.contactEmail);
  }
}
