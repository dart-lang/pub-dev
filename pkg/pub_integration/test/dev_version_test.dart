// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:http/http.dart' as http;
import 'package:pub_integration/script/dev_version.dart';
import 'package:pub_integration/src/fake_credentials.dart';
import 'package:pub_integration/src/fake_test_context_provider.dart';
import 'package:test/test.dart';

void main() {
  group('devVersion - dev first', () {
    late final TestContextProvider fakeTestScenario;
    final httpClient = http.Client();

    setUpAll(() async {
      fakeTestScenario = await TestContextProvider.start();
    });

    tearDownAll(() async {
      await fakeTestScenario.close();
      httpClient.close();
    });

    test('steps', () async {
      final script = DevVersionScript(
        pubHostedUrl: fakeTestScenario.pubHostedUrl,
        credentialsFileContent: fakeCredentialsFileContent(),
      );
      await script.verify(false);
    });
  }, timeout: Timeout.factor(testTimeoutFactor));

  group('devVersion - stable first', () {
    late final TestContextProvider fakeTestScenario;
    final httpClient = http.Client();

    setUpAll(() async {
      fakeTestScenario = await TestContextProvider.start();
    });

    tearDownAll(() async {
      await fakeTestScenario.close();
      httpClient.close();
    });

    test('steps', () async {
      final script = DevVersionScript(
        pubHostedUrl: fakeTestScenario.pubHostedUrl,
        credentialsFileContent: fakeCredentialsFileContent(),
      );
      await script.verify(true);
    });
  }, timeout: Timeout.factor(testTimeoutFactor));
}
