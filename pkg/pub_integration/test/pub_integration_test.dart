// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:http/http.dart' as http;
import 'package:pub_integration/pub_integration.dart';
import 'package:pub_integration/src/fake_test_context_provider.dart';
import 'package:test/test.dart';

void main() {
  group('Integration test using pkg/fake_pub_server', () {
    late final TestContextProvider fakeTestScenario;
    final httpClient = http.Client();

    setUpAll(() async {
      fakeTestScenario = await TestContextProvider.start();
    });

    tearDownAll(() async {
      await fakeTestScenario.close();
      httpClient.close();
    });

    test('standard integration', () async {
      await verifyPub(
        pubHostedUrl: fakeTestScenario.pubHostedUrl,
        adminUser: await fakeTestScenario.createTestUser(
          email: 'user@example.com',
        ),
        invitedUser: await fakeTestScenario.createTestUser(
          email: 'dev@example.com',
        ),
        expectLiveSite: false,
      );
    });
  }, timeout: Timeout.factor(testTimeoutFactor));
}
