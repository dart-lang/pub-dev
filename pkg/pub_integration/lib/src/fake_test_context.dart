// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:_pub_shared/pubapi.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'fake_test_context_provider.dart';
import 'test_scenario.dart';

/// Create a [TestContext] for running integration [TestScenario]'s against
/// the fake server.
///
/// Returns a [TestContext] and a cleanup function.
Future<
    ({
      TestContext context,
      Future<void> Function() close,
    })> createFakeTestContext() async {
  final provider = await TestContextProvider.start();
  final c = http.Client();
  final tempDir = await Directory.systemTemp.createTemp('pub-integration-');

  final userA = await provider.createTestUser(email: 'user-a@example.com');
  // TODO: publish _dummy_pkg to the fake server and make sure that it's
  //       owned by userA! Probably we can't just publish it here.
  //       Though it'd be ideal to use a prepopulated TestProfile thing.

  return (
    context: TestContext(
      pubHostedUrl: provider.pubHostedUrl,
      client: c,
      publicApi: PubApiClient(provider.pubHostedUrl, client: c),
      adminApi: PubApiClient(provider.pubHostedUrl,
          client: _HttpClientWithAuthorization(c, () async {
            // TODO: Return fake OIDC id_token for the admin user
            throw UnimplementedError('Duplicate logic from test_models.dart');
          })),
      adminServiceAccount: TestServiceAccount(
          email: 'admin@pub.dev',
          getIdToken: () async {
            // TODO: Return fake OIDC id_token for the admin user
            throw UnimplementedError('Duplicate logic from test_models.dart');
          }),
      userA: userA,
      userB: await provider.createTestUser(email: 'user-b@example.com'),
      testPackage: '_dummy_pkg',
      tempDir: tempDir.path,
      dartSdkRoot: p.dirname(p.dirname(Platform.resolvedExecutable)),
    ),
    close: () async {
      c.close();
      await provider.close();
      await tempDir.delete(recursive: true);
    },
  );
}

class _HttpClientWithAuthorization extends http.BaseClient {
  final http.Client _client;
  final Future<String> Function() _getBearerToken;

  _HttpClientWithAuthorization(
    this._client,
    this._getBearerToken,
  );

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final token = await _getBearerToken();
    request.headers['Authorization'] = 'Bearer $token';
    return await _client.send(request);
  }

  @override
  void close() {
    super.close();
  }
}
