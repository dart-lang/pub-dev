// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:gcloud/db.dart' as db;
import 'package:meta/meta.dart';
import 'package:ulid/ulid.dart';

import '../frontend/static_files.dart';
import '../search/search_service.dart' show SearchQuery;

part 'models.g.dart';

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

/// Data model for [Like] entities.
///
/// Key properties:
///  * `id`: name of the package that is liked.
///  * `parentKey`: key of the user that liked the package.
///
/// A [Like] entity is created when [userId] likes [package].
/// When a user unlikes a package the [Like] entity is deleted
@db.Kind(name: 'Like', idType: db.IdType.String)
class Like extends db.ExpandoModel {
  String get userId => parentKey.id as String;
  String get package => id as String;

  @db.DateTimeProperty()
  DateTime created;

  /// Same as [id]. This is added to enable filtering on queries.
  @db.StringProperty()
  String packageName;
}

/// The cacheable version of [Like].
@JsonSerializable()
class LikeData {
  final String userId;
  final String package;
  final DateTime created;

  LikeData({this.userId, this.package, this.created});

  factory LikeData.fromJson(Map<String, dynamic> json) =>
      _$LikeDataFromJson(json);

  Map<String, dynamic> toJson() => _$LikeDataToJson(this);

  factory LikeData.fromModel(Like like) {
    return LikeData(
      userId: like.userId,
      package: like.package,
      created: like.created,
    );
  }
}

/// Maps the session id (from cookie) to User.id and cached profile properties.
@db.Kind(name: 'UserSession', idType: db.IdType.String)
class UserSession extends db.ExpandoModel {
  /// Same as [id].
  /// This is a v4 (random) UUID String.
  String get sessionId => id as String;

  @db.ModelKeyProperty(required: true)
  db.Key userIdKey;

  String get userId => userIdKey.id as String;

  @db.StringProperty(required: true)
  String email;

  /// The name of the user given by the authentication provider.
  /// May be null, or could contain any arbitrary text.
  @db.StringProperty()
  String name;

  @db.StringProperty()
  String imageUrl;

  @db.DateTimeProperty(required: true)
  DateTime created;

  @db.DateTimeProperty(required: true)
  DateTime expires;

  bool isExpired() => DateTime.now().isAfter(expires);
}

/// The cacheable version of [UserSession].
@JsonSerializable()
class UserSessionData {
  /// This is a v4 (random) UUID String that is set as a http cookie.
  final String sessionId;

  /// The v4 (random) UUID String of the [User] that has this session.
  final String userId;

  /// The email address of the [User].
  final String email;

  /// The name of the [User] (may be null, or any arbitrary text).
  final String name;

  /// The image URL of the user's profile picture (may be null).
  final String imageUrl;

  /// The time when the session was created.
  final DateTime created;

  /// The time when the session will expire.
  final DateTime expires;

  UserSessionData({
    this.sessionId,
    this.userId,
    this.email,
    this.name,
    this.imageUrl,
    this.created,
    this.expires,
  });

  factory UserSessionData.fromModel(UserSession session) {
    return UserSessionData(
      sessionId: session.sessionId,
      userId: session.userId,
      email: session.email,
      name: session.name,
      imageUrl: session.imageUrl,
      created: session.created,
      expires: session.expires,
    );
  }

  factory UserSessionData.fromJson(Map<String, dynamic> json) =>
      _$UserSessionDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserSessionDataToJson(this);

  /// Set image size to NxN pixels for faster loading, see:
  /// https://developers.google.com/people/image-sizing
  String imageUrlOfSize(int layoutSize) {
    if (imageUrl == null) {
      return staticUrls.defaultProfilePng;
    }
    // Double the layout size, for better quality on higher dpi displays.
    final imageSize = layoutSize * 2;
    return '$imageUrl=s$imageSize';
  }
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

/// An active consent request sent to a recipient.
///
/// When [userId] or [email] is specified, the accepting user is matched against
/// these values on accepting the consent.
@db.Kind(name: 'Consent', idType: db.IdType.String)
class Consent extends db.Model {
  /// The consent id.
  String get consentId => id as String;

  /// The user that this consent is for.
  @db.StringProperty()
  String userId;

  @db.StringProperty()
  String email;

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
    @required this.fromUserId,
    @required this.userId,
    @required this.email,
    @required this.kind,
    @required this.args,
    Duration timeout = const Duration(days: 7),
  }) {
    id = Ulid().toString();
    dedupId = consentDedupId(
      fromUserId: fromUserId,
      userId: userId,
      email: email,
      kind: kind,
      args: args,
    );
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
String consentDedupId({
  @required String fromUserId,
  @required String userId,
  @required String email,
  @required String kind,
  @required List<String> args,
}) =>
    [fromUserId, userId, email, kind, ...args]
        .where((s) => s != null)
        .map(Uri.encodeComponent)
        .join('/');

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class SearchPreference {
  final String sdk;
  final List<String> runtimes;
  final List<String> platforms;

  SearchPreference._(this.sdk, this.runtimes, this.platforms);

  factory SearchPreference({
    String sdk,
    List<String> runtimes,
    List<String> platforms,
  }) =>
      SearchPreference._(
        sdk,
        runtimes ?? <String>[],
        platforms ?? <String>[],
      );

  factory SearchPreference.fromJson(Map<String, dynamic> json) =>
      _$SearchPreferenceFromJson(json);

  factory SearchPreference.fromSearchQuery(SearchQuery query) {
    return SearchPreference(
      sdk: query.sdk,
      runtimes: query.tagsPredicate.tagPartsWithPrefix('runtime'),
      platforms: query.tagsPredicate.tagPartsWithPrefix('platform'),
    );
  }

  /// Parses cookie [value] and returns the parsed object.
  /// Returns `null` if value is invalid.
  static SearchPreference tryParseCookieValue(String value) {
    if (value == null) return null;
    try {
      return SearchPreference.fromJson(
          json.decode(utf8.decode(base64Url.decode(value)))
              as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic> toJson() => _$SearchPreferenceToJson(this);

  String toCookieValue() {
    final reduced = SearchPreference._(
      sdk,
      runtimes.isEmpty ? null : runtimes,
      platforms.isEmpty ? null : platforms,
    );
    return base64Url.encode(utf8.encode(json.encode(reduced.toJson())));
  }

  SearchQuery toSearchQuery() =>
      SearchQuery.parse(sdk: sdk, runtimes: runtimes, platforms: platforms);
}
