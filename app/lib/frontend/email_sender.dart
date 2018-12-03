// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../shared/email.dart';
import 'models.dart' show PrivateKey;

final _logger = new Logger('pub.email');

/// Sets the active [EmailSender].
void registerEmailSender(EmailSender value) =>
    ss.register(#_email_sender, value);

/// The active [EmailSender].
EmailSender get emailSender => ss.lookup(#_email_sender) as EmailSender;

/// Sends emails using credentials periodically fetched from Datastore.
class EmailSender {
  final DatastoreDB _db;
  SmtpServer _server;
  DateTime _lastUpdated;
  EmailSender(this._db);

  /// Sends a [message] and returns when the operation completed.
  /// Errors are only logged, they do not block the processing.
  Future sendMessage(EmailMessage message) async {
    await _update();
    final logText = '(${message.subject}) '
        'from ${message.from} '
        'to ${message.recipients.join(', ')}';
    if (_server == null) {
      _logger.info('Not sending e-mail (SMTP not configured): $logText.');
    } else {
      _logger.info('Sending e-mail: $logText...');
      try {
        final result = await send(_toMessage(message), _server);
        for (var sendReport in result) {
          sendReport?.validationProblems?.forEach((p) {
            _logger.info('E-mail problem: ${p.code} ${p.msg}.');
          });
        }
      } catch (e, st) {
        _logger.severe('Sending e-mail failed: $logText.', e, st);
      }
    }
  }

  Future _update() async {
    final now = new DateTime.now().toUtc();
    if (_lastUpdated != null && now.difference(_lastUpdated).inMinutes < 10) {
      return;
    }
    final list = await _db.lookup([
      _db.emptyKey.append(PrivateKey, id: 'smtp.username'),
      _db.emptyKey.append(PrivateKey, id: 'smtp.password'),
    ]);
    final PrivateKey username = list[0];
    final PrivateKey password = list[1];
    if (username == null ||
        username.value == null ||
        username.value.isEmpty ||
        password == null ||
        password.value == null ||
        password.value.isEmpty) {
      _server = null;
    } else {
      _server = gmail(username.value, password.value);
    }
    _lastUpdated = now;
  }

  Message _toMessage(EmailMessage input) {
    return new Message()
      ..from = _toAddress(input.from)
      ..recipients = input.recipients.map(_toAddress).toList()
      ..subject = input.subject
      ..text = input.bodyText;
  }

  Address _toAddress(EmailAddress input) =>
      input == null ? null : new Address(input.email, input.name);
}
