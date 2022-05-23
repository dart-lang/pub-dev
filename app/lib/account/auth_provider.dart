// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

enum AuthSource {
  /// `pub` command-line client
  client,

  /// `pub.dev` user on the web UI
  website,

  /// administrator account
  admin,
}

class AuthResult {
  final String oauthUserId;
  final String email;

  AuthResult(this.oauthUserId, this.email);
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
  /// Checks the [token] and returns a verified user information.
  ///
  /// Returns null on any error, or if the token is expired, or the user is not
  /// verified.
  Future<AuthResult?> tryAuthenticate(AuthSource source, String token);

  /// Returns the profile information of a given access token.
  Future<AccountProfile?> getAccountProfile(String? accessToken);

  /// Close resources.
  Future<void> close();
}
