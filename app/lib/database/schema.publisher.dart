// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'schema.dart';

/// A publisher: a verified domain that owns packages.
///
/// TODO: rename to `Publisher` after the SQL migration.
@PrimaryKey(['publisherId'])
abstract final class PublisherRow extends Row {
  /// The domain name of the publisher.
  String get publisherId;

  /// Markdown formatted description.
  String? get description;

  String? get websiteUrl;

  /// `null` when the publisher is abandoned and the address is purged.
  String? get contactEmail;

  DateTime get createdAt;

  DateTime get updatedAt;

  bool get isAbandoned;

  bool get isModerated;

  DateTime? get moderatedAt;
}

extension PublisherRowExt on PublisherRow {
  /// Whether the publisher has a displayable description.
  bool get hasDescription => description != null && description!.isNotEmpty;

  /// Whether the publisher has a displayable contact email.
  bool get hasContactEmail => contactEmail != null && contactEmail!.isNotEmpty;

  /// Whether we should not list the publisher page in sitemap or promote it in
  /// search engines.
  bool get isUnlisted => isAbandoned || isModerated;
  bool get isVisible => !isUnlisted;

  PublisherStatus get status {
    if (isModerated) {
      return PublisherStatus.moderated;
    } else if (isAbandoned) {
      return PublisherStatus.abandoned;
    } else {
      return PublisherStatus.active;
    }
  }
}

/// A user that is a member of a publisher.
///
/// TODO: rename to `PublisherMember` after the SQL migration.
@PrimaryKey(['publisherId', 'userId'])
@ForeignKey(
  ['publisherId'],
  table: 'publishers',
  fields: ['publisherId'],
  name: 'publisher',
  as: 'members',
  onDelete: .cascade,
  onUpdate: .cascade,
)
@ForeignKey(
  ['userId'],
  table: 'users',
  fields: ['userId'],
  name: 'user',
  as: 'publisherMemberships',
  onDelete: .cascade,
  onUpdate: .cascade,
)
@Index(name: 'userPublisher', fields: ['userId', 'publisherId'])
abstract final class PublisherMemberRow extends Row {
  String get publisherId;

  String get userId;

  DateTime get createdAt;

  DateTime get updatedAt;

  /// One of the `PublisherMemberRole` values.
  String get role;
}
