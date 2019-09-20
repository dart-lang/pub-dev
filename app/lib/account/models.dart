// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart' as db;
import 'package:meta/meta.dart';
import 'package:ulid/ulid.dart';

/// User data model with a random UUID id.
@db.Kind(name: 'User', idType: db.IdType.String)
class User extends db.ExpandoModel {
  /// Same as [id].
  /// A random UUID id.
  String get userId => id as String;

  /// The Google OAuth2 ID of the [User].
  ///
  /// This may be `null` for users that never logged in since we've started
  /// tracking authentications, or if the user [isDeleted] and the [User] entity
  /// is retained for audit purposes.
  @db.StringProperty()
  String oauthUserId;

  @db.StringProperty()
  String email;

  /// [DateTime] the [User] entity was created.
  ///
  /// This may be `null` if the user [isDeleted] and the [User] entity is
  /// retained for audit purposes.
  @db.DateTimeProperty()
  DateTime created;

  /// Set to `true` if user is deleted, may otherwise be `null` or `false`.
  ///
  /// Use [isDeleted] to avoid `null` checking.
  @db.BoolProperty(propertyName: 'isDeleted')
  bool isDeletedFlag;

  /// [isDeleted] is set when a user account is deleted.
  /// When this happens user-data such as preferences are purged.
  ///
  /// However, we retain the user entity if and only if the user has uploaded
  /// packages or appears in the history by other means. This is to ensure that
  /// we can see:
  /// (A) who uploaded a package, and,
  /// (B) who granted the permissions that allowed said package to be uploaded.
  bool get isDeleted => isDeletedFlag == true;
  set isDeleted(bool value) {
    isDeletedFlag = value;
  }
}

/// Maps Oauth user_id to User.id
@db.Kind(name: 'OAuthUserID', idType: db.IdType.String)
class OAuthUserID extends db.ExpandoModel {
  /// Same as [id].
  String get oauthUserId => id as String;

  @db.ModelKeyProperty(required: true)
  db.Key userIdKey;

  String get userId => userIdKey.id as String;
}

/// Maps the session id (from cookie) to User.id and cached profile properties.
class UserSession extends db.ExpandoModel {
  /// Same as [id].
  /// This is a v4 (random) UUID String.
  String get sessionId => id as String;

  @db.ModelKeyProperty(required: true)
  db.Key userIdKey;

  String get userId => userIdKey.id as String;

  @db.StringProperty(required: true)
  String email;

  @db.StringProperty()
  String imageUrl;

  @db.DateTimeProperty(required: true)
  DateTime created;

  @db.DateTimeProperty(required: true)
  DateTime expires;

  bool isExpired() => DateTime.now().isAfter(expires);
}

/// Derived data for [User] for fast lookup.
@db.Kind(name: 'UserInfo', idType: db.IdType.String)
class UserInfo extends db.ExpandoModel {
  String get userId => id as String;

  @db.StringListProperty()
  List<String> packages = <String>[];

  @db.StringListProperty()
  List<String> publishers = <String>[];

  @db.DateTimeProperty()
  DateTime updated;
}

/// An active consent request sent to the recipient [User] (the parent entity).
@db.Kind(name: 'Consent', idType: db.IdType.String)
class Consent extends db.Model {
  /// The consent id.
  String get consentId => id as String;

  /// The user that this consent is for.
  String get userId => parentKey.id as String;

  /// A [Uri.path]-like concatenation of identifiers from [kind] and [args].
  /// It should be used to query the Datastore for duplicate detection.
  @db.StringProperty()
  String dedupId;

  @db.StringProperty()
  String kind;

  @db.StringListProperty()
  List<String> args;

  @db.StringProperty()
  String fromUserId;

  @db.DateTimeProperty()
  DateTime created;

  @db.DateTimeProperty()
  DateTime expires;

  @db.DateTimeProperty()
  DateTime lastNotified;

  @db.IntProperty()
  int notificationCount;

  Consent();

  Consent.init({
    @required db.Key parentKey,
    @required this.kind,
    @required this.args,
    @required this.fromUserId,
    Duration timeout = const Duration(days: 7),
  }) {
    this.parentKey = parentKey;
    this.id = Ulid().toString();
    dedupId = consentDedupId(kind, args);
    created = DateTime.now().toUtc();
    notificationCount = 0;
    expires = created.add(timeout);
  }

  bool isExpired() => DateTime.now().toUtc().isAfter(expires);

  /// The timestamp when the next notification could be sent out.
  DateTime get nextNotification =>
      (lastNotified ?? created).add(Duration(minutes: 1 << notificationCount));

  /// Whether a new notification should be sent.
  bool shouldNotify() =>
      notificationCount == 0 ||
      DateTime.now().toUtc().isAfter(nextNotification);
}

/// Calculates the dedupId of a consent request.
String consentDedupId(String kind, List<String> args) =>
    [kind, ...args].map(Uri.encodeComponent).join('/');
