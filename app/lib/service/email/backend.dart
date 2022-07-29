// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';

import '../../frontend/email_sender.dart';
import '../../shared/datastore.dart';
import '../../shared/email.dart';
import 'models.dart';

final _logger = Logger('email.backend');
final _random = Random.secure();

/// Sets the email backend service.
void registerEmailBackend(EmailBackend backend) =>
    ss.register(#_emailBackend, backend);

/// The active email backend service.
EmailBackend get emailBackend => ss.lookup(#_emailBackend) as EmailBackend;

/// Represents the backend for the outgoing email queue.
class EmailBackend {
  final DatastoreDB _db;

  EmailBackend(this._db);

  /// Creates [OutgoingEmail] entities that can be stored alongside a transaction.
  List<OutgoingEmail> prepareEntities(EmailMessage msg) {
    return msg.recipients
        .map(
          (recipient) => OutgoingEmail.init(
            fromEmail: msg.from.email,
            recipientEmail: recipient.email,
            subject: msg.subject,
            bodyText: msg.bodyText,
          ),
        )
        .toList();
  }

  /// Queries all [OutgoingEmail] objects and tries to send out the email,
  /// deleting the entry after the email was sent successfully. This method
  /// should be called only from the background task.
  ///
  /// The processing of the Datastore query will be stopped after [stopAfter]
  /// duration has elapsed. This allows the periodic task to complete within
  /// the planned time window.
  ///
  /// Returns the number of successfully sent emails.
  Future<int> trySendAllOutgoingEmails({
    Duration? stopAfter,
  }) async {
    final sw = Stopwatch()..start();
    final query = _db.query<OutgoingEmail>()..order('-created');
    var successful = 0;
    await for (final m in query.run()) {
      if (stopAfter != null && sw.elapsed > stopAfter) break;
      if (m.isNotAlive) continue;
      if (!m.mayAttemptNow) continue;
      final wasSent = await _trySendOutgoingEmail(m.uuid);
      if (wasSent) {
        successful++;
      }
    }
    return successful;
  }

  /// Tries to send [emails]. The [OutgoingEmail] entry will be deleted after
  /// the email was sent successfully.
  ///
  /// This method should be called right after the entries
  /// are saved in the Datastore.
  Future<void> trySendOutgoingEmails(Iterable<OutgoingEmail> emails) async {
    for (final id in emails.map((e) => e.uuid)) {
      await _trySendOutgoingEmail(id);
    }
  }

  /// Tries to send email with the given [id]. The
  /// [OutgoingEmail] entry will be deleted after the
  /// email was sent successfully.
  ///
  /// Returns true if the email was sent successfully.
  Future<bool> _trySendOutgoingEmail(String id) async {
    final key = _db.emptyKey.append(OutgoingEmail, id: id);
    final now = clock.now().toUtc();
    final entry = await withRetryTransaction(_db, (tx) async {
      final o = await tx.lookupOrNull<OutgoingEmail>(key);
      if (o == null || o.isNotAlive) {
        return null;
      }
      o.attempts++;
      o.lastAttempted = now;
      // retry after a random delay in the next 2-6 hours
      o.pendingAt =
          now.add(Duration(hours: 2, minutes: _random.nextInt(4 * 60)));
      tx.insert(o);

      return o;
    });
    if (entry == null) {
      return false;
    }

    try {
      await emailSender.sendMessage(EmailMessage(
        uuid: entry.uuid,
        EmailAddress(entry.fromEmail!),
        [EmailAddress(entry.recipientEmail!)],
        entry.subject!,
        entry.bodyText!,
      ));

      await withRetryTransaction(_db, (tx) async {
        final o = await tx.lookupOrNull<OutgoingEmail>(key);
        if (o != null) {
          tx.delete(key);
        }
      });

      // successful send, deleting entry
      return true;
    } catch (e, st) {
      _logger.warning('Email sending failed.', e, st);
      await withRetryTransaction(_db, (tx) async {
        final o = await tx.lookupOrNull<OutgoingEmail>(key);
        if (o == null) {
          return;
        }
        o.lastError = e.toString();
        tx.insert(o);
      });

      // TODO: track recipient email failure to rate limit attempts
      // TODO: track service errors to rate limit attempts
      return false;
    }
  }

  /// Deletes entries that exceeded the maximum attempt count.
  ///
  /// Returns the number of deleted entries.
  Future<int> deleteDeadOutgoingEmails() async {
    final stats = await _db.deleteWithQuery<OutgoingEmail>(
      _db.query<OutgoingEmail>(),
      where: (m) => m.isNotAlive,
      beforeDelete: (list) {
        for (final m in list) {
          _logger.warning('Removing dead outgoing email: ${m.id} to '
              '${m.recipientEmail} with last error: ${m.lastError}.');
        }
      },
    );
    return stats.deleted;
  }
}
