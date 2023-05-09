// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:http/http.dart' as http;
import 'package:pub_integration/pub_integration.dart';
import 'package:pub_integration/src/fake_pub_server_process.dart';
import 'package:pub_integration/src/fake_test_user.dart';
import 'package:pub_integration/src/headless_env.dart';
import 'package:test/test.dart';

void main() {
  group('Integration test using pkg/fake_pub_server', () {
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

    test('standard integration', () async {
      headlessGroup = HeadlessGroup(
        testName: 'pub-integration',
        origin: 'http://localhost:${fakePubServerProcess.port}',
      );

      await verifyPub(
        pubHostedUrl: 'http://localhost:${fakePubServerProcess.port}',
        adminUser: await createFakeTestUser(
          email: 'user@example.com',
          headlessEnv: await headlessGroup.createNewProfile(),
          fakeEmailReader: fakePubServerProcess.fakeEmailReader,
        ),
        invitedUser: await createFakeTestUser(
          email: 'dev@example.com',
          headlessEnv: await headlessGroup.createNewProfile(),
          fakeEmailReader: fakePubServerProcess.fakeEmailReader,
        ),
        expectLiveSite: false,
      );
    });
  }, timeout: Timeout.factor(testTimeoutFactor));
}
