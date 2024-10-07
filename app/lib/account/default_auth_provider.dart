// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/utils/http.dart';
import 'package:basics/basics.dart';
import 'package:clock/clock.dart';
import 'package:googleapis/oauth2/v2.dart' as oauth2_v2;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import '../service/openid/gcp_openid.dart';
import '../service/openid/github_openid.dart';
import '../service/openid/jwt.dart';
import '../service/openid/openid_models.dart';
import '../service/secret/backend.dart';
import '../shared/configuration.dart';
import '../shared/email.dart' show looksLikeEmail;
import '../shared/exceptions.dart';
import '../shared/monitoring.dart';
import '../shared/utils.dart' show fixedTimeEquals;
import 'auth_provider.dart';

final _logger = Logger('pub.account.google_auth2');

/// The token-info end-point.
final _tokenInfoEndPoint = Uri.parse('https://oauth2.googleapis.com/tokeninfo');

/// Provides OAuth2-based authentication through JWKS and Google account APIs.
class DefaultAuthProvider extends BaseAuthProvider {
  late http.Client _httpClient;
  late oauth2_v2.Oauth2Api _oauthApi;

  DefaultAuthProvider() {
    _httpClient = httpRetryClient(retries: 2);
    _oauthApi = oauth2_v2.Oauth2Api(_httpClient);
  }

  @override
  Future<void> close() async {
    _httpClient.close();
  }

  @override
  Future<oauth2_v2.Tokeninfo> callTokenInfoWithAccessToken({
    required String accessToken,
  }) async {
    return _oauthApi.tokeninfo(accessToken: accessToken);
  }

  @override
  Future<http.Response> callTokenInfoWithIdToken(
      {required String idToken}) async {
    // Hit the token-info end-point documented at:
    // https://developers.google.com/identity/sign-in/web/backend-auth
    // Note: ideally, we would verify these JWTs locally, but unfortunately
    //       we don't have a solid RSA implementation available in Dart.
    final u =
        _tokenInfoEndPoint.replace(queryParameters: {'id_token': idToken});
    return await _httpClient.get(u, headers: {'accept': 'application/json'});
  }

  @override
  Future<oauth2_v2.Userinfo> callGetUserinfo(
      {required String accessToken}) async {
    final authClient = auth.authenticatedClient(
        _httpClient,
        auth.AccessCredentials(
          auth.AccessToken(
            'Bearer',
            accessToken,
            clock.now().toUtc().add(Duration(minutes: 20)), // avoid refresh
          ),
          null,
          [],
        ));

    final oauth2 = oauth2_v2.Oauth2Api(authClient);
    return await oauth2.userinfo.get();
  }

  @override
  Future<bool> verifyTokenSignature({
    required JsonWebToken token,
    required Future<OpenIdData> Function() openIdDataFetch,
  }) async {
    final openIdData = await openIdDataFetch();
    return await token.verifySignature(openIdData.jwks);
  }

  String _getOauthServerAudience() => activeConfiguration.pubServerAudience!;

  Future<String?> _getOauthServerClientSecret() async {
    return await secretBackend.lookup(
      SecretKey.oauthClientSecret,
      maxAge: Duration(hours: 3),
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
    // Using https://developers.google.com/identity/protocols/oauth2/web-server#httprest_1
    return Uri.parse('https://accounts.google.com/o/oauth2/v2/auth').replace(
      queryParameters: {
        'client_id': _getOauthServerAudience(),
        'redirect_uri': getOauthRedirectUri(),
        'response_type': 'code',
        'scope': [
          oauth2_v2.Oauth2Api.openidScope,
          oauth2_v2.Oauth2Api.userinfoEmailScope,
          oauth2_v2.Oauth2Api.userinfoProfileScope,
          ...?includeScopes,
        ].join(' '),
        'state': encodeState(state),
        'nonce': nonce,
        if (promptSelect) 'prompt': 'select_account',
        if (!promptSelect && loginHint != null && loginHint.isNotEmpty)
          'login_hint': loginHint,
      },
    );
  }

  @override
  Future<AuthResult?> tryAuthenticateOauthCode({
    required String code,
    required String expectedNonce,
  }) async {
    try {
      final audience = _getOauthServerAudience();
      final secret = await _getOauthServerClientSecret();
      final tokenUri = Uri.parse('https://oauth2.googleapis.com/token');
      final formData = {
        'code': code,
        'client_id': audience,
        'client_secret': secret,
        'redirect_uri': getOauthRedirectUri(),
        'grant_type': 'authorization_code',
      };
      final rs = await http.post(tokenUri, body: formData);
      if (rs.statusCode != 200) {
        return null;
      }
      final body = json.decode(rs.body);
      final idToken = body['id_token'] as String;
      final accessToken = body['access_token'] as String;
      final auth = await _tryAuthenticateJwt(
        idToken,
        expectedNonce: expectedNonce,
      );
      if (auth == null) {
        return null;
      }
      if (auth.name == null) {
        _logger.pubNoticeWarning('auth-name', '${auth.email} has no name');
      }
      return auth.withToken(accessToken: accessToken);
    } catch (e, st) {
      _logger.severe('Error processing oauth code.', e, st);
      return null;
    }
  }
}

/// Provides base methods and checks for OAuth2-based authentication.
abstract class BaseAuthProvider extends AuthProvider {
  /// Calls the Google tokeninfo GET endpoint with [idToken].
  Future<http.Response> callTokenInfoWithIdToken({required String idToken});

