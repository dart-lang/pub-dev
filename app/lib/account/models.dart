// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pub_dev/shared/utils.dart';
import 'package:ulid/ulid.dart';

import '../frontend/static_files.dart';
import '../shared/datastore.dart' as db;

part 'models.g.dart';

/// User data model with a random UUID id.
@db.Kind(name: 'User', idType: db.IdType.String)
class User extends db.ExpandoModel<String> {
  /// Same as [id].
  /// A random UUID id.
  String get userId => id!;

  /// The Google OAuth2 ID of the [User].
  ///
  /// This may be `null` for users that never logged in since we've started
  /// tracking authentications, or if the user [isDeleted] and the [User] entity
  /// is retained for audit purposes.
  @db.StringProperty()
  String? oauthUserId;

  @db.StringProperty()
  String? email;

  /// [DateTime] the [User] entity was created.
  ///
  /// This may be `null` if the user [isDeleted] and the [User] entity is
  /// retained for audit purposes.
  @db.DateTimeProperty()
  DateTime? created;

  /// [isDeleted] is set when a user account is deleted.
  /// When this happens user-data such as preferences are purged.
  ///
  /// However, we retain the user entity if and only if the user has uploaded
  /// packages or appears in the history by other means. This is to ensure that
  /// we can see:
  /// (A) who uploaded a package, and,
  /// (B) who granted the permissions that allowed said package to be uploaded.
  @db.BoolProperty(required: true)
  bool isDeleted = false;

  /// [isBlocked] is set when a user account is blocked (is on administrative hold).
  /// When this happens user-data is preserved, but the user should not be able
  /// to perform any action.
  @db.BoolProperty(required: true)
  bool isBlocked = false;
}

/// Maps Oauth user_id to User.id
@db.Kind(name: 'OAuthUserID', idType: db.IdType.String)
class OAuthUserID extends db.ExpandoModel<String> {
  /// Same as [id].
  String get oauthUserId => id!;

  @db.ModelKeyProperty(required: true)
  db.Key? userIdKey;

  String get userId => userIdKey!.id as String;
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
class Like extends db.ExpandoModel<String> {
  String get userId => parentKey!.id! as String;
  String get package => id!;

  @db.DateTimeProperty()
  DateTime? created;

  /// Same as [id]. This is added to enable filtering on queries.
  @db.StringProperty()
  String? packageName;

  /// Returns a new [Like] object with a new parent.
  /// Should be used only for merging users.
  Like changeParentUser(db.Key newParentKey) {
    return Like()
      ..parentKey = newParentKey
      ..id = package
      ..created = created
      ..packageName = packageName;
  }
}

/// The cacheable version of [Like].
@JsonSerializable()
class LikeData {
  final String? userId;
  final String? package;
  final DateTime? created;

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

/// Tracks the client session, optionally with authenticated
/// userId and cached profile information.
@db.Kind(name: 'UserSession', idType: db.IdType.String)
class UserSession extends db.ExpandoModel<String> {
  /// Same as [id].
  /// This is a v4 (random) UUID String.
  String get sessionId => id as String;

  @db.StringProperty()
  String? userId;

  @db.StringProperty(indexed: false)
  String? email;

  /// The name of the user given by the authentication provider.
  /// May be null, or could contain any arbitrary text.
  @db.StringProperty(indexed: false)
  String? name;

  @db.StringProperty(indexed: false)
  String? imageUrl;

  @db.DateTimeProperty(required: true, indexed: false)
  DateTime? created;

  @db.DateTimeProperty(required: true)
  DateTime? expires;

  @db.DateTimeProperty(indexed: false)
  DateTime? authenticatedAt;

  @db.StringProperty(indexed: false)
  String? csrfToken;

  /// The random value used for OpenID authentication.
  @db.StringProperty(indexed: false)
  String? openidNonce;

  /// The access token from the OpenID authentication.
  ///
  /// Note: we shall only try to use this token when [authenticatedAt]
  /// happened in the last hour.
  ///
  /// Note: we do not cache the token in redis.
  @db.StringProperty(indexed: false)
  String? accessToken;

  /// The granted scopes from the OpenID authentication.
  @db.StringProperty(indexed: false)
  String? grantedScopes;

  UserSession();
  UserSession.init() {
    id = createUuid();
    csrfToken = createUuid();
    openidNonce = createUuid();
  }

  bool isExpired() => clock.now().isAfter(expires!);
  Duration get maxAge => expires!.difference(clock.now());
}

/// Pattern for detecting profile image parameters as specified in [1].
///
/// [1]: https://developers.google.com/people/image-sizing
final _imgParamPattern = RegExp(
  r'=(?:(?:[swh]\d+)|[cp])(?:-(?:(?:[swh]\d+)|[cp]))*$',
);

/// The cacheable version of [UserSession].
@JsonSerializable()
class SessionData {
  /// This is a v4 (random) UUID String that is set as a http cookie.
  final String sessionId;

  /// The v4 (random) UUID String of the [User] that has this session.
  final String? userId;

