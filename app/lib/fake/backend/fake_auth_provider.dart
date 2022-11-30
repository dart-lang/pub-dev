// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:crypto/crypto.dart';
import 'package:meta/meta.dart';
import 'package:pub_dev/service/openid/gcp_openid.dart';

import '../../account/auth_provider.dart';
import '../../service/openid/github_openid.dart';
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
  Future<JsonWebToken?> tryAuthenticateAsServiceToken(String token) async {
    final parsed = JsonWebToken.tryParse(token);
    if (parsed == null) {
      return null;
    }
    final audiences = parsed.payload.aud;
    if (audiences.length != 1 ||
        audiences.single != activeConfiguration.externalServiceAudience) {
      return null;
    }
    // reject if signature is not 'valid'.
    if (base64.encode(parsed.signature) !=
        base64.encode(utf8.encode('valid'))) {
      return null;
    }
    return parsed;
  }

  @override
  Future<AuthResult?> tryAuthenticateAsUser(String accessToken) async {
    late String jwtTokenValue;
    if (accessToken.contains('-at-') &&
        !JsonWebToken.looksLikeJWT(accessToken)) {
      final uri = Uri.tryParse(accessToken);
      if (uri == null) {
        return null;
      }
      final email = uri.path.replaceAll('-at-', '@').replaceAll('-dot-', '.');
      final audience = uri.queryParameters['aud'] ?? 'fake-site-audience';
      jwtTokenValue = _createGcpToken(
        email: email,
        audience: audience,
        signature: null,
      );
    } else {
      jwtTokenValue = accessToken;
    }

    final parsed = JsonWebToken.tryParse(jwtTokenValue);
    if (parsed == null) {
      return null;
    }
    // check audience
    final audiences = parsed.payload.aud;
    final allowedAudiences = <String>[
      activeConfiguration.pubClientAudience!,
      activeConfiguration.pubSiteAudience!,
    ];
    if (audiences.length != 1 || !allowedAudiences.contains(audiences.single)) {
      return null;
    }
    // reject if signature is not 'valid'.
    if (base64.encode(parsed.signature) !=
        base64.encode(utf8.encode('valid'))) {
      return null;
    }

    final email = parsed.payload['email'] as String;
    final oauthUserId = _oauthUserIdFromEmail(email);
    return AuthResult(
      oauthUserId: oauthUserId,
      email: email,
      audience: audiences.single,
    );
  }

  @override
  Future<AccountProfile?> getAccountProfile(String? accessToken) async {
    if (accessToken == null) {
      return null;
    }
    final authResult = await tryAuthenticateAsUser(accessToken);
    if (authResult == null) {
      return null;
    }
    final email = authResult.email;

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

@visibleForTesting
String createFakeAuthTokenForEmail(
  String email, {
  String? audience,
}) {
  return Uri(
      path: email.replaceAll('.', '-dot-').replaceAll('@', '-at-'),
      queryParameters: {'aud': audience ?? 'fake-site-audience'}).toString();
}

@visibleForTesting
String createFakeServiceAccountToken({
  required String email,
  // `https://pub.dev` unless specified otherwise
  String? audience,
  // utf8-encoded `valid` unless specified otherwise
  List<int>? signature,
}) {
  return _createGcpToken(
    email: email,
    audience: audience ?? 'https://pub.dev',
    signature: signature,
  );
}

String _createGcpToken({
  required String email,
  required String audience,
  required List<int>? signature,
}) {
  final token = JsonWebToken(
    header: {},
    payload: {
      'email': email,
      'sub': _oauthUserIdFromEmail(email),
      'aud': audience,
      'iss': GcpServiceAccountJwtPayload.issuerUrl,
      ..._jwtPayloadTimestamps(),
    },
    signature: signature ?? utf8.encode('valid'),
  );
  return token.asEncodedString();
}

@visibleForTesting
String createFakeGithubActionToken({
  required String repository,
  required String ref,
  // `https://pub.dev` unless specified otherwise
  String? audience,

  // 'push' unless specified otherwise
  String? eventName,
  String? sha,
  String? actor,
  String? environment,
  // utf8-encoded `valid` unless specified otherwise
  List<int>? signature,
  String? runId,
}) {
  var refType = ref.split('/')[1];
  if (refType.endsWith('s')) {
    refType = refType.substring(0, refType.length - 1);
  }
  final token = JsonWebToken(
    header: {},
    payload: {
      'aud': audience ?? 'https://pub.dev',
      'repository': repository,
      'repository_owner': repository.split('/').first,
      'event_name': eventName ?? 'push',
      'ref': ref,
      'ref_type': refType,
      'iss': GitHubJwtPayload.issuerUrl,
      'run_id': runId ?? clock.now().millisecondsSinceEpoch.toString(),
      if (sha != null) 'sha': sha,
      if (actor != null) 'actor': actor,
      if (environment != null) 'environment': environment,
      ..._jwtPayloadTimestamps(),
    },
    signature: signature ?? utf8.encode('valid'),
  );
  return token.asEncodedString();
}

String _oauthUserIdFromEmail(String email) =>
    email.replaceAll('@', '-').replaceAll('.', '-');

Map<String, dynamic> _jwtPayloadTimestamps() {
  final now = clock.now();
  return <String, dynamic>{
    'iat': now.millisecondsSinceEpoch ~/ 1000,
    'nbf': now.millisecondsSinceEpoch ~/ 1000,
    'exp': now.add(Duration(minutes: 1)).millisecondsSinceEpoch ~/ 1000,
  };
}
