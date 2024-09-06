// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/data/admin_api.dart';
import 'package:http/http.dart' as http;
import 'package:pub_integration/src/fake_test_context_provider.dart';
import 'package:pub_integration/src/pub_puppeteer_helpers.dart';
import 'package:pub_integration/src/test_browser.dart';
import 'package:test/test.dart';

final _caseIdExpr = RegExp(r'[0-9]{8}I[0-9a-f]{10}');

void main() {
  group('report', () {
    late final TestContextProvider fakeTestScenario;
    final httpClient = http.Client();

    setUpAll(() async {
      fakeTestScenario = await TestContextProvider.start();
    });

    tearDownAll(() async {
      await fakeTestScenario.close();
      httpClient.close();
    });

    test('bulk tests', () async {
      // base setup: publish packages
      await httpClient.post(
          Uri.parse('${fakeTestScenario.pubHostedUrl}/fake-test-profile'),
          body: json.encode({
            'testProfile': {
              'defaultUser': 'user@pub.dev',
              'packages': [
                {
                  'name': 'oxygen',
                  'versions': ['1.0.0', '1.2.0'],
                },
              ],
            },
          }));

      final anonReporter = await fakeTestScenario.createAnonymousTestUser();
      final reporter =
          await fakeTestScenario.createTestUser(email: 'reporter@pub.dev');
      final pkgAdminUser =
          await fakeTestScenario.createTestUser(email: 'user@pub.dev');
      final adminUser =
          await fakeTestScenario.createTestUser(email: 'admin@pub.dev');
      final supportUser =
          await fakeTestScenario.createTestUser(email: 'support@pub.dev');

      // visit report page and file a report
      await anonReporter.withBrowserPage(
        (page) async {
          await page.gotoOrigin('/report?subject=package:oxygen');
          await page.waitAndClick('.report-page-direct-report');
          await page.waitFocusAndType('#report-email', 'reporter@pub.dev');
          await page.waitFocusAndType(
              '#report-message', 'Huston, we have a problem.');
          await page.waitAndClick('#report-submit');
          await page.waitForNavigation();
          expect(
              await page.content, contains('has been submitted successfully'));
        },
      );

      // verify emails
      final reportEmail1 = await reporter.readLatestEmail();
      final reportEmail2 = await supportUser.readLatestEmail();
      expect(reportEmail1, contains('package:oxygen'));
      expect(reportEmail2, contains('package:oxygen'));
      expect(reportEmail1, contains('Huston'));

      // verify moderation case
      final caseId = _caseIdExpr.firstMatch(reportEmail2)!.group(0)!;
      final caseData = await adminUser.serverApi.adminInvokeAction(
        'moderation-case-info',
        AdminInvokeActionArguments(
          arguments: {
            'case': caseId,
          },
        ),
      );
      expect(caseData.output, {
        'caseId': caseId,
        'reporterEmail': 'reporter@pub.dev',
        'kind': 'notification',
        'opened': isNotEmpty,
        'resolved': null,
        'source': 'external-notification',
        'subject': 'package:oxygen',
        'isSubjectOwner': false,
        'status': 'pending',
        'grounds': null,
        'violation': null,
        'reason': null,
        'url': null,
        'appealedCaseId': null,
        'actionLog': {'entries': []}
      });

      // moderate package
      final moderateRs = await adminUser.serverApi.adminInvokeAction(
        'moderate-package',
        AdminInvokeActionArguments(
          arguments: {
            'case': caseId,
            'package': 'oxygen',
            'state': 'true',
          },
        ),
      );
      expect(
        moderateRs.output,
        {
          'package': 'oxygen',
          'before': {'isModerated': false, 'moderatedAt': null},
          'after': {'isModerated': true, 'moderatedAt': isNotEmpty},
        },
      );

      // package page is not accessible
      await anonReporter.withBrowserPage((page) async {
        await page.gotoOrigin('/packages/oxygen');
        final content = await page.content;
        expect(content, contains('has been moderated'));
      });

      final appealPageUrl =
          Uri.parse('https://pub.dev/report').replace(queryParameters: {
        'appeal': caseId,
        'subject': 'package:oxygen',
      }).toString();

      await adminUser.serverApi.adminInvokeAction(
        'moderation-case-resolve',
        AdminInvokeActionArguments(
          arguments: {
            'case': caseId,
            'grounds': 'policy',
            'violation': 'scope_of_platform_service',
            'reason': 'Package violated our policy.',
          },
        ),
      );

      // sending email to reporter
      await adminUser.serverApi.adminInvokeAction(
        'email-send',
        AdminInvokeActionArguments(
          arguments: {
            'from': 'support@pub.dev',
            'to': 'reporter@pub.dev',
            'subject': 'Resolution on your report - $caseId',
            'body': 'Dear reporter,\n\n'
                'We have closed the case with the following resolution: ...\n\n'
                'If you want to appeal this decision, you may use the following URL:\n'
                '$appealPageUrl\n\n'
                'Best regards,\n pub.dev admins',
            'in-reply-to': caseId,
          },
        ),
      );
      final reporterConclusionMail = await reporter.readLatestEmail();
      expect(reporterConclusionMail, contains(appealPageUrl));

      // sending email to moderated admins
      await adminUser.serverApi.adminInvokeAction(
        'email-send',
        AdminInvokeActionArguments(
          arguments: {
            'from': 'support@pub.dev',
            'to': 'package:oxygen',
            'subject': 'You have been moderated',
            'body': 'Appeal on $appealPageUrl',
          },
        ),
      );
      final packageAdminConclusionMail = await pkgAdminUser.readLatestEmail();
      expect(packageAdminConclusionMail, contains(appealPageUrl));

      // admin appeals
      await pkgAdminUser.withBrowserPage((page) async {
        await page
            .gotoOrigin(appealPageUrl.replaceAll('https://pub.dev/', '/'));

        await page.waitFocusAndType(
            '#report-message', 'Huston, I have a different idea.');
        await page.waitAndClick('#report-submit');
        await page.waitForNavigation();
        expect(await page.content, contains('has been submitted successfully'));
      });

      final appealEmail = await supportUser.readLatestEmail();

      // extract new case id from email
      final appealCaseId = _caseIdExpr.firstMatch(appealEmail)!.group(0)!;

      // admin closes case without further action
      await adminUser.serverApi.adminInvokeAction(
        'moderation-case-resolve',
        AdminInvokeActionArguments(
          arguments: {
            'case': appealCaseId,
          },
        ),
      );

      // sending email to reporter
      await adminUser.serverApi.adminInvokeAction(
        'email-send',
        AdminInvokeActionArguments(
          arguments: {
            'from': 'support@pub.dev',
            'to': pkgAdminUser.email,
            'subject': 'Your appeal has been rejected.',
            'body': '...',
            'in-reply-to': appealCaseId,
          },
        ),
      );
    });
  }, timeout: Timeout.factor(testTimeoutFactor));
}
