// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/pubapi.dart';
import 'package:http/http.dart' as http;
import 'package:pub_integration/src/fake_credentials.dart';
import 'package:pub_integration/src/headless_env.dart';
import 'package:pub_integration/src/pub_puppeteer_helpers.dart';
import 'package:puppeteer/puppeteer.dart';

import 'test_scenario.dart';

class FakeTestUser implements TestUser {
  @override
  final String email;

  @override
  final Browser browser;

  @override
  final PubApiClient api;

  FakeTestUser({
    required this.email,
    required this.browser,
    required this.api,
  });

  @override
  Future<String> readLatestEmail() {
    // TODO: implement readLatestEmail after #6549 lands.
    throw UnimplementedError();
  }

  @override
  Future<Map<String, Object?>> createCredentials() async {
    return fakeCredentialsMap(email: email);
  }

  static Future<FakeTestUser> create({
    required String email,
    required Browser browser,
    List<String>? scopes,
  }) async {
    // TODO: refactor/reuse HeadlessEnv.withPage
    final page = await browser.newPage();
    await page.fakeAuthSignIn(email: email, scopes: scopes);
    final api = await _apiClientHttpHeadersFromSignedInSession(page);
    await page.close();
    return FakeTestUser(
      email: email,
      browser: browser,
      api: api,
    );
  }
}

/// Extracts the HTTP headers required for pub.dev API client (session cookies and CSRF token).
Future<PubApiClient> _apiClientHttpHeadersFromSignedInSession(Page page) async {
  await page.gotoOrigin('/my-liked-packages');
  final csrfElement = await page.$('meta[name="csrf-token"]');
  final csrfToken = await csrfElement.attributeValue('content');

  final cookies = await page.cookies();
  final cookieHeader = cookies
      .where((e) => e.name.contains('-PUB_S') || e.name.startsWith('PUB_S'))
      .map((e) => '${e.name}=${e.value}')
      .join('; ');
  final headers = <String, String>{
    'cookie': cookieHeader,
    if (csrfToken != null) 'x-pub-csrf-token': csrfToken,
  };
  final client = _HttpClient(http.Client(), true, headers);
  return PubApiClient(page.origin, client: client);
}

/// An [http.Client] which sends additional headers along the request.
class _HttpClient extends http.BaseClient {
  final http.Client _client;
  final bool _closeInnerClient;
  final Map<String, String> _headers;

  _HttpClient(
    this._client,
    this._closeInnerClient,
    this._headers,
  );

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers.addAll(_headers);
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
