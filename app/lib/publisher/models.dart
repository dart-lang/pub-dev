// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:json_annotation/json_annotation.dart';

import '../shared/datastore.dart' as db;

part 'models.g.dart';

/// The type of the package lists of a publisher.
enum PublisherPackagesPageKind {
  listed,
  unlisted,
}

/// Canonical publisher data.
@db.Kind(name: 'Publisher', idType: db.IdType.String)
class Publisher extends db.ExpandoModel<String> {
  /// The associated domain name of the publisher.
  String get publisherId => id!;

  /// Markdown formatted description of the publisher.
  ///
  /// Limited to 64 KB in length.
  @db.StringProperty(indexed: false)
  String? description;

  @db.StringProperty(indexed: false)
  String? websiteUrl;

  /// The email address which other users can use to contact the publisher.
  ///
  /// This may be `null` if the publisher [isAbandoned] and the [Publisher]
  /// entity is retained for audit purposes.
  @db.StringProperty(indexed: false)
  String? contactEmail;

  @db.DateTimeProperty(required: true)
  DateTime? created;

  @db.DateTimeProperty(required: true)
  DateTime? updated;

  /// [isAbandoned] is set when a [Publisher] is abandoned (all of its members left).
  /// When this happens possible user-data such as [contactEmail] are purged.
  ///
  /// However, we retain the [Publisher] entity if and only if their members have
  /// uploaded packages or appears in the history by other means. This is to
  /// ensure that we can see:
  /// (A) who uploaded a package, and,
  /// (B) who granted the permissions that allowed said package to be uploaded.
  @db.BoolProperty(required: true)
  bool isAbandoned = false;

  /// [isBlocked] is set when a [Publisher] is blocked by an administrative action.
  /// When this happens:
  /// - The publisher page should not be visible, nor listed anywhere.
  /// - Administrator roles of the publisher must not be able to change any setting,
  ///   membership information, or invite new members.
  /// - Administrator roles of the publisher must not be able to publisher a new version
  ///   for packages of the publisher, or change any of the existing package's properties.
  @db.BoolProperty(required: true)
  bool isBlocked = false;

  Publisher();

  Publisher.init({
    required db.Key parentKey,
    required String publisherId,
    required this.contactEmail,
  }) {
    final now = clock.now().toUtc();
    this.parentKey = parentKey;
    id = publisherId;
    created = now;
    updated = now;
    description = '';
    websiteUrl = defaultPublisherWebsite(publisherId);
    isAbandoned = false;
    isBlocked = false;
  }

  /// Clears most properties on the entity and sets the [isBlocked] flag.
  void markForBlocked() {
    isBlocked = true;
    isAbandoned = true;
    contactEmail = null;
    description = '';
    updated = clock.now().toUtc();
  }

  /// Whether the publisher has a displayable description.
  bool get hasDescription => description != null && description!.isNotEmpty;

  /// Whether the publisher has a displayable contact email.
  bool get hasContactEmail => contactEmail != null && contactEmail!.isNotEmpty;

  /// Whether we should not list the publisher page in sitemap or promote it in search engines.
  bool get isUnlisted => isBlocked || isAbandoned;
}

/// Derived publisher data.
@db.Kind(name: 'PublisherInfo', idType: db.IdType.String)
class PublisherInfo extends db.ExpandoModel<String> {
  /// The associated domain name of the publisher.
  String get publisherId => id!;

  @db.DateTimeProperty()
  DateTime? updated;

  /// List of packages that are associated with this publisher.
  @db.StringListProperty()
  List<String>? packages;

  /// List of userIds that are administrators of this publisher.
  /// (their email address is public information)
  @db.StringListProperty()
  List<String>? admins;

  /// List of userIds that are public members of this publisher.
  /// (their email address is public information)
  @db.StringListProperty()
  List<String>? publicMembers;
}

/// Values for [PublisherMember.role]
abstract class PublisherMemberRole {
  /// Administrator of the publisher.
  static const String admin = 'admin';

  /// All the allowed values.
  static const values = <String>[admin];
}

/// Stores the membership information of a single user.
@db.Kind(name: 'PublisherMember', idType: db.IdType.String)
class PublisherMember extends db.ExpandoModel<String> {
  /// The key of the publisher.
  db.Key get publisherKey => parentKey!;

  /// The associated domain name of the publisher.
  String get publisherId => publisherKey.id! as String;

  /// The userId of the member.
  @db.StringProperty(required: true)
  String? userId;

  @db.DateTimeProperty(required: true)
  DateTime? created;

  @db.DateTimeProperty(required: true)
  DateTime? updated;

  /// One of [PublisherMemberRole].
  @db.StringProperty(required: true)
  String? role;

  /// Returns a new [PublisherMember] object with a new parent.
  /// Should be used only for merging users.
  PublisherMember changeParentUserId(String? userId) {
    return PublisherMember()
      ..parentKey = parentKey
      ..id = userId
      ..userId = userId
      ..created = created
      ..updated = updated
      ..role = role;
  }
}

@JsonSerializable()
class PublisherPage {
  final List<PublisherSummary>? publishers;

  PublisherPage({
    required this.publishers,
  });

  factory PublisherPage.fromJson(Map<String, dynamic> json) =>
      _$PublisherPageFromJson(json);
  Map<String, dynamic> toJson() => _$PublisherPageToJson(this);
}

@JsonSerializable()
class PublisherSummary {
  final String publisherId;
  final DateTime created;

  PublisherSummary({
    required this.publisherId,
    required this.created,
  });

  factory PublisherSummary.fromJson(Map<String, dynamic> json) =>
      _$PublisherSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$PublisherSummaryToJson(this);
}

String defaultPublisherWebsite(String domain) => 'https://$domain/';
