// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:http/http.dart' as http;
import 'package:pub_integration/script/publisher.dart';
import 'package:pub_integration/src/fake_credentials.dart';
import 'package:pub_integration/src/fake_pub_server_process.dart';
import 'package:pub_integration/src/headless_env.dart';
import 'package:pub_integration/src/pub_puppeteer_helpers.dart';
import 'package:test/test.dart';

void main() {
  group('publisher', () {
    late FakePubServerProcess fakePubServerProcess;
    late final HeadlessEnv headlessEnv;
    final httpClient = http.Client();

    setUpAll(() async {
      fakePubServerProcess = await FakePubServerProcess.start();
      await fakePubServerProcess.started;
    });

    tearDownAll(() async {
      await headlessEnv.close();
      await fakePubServerProcess.kill();
      httpClient.close();
    });

    test('publisher script', () async {
      // start browser
      headlessEnv = HeadlessEnv(
        testName: 'browser',
        origin: 'http://localhost:${fakePubServerProcess.port}',
      );
      await headlessEnv.startBrowser();

      Future<void> inviteCompleterFn() async {
        final emails =
            await fakePubServerProcess.fakeEmailReader.readAllEmails();
        final lastEmailText = emails.last['bodyText'] as String;
        final inviteUrlLogLine = lastEmailText
            .split('\n')
            .firstWhere((line) => line.contains('https://pub.dev/consent'));
        final inviteUri = Uri.parse(inviteUrlLogLine
            .substring(inviteUrlLogLine.indexOf('https://pub.dev/consent')));
        final consentId = inviteUri.queryParameters['id']!;

        // spoofed consent, trying to accept it with a different user
        await headlessEnv.withPage(
          fn: (page) async {
            await page
                .gotoOrigin('/sign-in?fake-email=somebodyelse@example.com');
            final rs = await page.gotoOrigin('/consent?id=$consentId');
            expect(rs.status, 400);
          },
        );

        // accepting it with the good user
        await headlessEnv.withPage(
          fn: (page) async {
            await page.fakeAuthSignIn(email: 'dev@example.org');
            await page.acceptConsent(consentId: consentId);
          },
        );
      }

      final script = PublisherScript(
        pubHostedUrl: 'http://localhost:${fakePubServerProcess.port}',
        credentialsFileContent: fakeCredentialsFileContent(),
        invitedEmail: 'dev@example.org',
        inviteCompleterFn: inviteCompleterFn,
        headlessEnv: headlessEnv,
      );
      await script.verify();
    });
  }, timeout: Timeout.factor(testTimeoutFactor));
}
