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
        'email-send',
        AdminInvokeActionArguments(arguments: {
          'to': 'a@pub.dev,b@pub.dev',
          'subject': 'Test email',
          'body': 'Test body',
        }),
      );
      expect(rs1.output, {
        'emails': ['a@pub.dev', 'b@pub.dev'],
        'sent': true,
      });
      expect(fakeEmailSender.sentMessages, hasLength(1));
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
        'email-send',
        AdminInvokeActionArguments(arguments: {
          'to': 'package:oxygen',
          'subject': 'Test email',
          'body': 'Test body',
        }),
      );
      expect(rs1.output, {
        'emails': ['admin@pub.dev'],
        'sent': true,
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
