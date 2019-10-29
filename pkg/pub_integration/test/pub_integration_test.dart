// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test/test.dart';

import 'package:pub_integration/pub_integration.dart';
import 'package:pub_integration/src/fake_credentials.dart';
import 'package:pub_integration/src/fake_pub_server_process.dart';

void main() {
  group('Integration test using pkg/fake_pub_server', () {
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

    test('standard integration', () async {
      final inviteUrlFuture = fakePubServerProcess
          .waitForLine((line) => line.contains('https://pub.dev/consent?id='));
      Future inviteCompleterFn() async {
        final pageUrl = await inviteUrlFuture.timeout(Duration(seconds: 30));
        final pageUri = Uri.parse(pageUrl);
        final consentId = pageUri.queryParameters['id'];
        await httpClient.put(
          'http://localhost:${fakePubServerProcess.port}/api/account/consent/$consentId',
          headers: {
            'Authorization': 'Bearer dev-at-example-dot-org',
          },
          body: json.encode({'granted': true}),
        );
      }

      await verifyPub(
        pubHostedUrl: 'http://localhost:${fakePubServerProcess.port}',
        credentialsFileContent: fakeCredentialsFileContent(),
        invitedEmail: 'dev@example.org',
        inviteCompleterFn: inviteCompleterFn,
      );
    });
  }, timeout: Timeout.factor(2));
}
