// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:googleapis/oauth2/v2.dart' as oauth2_v2;
import 'package:googleapis/searchconsole/v1.dart' as wmx;

import '../service/openid/jwt.dart';
import '../shared/exceptions.dart';

/// The scope name for webmaster access.
final webmasterScope = wmx.SearchConsoleApi.webmastersReadonlyScope;

/// The list of scopes that are allowed in the public API request.
final _allowedScopes = <String>{
  webmasterScope,
};

class AuthResult {
  final String oauthUserId;
  final String email;
  final String audience;
  final String? name;
  final String? imageUrl;
  final String? accessToken;

  AuthResult({
    required this.oauthUserId,
    required this.email,
    required this.audience,
    this.name,
    this.imageUrl,
    this.accessToken,
  });

  AuthResult withToken({
    required String accessToken,
  }) {
    return AuthResult(
      oauthUserId: oauthUserId,
      email: email,
      audience: audience,
      name: name,
      imageUrl: imageUrl,
      accessToken: accessToken,
    );
  }
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

  /// Returns the URL that the user should visit for authentication.
  Future<Uri> getOauthAuthenticationUrl({
    required Map<String, String> state,
    required String nonce,
    required bool promptSelect,
    required List<String>? includeScopes,
    required String? loginHint,
  });

  /// Verifies authentication using [code] and returns the OAuth2 profile information.
  ///
  /// This is the final step of the sign-in flow started by redirecting the user
  /// to [getOauthAuthenticationUrl].
  Future<AuthResult?> tryAuthenticateOauthCode({
    required String code,
    required String expectedNonce,
  });

  /// Calls the Google tokeninfo POST endpoint with [accessToken].
  Future<oauth2_v2.Tokeninfo> callTokenInfoWithAccessToken(
      {required String accessToken});

  /// Close resources.
  Future<void> close();
}

/// Verifies the [includeScopes] and throws if any of them is not allowed.
void verifyIncludeScopes(List<String>? includeScopes) {
  if (includeScopes == null || includeScopes.isEmpty) {
    return;
  }
  for (final scope in includeScopes) {
    InvalidInputException.check(
        _allowedScopes.contains(scope), 'Invalid scope: "$scope".');
  }
}
