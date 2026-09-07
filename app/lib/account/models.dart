// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pub_dev/admin/actions/actions.dart';
import 'package:ulid/ulid.dart';

import '../database/schema.dart';
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

  /// `true` if user was moderated (pending moderation or deletion).
  @db.BoolProperty(required: true)
  bool isModerated = false;

  /// The timestamp when the user was moderated.
  @db.DateTimeProperty()
  DateTime? moderatedAt;

  /// One of the [UserModeratedReason] values.
  @db.StringProperty()
  String? moderatedReason;

  User();
  User.init() {
    isDeleted = false;
    isModerated = false;
  }

  late final isVisible = !isModerated && !isDeleted;
  bool get isNotVisible => !isVisible;

  void updateIsModerated({
    required bool isModerated,
    required String? moderatedReason,
  }) {
    if (isModerated) {
      InvalidInputException.checkNotNull(moderatedReason, 'reason');
      InvalidInputException.checkAnyOf(
        moderatedReason,
        'reason',
        UserModeratedReason.values,
      );
    } else {
      InvalidInputException.checkNull(moderatedReason, 'reason');
    }

    this.isModerated = isModerated;
    moderatedAt = isModerated ? clock.now().toUtc() : null;
    this.moderatedReason = moderatedReason;
  }
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

/// Convenience helpers for the SQL-backed session row.
extension UserSessionRowExt on UserSessionRow {
  bool isExpired() => clock.now().isAfter(expires);
  Duration get maxAge => expires.difference(clock.now());
}

/// Pattern for detecting profile image parameters as specified in [1].
///
/// [1]: https://developers.google.com/people/image-sizing
final _imgParamPattern = RegExp(
  r'=(?:(?:[swh]\d+)|[cp])(?:-(?:(?:[swh]\d+)|[cp]))*$',
);

/// The cacheable version of [UserSessionRow].
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

  factory SessionData.fromRow(UserSessionRow row) {
    return SessionData(
      sessionId: row.sessionId,
      userId: row.userId,
      email: row.email,
      name: row.name,
      imageUrl: row.imageUrl,
      created: row.created,
      expires: row.expires,
      authenticatedAt: row.authenticatedAt,
      csrfToken: row.csrfToken,
      grantedScopes: (row.grantedScopes ?? '').split(' ').toSet().toList(),
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
    if (imageUrl == null || imageUrl == staticUrls.defaultProfilePng) {
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

  /// May be an `User.userId` or `support@pub.dev`.
  @db.StringProperty()
  String? fromAgent;

  @db.DateTimeProperty()
  DateTime? created;

  @db.DateTimeProperty()
  DateTime? expires;

  @db.DateTimeProperty()
  DateTime? lastNotified;

  @db.IntProperty()
  int notificationCount = 0;

  Consent();

  Consent.init({
    required this.fromAgent,
    required this.email,
    required this.kind,
    required this.args,
    Duration timeout = const Duration(days: 7),
  }) {
    id = Ulid().toString();
    dedupId = consentDedupId(
      fromAgentId: fromAgent!,
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
  required String fromAgentId,
  required String? email,
  required String? kind,
  required List<String> args,
}) => [
  fromAgentId,
  email,
  kind,
  ...args,
].nonNulls.map(Uri.encodeComponent).join('/');

abstract class UserModeratedReason {
  static const bot = 'bot';
  static const illegalContent = 'illegal-content';
  static const policyViolation = 'policy-violation';
  static const spam = 'spam';
  static const unfoundedNotifications = 'unfounded-notifications';
  static const unfoundedAppeals = 'unfounded-appeals';

  static const values = {
    bot,
    illegalContent,
    policyViolation,
    spam,
    unfoundedNotifications,
    unfoundedAppeals,
  };
}
