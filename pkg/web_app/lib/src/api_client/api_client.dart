// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:http/browser_client.dart' as browser_client;

import '../_authentication_proxy.dart';
import '_authenticated_client.dart';
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
    PubApiClient(_baseUrl, client: browser_client.BrowserClient());

/// The pub API client to use with account credentials.
PubApiClient get client {
  return PubApiClient(_baseUrl, client: createAuthenticatedClient(() async {
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
