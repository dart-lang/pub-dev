// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/utils/http.dart';
import 'package:http/http.dart' as http;
import 'package:pub_dev/account/session_cookie.dart';

/// Returns an [http.Client] which sends a `Bearer` token as `Authorization`
/// header for each request.
http.Client httpClientWithAuthorization({
  required Future<String?> Function() tokenProvider,
  required Future<String?> Function() sessionIdProvider,
  required Future<String?> Function() csrfTokenProvider,
  Future<Map<String, String>?> Function()? cookieProvider,
  http.Client? client,
}) {
  return _AuthenticatedClient(
    tokenProvider,
    sessionIdProvider,
    csrfTokenProvider,
    cookieProvider,
    client ?? httpRetryClient(),
    client == null,
  );
}

/// An [http.Client] which sends a `Bearer` token as `Authorization` header for
/// each request.
class _AuthenticatedClient extends http.BaseClient {
  final Future<String?> Function() _tokenProvider;
  final Future<String?> Function() _sessionIdProvider;
  final Future<String?> Function() _csrfTokenProvider;
  final Future<Map<String, String>?> Function()? _cookieProvider;
  final http.Client _client;
  final bool _closeInnerClient;

  _AuthenticatedClient(
    this._tokenProvider,
    this._sessionIdProvider,
    this._csrfTokenProvider,
    this._cookieProvider,
    this._client,
    this._closeInnerClient,
  );

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final token = await _tokenProvider();
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }
    final currentCookies = request.headers['cookie'];
    final providedCookies =
        _cookieProvider == null ? null : await _cookieProvider!();

    final sessionId = await _sessionIdProvider();
    request.headers['cookie'] = [
      if (currentCookies != null && currentCookies.isNotEmpty) currentCookies,
      ...?providedCookies?.entries.map((e) => '${e.key}=${e.value}'),
      // ignore: invalid_use_of_visible_for_testing_member
      if (sessionId != null) '$clientSessionLaxCookieName=$sessionId',
      // ignore: invalid_use_of_visible_for_testing_member
      if (sessionId != null) '$clientSessionStrictCookieName=$sessionId',
    ].join('; ');

    if (sessionId != null) {
      final csrfToken = await _csrfTokenProvider();
      if (csrfToken != null) {
        request.headers['x-pub-csrf-token'] = csrfToken;
      }
    }
    return await _client.send(request);
  }

  @override
  void close() {
    if (_closeInnerClient) {
      _client.close();
    }
    super.close();
  }
}
