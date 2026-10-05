// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:fake_async/fake_async.dart';
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
      expect(log, ['#0 sending to user@pub.dev']);

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

    test(
      'retries SmtpClientAuthenticationException after invalidating credentials',
      () async {
        final log = <String>[];
        var attempts = 0;
        final sender = _EmailSender(log, (message) {
          attempts++;
          if (attempts == 1) {
            log.add('Throwing SmtpClientAuthenticationException.');
            throw SmtpClientAuthenticationException('auth failed');
          }
          log.add('Sent successfully.');
        });
        await sender.sendMessage(newEmailMessage());
        expect(log, [
          'Connecting #0 for admin@pub.dev',
          '#0 sending to user@pub.dev',
          'Throwing SmtpClientAuthenticationException.',
          'Invalidate credentials.',
          '#0 closing connection.',
          'Connecting #1 for admin@pub.dev',
          '#1 sending to user@pub.dev',
          'Sent successfully.',
        ]);
        expect(sender.shouldBackoff, isFalse);
      },
    );

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

    test(
      'connect failure is reported and does not block later sends',
      () async {
        final log = <String>[];
        final sender = _EmailSender(
          log,
          (message) => log.add('Sent successfully.'),
          connectFn: (id) {
            if (id == 0) {
              throw Exception('failed to get access token');
            }
          },
        );
        await expectLater(
          sender.sendMessage(newEmailMessage()).timeout(Duration(seconds: 5)),
          throwsA(
            isA<Exception>().having(
              (e) => '$e',
              'message',
              contains('access token'),
            ),
          ),
        );
        await sender
            .sendMessage(newEmailMessage())
            .timeout(Duration(seconds: 5));
        expect(log, [
          'Connecting #0 for admin@pub.dev',
          'Connecting #1 for admin@pub.dev',
          '#1 sending to user@pub.dev',
          'Sent successfully.',
        ]);
      },
    );

    test(
      'connect throwing SmtpClientAuthenticationException is retried',
      () async {
        final log = <String>[];
        final sender = _EmailSender(
          log,
          (message) => log.add('Sent successfully.'),
          connectFn: (id) {
            if (id == 0) {
              throw SmtpClientAuthenticationException('token exchange failed');
            }
          },
        );
        await sender
            .sendMessage(newEmailMessage())
            .timeout(Duration(seconds: 10));
        expect(log, [
          'Connecting #0 for admin@pub.dev',
          'Invalidate credentials.',
          'Connecting #1 for admin@pub.dev',
          '#1 sending to user@pub.dev',
          'Sent successfully.',
        ]);
      },
    );

    test('hanging send times out and the connection is replaced', () {
      fakeAsync((async) {
        final log = <String>[];
        var sendCount = 0;
        final sender = _EmailSender(log, (message) async {
          sendCount++;
          if (sendCount == 1) {
            log.add('Hanging.');
            await Completer<void>().future;
          }
          log.add('Sent successfully.');
        });
        var completed = false;
        sender.sendMessage(newEmailMessage()).then((_) => completed = true);
        async.elapse(Duration(minutes: 10));
        expect(completed, isTrue);
        expect(log, [
          'Connecting #0 for admin@pub.dev',
          '#0 sending to user@pub.dev',
          'Hanging.',
          '#0 closing connection.',
          'Connecting #1 for admin@pub.dev',
          '#1 sending to user@pub.dev',
          'Sent successfully.',
        ]);
      });
    });
  });
}

typedef _EmailSenderFn = FutureOr<void> Function(EmailMessage message);
typedef _ConnectFn = FutureOr<void> Function(int connectionId);

class _EmailSender extends EmailSenderBase {
  final List<String> _log;
  final _EmailSenderFn _emailSenderFn;
  final _ConnectFn? _connectFn;
  int _connectionCount = 0;

  _EmailSender(this._log, this._emailSenderFn, {_ConnectFn? connectFn})
    : _connectFn = connectFn;

  @override
  Future<EmailSenderConnection> connect(String senderEmail) async {
    final id = _connectionCount++;
    _log.add('Connecting #$id for $senderEmail');
    await _connectFn?.call(id);
    return _EmailSenderConnection(id, this);
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
