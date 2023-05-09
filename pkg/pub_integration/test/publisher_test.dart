// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:http/http.dart' as http;
import 'package:pub_integration/script/publisher.dart';
import 'package:pub_integration/src/fake_pub_server_process.dart';
import 'package:pub_integration/src/fake_test_user.dart';
import 'package:pub_integration/src/headless_env.dart';
import 'package:pub_integration/src/pub_puppeteer_helpers.dart';
import 'package:test/test.dart';

void main() {
  group('publisher', () {
    late FakePubServerProcess fakePubServerProcess;
    late final HeadlessGroup headlessGroup;
    final httpClient = http.Client();

    setUpAll(() async {
      fakePubServerProcess = await FakePubServerProcess.start();
      await fakePubServerProcess.started;
    });

    tearDownAll(() async {
      await headlessGroup.close();
      await fakePubServerProcess.kill();
      httpClient.close();
    });

    test('publisher script', () async {
      // start browser
      headlessGroup = HeadlessGroup(
        testName: 'browser',
        origin: 'http://localhost:${fakePubServerProcess.port}',
      );

      final script = PublisherScript(
        pubHostedUrl: 'http://localhost:${fakePubServerProcess.port}',
        adminUser: await createFakeTestUser(
          email: 'user@example.com',
          headlessEnv: await headlessGroup.createNewProfile(),
          fakeEmailReader: fakePubServerProcess.fakeEmailReader,
          scopes: [webmastersReadonlyScope],
        ),
        invitedUser: await createFakeTestUser(
          email: 'dev@example.com',
          headlessEnv: await headlessGroup.createNewProfile(),
          fakeEmailReader: fakePubServerProcess.fakeEmailReader,
        ),
        unrelatedUser: await createFakeTestUser(
          email: 'somebodyelse@example.com',
          headlessEnv: await headlessGroup.createNewProfile(),
          fakeEmailReader: fakePubServerProcess.fakeEmailReader,
        ),
      );
      await script.verify();
    });
  }, timeout: Timeout.factor(testTimeoutFactor));
}
