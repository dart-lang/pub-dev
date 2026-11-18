// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_dev/shared/utils.dart';
import 'package:typed_sql/typed_sql.dart';

import '../../shared/datastore.dart';
import 'email_sender.dart';
import 'email_templates.dart';
import 'models.dart';

final _logger = Logger('email.backend');
final _random = Random.secure();

/// The maximum number of pending rows to load in a single batch when
/// scanning for outgoing emails to send.
const _maxOutgoingEmailBatchSize = 1000;

/// The minimum age a Datastore [OutgoingEmail] entity must have before
/// [EmailBackend.migrateFromDatastore] will pick it up for SQL migration.
const _minBatchMigrationAge = Duration(minutes: 1);

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
      bodyHtml: msg.bodyHtml,
    );
  }

  /// Queries all pending [OutgoingEmail] rows in SQL and tries to send out
  /// the email, deleting the row after the email was sent successfully. This
  /// method should be called only from the background task.
  ///
  /// This first calls [migrateFromDatastore] to migrate any Datastore entities
  /// left behind into SQL.
  ///
  /// The processing of the query results will be stopped after [stopAfter]
  /// duration has elapsed. This allows the periodic task to complete within
  /// the planned time window.
  ///
  /// Returns the number of successfully sent emails.
  Future<int> trySendAllOutgoingEmails({Duration? stopAfter}) async {
    final sw = Stopwatch()..start();
    await migrateFromDatastore();
    final now = clock.now().toUtc();
    final ids = await primaryDatabase.withRetry(
      (db) => db.outgoingEmails
          .where(
            (e) =>
                e.attempts.lessThanValue(outgoingEmailMaxAttempts) &
                e.pendingAt.isBeforeValue(now) &
                e.claimId.isNull(),
          )
          .orderBy((e) => [(e.createdAt, Order.descending)])
          .select((e) => (e.id,))
          .limit(_maxOutgoingEmailBatchSize)
          .fetch(),
    );
    var successful = 0;
    for (final id in ids) {
      if (stopAfter != null && sw.elapsed > stopAfter) break;
      if (emailSender.shouldBackoff) break;
      successful += await _trySendOutgoingEmail(id);
    }
    return successful;
  }

  /// Tries to send [email]. The [OutgoingEmail] row will be deleted after
  /// the email was sent successfully.
  ///
  /// This method should be called right after the SQL row has been created
  /// (see [migrateToSql]).
  ///
  /// Returns the number of emails that were sent successfully.
  Future<int> trySendOutgoingEmail(OutgoingEmail email) async {
    return await _trySendOutgoingEmail(email.uuid);
  }

  /// Tries to send email with the given [id], working only against the SQL
  /// row (Datastore is no longer consulted at sending time). The row will
  /// be deleted after the email was sent successfully.
  ///
  /// Returns the number of emails that were sent successfully.
  Future<int> _trySendOutgoingEmail(String id) async {
    if (emailSender.shouldBackoff) {
      return 0;
    }
    final now = clock.now().toUtc();
    final claimId = createUuid();
    final claimed = await primaryDatabase.withRetry(
      (db) => db.outgoingEmails
          .where(
            (e) =>
                e.id.equalsValue(id) &
                e.claimId.isNull() &
                e.attempts.lessThanValue(outgoingEmailMaxAttempts),
          )
          .update(
            (row, set) => set(
              attempts: row.attempts + 1.asExpr,
              lastAttemptedAt: now.asExpr,
              // retry after a random delay in the next 2-6 hours, if and
              // only if, claimId has been cleared. We never retry sending
              // emails if we don't know if the email was sent or not
              // (because we don't want to send it multiple times).
              pendingAt: now
                  .add(Duration(hours: 2, minutes: _random.nextInt(4 * 60)))
                  .asExpr,
              claimId: claimId.asExpr,
            ),
          )
          .returnUpdated()
          .executeAndFetch(),
    );
    if (claimed.isEmpty) {
      return 0;
    }
    final entry = claimed.single;

    final recipientEmails =
        ((entry.recipientEmailsJson.value as List?) ?? const <Object?>[])
            .cast<String>();
    final sent = <String>[];
    for (final recipientEmail in recipientEmails) {
      try {
        await emailSender.sendMessage(
          EmailMessage(
            localMessageId: entry.id,
            EmailAddress(entry.fromEmail),
            [EmailAddress(recipientEmail)],
            entry.subject,
            entry.bodyText,
            bodyHtml: entry.bodyHtml,
          ),
        );
        sent.add(recipientEmail);
      } on EmailSenderException catch (e, st) {
        _logger.warning('Email sending failed (claimId="$claimId").', e, st);
      } catch (e, st) {
        _logger.warning('Email sending failed (claimId="$claimId").', e, st);
      }
    }

    final remaining = recipientEmails
        .where((email) => !sent.contains(email))
        .toList();
    final finalized = await primaryDatabase.withRetry((db) {
      final claimedRow = db.outgoingEmails.where(
        (e) => e.id.equalsValue(id) & e.claimId.equalsValue(claimId),
      );
      if (remaining.isEmpty) {
        return claimedRow.delete().returnDeleted().executeAndFetch();
      }
      return claimedRow
          .update(
            (_, set) => set(
              claimId: toExpr(null),
              recipientEmailsJson: JsonValue(remaining).asExpr,
            ),
          )
          .returnUpdated()
          .executeAndFetch();
    });
    if (finalized.isEmpty) {
      _logger.shout(
        'OutgoingEmail row was removed or its claim changed while sending '
        'emails (claimId="$claimId").',
      );
    }
    return sent.length;
  }

  /// Deletes entries that exceeded the maximum attempt count or have an
  /// expired claim.
  ///
  /// Returns the number of deleted entries.
  Future<int> deleteDeadOutgoingEmails() async {
    final deleted = await primaryDatabase.withRetry(
      (db) => db.outgoingEmails
          .where(
            (e) =>
                e.attempts.greaterThanOrEqualValue(outgoingEmailMaxAttempts) |
                (e.claimId.isNotNull() &
                    e.lastAttemptedAt
                        .orElse(e.createdAt)
                        .isBeforeValue(
                          clock.now().toUtc().subtract(
                            outgoingEmailClaimExpiration,
                          ),
                        )),
          )
          .delete()
          .returnDeleted()
          .executeAndFetch(),
    );

    for (final m in deleted) {
      _logger.warning(
        'Removing dead outgoing email: ${m.id} to '
        '${(m.recipientEmailsJson.value as List?)?.join(', ')}. '
        '(claimId="${m.claimId}")',
      );
    }

    return deleted.length;
  }

  /// Migrates [email] into SQL, and deletes the Datastore entity.
  ///
  /// This should be called right after [email] has been (or would have been)
  /// written to Datastore, so that SQL becomes the sole store for it.
  Future<void> migrateToSql(OutgoingEmail email) async {
    await primaryDatabase.transactWithRetry(
      (db) => db.outgoingEmails
          .upsertValue(
            id: email.uuid,
            createdAt: email.created!,
            attempts: email.attempts,
            lastAttemptedAt: email.lastAttempted,
            claimId: email.claimId,
            pendingAt: email.pendingAt!,
            fromEmail: email.fromEmail!,
            recipientEmailsJson: JsonValue(email.recipientEmails),
            subject: email.subject!,
            bodyText: email.bodyText!,
            bodyHtml: email.bodyHtml!,
          )
          .execute(),
    );
    await withRetryTransaction(_db, (tx) async => tx.delete(email.key));
  }

  /// Migrates [OutgoingEmail] entries found in Datastore into SQL, deleting
  /// each Datastore entity after it has been migrated.
  ///
  /// Only entities created more than [_minBatchMigrationAge] ago are considered,
  /// so that this sweep never races with the eager calls made inline with
  /// Datastore transactions.
  ///
  /// This is a best-effort cleanup of stragglers that were not migrated
  /// eagerly (e.g. because the process died between the SQL write and the
  /// Datastore delete), and is expected to be called periodically.
  Future<int> migrateFromDatastore() async {
    final cutoff = clock.now().toUtc().subtract(_minBatchMigrationAge);
    final query = _db.query<OutgoingEmail>()..filter('created <', cutoff);
    var count = 0;
    await for (final email in query.run()) {
      await migrateToSql(email);
      count++;
    }
    return count;
  }
}
