// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
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
final testTimeoutFactor = 8;

class TestContextProvider {
  final String pubHostedUrl;
  final FakePubServerProcess _fakePubServerProcess;
  final TestBrowser _testBrowser;

  TestContextProvider._(
    this.pubHostedUrl,
    this._fakePubServerProcess,
    this._testBrowser,
  );

  static Future<TestContextProvider> start({
    List<IgnoreMessageFilter>? ignoreServerErrors,
  }) async {
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
      ignoreServerErrors: ignoreServerErrors,
    );
    await testBrowser.startBrowser();
    return TestContextProvider._(origin, fakePubServerProcess, testBrowser);
  }

  Future<void> close() async {
    await _testBrowser.close();
    await _fakePubServerProcess.kill();
  }

  Future<TestUser> createAnonymousTestUser({
    bool expectAllResponsesToBeCacheControlPublic = true,
  }) async {
    final session = await _testBrowser.createSession();
    return TestUser(
      email: '',
      browserApi: PubApiClient(pubHostedUrl),
      serverApi: PubApiClient(pubHostedUrl),
      withBrowserPage: <T>(Future<T> Function(Page) fn) async {
        return await session.withPage<T>(
          fn: fn,
          expectAllResponsesToBeCacheControlPublic:
              expectAllResponsesToBeCacheControlPublic,
        );
      },
      readLatestEmail: () async => throw UnimplementedError(),
      createCredentials: () async => throw UnimplementedError(),
    );
  }

  Future<TestUser> createTestUser({
    required String email,
    List<String>? scopes,
  }) async {
    late PubApiClient browserApi;
    final session = await _testBrowser.createSession();
    await session.withPage(
      fn: (page) async {
        await page.fakeAuthSignIn(email: email, scopes: scopes);
        browserApi = await _apiClientHttpHeadersFromSignedInSession(page);
      },
    );

    return TestUser(
      email: email,
      browserApi: browserApi,
      serverApi: await _createClientWithAudience(
        pubHostedUrl: pubHostedUrl,
        email: email,
      ),
      createCredentials: () => fakeCredentialsMap(email: email),
      readLatestEmail: () async {
        final map = await _fakePubServerProcess.fakeEmailReader.readLatestEmail(
          recipient: email,
        );
        return map['bodyText'] as String;
      },
      withBrowserPage: <T>(Future<T> Function(Page) fn) async {
        return await session.withPage<T>(
          fn: (page) async {
            return await fn(page);
          },
        );
      },
    );
  }
}

Future<PubApiClient> _createClientWithAudience({
  required String pubHostedUrl,
  required String email,
  String? audience,
}) async {
  final token = await createFakeGcpToken(
    pubHostedUrl: pubHostedUrl,
    email: email,
    audience: audience,
  );
  return PubApiClient(
    pubHostedUrl,
    client: createHttpClientWithHeaders({'authorization': 'Bearer $token'}),
  );
}

Future<String> createFakeGcpToken({
  required String pubHostedUrl,
  required String email,
  String? audience,
}) async {
  final rs = await http.get(
    Uri.parse(pubHostedUrl).replace(
      path: '/fake-gcp-token',
      queryParameters: {
        'email': email,
        if (audience != null) 'audience': audience,
      },
    ),
  );
  final map = json.decode(rs.body) as Map<String, dynamic>;
  return map['token'] as String;
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

  _HttpClient(this._client, this._closeInnerClient, this._headers);

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
