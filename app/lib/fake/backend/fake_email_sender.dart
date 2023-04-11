// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:mailer/mailer.dart';
import 'package:path/path.dart' as p;
import 'package:ulid/ulid.dart';

import '../../frontend/email_sender.dart';
import '../../shared/email.dart';

FakeEmailSender get fakeEmailSender => emailSender as FakeEmailSender;

class FakeEmailSender implements EmailSender {
  final String? _outputDir;
  final sentMessages = <EmailMessage>[];
  int failNextMessageCount = 0;

  FakeEmailSender({
    String? outputDir,
  }) : _outputDir = outputDir;

  @override
  bool get shouldBackoff => false;

  @override
  Future<void> sendMessage(EmailMessage message) async {
    message.verifyLocalMessageId();
    if (failNextMessageCount > 0) {
      failNextMessageCount--;
      throw SmtpClientCommunicationException('fake network problem');
    }
    sentMessages.add(message);
    if (_outputDir != null) {
      final uuid = message.localMessageId ?? Ulid().toCanonical();
      final file = File(p.join(_outputDir!, '$uuid.json'));
      await file.parent.create(recursive: true);
      await file.writeAsString(json.encode(message.toJson()));
    }
  }
}
