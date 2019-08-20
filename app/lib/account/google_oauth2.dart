import 'dart:convert' show json;

import 'package:googleapis/oauth2/v2.dart' as oauth2_v2;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import '../service/secret/backend.dart';
import '../shared/email.dart' show isValidEmail;
import 'auth_provider.dart';

final _logger = Logger('pub.account.google_auth2');

/// Provides OAuth2-based authentication through Google accounts.
class GoogleOauth2AuthProvider extends AuthProvider {
  final String _siteAudience;
  final List<String> _trustedAudiences;
  http.Client _httpClient;
  oauth2_v2.Oauth2Api _oauthApi;
  bool _secretLoaded = false;
  String _secret;

  GoogleOauth2AuthProvider(this._siteAudience, this._trustedAudiences) {
    _httpClient = http.Client();
    _oauthApi = oauth2_v2.Oauth2Api(_httpClient);
  }

  @override
  String authorizationUrl(String redirectUrl, String state) {
    return Uri.parse('https://accounts.google.com/o/oauth2/v2/auth').replace(
      queryParameters: {
        'client_id': _siteAudience,
        'redirect_uri': redirectUrl,
        'scope': 'openid profile email',
        'response_type': 'code',
        'access_type': 'online',
        'state': state,
      },
    ).toString();
  }

  @override
  Future<String> authCodeToAccessToken(String redirectUrl, String code) async {
    try {
      await _loadSecret();
      final rs = await _httpClient
          .post('https://www.googleapis.com/oauth2/v4/token', body: {
        'code': code,
        'client_id': _siteAudience,
        'client_secret': _secret,
        'redirect_uri': redirectUrl,
        'grant_type': 'authorization_code',
      });
      if (rs.statusCode >= 400) {
        _logger.info('Bad authorization token: $code for $redirectUrl');
        return null;
      }
      final tokenMap = json.decode(rs.body) as Map<String, dynamic>;
      return tokenMap['access_token'] as String;
    } catch (e) {
      _logger.info('Bad authorization token: $code for $redirectUrl', e);
    }
    return null;
  }

  @override
  Future<AuthResult> tryAuthenticate(String accessToken) async {
    //TODO: Support id_tokens
    if (accessToken == null) {
      return null;
    }
    oauth2_v2.Tokeninfo info;
    try {
      info = await _oauthApi.tokeninfo(accessToken: accessToken);
      if (info == null) {
        return null;
      }

      if (!_trustedAudiences.contains(info.audience)) {
        _logger.warning('OAuth2 access attempted with invalid audience, '
            'for email: "${info.email}", audience: "${info.audience}"');
        return null;
      }

      if (info.expiresIn == null ||
          info.expiresIn <= 0 ||
          info.userId == null ||
          info.userId.isEmpty ||
          info.verifiedEmail != true ||
          info.email == null ||
          info.email.isEmpty ||
          !isValidEmail(info.email)) {
        _logger.warning('OAuth2 token info invalid: ${info.toJson()}');
        return null;
      }

      return AuthResult(info.userId, info.email.toLowerCase());
    } on oauth2_v2.ApiRequestError catch (e) {
      _logger.info('Access denied for OAuth2 access token.', e);
    } catch (e, st) {
      _logger.warning('OAuth2 access token lookup failed.', e, st);
    }
    return null;
  }

  @override
  Future close() async {
    _httpClient.close();
  }

  Future _loadSecret() async {
    if (_secretLoaded) return;
    _secret =
        await secretBackend.lookup('${SecretKey.oauthPrefix}$_siteAudience');
    _secretLoaded = true;
  }
}