  /// Calls the Google userinfo endpoint with [accessToken].
  Future<oauth2_v2.Userinfo> callGetUserinfo({required String accessToken});

  /// Verifies if [token] has the correct signature, using the potentially cached
  /// [openIdDataFetch] function to get the required [OpenIdData] for the verification.
  Future<bool> verifyTokenSignature({
    required JsonWebToken token,
    required Future<OpenIdData> Function() openIdDataFetch,
  });

  @override
  Future<JsonWebToken?> tryAuthenticateAsServiceToken(String token) async {
    if (!JsonWebToken.looksLikeJWT(token)) {
      return null;
    }
    final idToken = JsonWebToken.tryParse(token);
    if (idToken == null) {
      return null;
    }
    // The audience check here is necessary, to ensure that we don't accidentally
    // handle `id_token` from our user-account OAuth flow the same way as service
    // agent tokens.
    final audiences = idToken.payload.aud;
    if (audiences.length != 1 ||
        audiences.single != activeConfiguration.externalServiceAudience) {
      return null;
    }

    if (idToken.payload.iss == GitHubJwtPayload.issuerUrl) {
      // The token claims to be issued by GitHub. If there is any problem
      // with the token, the authentication should fail without any fallback.
      await _verifyToken(idToken, openIdDataFetch: fetchGitHubOpenIdData);
      return idToken;
    }

    if (idToken.payload.iss == GcpServiceAccountJwtPayload.issuerUrl) {
      // The token claims to be issued by GCP with the target audience of
      // external services. If there is any problem with the token, the
      // authentication should fail without any fallback (e.g. authenticating
      // the token as a User).

      // TODO: use the tokeninfo endpoint instead
      await _verifyToken(idToken, openIdDataFetch: fetchGoogleCloudOpenIdData);
      return idToken;
    }
    return null;
  }

  Future<void> _verifyToken(
    JsonWebToken idToken, {
    required Future<OpenIdData> Function() openIdDataFetch,
  }) async {
    final isValidTimestamp =
        idToken.payload.isTimely(threshold: Duration(minutes: 2));
    if (!isValidTimestamp) {
      throw AuthenticationException.tokenInvalid('invalid timestamps');
    }
    final aud =
        idToken.payload.aud.length == 1 ? idToken.payload.aud.single : null;
    if (aud != activeConfiguration.externalServiceAudience) {
      throw AuthenticationException.tokenInvalid(
          'audience "${idToken.payload.aud}" does not match "${activeConfiguration.externalServiceAudience}"');
    }
    final signatureMatches = await verifyTokenSignature(
      token: idToken,
      openIdDataFetch: openIdDataFetch,
    );
    if (!signatureMatches) {
      throw AuthenticationException.tokenInvalid('invalid signature');
    }
  }

