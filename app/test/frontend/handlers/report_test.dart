// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/account_api.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/fake/backend/fake_email_sender.dart';
import 'package:pub_dev/frontend/handlers/experimental.dart';
import 'package:pub_dev/frontend/request_context.dart';
import 'package:test/test.dart';

import '../../shared/handlers_test_utils.dart';
import '../../shared/test_services.dart';
import '_utils.dart';

void main() {
  group('Report handlers test', () {
    testWithProfile('requires authentication', fn: () async {
      await expectHtmlResponse(
        await issueGet(
          '/report',
          headers: {'cookie': '$experimentalCookieName=report'},
        ),
        present: ['Authentication required'],
        absent: ['Please describe the issue you want to report:'],
      );
    });

    testWithProfile('OK', fn: () async {
      final cookies = await acquireSessionCookies('user@pub.dev');
      await expectHtmlResponse(
        await issueGet(
          '/report',
          headers: {'cookie': '$experimentalCookieName=report; $cookies'},
        ),
        present: ['Please describe the issue you want to report:'],
        absent: ['Authentication required'],
      );
    });
  });

  group('Report API test', () {
    testWithProfile('authentication required', fn: () async {
      await withHttpPubApiClient(
        experimental: {'report'},
        fn: (client) async {
          await expectApiException(
            client.postReport(ReportForm(
              description: 'Problem.',
            )),
            status: 401,
            code: 'MissingAuthentication',
          );
          expect(fakeEmailSender.sentMessages, isEmpty);
        },
      );
    });

    testWithProfile('too short description', fn: () async {
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
                description: 'Problem.',
              )),
              status: 400,
              code: 'InvalidInput',
              message: '\"description\" must be longer than 20 charaters',
            );
            expect(fakeEmailSender.sentMessages, isEmpty);
          },
        );
      });
    });

    testWithProfile('OK', fn: () async {
      await withFakeAuthRequestContext('user@pub.dev', () async {
        final sessionId = requestContext.sessionData?.sessionId;
        final csrfToken = requestContext.csrfToken;
        await withHttpPubApiClient(
          experimental: {'report'},
          sessionId: sessionId,
          csrfToken: csrfToken,
          fn: (client) async {
            final msg = await client.postReport(ReportForm(
              description: 'Huston, we have a problem.',
            ));
            expect(msg.message, 'Report submitted successfully.');
            expect(fakeEmailSender.sentMessages, hasLength(1));
            final email = fakeEmailSender.sentMessages.single;
            expect(email.from.email, 'noreply@pub.dev');
            expect(email.recipients.single.email, 'support@pub.dev');
            expect(email.ccRecipients.single.email, 'user@pub.dev');
          },
        );
      });
    });
  });
}
