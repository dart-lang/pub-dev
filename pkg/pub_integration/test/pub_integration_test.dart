// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pub_integration/pub_integration.dart';
import 'package:pub_integration/src/fake_credentials.dart';
import 'package:pub_integration/src/fake_pub_server_process.dart';
import 'package:test/test.dart';

void main() {
  group('Integration test using pkg/fake_pub_server', () {
    late FakePubServerProcess fakePubServerProcess;
    final httpClient = http.Client();

    setUpAll(() async {
      fakePubServerProcess = await FakePubServerProcess.start();
      await fakePubServerProcess.started;
    });

    tearDownAll(() async {
      await fakePubServerProcess.kill();
      httpClient.close();
    });

    test('standard integration', () async {
      Future<void> inviteCompleterFn() async {
        final emails =
            await fakePubServerProcess.fakeEmailReader.readAllEmails();
        final lastEmailText = emails.last['bodyText'] as String;
        final inviteUrlLogLine = lastEmailText
            .split('\n')
            .firstWhere((line) => line.contains('https://pub.dev/consent'));
        final inviteUri = Uri.parse(inviteUrlLogLine
            .substring(inviteUrlLogLine.indexOf('https://pub.dev/consent')));
        final consentId = inviteUri.queryParameters['id'];

        // spoofed consent, trying to accept it with a different user
        final rs1 = await httpClient.put(
          Uri.parse(
              'http://localhost:${fakePubServerProcess.port}/api/account/consent/$consentId'),
          headers: {
            'Authorization':
                'Bearer somebodyelse-at-example-dot-org?aud=fake-site-audience',
            'content-type': 'application/json; charset="utf-8"',
          },
          body: json.encode({'granted': true}),
        );
        if (rs1.statusCode != 400) {
          throw Exception('Expected status code 400, got: ${rs1.statusCode}');
        }

        // accepting it with the good user
        final rs2 = await httpClient.put(
          Uri.parse(
              'http://localhost:${fakePubServerProcess.port}/api/account/consent/$consentId'),
          headers: {
            'Authorization':
                'Bearer dev-at-example-dot-org?aud=fake-site-audience',
            'content-type': 'application/json; charset="utf-8"',
          },
          body: json.encode({'granted': true}),
        );
        if (rs2.statusCode != 200) {
          throw Exception('Expected status code 200, got: ${rs2.statusCode}');
        }
      }

      await verifyPub(
        pubHostedUrl: 'http://localhost:${fakePubServerProcess.port}',
        credentialsFileContent: fakeCredentialsFileContent(),
        mainAccessToken: 'user-at-example-dot-com?aud=fake-site-audience',
        invitedEmail: 'dev@example.org',
        inviteCompleterFn: inviteCompleterFn,
        expectLiveSite: false,
      );
    });
  }, timeout: Timeout.factor(testTimeoutFactor));
}
