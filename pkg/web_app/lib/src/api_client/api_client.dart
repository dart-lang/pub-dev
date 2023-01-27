// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import '../_authentication_proxy.dart';
import '../deferred/http.dart' as http;
import 'pubapi.client.dart';

export '_rpc.dart';

String get _baseUrl {
  final location = Uri.parse(window.location.href);
  return Uri(
    scheme: location.scheme,
    host: location.host,
    port: location.port,
  ).toString();
}

/// The pub API client to use without credentials.
PubApiClient get unauthenticatedClient =>
    PubApiClient(_baseUrl, client: http.Client());

/// The pub API client to use with account credentials.
PubApiClient get client {
  return PubApiClient(_baseUrl,
      client: http.createAuthenticatedClient(() async {
    // Try new pub.dev token first.
    final rs = await http.get(
      Uri.parse('/api/account/session'),
      headers: {
        'content-type': 'application/json; charset="utf-8"',
        'x-pub-dev-token-request': '1',
      },
    );
    if (rs.statusCode == 200) {
      final tokenRs = rs.headers['x-pub-dev-token'];
      if (tokenRs != null) {
        return tokenRs;
      }
    }

    // Wait until we're initialized
    await authProxyReady;

    if (!authenticationProxy.isSignedIn()) {
      await authenticationProxy.trySignIn();
    }
    if (!authenticationProxy.isSignedIn()) {
      print('Login failed');
      throw StateError('User not logged in');
    }
    return authenticationProxy.idToken();
  }));
}
