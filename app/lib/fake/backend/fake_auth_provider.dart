// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:crypto/crypto.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis/oauth2/v2.dart' as oauth2_v2;
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/frontend/request_context.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_dev/tool/utils/pub_api_client.dart';
import '../../account/auth_provider.dart';
import '../../account/default_auth_provider.dart';
import '../../account/session_cookie.dart';
import '../../frontend/handlers/pubapi.client.dart';
import '../../service/openid/gcp_openid.dart';
import '../../service/openid/github_openid.dart';
import '../../service/openid/jwt.dart';
import '../../service/openid/openid_models.dart';
import '../../shared/configuration.dart';

/// A fake auth provider where user resolution is done via the provided access
/// token.
///
/// Access tokens are in the format of user-name-at-example-dot-com and resolve
/// to user-name@example.com as email and user-name-example-com as userId.
///
/// Access tokens without '-at-' are not resolving to any user.
class FakeAuthProvider extends BaseAuthProvider {
  @override
  Future<void> close() async {}

  @override
  Future<oauth2_v2.Userinfo> callGetUserinfo({
    required String accessToken,
  }) {
    // Since we don't use getAccountProfile from the base class, this method
    // won't get called.
    throw AssertionError();
  }

  @override
  Future<oauth2_v2.Tokeninfo> callTokenInfoWithAccessToken({
    required String accessToken,
  }) async {
    final token = JsonWebToken.tryParse(accessToken);
    if (token == null) {
      throw oauth2_v2.ApiRequestError(
          'Unable to parse access token: $accessToken');
    }
    final goodSignature = await verifyTokenSignature(
        token: token, openIdDataFetch: () async => throw AssertionError());
    if (!goodSignature) {
      throw oauth2_v2.ApiRequestError(null);
    }
    return oauth2_v2.Tokeninfo(
      audience: token.payload.aud.single,
      email: token.payload['email'] as String?,
      scope: token.payload['scope'] as String?,
      userId: token.payload['sub'] as String?,
    );
  }

  @override
  Future<http.Response> callTokenInfoWithIdToken({
    required String idToken,
  }) async {
    final token = JsonWebToken.tryParse(idToken);
    if (token == null) {
      return http.Response(json.encode({}), 400);
    }
    final goodSignature = await verifyTokenSignature(
        token: token, openIdDataFetch: () async => throw AssertionError());
    if (!goodSignature) {
      return http.Response(json.encode({}), 400);
    }
    return http.Response(
        json.encode({
          ...token.header,
          ...token.payload,
          'email_verified': true,
        }),
        200);
  }

  @override
  Future<bool> verifyTokenSignature({
    required JsonWebToken token,
    required Future<OpenIdData> Function() openIdDataFetch,
  }) async {
    return base64.encode(token.signature) ==
        base64.encode(utf8.encode('valid'));
  }

