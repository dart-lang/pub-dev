// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:pub_dev/shared/utils.dart';

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

  /// Creates [OutgoingEmail] entity that can be stored alongside a transaction.
  OutgoingEmail prepareEntity(EmailMessage msg) {
    final recipientEmails = msg.recipients.map((e) => e.email).toList();
    return OutgoingEmail.init(
      fromEmail: msg.from.email,
      recipientEmails: recipientEmails,
      subject: msg.subject,
      bodyText: msg.bodyText,
    );
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
      final count = await _trySendOutgoingEmail(m.uuid);
      successful += count;
    }
    return successful;
  }

  /// Tries to send [email]. The [OutgoingEmail] entry will be deleted after
  /// the email was sent successfully.
  ///
  /// This method should be called right after the entries
  /// are saved in the Datastore.
  Future<void> trySendOutgoingEmail(OutgoingEmail email) async {
    await _trySendOutgoingEmail(email.uuid);
  }

  /// Tries to send email with the given [id]. The
  /// [OutgoingEmail] entry will be deleted after the
  /// email was sent successfully.
  ///
  /// Returns the number of emails that were sent successfully.
  Future<int> _trySendOutgoingEmail(String id) async {
    final key = _db.emptyKey.append(OutgoingEmail, id: id);
    final now = clock.now().toUtc();
    final claimId = createUuid();
    final entry = await withRetryTransaction(_db, (tx) async {
      final o = await tx.lookupOrNull<OutgoingEmail>(key);
      if (o == null || o.isNotAlive || o.claimId != null) {
        return null;
      }
      o.attempts++;
      o.lastAttempted = now;
      // retry after a random delay in the next 2-6 hours
      o.pendingAt =
          now.add(Duration(hours: 2, minutes: _random.nextInt(4 * 60)));
      o.claimId = claimId;
      tx.insert(o);
      return o;
    });
    if (entry == null) {
      return 0;
    }

    final recipientEmails = entry.recipientEmails ?? const <String>[];
    final sent = <String>[];
    for (final recipientEmail in recipientEmails) {
      try {
        await emailSender.sendMessage(EmailMessage(
          uuid: entry.uuid,
          EmailAddress(entry.fromEmail!),
          [EmailAddress(recipientEmail)],
          entry.subject!,
          entry.bodyText!,
        ));
        sent.add(recipientEmail);
      } catch (e, st) {
        _logger.warning('Email sending failed (claimId="$claimId").', e, st);
      }
    }

    await withRetryTransaction(_db, (tx) async {
      final o = await tx.lookupOrNull<OutgoingEmail>(key);
      if (o == null || o.claimId != claimId) {
        return;
      }
      for (final email in sent) {
        o.recipientEmails?.remove(email);
      }
      if (o.recipientEmails?.isEmpty ?? false) {
        tx.delete(key);
      } else {
        o.claimId = null;
        tx.insert(o);
      }
    });
    return sent.length;
  }

  /// Deletes entries that exceeded the maximum attempt count.
  ///
  /// Returns the number of deleted entries.
  Future<int> deleteDeadOutgoingEmails() async {
    final stats = await _db.deleteWithQuery<OutgoingEmail>(
      _db.query<OutgoingEmail>(),
      where: (m) => m.isNotAlive || m.hasExpiredClaim,
      beforeDelete: (list) {
        for (final m in list) {
          _logger.warning('Removing dead outgoing email: ${m.id} to '
              '${m.recipientEmails?.join(', ')}. (claimId="${m.claimId}")');
        }
      },
    );
    return stats.deleted;
  }
}
