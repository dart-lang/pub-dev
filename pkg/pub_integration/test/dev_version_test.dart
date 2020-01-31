// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:http/http.dart' as http;
import 'package:test/test.dart';

import 'package:pub_integration/script/dev_version.dart';
import 'package:pub_integration/src/fake_credentials.dart';
import 'package:pub_integration/src/fake_pub_server_process.dart';

void main() {
  group('devVersion - dev first', () {
    FakePubServerProcess fakePubServerProcess;
    final httpClient = http.Client();

    setUpAll(() async {
      fakePubServerProcess = await FakePubServerProcess.start();
      await fakePubServerProcess.started;
    });

    tearDownAll(() async {
      await fakePubServerProcess?.kill();
      httpClient.close();
    });

    test('steps', () async {
      final script = DevVersionScript(
        pubHostedUrl: 'http://localhost:${fakePubServerProcess.port}',
        credentialsFileContent: fakeCredentialsFileContent(),
      );
      await script.verify(false);
    });
  }, timeout: Timeout.factor(testTimeoutFactor));

  group('devVersion - stable first', () {
    FakePubServerProcess fakePubServerProcess;
    final httpClient = http.Client();

    setUpAll(() async {
      fakePubServerProcess = await FakePubServerProcess.start();
      await fakePubServerProcess.started;
    });

    tearDownAll(() async {
      await fakePubServerProcess?.kill();
      httpClient.close();
    });

    test('steps', () async {
      final script = DevVersionScript(
        pubHostedUrl: 'http://localhost:${fakePubServerProcess.port}',
        credentialsFileContent: fakeCredentialsFileContent(),
      );
      await script.verify(true);
    });
  }, timeout: Timeout.factor(testTimeoutFactor));
}
