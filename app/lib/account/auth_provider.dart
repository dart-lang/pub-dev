// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../service/openid/jwt.dart';

class AuthResult {
  final String oauthUserId;
  final String email;
  final String audience;

  AuthResult({
    required this.oauthUserId,
    required this.email,
    required this.audience,
  });
}

class AccountProfile {
  final String? name;
  final String? imageUrl;

  AccountProfile({
    required this.name,
    required this.imageUrl,
  });
}

/// Authenticates bearer tokens from the `'authentication: bearer'` header.
abstract class AuthProvider {
  /// Parses and verifies [token] - if issued by an external service
  /// targeting `pub.dev`.
  Future<JsonWebToken?> tryAuthenticateAsServiceToken(String token);

  /// Checks the [token] and returns a verified user information.
  ///
  /// Returns null on any error, or if the token is expired, or the user is not
  /// verified.
  Future<AuthResult?> tryAuthenticateAsUser(String token);

  /// Returns the profile information of a given access token.
  Future<AccountProfile?> getAccountProfile(String? accessToken);

  /// Close resources.
  Future<void> close();
}
