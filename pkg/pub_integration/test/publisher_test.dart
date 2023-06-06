// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:http/http.dart' as http;
import 'package:pub_integration/script/publisher.dart';
import 'package:pub_integration/src/fake_test_context_provider.dart';
import 'package:pub_integration/src/pub_puppeteer_helpers.dart';
import 'package:test/test.dart';

void main() {
  group('publisher', () {
    late final TestContextProvider fakeTestScenario;
    final httpClient = http.Client();

    setUpAll(() async {
      fakeTestScenario = await TestContextProvider.start();
    });

    tearDownAll(() async {
      await fakeTestScenario.close();
      httpClient.close();
    });

    test('publisher script', () async {
      final script = PublisherScript(
        pubHostedUrl: fakeTestScenario.pubHostedUrl,
        adminUser: await fakeTestScenario.createTestUser(
          email: 'user@example.com',
          scopes: [webmastersReadonlyScope],
        ),
        invitedUser: await fakeTestScenario.createTestUser(
          email: 'dev@example.com',
        ),
        unrelatedUser: await fakeTestScenario.createTestUser(
          email: 'somebodyelse@example.com',
        ),
      );
      await script.verify();
    });
  }, timeout: Timeout.factor(testTimeoutFactor));
}