  /// The email address of the [User].
  final String? email;

  /// The name of the [User] (may be null, or any arbitrary text).
  final String? name;

  /// The image URL of the user's profile picture (may be null).
  final String? imageUrl;

  /// The time when the session was created.
  final DateTime created;

  /// The time when the session will expire.
  final DateTime expires;

  /// The time when the session was last authenticated.
  final DateTime? authenticatedAt;

  /// The CSRF token to store in the HTML page that is expected to be
  /// present in authenticated requests.
  final String? csrfToken;

  /// The list of granted scopes from the OpenID authentication.
  final List<String>? grantedScopes;

  SessionData({
    required this.sessionId,
    this.userId,
    this.email,
    this.name,
    this.imageUrl,
    required this.created,
    required this.expires,
    this.authenticatedAt,
    this.csrfToken,
    this.grantedScopes,
  });

  factory SessionData.fromModel(UserSession session) {
    return SessionData(
      sessionId: session.sessionId,
      userId: session.userId,
      email: session.email,
      name: session.name,
      imageUrl: session.imageUrl,
      created: session.created!,
      expires: session.expires!,
      authenticatedAt: session.authenticatedAt,
      csrfToken: session.csrfToken,
      grantedScopes: (session.grantedScopes ?? '').split(' ').toSet().toList(),
    );
  }

  factory SessionData.fromJson(Map<String, dynamic> json) =>
      _$SessionDataFromJson(json);

  Map<String, dynamic> toJson() => _$SessionDataToJson(this);

  Duration get maxAge => expires.difference(clock.now());
  bool get isAuthenticated => userId != null && userId!.isNotEmpty;
  bool get isExpired => clock.now().isAfter(expires);
  bool get hasName => name != null && name!.isNotEmpty;

  /// Set image size to NxN pixels for faster loading, see:
  /// https://developers.google.com/people/image-sizing
  String imageUrlOfSize(int layoutSize) {
    if (imageUrl == null) {
      return staticUrls.defaultProfilePng;
    }
    // Double the layout size, for better quality on higher dpi displays.
    final imageSize = layoutSize * 2;

    // Strip existing options from the imageUrl if there is any
    var u = imageUrl!;
    if (u.contains('=') && _imgParamPattern.hasMatch(u)) {
      u = u.substring(0, u.lastIndexOf('='));
    }
    return '$u=s$imageSize';
  }
}

/// Derived data for [User] for fast lookup.
@db.Kind(name: 'UserInfo', idType: db.IdType.String)
class UserInfo extends db.ExpandoModel<String> {
  String get userId => id!;

  @db.StringListProperty()
  List<String> packages = <String>[];

  @db.StringListProperty()
  List<String> publishers = <String>[];

  @db.DateTimeProperty()
  DateTime? updated;
}

/// An active consent request sent to a recipient.
/// Users are identified by their e-mail address, and not by their userId.
@db.Kind(name: 'Consent', idType: db.IdType.String)
class Consent extends db.Model {
  /// The consent id.
  String get consentId => id as String;

  /// The email that this consent is for.
  @db.StringProperty(required: true)
  String? email;

  /// A [Uri.path]-like concatenation of identifiers from [kind] and [args].
  /// It should be used to query the Datastore for duplicate detection.
  @db.StringProperty()
  String? dedupId;

  @db.StringProperty()
  String? kind;

  @db.StringListProperty()
  List<String>? args;

  @db.StringProperty()
  String? fromUserId;

  @db.DateTimeProperty()
  DateTime? created;

  @db.DateTimeProperty()
  DateTime? expires;

  @db.DateTimeProperty()
  DateTime? lastNotified;

  @db.IntProperty()
  int notificationCount = 0;

  @db.BoolProperty()
  bool? createdBySiteAdmin = false;

  Consent();

  Consent.init({
    required this.fromUserId,
    required this.email,
    required this.kind,
    required this.args,
    this.createdBySiteAdmin = false,
    Duration timeout = const Duration(days: 7),
  }) {
    id = Ulid().toString();
    dedupId = consentDedupId(
      fromUserId: fromUserId,
      email: email,
      kind: kind,
      args: args!,
    );
    created = clock.now().toUtc();
    expires = created!.add(timeout);
  }

  bool isExpired() => clock.now().toUtc().isAfter(expires!);

  /// The timestamp when the next notification could be sent out.
  DateTime get nextNotification =>
      (lastNotified ?? created)!.add(Duration(minutes: 1 << notificationCount));

  /// Whether a new notification should be sent.
  bool shouldNotify() =>
      notificationCount == 0 || clock.now().toUtc().isAfter(nextNotification);
}

/// Calculates the dedupId of a consent request.
String consentDedupId({
  required String? fromUserId,
  required String? email,
  required String? kind,
  required List<String> args,
}) =>
    [fromUserId, email, kind, ...args]
        .where((s) => s != null)
        .whereType<String>()
        .map(Uri.encodeComponent)
        .join('/');
