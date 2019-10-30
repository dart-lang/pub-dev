// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test/test.dart';

import 'package:pub_integration/script/publisher.dart';
import 'package:pub_integration/src/fake_credentials.dart';
import 'package:pub_integration/src/fake_pub_server_process.dart';

void main() {
  group('publisher', () {
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

    test('publisher script', () async {
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

      final script = PublisherScript(
        pubHostedUrl: 'http://localhost:${fakePubServerProcess.port}',
        credentialsFileContent: fakeCredentialsFileContent(),
        invitedEmail: 'dev@example.org',
        inviteCompleterFn: inviteCompleterFn,
      );
      await script.verify();
    });
  }, timeout: Timeout.factor(2));
}
