// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:mailer/mailer.dart';
import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/service/email/email_sender.dart';
import 'package:pub_dev/service/email/email_templates.dart';
import 'package:test/test.dart';

void main() {
  group('EmailSenderBase', () {
    EmailMessage newEmailMessage() => EmailMessage(
          EmailAddress('admin@pub.dev'),
          [EmailAddress('user@pub.dev')],
          'subject',
          'bodyText',
        );

    test('sending email', () async {
      final log = <String>[];
      final sender = _EmailSender(log, (message) {});

      await sender.sendMessage(newEmailMessage());
      expect(log, [
        'Connecting #0 for admin@pub.dev',
        '#0 sending to user@pub.dev',
      ]);

      log.clear();
      await sender.sendMessage(newEmailMessage());
      expect(log, [
        '#0 sending to user@pub.dev',
      ]);

      log.clear();
      await withClock(Clock.fixed(clock.minutesFromNow(2)), () async {
        await sender.sendMessage(newEmailMessage());
      });
      expect(log, [
        '#0 closing connection.',
        'Connecting #1 for admin@pub.dev',
        '#1 sending to user@pub.dev',
      ]);
    });

    test('throwing MailerException', () async {
      final log = <String>[];
      final sender = _EmailSender(log, (message) {
        log.add('Throwing SmtpClientCommunicationException.');
        throw SmtpClientCommunicationException('test');
      });
      await expectLater(
        () => sender.sendMessage(newEmailMessage()),
        throwsA(isA<EmailSenderException>()),
      );
      expect(log, [
        'Connecting #0 for admin@pub.dev',
        '#0 sending to user@pub.dev',
        'Throwing SmtpClientCommunicationException.',
        '#0 closing connection.',
        'Connecting #1 for admin@pub.dev',
        '#1 sending to user@pub.dev',
        'Throwing SmtpClientCommunicationException.',
      ]);
    });

    test('later async exception invalidates the connection', () async {
      final log = <String>[];
      final sender = _EmailSender(log, (message) async {
        scheduleMicrotask(() async {
          await Future.delayed(Duration(seconds: 1));
          log.add('Throwing Exception from microtask.');
          throw Exception();
        });
        log.add('Completed sending.');
      });
      // first message triggers async exception in the zone
      await sender.sendMessage(newEmailMessage());

      // waiting for the exception to happen
      await Future.delayed(Duration(seconds: 2));

      // second message finds the connection as invalid, creates a new one
      await sender.sendMessage(newEmailMessage());
      expect(log, [
        'Connecting #0 for admin@pub.dev',
        '#0 sending to user@pub.dev',
        'Completed sending.',
        'Throwing Exception from microtask.',
        '#0 closing connection.',
        'Connecting #1 for admin@pub.dev',
        '#1 sending to user@pub.dev',
        'Completed sending.',
      ]);
    });
  });
}

typedef _EmailSenderFn = FutureOr<void> Function(EmailMessage message);

class _EmailSender extends EmailSenderBase {
  final List<String> _log;
  final _EmailSenderFn _emailSenderFn;
  int _connectionCount = 0;

  _EmailSender(this._log, this._emailSenderFn);

  @override
  Future<EmailSenderConnection> connect(String senderEmail) async {
    try {
      _log.add('Connecting #$_connectionCount for $senderEmail');
      return _EmailSenderConnection(_connectionCount, this);
    } finally {
      _connectionCount++;
    }
  }

  @override
  void invalidateCredentials() {
    _log.add('Invalidate credentials.');
  }
}

class _EmailSenderConnection extends EmailSenderConnection {
  final int _id;
  final _EmailSender _sender;

  _EmailSenderConnection(this._id, this._sender);

  @override
  Future<void> send(EmailMessage message) async {
    _sender._log.add('#$_id sending to ${message.recipients.join(', ')}');
    await _sender._emailSenderFn(message);
  }

  @override
  Future<void> close() async {
    _sender._log.add('#$_id closing connection.');
  }
}
