// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/account_api.dart';
import 'package:pub_dev/admin/models.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/fake/backend/fake_email_sender.dart';
import 'package:pub_dev/frontend/handlers/experimental.dart';
import 'package:pub_dev/frontend/request_context.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:test/test.dart';

import '../../shared/handlers_test_utils.dart';
import '../../shared/test_services.dart';
import '_utils.dart';

void main() {
  group('Report handlers test', () {
    testWithProfile('page does not require authentication', fn: () async {
      await expectHtmlResponse(
        await issueGet(
          '/report?subject=package:oxygen',
          headers: {'cookie': '$experimentalCookieName=report'},
        ),
        present: [
          'Please describe the issue you want to report:',
          'Contact information',
        ],
      );
    });

    testWithProfile('page works with signed-in session', fn: () async {
      final cookies = await acquireSessionCookies('user@pub.dev');
      await expectHtmlResponse(
        await issueGet(
          '/report?subject=package:oxygen',
          headers: {'cookie': '$experimentalCookieName=report; $cookies'},
        ),
        present: ['Please describe the issue you want to report:'],
        absent: ['Contact information'],
      );
    });

    testWithProfile('page with missing subject', fn: () async {
      await expectHtmlResponse(
        await issueGet(
          '/report',
          headers: {'cookie': '$experimentalCookieName=report'},
        ),
        present: [
          '&quot;subject&quot; cannot be `null`',
        ],
        absent: [
          'Please describe the issue you want to report:',
        ],
        status: 400,
      );
    });

    testWithProfile('page with bad subject', fn: () async {
      await expectHtmlResponse(
        await issueGet(
          '/report?subject=x',
          headers: {'cookie': '$experimentalCookieName=report'},
        ),
        present: [
          'Invalid &quot;subject&quot; parameter.',
        ],
        absent: [
          'Please describe the issue you want to report:',
        ],
        status: 400,
      );
    });

    testWithProfile('page with package version subject', fn: () async {
      await expectHtmlResponse(
        await issueGet(
          '/report?subject=package-version:oxygen/1.0.0',
          headers: {'cookie': '$experimentalCookieName=report'},
        ),
        present: [
          'Please describe the issue you want to report:',
          'oxygen/1.0.0',
        ],
      );
    });
  });

  group('Report API test', () {
    testWithProfile('unauthenticated email missing', fn: () async {
      await withHttpPubApiClient(
        experimental: {'report'},
        fn: (client) async {
          await expectApiException(
            client.postReport(ReportForm(
              message: 'Problem.',
            )),
            status: 400,
            code: 'InvalidInput',
            message: 'Email is invalid or missing.',
          );
          expect(fakeEmailSender.sentMessages, isEmpty);
        },
      );
    });

    testWithProfile('authenticated email must be absent', fn: () async {
      await withFakeAuthRequestContext('user@pub.dev', () async {
        final sessionId = requestContext.sessionData?.sessionId;
        final csrfToken = requestContext.csrfToken;
        await withHttpPubApiClient(
          experimental: {'report'},
          sessionId: sessionId,
          csrfToken: csrfToken,
          fn: (client) async {
            await expectApiException(
              client.postReport(ReportForm(
                email: 'any@pub.dev',
                message: 'Problem.',
              )),
              status: 400,
              code: 'InvalidInput',
              message: '\"email\" must be `null`',
            );
            expect(fakeEmailSender.sentMessages, isEmpty);
          },
        );
      });
    });

    testWithProfile('subject missing', fn: () async {
      await withHttpPubApiClient(
        experimental: {'report'},
        fn: (client) async {
          await expectApiException(
            client.postReport(ReportForm(
              email: 'user@pub.dev',
              message: 'Huston, we have a problem.',
            )),
            status: 400,
            code: 'InvalidInput',
            message: '\"subject\" cannot be `null`',
          );
          expect(fakeEmailSender.sentMessages, isEmpty);
        },
      );
    });

    testWithProfile('subject is invalid', fn: () async {
      await withHttpPubApiClient(
        experimental: {'report'},
        fn: (client) async {
          await expectApiException(
            client.postReport(ReportForm(
              email: 'user@pub.dev',
              subject: 'x',
              message: 'Huston, we have a problem.',
            )),
            status: 400,
            code: 'InvalidInput',
            message: 'Invalid subject.',
          );
          expect(fakeEmailSender.sentMessages, isEmpty);
        },
      );
    });

    testWithProfile('package missing', fn: () async {
      await withHttpPubApiClient(
        experimental: {'report'},
        fn: (client) async {
          await expectApiException(
            client.postReport(ReportForm(
              email: 'user@pub.dev',
              subject: 'package:x',
              message: 'Huston, we have a problem.',
            )),
            status: 404,
            code: 'NotFound',
            message: 'Package \"x\" does not exist.',
          );
          expect(fakeEmailSender.sentMessages, isEmpty);
        },
      );
    });

    testWithProfile('version missing', fn: () async {
      await withHttpPubApiClient(
        experimental: {'report'},
        fn: (client) async {
          await expectApiException(
            client.postReport(ReportForm(
              email: 'user@pub.dev',
              subject: 'package-version:oxygen/4.0.0',
              message: 'Huston, we have a problem.',
            )),
            status: 404,
            code: 'NotFound',
            message: 'Package version \"oxygen/4.0.0\" does not exist.',
          );
          expect(fakeEmailSender.sentMessages, isEmpty);
        },
      );
    });

    testWithProfile('publisher missing', fn: () async {
      await withHttpPubApiClient(
        experimental: {'report'},
        fn: (client) async {
          await expectApiException(
            client.postReport(ReportForm(
              email: 'user@pub.dev',
              subject: 'publisher:unknown-domain.com',
              message: 'Huston, we have a problem.',
            )),
            status: 404,
            code: 'NotFound',
            message: 'Publisher \"unknown-domain.com\" does not exist.',
          );
          expect(fakeEmailSender.sentMessages, isEmpty);
        },
      );
    });

    testWithProfile('too short message', fn: () async {
      await withFakeAuthRequestContext('user@pub.dev', () async {
        final sessionId = requestContext.sessionData?.sessionId;
        final csrfToken = requestContext.csrfToken;
        await withHttpPubApiClient(
          experimental: {'report'},
          sessionId: sessionId,
          csrfToken: csrfToken,
          fn: (client) async {
            await expectApiException(
              client.postReport(ReportForm(
                subject: 'package:oxygen',
                message: 'Problem.',
              )),
              status: 400,
              code: 'InvalidInput',
              message: '\"message\" must be longer than 20 charaters',
            );
            expect(fakeEmailSender.sentMessages, isEmpty);
          },
        );
      });
    });

    testWithProfile('unauthenticated success', fn: () async {
      await withHttpPubApiClient(
        experimental: {'report'},
        fn: (client) async {
          final msg = await client.postReport(ReportForm(
            email: 'user2@pub.dev',
            subject: 'package:oxygen',
            message: 'Huston, we have a problem.',
          ));

          expect(msg.message, 'Report submitted successfully.');
          expect(fakeEmailSender.sentMessages, hasLength(1));
          final email = fakeEmailSender.sentMessages.single;
          expect(email.from.email, 'noreply@pub.dev');
          expect(email.recipients.single.email, 'support@pub.dev');
          expect(email.ccRecipients.single.email, 'user2@pub.dev');

          final mc = await dbService.query<ModerationCase>().run().single;
          expect(mc.subject, 'package:oxygen');
          expect(mc.reporterEmail, 'user2@pub.dev');
        },
      );
    });

    testWithProfile('authenticated success', fn: () async {
      await withFakeAuthRequestContext('user@pub.dev', () async {
        final sessionId = requestContext.sessionData?.sessionId;
        final csrfToken = requestContext.csrfToken;
        await withHttpPubApiClient(
          experimental: {'report'},
          sessionId: sessionId,
          csrfToken: csrfToken,
          fn: (client) async {
            final msg = await client.postReport(ReportForm(
              message: 'Huston, we have a problem.',
              subject: 'package:oxygen',
            ));
            expect(msg.message, 'Report submitted successfully.');
            expect(fakeEmailSender.sentMessages, hasLength(1));
            final email = fakeEmailSender.sentMessages.single;
            expect(email.bodyText, contains('Subject: package:oxygen'));
            expect(email.from.email, 'noreply@pub.dev');
            expect(email.recipients.single.email, 'support@pub.dev');
            expect(email.ccRecipients.single.email, 'user@pub.dev');

            final mc = await dbService.query<ModerationCase>().run().single;
            expect(mc.subject, 'package:oxygen');
            expect(mc.reporterEmail, 'user@pub.dev');
          },
        );
      });
    });
  });
}
