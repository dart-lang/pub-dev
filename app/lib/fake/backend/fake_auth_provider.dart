// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:crypto/crypto.dart';

import '../../account/agent.dart';
import '../../account/auth_provider.dart';
import '../../service/openid/gcp_openid.dart';
import '../../service/openid/jwt.dart';
import '../../shared/configuration.dart';

/// A fake auth provider where user resolution is done via the provided access
/// token.
///
/// Access tokens are in the format of user-name-at-example-dot-com and resolve
/// to user-name@example.com as email and user-name-example-com as userId.
///
/// Access tokens without '-at-' are not resolving to any user.
class FakeAuthProvider implements AuthProvider {
  @override
  Future<void> close() async {}

  @override
  Future<AuthResult?> tryAuthenticate(String accessToken) async {
    if (!accessToken.contains('-at-')) {
      return null;
    }
    final uri = Uri.tryParse(accessToken);
    if (uri == null) {
      return null;
    }

    final email = uri.path.replaceAll('-at-', '@').replaceAll('-dot-', '.');
    final oauthUserId = _oauthUserIdFromEmail(email);
    return AuthResult(
      oauthUserId: oauthUserId,
      email: email,
      audience: uri.queryParameters['aud'] ?? '',
    );
  }

  @override
  Future<AccountProfile?> getAccountProfile(String? accessToken) async {
    if (accessToken == null || !accessToken.contains('-at-')) return null;
    final email = accessToken.replaceAll('-dot-', '.').replaceAll('-at-', '@');

    // using the user part as name
    final name =
        email.split('@').first.replaceAll('-', ' ').replaceAll('.', ' ');

    // gravatar image with retro face
    final emailMd5 = md5.convert(utf8.encode(email.trim())).toString();
    final imageUrl = 'https://www.gravatar.com/avatar/$emailMd5?d=retro&s=200';

    return AccountProfile(
      name: name,
      imageUrl: imageUrl,
    );
  }
}

String createFakeAuthTokenForEmail(
  String email, {
  String? audience,
}) {
  return Uri(
      path: email.replaceAll('.', '-dot-').replaceAll('@', '-at-'),
      queryParameters: {'aud': audience ?? 'fake-site-audience'}).toString();
}

String createFakeServiceAccountToken(
    {required String email, String? audience}) {
  return Uri(path: 'gcp-service-account', queryParameters: {
    'email': email,
    'aud': audience ?? 'https://pub.dev',
  }).toString();
}

String _oauthUserIdFromEmail(String email) =>
    email.replaceAll('@', '-').replaceAll('.', '-');

Future<AuthenticatedAgent?> fakeServiceAgentAuthenticator(String token) async {
  final uri = Uri.tryParse(token);
  if (uri == null) {
    return null;
  }
  if (uri.path == 'gcp-service-account') {
    final audience = uri.queryParameters['aud'];
    if (audience != activeConfiguration.externalServiceAudience) {
      return null;
    }

    final email = uri.queryParameters['email']!;
    // ignore: invalid_use_of_visible_for_testing_member
    final now = clock.now();
    final idToken = JsonWebToken(
      header: {},
      payload: {
        'email': email,
        'sub': _oauthUserIdFromEmail(email),
        'aud': audience,
        'iat': now.millisecondsSinceEpoch ~/ 1000,
        'exp': now.add(Duration(minutes: 1)).millisecondsSinceEpoch ~/ 1000,
        'iss': GcpServiceAccountJwtPayload.issuerUrl,
      },
      signature: [],
    );
    return AuthenticatedGcpServiceAccount(
      idToken: idToken,
      payload: GcpServiceAccountJwtPayload(idToken.payload),
    );
  }

  return null;
}
