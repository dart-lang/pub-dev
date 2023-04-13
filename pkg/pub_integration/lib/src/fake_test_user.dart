// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/pubapi.dart';
import 'package:http/http.dart' as http;
import 'package:pub_integration/src/fake_credentials.dart';
import 'package:pub_integration/src/fake_pub_server_process.dart';
import 'package:pub_integration/src/headless_env.dart';
import 'package:pub_integration/src/pub_puppeteer_helpers.dart';
import 'package:puppeteer/puppeteer.dart';

import 'test_scenario.dart';

Future<_FakeTestUser> createFakeTestUser({
  required String email,
  required HeadlessEnv headlessEnv,
  required FakeEmailReaderFromOutputDirectory fakeEmailReader,
  List<String>? scopes,
}) async {
  late PubApiClient api;
  await headlessEnv.withPage(fn: (page) async {
    await page.fakeAuthSignIn(email: email, scopes: scopes);
    api = await _apiClientHttpHeadersFromSignedInSession(page);
  });
  return _FakeTestUser(
    email: email,
    headlessEnv: headlessEnv,
    api: api,
    fakeEmailReader: fakeEmailReader,
  );
}

class _FakeTestUser implements TestUser {
  @override
  final String email;

  final HeadlessEnv _headlessEnv;

  @override
  final PubApiClient api;

  final FakeEmailReaderFromOutputDirectory _fakeEmailReader;

  _FakeTestUser({
    required this.email,
    required HeadlessEnv headlessEnv,
    required this.api,
    required FakeEmailReaderFromOutputDirectory fakeEmailReader,
  })  : _headlessEnv = headlessEnv,
        _fakeEmailReader = fakeEmailReader;

  @override
  Future<T> withBrowserPage<T>(Future<T> Function(Page page) fn) async {
    return await _headlessEnv.withPage(fn: fn);
  }

  @override
  Future<String> readLatestEmail() async {
    final map = await _fakeEmailReader.readLatestEmail(recipient: email);
    return map['bodyText'] as String;
  }

  @override
  Future<Map<String, Object?>> createCredentials() async {
    return fakeCredentialsMap(email: email);
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
