// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../service/secret/backend.dart';
import '../shared/email.dart';

final _logger = Logger('pub.email');

/// Sets the active [EmailSender].
void registerEmailSender(EmailSender value) =>
    ss.register(#_email_sender, value);

/// The active [EmailSender].
EmailSender get emailSender => ss.lookup(#_email_sender) as EmailSender;

/// Sends emails using credentials periodically fetched from Datastore.
class EmailSender {
  final bool _blockEmails;
  SmtpServer _server;
  DateTime _lastUpdated;
  EmailSender(this._blockEmails);

  /// Sends a [message] and returns when the operation completed.
  /// Errors are only logged, they do not block the processing.
  Future sendMessage(EmailMessage message) async {
    await _update();
    final debugHeader = '(${message.subject}) '
        'from ${message.from} '
        'to ${message.recipients.join(', ')}';
    if (_blockEmails || _server == null) {
      _logger.info('Not sending e-mail (SMTP not configured): '
          '$debugHeader\n${message.bodyText}.');
    } else {
      _logger.info('Sending e-mail: $debugHeader...');
      try {
        await send(_toMessage(message), _server);
      } catch (e, st) {
        _logger.severe('Sending e-mail failed: $debugHeader.', e, st);
      }
    }
  }

  Future _update() async {
    // Caching the values for 10 minutes, updating them only if the previous
    // access happened earlier.
    final now = DateTime.now().toUtc();
    if (_lastUpdated != null && now.difference(_lastUpdated).inMinutes < 10) {
      return;
    }
    final username = await secretBackend.lookup(SecretKey.smtpUsername);
    final password = await secretBackend.lookup(SecretKey.smtpPassword);
    if (username == null ||
        username.isEmpty ||
        password == null ||
        password.isEmpty) {
      _server = null;
    } else {
      _server = gmail(username, password);
    }
    _lastUpdated = now;
  }

  Message _toMessage(EmailMessage input) {
    return Message()
      ..from = _toAddress(input.from)
      ..recipients = input.recipients.map(_toAddress).toList()
      ..subject = input.subject
      ..text = input.bodyText;
  }

  Address _toAddress(EmailAddress input) =>
      input == null ? null : Address(input.email, input.name);
}
