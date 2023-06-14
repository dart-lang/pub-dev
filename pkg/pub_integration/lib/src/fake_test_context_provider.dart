// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:isolate';

import 'package:_pub_shared/pubapi.dart';
import 'package:http/http.dart' as http;
import 'package:puppeteer/puppeteer.dart';

import 'fake_credentials.dart';
import 'fake_pub_server_process.dart';
import 'pub_puppeteer_helpers.dart';
import 'test_browser.dart';
import 'test_scenario.dart';

/// The timeout factor that should be used in integration tests.
final testTimeoutFactor = 6;

class TestContextProvider {
  final String pubHostedUrl;
  final FakePubServerProcess _fakePubServerProcess;
  final TestBrowser _testBrowser;

  TestContextProvider._(
      this.pubHostedUrl, this._fakePubServerProcess, this._testBrowser);

  static Future<TestContextProvider> start() async {
    final fakePubServerProcess = await FakePubServerProcess.start();
    await fakePubServerProcess.started;
    final origin = 'http://localhost:${fakePubServerProcess.port}';

    // creating a unique test name for coverage reports
    final testName = [
      Platform.script.pathSegments.last.replaceAll('.', '-'),
      DateTime.now().millisecondsSinceEpoch,
      Isolate.current.hashCode,
    ].join('-');

    final testBrowser = TestBrowser(
      origin: origin,
      testName: testName,
    );
    await testBrowser.startBrowser();
    return TestContextProvider._(origin, fakePubServerProcess, testBrowser);
  }

  Future<void> close() async {
    await _testBrowser.close();
    await _fakePubServerProcess.kill();
  }

  Future<TestUser> createAnonymousTestUser() async {
    return TestUser(
      email: '',
      api: PubApiClient(pubHostedUrl),
      withBrowserPage: <T>(Future<T> Function(Page) fn) async {
        return await _testBrowser.withPage<T>(fn: fn);
      },
      readLatestEmail: () async => throw UnimplementedError(),
      createCredentials: () async => throw UnimplementedError(),
    );
  }

  Future<TestUser> createTestUser({
    required String email,
    List<String>? scopes,
  }) async {
    return await _createFakeTestUser(
      email: email,
      testBrowser: _testBrowser,
      fakeEmailReader: _fakePubServerProcess.fakeEmailReader,
      scopes: scopes,
    );
  }
}

Future<TestUser> _createFakeTestUser({
  required String email,
  required TestBrowser testBrowser,
  required FakeEmailReaderFromOutputDirectory fakeEmailReader,
  List<String>? scopes,
}) async {
  late PubApiClient api;
  await testBrowser.withPage(fn: (page) async {
    await page.fakeAuthSignIn(email: email, scopes: scopes);
    api = await _apiClientHttpHeadersFromSignedInSession(page);
  });
  return TestUser(
    email: email,
    api: api,
    createCredentials: () => fakeCredentialsMap(email: email),
    readLatestEmail: () async {
      final map = await fakeEmailReader.readLatestEmail(recipient: email);
      return map['bodyText'] as String;
    },
    withBrowserPage: <T>(Future<T> Function(Page) fn) async {
      return await testBrowser.withPage<T>(fn: (page) async {
        await page.fakeAuthSignIn(email: email, scopes: scopes);
        return await fn(page);
      });
    },
  );
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
  final client = createHttpClientWithHeaders(headers);
  return PubApiClient(page.origin, client: client);
}

http.Client createHttpClientWithHeaders(Map<String, String> headers) =>
    _HttpClient(http.Client(), true, headers);

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