  @override
  Future<AuthResult?> tryAuthenticateAsUser(String input) async {
    late String jwtTokenValue;
    var accessToken = input;
    // TODO: migrate all test to use base64-encoded token
    try {
      accessToken = utf8.decode(base64Url.decode(input));
    } catch (_) {
      // ignored
    }

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
    return super.tryAuthenticateAsUser(jwtTokenValue);
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

  @override
  Future<Uri> getOauthAuthenticationUrl({
    required Map<String, String> state,
    required String nonce,
    required bool promptSelect,
    required List<String>? includeScopes,
    required String? loginHint,
  }) async {
    verifyIncludeScopes(includeScopes);
    final email = state['fake-email'] ?? loginHint;
    if (email == null || email.isEmpty) {
      return Uri.parse(getOauthRedirectUri());
    }
    final token = _createGcpToken(
      email: email,
      audience: activeConfiguration.pubServerAudience!,
      signature: null,
      extraPayload: {
        'nonce': nonce,
      },
      scope: includeScopes?.join(' '),
    );
    return Uri.parse(getOauthRedirectUri()).replace(
      queryParameters: {
        'state': encodeState(state),
        'code': token,
      },
    );
  }

  @override
  Future<AuthResult?> tryAuthenticateOauthCode({
    required String code,
    required String expectedNonce,
  }) async {
    final token = JsonWebToken.tryParse(code);
    if (token == null) {
      return null;
    }
    if (token.payload['nonce'] != expectedNonce) {
      return null;
    }
    final email = token.payload['email'] as String;
    // using the user part as name
    final name =
        email.split('@').first.replaceAll('-', ' ').replaceAll('.', ' ');

    // gravatar image with retro face
    final emailMd5 = md5.convert(utf8.encode(email.trim())).toString();
    final imageUrl = 'https://www.gravatar.com/avatar/$emailMd5?d=retro&s=200';

    return AuthResult(
      oauthUserId: token.payload['sub'] as String,
      email: email,
      audience: token.payload['aud'] as String,
      name: name,
      imageUrl: imageUrl,
      accessToken: _createGcpToken(
        email: email,
        audience: activeConfiguration.pubServerAudience!,
        scope: token.payload['scope'] as String?,
        signature: null,
      ),
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
  Map<String, Object>? extraPayload,
  String? scope,
}) {
  final token = JsonWebToken(
    header: {
      'alg': 'RS256',
      'typ': 'JWT',
    },
    payload: {
      'email': email,
      'sub': fakeOauthUserIdFromEmail(email),
      'aud': audience,
      'iss': GcpServiceAccountJwtPayload.issuerUrl,
      ...?extraPayload,
      ..._jwtPayloadTimestamps(),
      if (scope != null) 'scope': scope,
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
  String? repositoryId,
  String? repositoryOwnerId,
}) {
  var refType = ref.split('/')[1];
  if (refType.endsWith('s')) {
    refType = refType.substring(0, refType.length - 1);
  }
  final token = JsonWebToken(
    header: {
      'alg': 'RS256',
      'typ': 'JWT',
    },
    payload: {
      'aud': audience ?? 'https://pub.dev',
      'repository': repository,
      'repository_id': repositoryId ?? repository.hashCode.abs().toString(),
      'repository_owner': repository.split('/').first,
      'repository_owner_id': repositoryOwnerId ??
          repository.split('/').first.hashCode.abs().toString(),
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

String fakeOauthUserIdFromEmail(String email) =>
    email.replaceAll('@', '-').replaceAll('.', '-');

Map<String, dynamic> _jwtPayloadTimestamps() {
  final now = clock.now().toUtc();
  final iat = now.subtract(Duration(minutes: 1));
  return <String, dynamic>{
    'iat': iat.millisecondsSinceEpoch ~/ 1000,
    'nbf': iat.millisecondsSinceEpoch ~/ 1000,
    'exp': now.add(Duration(minutes: 5)).millisecondsSinceEpoch ~/ 1000,
  };
}

/// Creates a new session and returns the sessionId from the cookies.
Future<String> _acquireFakeSessionId({
  required String email,
  String? pubHostedUrl,
  List<String>? scopes,
}) async {
  final baseUri =
      Uri.parse(pubHostedUrl ?? activeConfiguration.primarySiteUri.toString());
  final client = http.Client();
  try {
    final rs = await client.send(http.Request(
      'GET',
      Uri(
        scheme: baseUri.scheme,
        host: baseUri.host,
        port: baseUri.port,
        path: '/sign-in',
        queryParameters: {
          'fake-email': email,
          'go': '/',
          if (scopes != null) 'scope': scopes.join(' '),
        },
      ),
    )..followRedirects = false);
    if (rs.statusCode != 303) {
      throw Exception('Unexpected status code: ${rs.statusCode}');
    }
    final cookieHeaders =
        rs.headers['set-cookie']?.split(',').map((e) => e.trim()) ?? <String>[];
    final cookies = cookieHeaders.map((h) => h.split(';').first).toList();
    final sessionId = cookies
        .firstWhere((e) => e.startsWith('$clientSessionLaxCookieName='))
        .split('=')
        .last
        .trim();
    // complete sign-in
    final completeRequest = http.Request(
      'GET',
      Uri.parse(rs.headers['location']!),
    );
    completeRequest.headers['cookie'] = cookies.join('; ');
    final rs2 = await client.send(completeRequest);
    if (rs2.statusCode != 200) {
      throw AuthenticationException.failed();
    }
    return sessionId;
  } finally {
    client.close();
  }
}

/// Issues a page request and extracts the CSRF token value.
Future<String> _acquireCsrfToken({
  required String sessionId,
  String? pubHostedUrl,
}) async {
  final baseUri =
      Uri.parse(pubHostedUrl ?? activeConfiguration.primarySiteUri.toString());
  final client = http.Client();
  try {
    final rs = await client.send(http.Request(
      'GET',
      Uri(
        scheme: baseUri.scheme,
        host: baseUri.host,
        port: baseUri.port,
        path: '/my-liked-packages',
      ),
    )..headers['cookie'] =
        '$clientSessionLaxCookieName=$sessionId; $clientSessionStrictCookieName=$sessionId');
    if (rs.statusCode != 200) {
      throw Exception('Unexpected status code: ${rs.statusCode}.');
    }
    final body = await rs.stream.bytesToString();
    return body.split('name="csrf-token" content="').last.split('"').first;
  } finally {
    client.close();
  }
}

/// Creates a pub.dev API client and executes [fn], making sure that the HTTP
/// resources are freed after the callback finishes.
///
/// The [email] is used to create an HTTP session and the related CSRF token is
/// extracted from the session, both are sent alongside the requests.
Future<R> withFakeAuthHttpPubApiClient<R>({
  required String email,
  List<String>? scopes,
  required Future<R> Function(PubApiClient client) fn,
  String? pubHostedUrl,
}) async {
  final sessionId = await _acquireFakeSessionId(
    email: email,
    pubHostedUrl: pubHostedUrl,
    scopes: scopes,
  );
  final csrfToken = await _acquireCsrfToken(
    sessionId: sessionId,
    pubHostedUrl: pubHostedUrl,
  );

  return await withHttpPubApiClient(
    sessionId: sessionId,
    csrfToken: csrfToken,
    pubHostedUrl: pubHostedUrl,
    fn: fn,
  );
}

/// Creates an API client with fake [email] that uses the configured HTTP endpoints.
///
/// Services scopes are used to automatically close the client once we exit the current scope.
@visibleForTesting
Future<PubApiClient> createFakeAuthPubApiClient({
  required String email,
  String? pubHostedUrl,
  List<String>? scopes,
}) async {
  final sessionId = await _acquireFakeSessionId(
    email: email,
    pubHostedUrl: pubHostedUrl,
    scopes: scopes,
  );
  final csrfToken = await _acquireCsrfToken(
    sessionId: sessionId,
    pubHostedUrl: pubHostedUrl,
  );
  return createPubApiClient(
    sessionId: sessionId,
    csrfToken: csrfToken,
  );
}

/// Creates a request context scope with the provided [email] using the fake
/// authentication provider, then runs [fn] with it.
Future<R> withFakeAuthRequestContext<R>(
  String email,
  Future<R> Function() fn, {
  List<String>? scopes,
}) async {
  final sessionId = await _acquireFakeSessionId(email: email);
  final csrfToken = await _acquireCsrfToken(sessionId: sessionId);
  final sessionData = await accountBackend.getSessionData(sessionId);
  final experimentalFlags = requestContext.experimentalFlags;
  return await ss.fork(() async {
    registerRequestContext(RequestContext(
      clientSessionCookieStatus: ClientSessionCookieStatus(
        sessionId: sessionId,
        isStrict: true,
      ),
      sessionData: sessionData,
      csrfToken: csrfToken,
      experimentalFlags: experimentalFlags,
    ));
    return await fn();
  }) as R;
}