  /// Authenticate [token] as `access_token` or `id_token`.
  @override
  Future<AuthResult?> tryAuthenticateAsUser(String token) async {
    if (token.isEmpty) {
      return null;
    }

    AuthResult? result;
    // Note: it might be overkill to try both authentication flows. But once
    //       we've migrated the pub client to authenticate using id_tokens
    //       the implications of accidentally breaking access_token
    //       authentication will be much smaller and we can switch to a mode
    //       where we only check if it's an accessToken if it looks like an
    //       accessToken.
    //       But to reduce the risk of an outage we shall attempt both flows
    //       for now. Notice that the cost of the second check is small
    //       assuming we rarely receive invalid access_tokens or id_tokens.
    if (_isLikelyAccessToken(token)) {
      // If this is most likely an access_token, we try access_token first,
      // and if not a valid access_token we try it as a JWT:
      result = await _tryAuthenticateAccessToken(token) ??
          await _tryAuthenticateJwt(token);
    } else {
      // If this is not likely to be an access_token, we try JWT first,
      // and if not valid JWT we try it as access_token:
      result = await _tryAuthenticateJwt(token) ??
          await _tryAuthenticateAccessToken(token);
    }

    // check that audience is one the allowed audiences for users
    final audience = result?.audience;
    if (audience == null) {
      return null;
    }
    final allowedAudiences = <String>[
      activeConfiguration.pubClientAudience!,
      activeConfiguration.pubServerAudience!,
    ];
    if (!allowedAudiences.contains(audience)) {
      return null;
    }

    return result;
  }

  /// Authenticate with oauth2 [accessToken].
  Future<AuthResult?> _tryAuthenticateAccessToken(String accessToken) async {
    oauth2_v2.Tokeninfo info;
    try {
      info = await callTokenInfoWithAccessToken(accessToken: accessToken);
      if (info.userId == null) {
        return null;
      }

      final audience = info.audience;
      if (audience == null) {
        _logger.warning('OAuth2 access attempted with invalid audience, '
            'for email: "${info.email}", audience: "${info.audience}"');
        return null;
      }

      if (info.expiresIn == null ||
          info.expiresIn! <= 0 ||
          info.userId == null ||
          info.userId!.isEmpty ||
          info.verifiedEmail != true ||
          info.email == null ||
          info.email!.isEmpty ||
          !looksLikeEmail(info.email)) {
        _logger.warning('OAuth2 token info invalid: ${info.toJson()}');
        return null;
      }

      return AuthResult(
        oauthUserId: info.userId!,
        email: info.email!.toLowerCase(),
        audience: audience,
      );
    } on oauth2_v2.ApiRequestError catch (e) {
      _logger.info('Access denied for OAuth2 access token.', e);
    } catch (e, st) {
      _logger.warning('OAuth2 access token lookup failed.', e, st);
    }
    return null;
  }

