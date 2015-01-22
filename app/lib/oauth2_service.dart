// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.oauth2_service;

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/oauth2/v2.dart' as oauth2_v2;
import 'package:http/http.dart' as http;

/// Register a new [OAuth2Service] object.
OAuth2Service get oauth2Service => ss.lookup(#_oauth2_service);

/// Look up the current registered [OAuth2Service].
void registerOauth2Service(OAuth2Service service)
    => ss.register(#_oauth2_service, service);

/// A service used for looking up email addresses using an OAuth2 access token.
class OAuth2Service {
  final http.Client client;

  OAuth2Service(this.client);

  /// Looks up the email address by using the [accessTokenString] which
  /// contains an access token.
  Future<String> lookup(String accessTokenString) async {
    var future = new DateTime.utc(4242);
    var accessToken = new AccessToken('Bearer', accessTokenString, future);
    var credentials = new AccessCredentials(accessToken, null, []);
    var authClient = authenticatedClient(client, credentials);

    oauth2_v2.Userinfoplus info;
    try {
      var api = new oauth2_v2.Oauth2Api(authClient);
      info = await api.userinfo.get();
    } finally {
      authClient.close();
    }
    return info.email;
  }
}
