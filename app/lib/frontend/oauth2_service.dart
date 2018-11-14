// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.oauth2_service;

import 'dart:async';

import 'package:logging/logging.dart';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis/oauth2/v2.dart' as oauth2_v2;
import 'package:http/http.dart' as http;

final _logger = new Logger('frontend.oauth2');

/// Register a new [OAuth2Service] object.
OAuth2Service get oauth2Service => ss.lookup(#_oauth2_service) as OAuth2Service;

/// Look up the current registered [OAuth2Service].
void registerOAuth2Service(OAuth2Service service) =>
    ss.register(#_oauth2_service, service);

/// The pub client's OAuth2 identifier.
final _pubAudience = '818368855108-8grd2eg9tj9f38os6f1urbcvsq399u8n.apps.'
    'googleusercontent.com';

/// A service used for looking up email addresses using an OAuth2 access token.
class OAuth2Service {
  final http.Client client;

  OAuth2Service(this.client);

  /// Looks up the email address by using the [accessTokenString] which
  /// contains an access token.
  Future<String> lookup(String accessTokenString) async {
    final api = oauth2_v2.Oauth2Api(client);
    try {
      final info = await api.tokeninfo(accessToken: accessTokenString);
      if (info != null &&
          info.audience == _pubAudience &&
          info.expiresIn != null &&
          info.expiresIn > 0 &&
          info.verifiedEmail != null &&
          info.verifiedEmail &&
          info.email != null &&
          info.email != '') {
        return info.email;
      }
      if (info != null && info.audience != _pubAudience) {
        _logger.warning('OAuth2 access attempted with invalid audience, '
            'for email: "${info.email}", audience: "${info.audience}"');
      }
    } on oauth2_v2.ApiRequestError catch (e) {
      _logger.log(Level.INFO, 'Access denied for OAuth2 bearer token.', e);
    } catch (e, st) {
      _logger.warning('OAuth2 bearer token lookup failed.', e, st);
    }
    return null;
  }
}