  /// Authenticate with openid-connect `id_token`.
  Future<AuthResult?> _tryAuthenticateJwt(
    String jwt, {
    String? expectedNonce,
  }) async {
    final response = await callTokenInfoWithIdToken(idToken: jwt);
    // Expect a 200 response
    if (response.statusCode != 200) {
      return null;
    }
    final r = json.decode(response.body) as Map<String, dynamic>;
    if (r.containsKey('error')) {
      return null; // presumably an invalid token.
    }
    // Sanity check on the algorithm
    if (r['alg'] == 'none') {
      _logger.warning('JWT rejected, alg = "none"');
      return null;
    }
    // Sanity check on the algorithm
    final typ = r['typ'];
    if (typ != 'JWT') {
      _logger.warning('JWT rejected, typ = "$typ');
      return null;
    }
    // Validate the issuer.
    final iss = r['iss'];
    if (iss != 'accounts.google.com' && iss != 'https://accounts.google.com') {
      _logger.warning('JWT rejected, iss = "$iss');
      return null;
    }
    // Validate create time
    final fiveMinFromNow = clock.now().toUtc().add(Duration(minutes: 5));
    final iat = r['iat'];
    if (iat == null || _parseTimestamp(iat).isAfter(fiveMinFromNow)) {
      _logger.warning('JWT rejected, iat = "$iat"');
      return null; // Token is created more than 5 minutes in the future
    }
    // Validate expiration time
    final fiveMinInPast = clock.now().toUtc().subtract(Duration(minutes: 5));
    final exp = r['exp'];
    if (exp == null || _parseTimestamp(exp).isBefore(fiveMinInPast)) {
      _logger.warning('JWT rejected, exp = "$exp"');
      return null; // Token is expired more than 5 minutes in the past
    }
    // Validate audience
    final aud = r['aud'];
    if (aud is! String) {
      _logger.warning('JWT rejected, aud missing');
      return null; // missing audience
    }
    // Validate subject is present
    final sub = r['sub'];
    if (sub is! String) {
      _logger.warning('JWT rejected, sub missing');
      return null; // missing subject (probably missing 'openid' scope)
    }
    // Validate email is present
    final email = r['email'];
    if (email is! String) {
      _logger.warning('JWT rejected, email missing');
      return null; // missing email (probably missing 'email' scope)
    }
    final emailVerified = r['email_verified'];
    if (emailVerified != true && emailVerified != 'true') {
      _logger.warning('JWT rejected, email_verified = "$emailVerified"');
      return null; // missing email (probably missing 'email' scope)
    }
    final nonce = r['nonce'];
    if (nonce != null && nonce is! String) {
      _logger.warning('JWT rejected, bad `nonce`');
      return null;
    }
    if (expectedNonce != null && nonce == null) {
      _logger.warning('JWT rejected, expected `nonce`.');
      return null;
    }
    if (expectedNonce != null &&
        !fixedTimeEquals(nonce as String, expectedNonce)) {
      _logger.warning('JWT rejected, expected different `nonce`.');
      return null;
    }
    final name = r['name'];
    if (name != null && name is! String) {
      _logger.warning('JWT rejected, bad `name`');
      return null;
    }
    final picture = r['picture'];
    if (picture != null && picture is! String) {
      _logger.warning('JWT rejected, bad `picture`');
      return null;
    }
    return AuthResult(
      oauthUserId: sub,
      email: email,
      audience: aud,
      name: name as String?,
      imageUrl: picture as String?,
    );
  }

  @override
  Future<AccountProfile?> getAccountProfile(String? accessToken) async {
    if (accessToken == null) {
      return null;
    }
    final info = await callGetUserinfo(accessToken: accessToken);
    return AccountProfile(
      name: info.name ?? info.givenName,
      imageUrl: info.picture,
    );
  }

  String getOauthRedirectUri() {
    return activeConfiguration.primarySiteUri
        .replace(path: '/sign-in/complete')
        .toString();
  }
}

/// Return `true` if [token] is an `access_token`, and `false` if [token] is a
/// JWT.
///
/// The format of an oauth2 token does not appear to be limited. Indeed a JWT
/// could be used as an oauth2 `access_token`. Thus, the only correct thing to
/// do is to attempt authentication as both kinds of tokens. However, in
/// practice Google oauth2 `access_token`s starts with `'ya29.'` and do not
/// match the regular expression for JWTs. Thus, we can avoid significant
/// overhead by trying the most likely approach first.
bool _isLikelyAccessToken(String token) {
  // access_tokens starts with 'ya29.'
  if (token.startsWith('ya29.')) {
    return true;
  }
  // If it looks like a JWT, then it's probably not an access_token.
  if (JsonWebToken.looksLikeJWT(token)) {
    return false;
  }
  return true; // anything goes
}

/// Parse a timestamp from JWT as returned by token-info end-point.
///
/// Note. the token-info end-point returns strings, though the JWT specification
/// says that JWTs must be integers. We shall support both here for robustness.
/// Presumably the API will not break regardless.
DateTime _parseTimestamp(dynamic timestamp) {
  ArgumentError.checkNotNull(timestamp, 'timestamp');
  if (timestamp is String) {
    return DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
  }
  if (timestamp is int) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }
  throw ArgumentError.value(timestamp, 'timestamp', 'must be int or string');
}

final _stateCodec = json.fuse(utf8).fuse(base64Url);

/// Encode map-based [state] as URL-compatible string.
String encodeState(Map<String, String> state) {
  return _stateCodec.encode(state);
}

/// Decode URL-provided state as Map.
Map<String, String> decodeState(String? state) {
  if (state == null || state.isEmpty) {
    return const <String, String>{};
  }
  try {
    final map = _stateCodec.decode(state);
    if (map is Map<String, dynamic>) {
      return map
          .whereValue((v) => v != null)
          .map((key, value) => MapEntry(key, value.toString()));
    } else {
      return const <String, String>{};
    }
  } on FormatException {
    return const <String, String>{};
  }
}
