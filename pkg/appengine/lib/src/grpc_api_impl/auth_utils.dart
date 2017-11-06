// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// TODO(kustermann): At some point we should integrate this library
// into `package:googleapis_auth`.
library auth_utils;

import 'dart:async';

import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

/// Base class for a on-demand provider of oauth2 access tokens.
abstract class AccessTokenProvider {
  Future<auth.AccessToken> obtainAccessToken();
  Future close();
}

/// Provides oauth2 access tokens by using service account credentials from
/// the Compute Engine metadata server.
///
/// For more information see the Compute Engine documentation about service
/// accounts for VMs:
///
///   https://cloud.google.com/compute/docs/access/create-enable-service-accounts-for-instances
///
class MetadataAccessTokenProvider implements AccessTokenProvider {
  final http.Client _httpClient = new http.Client();

  Future<auth.AccessToken> obtainAccessToken() async {
    final auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaMetadataServer(_httpClient);
    return credentials.accessToken;
  }

  Future close() async {
    _httpClient.close();
  }
}

/// Provides oauth2 access tokens by using the provided service account
/// credentials.
class ServiceAccountTokenProvider implements AccessTokenProvider {
  final http.Client _httpClient = new http.Client();
  final auth.ServiceAccountCredentials _serviceAccount;
  final List<String> _scopes;

  ServiceAccountTokenProvider(this._serviceAccount, this._scopes);

  Future<auth.AccessToken> obtainAccessToken() async {
    final auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            _serviceAccount, _scopes, _httpClient);
    return credentials.accessToken;
  }

  Future close() async {
    _httpClient.close();
  }
}

/// Wraps an existing [AccessTokenProvider] and rate-limits the call to it
/// by ensuring there is at most one outstanding request.
///
/// If several callers try to obtain access tokens at the same time, then only
/// the first request will trigger a request to the underlying token provider
/// and the resulting access token (or an error) will be delivered to all
/// callers.
class LimitOutstandingRequests implements AccessTokenProvider {
  final AccessTokenProvider _provider;
  Completer _completer;

  LimitOutstandingRequests(this._provider);

  Future<auth.AccessToken> obtainAccessToken() {
    if (_completer != null) return _completer.future;

    _completer = new Completer<auth.AccessToken>();
    _provider.obtainAccessToken().then((auth.AccessToken token) {
      _completer.complete(token);
      _completer = null;
    }, onError: (error, stack) {
      _completer.completeError(error, stack);
      _completer = null;
    });

    return _completer.future;
  }

  Future close() => _provider.close();
}
