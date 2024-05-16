// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/admin_api.dart';
import 'package:pub_dev/fake/backend/fake_email_sender.dart';
import 'package:test/test.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('send email admin action', () {
    testWithProfile('sending email to direct recipients', fn: () async {
      final client = createPubApiClient(authToken: siteAdminToken);
      final rs1 = await client.adminInvokeAction(
        'send-email',
        AdminInvokeActionArguments(arguments: {
          'to-email': 'a@pub.dev,b@pub.dev',
          'email-subject': 'Test email',
          'email-body': 'Test body',
        }),
      );
      expect(rs1.output, {
        'uuid': isNotEmpty,
        'emails': ['a@pub.dev', 'b@pub.dev'],
        'sent': 2,
      });
      expect(fakeEmailSender.sentMessages, hasLength(2));
      final sent = fakeEmailSender.sentMessages
          .expand((e) => e.recipients)
          .map((e) => e.email)
          .toSet()
          .toList()
        ..sort();
      expect(sent, ['a@pub.dev', 'b@pub.dev']);
    });

    testWithProfile('sending email to subject admins', fn: () async {
      final client = createPubApiClient(authToken: siteAdminToken);
      final rs1 = await client.adminInvokeAction(
        'send-email',
        AdminInvokeActionArguments(arguments: {
          'to-subject-admin': 'package:oxygen',
          'email-subject': 'Test email',
          'email-body': 'Test body',
        }),
      );
      expect(rs1.output, {
        'uuid': isNotEmpty,
        'emails': ['admin@pub.dev'],
        'sent': 1,
      });
      expect(fakeEmailSender.sentMessages, hasLength(1));
      final email = fakeEmailSender.sentMessages.single;
      expect(email.toJson(), {
        'localMessageId': isNotEmpty,
        'from': 'support@pub.dev',
        'recipients': ['admin@pub.dev'],
        'ccRecipients': [],
        'subject': 'Test email',
        'bodyText': 'Test body'
      });
    });
  });
}
