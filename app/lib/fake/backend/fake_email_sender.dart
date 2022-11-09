// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:mailer/mailer.dart';

import '../../frontend/email_sender.dart';
import '../../shared/email.dart';

FakeEmailSender get fakeEmailSender => emailSender as FakeEmailSender;

class FakeEmailSender implements EmailSender {
  final sentMessages = <EmailMessage>[];
  int failNextMessageCount = 0;

  @override
  bool get shouldBackoff => false;

  @override
  Future<void> sendMessage(EmailMessage message) async {
    message.verifyUuid();
    if (failNextMessageCount > 0) {
      failNextMessageCount--;
      throw SmtpClientCommunicationException('fake network problem');
    }
    sentMessages.add(message);
    // also trigger logging as fake pub server's integration test expect them
    await loggingEmailSender.sendMessage(message);
    return;
  }
}
