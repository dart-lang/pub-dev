// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'schema.dart';

/// Tracks the client session, optionally with authenticated
/// userId and cached profile information.
///
/// TODO: rename to `UserSession` after the Datastore migration is completed.
@PrimaryKey(['sessionId'])
abstract final class UserSessionRow extends Row {
  /// The session ID, a random UUID String.
  String get sessionId;

  /// The id of the `User` that has this session.
  @Index.field()
  String? get userId;

  /// The email of the `User` that has this session.
  String? get email;

  /// The name of the `User` - given by the authentication provider.
  String? get name;

  /// The profile image URL of the `User` - given by the authentication provider.
  String? get imageUrl;

  /// The time when the session was created.
  DateTime get created;

  /// The time when the session will expire.
  @Index.field()
  DateTime get expires;

  /// The time when the session was last authenticated.
  DateTime? get authenticatedAt;

  /// The CSRF token that the session uses.
  String? get csrfToken;

  /// The random value used for OpenID authentication.
  String? get openidNonce;

  /// The access token from the OpenID authentication.
  String? get accessToken;

  /// The granted scopes from the OpenID authentication.
  String? get grantedScopes;
}
