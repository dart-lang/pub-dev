// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart' as db;

/// Canonical publisher data.
@db.Kind(name: 'Publisher', idType: db.IdType.String)
class Publisher extends db.ExpandoModel {
  /// The associated domain name of the publisher.
  String get publisherId => id as String;

  /// Markdown formatted description of the publisher.
  ///
  /// Limited to 64 KB in length.
  @db.StringProperty()
  String description;

  @db.StringProperty()
  String websiteUrl;

  @db.StringProperty()
  String contactEmail;

  @db.DateTimeProperty()
  DateTime created;

  @db.DateTimeProperty()
  DateTime updated;
}

/// Derived publisher data.
@db.Kind(name: 'PublisherInfo', idType: db.IdType.String)
class PublisherInfo extends db.ExpandoModel {
  /// The associated domain name of the publisher.
  String get publisherId => id as String;

  @db.DateTimeProperty()
  DateTime updated;

  /// List of packages that are associated with this publisher.
  @db.StringListProperty()
  List<String> packages;

  /// List of userIds that are administrators of this publisher.
  /// (their e-mail address is public information)
  @db.StringListProperty()
  List<String> admins;

  /// List of userIds that are public members of this publisher.
  /// (their e-mail address is public information)
  @db.StringListProperty()
  List<String> publicMembers;
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
class PublisherMember extends db.ExpandoModel {
  /// The key of the publisher.
  db.Key get publisherKey => parentKey;

  /// The associated domain name of the publisher.
  String get publisherId => publisherKey.id as String;

  /// The userId of the member.
  String get userId => id as String;

  @db.DateTimeProperty()
  DateTime created;

  @db.DateTimeProperty()
  DateTime updated;

  /// One of [PublisherMemberRole].
  @db.StringProperty()
  String role;
}
