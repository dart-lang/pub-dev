// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/account_api.dart' as api;
import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/shared/redis_cache.dart';
import 'package:retry/retry.dart';
import 'package:typed_sql/typed_sql.dart' hide Query;

import '../account/agent.dart';
import '../audit/backend.dart';
import '../audit/models.dart';
import '../frontend/templates/consent.dart';
import '../package/backend.dart';
import '../publisher/backend.dart';
import '../service/email/backend.dart';
import '../service/email/email_templates.dart' show createInviteEmail;
import '../shared/datastore.dart';
import '../shared/exceptions.dart';
import '../shared/urls.dart';
import 'backend.dart';
import 'models.dart';

final _logger = Logger('pub.consent.backend');

/// Sets the consent backend service.
void registerConsentBackend(ConsentBackend backend) =>
    ss.register(#_consentBackend, backend);

/// The active consent backend service.
ConsentBackend get consentBackend =>
    ss.lookup(#_consentBackend) as ConsentBackend;

/// List of consent kinds.
abstract class ConsentKind {
  /// Invite a new uploader to a package.
  static const packageUploader = 'PackageUploader';

  /// Request permission to use e-mail as publisher contact.
  static const publisherContact = 'PublisherContact';

  /// Invite a new member to a publisher.
  static const publisherMember = 'PublisherMember';
}

/// Represents the backend for the consent handling and authentication.
class ConsentBackend {
  final DatastoreDB _db;
  late final _actions = <String, ConsentAction>{
    ConsentKind.packageUploader: _PackageUploaderAction(_db),
    ConsentKind.publisherContact: _PublisherContactAction(_db),
    ConsentKind.publisherMember: _PublisherMemberAction(_db),
  };

  ConsentBackend(this._db);

  /// Returns the consent details.
  Future<api.Consent> getConsent(String consentId, String userEmail) async {
    InvalidInputException.checkUlid(consentId, 'consentId');
    final c = await _lookupAndCheck(consentId, userEmail);
    final action = _actions[c.kind]!;
    final fromAgent = c.fromAgent;
    final String invitingUserEmail;
    if (looksLikeUserId(fromAgent)) {
      invitingUserEmail = (await accountBackend.getEmailOfUserId(fromAgent))!;
    } else {
      invitingUserEmail = fromAgent;
    }
    return api.Consent(
      titleText: action.renderInviteTitleText(invitingUserEmail, c.args),
      descriptionHtml: action.renderInviteHtml(
        invitingUserEmail: invitingUserEmail,
        args: c.args,
        currentUserEmail: userEmail,
      ),
    );
  }

  /// Returns the consent details for API calls.
  Future<api.Consent> handleGetConsent(String consentId) async {
    final authenticatedUser = await requireAuthenticatedWebUser();
    return getConsent(consentId, authenticatedUser.email!);
  }

  /// Resolves the consent.
  Future<api.ConsentResult> resolveConsent(
    String consentId,
    api.ConsentResult result,
  ) async {
    InvalidInputException.checkUlid(consentId, 'consentId');
    final authenticatedUser = await requireAuthenticatedWebUser();
    final c = await _lookupAndCheck(consentId, authenticatedUser.email);
    InvalidInputException.checkNotNull(result.granted, 'granted');
    if (result.granted) {
      await _delete(c, (a) => a.onAccept(c));
      return api.ConsentResult(granted: true);
    } else {
      await _delete(
        c,
        (a) => a.onReject(
          c,
          userId: authenticatedUser.userId,
          userEmail: authenticatedUser.email,
        ),
      );
      return api.ConsentResult(granted: false);
    }
  }

  /// Create a new invitation, or
  /// - if it already exists, re-send the notification, or
  /// - if it was sent recently, do nothing.
  Future<api.InviteStatus> _invite({
    required AuthenticatedAgent activeAgent,
    required String email,
    required String kind,
    required List<String> args,
    required AuditLogRecord auditLogRecord,
  }) async {
    return retry(() async {
      // First check for existing consents with identical dedupId.
      final dedupId = consentDedupId(
        fromAgentId: activeAgent.agentId,
        email: email,
        kind: kind,
        args: args,
      );
      ConsentRow? existing;

      final dedupCacheEntry = cache.consentDedupLookup(dedupId);
      final cachedConsentId = await dedupCacheEntry.get();
      if (cachedConsentId != null) {
        existing = await _lookup(cachedConsentId);
      }
      existing ??= await _lookupByDedupId(dedupId);
      if (existing != null) {
        if (existing.isExpired()) {
          // expired entries should be deleted
          await _delete(existing, (a) => a.onExpire(existing!));
        } else if (existing.shouldNotify()) {
          // non-expired entries just re-send the notification
          return await _sendNotification(activeAgent.displayId, existing.id);
        } else {
          // completes an interrupted creation
          await _writeCopy(existing);
          return api.InviteStatus(
            emailSent: false,
            nextNotification: existing.nextNotification,
          );
        }
      }
      // Create a new entry.
      final consent = Consent.init(
        fromAgent: activeAgent.agentId,
        email: email,
        kind: kind,
        args: args,
      );
      await primaryDatabase.transactWithRetry((db) async {
        await _insertIntoSql(db, consent);
        await auditBackend.upsertIntoSql(db, auditLogRecord);
      });
      // The copy must exist before the dedup cache entry is set, otherwise
      // the previous release may look up the consent and remove its SQL row.
      await _db.commit(inserts: [consent]);
      await dedupCacheEntry.set(consent.consentId);
      return await _sendNotification(activeAgent.displayId, consent.consentId);
    });
  }

  /// Invites a new uploader to the package.
  Future<api.InviteStatus> invitePackageUploader({
    required AuthenticatedAgent agent,
    required String packageName,
    required String uploaderEmail,
  }) async {
    return await _invite(
      activeAgent: agent,
      email: uploaderEmail,
      kind: ConsentKind.packageUploader,
      args: [packageName],
      auditLogRecord: await AuditLogRecord.uploaderInvited(
        agent: agent,
        package: packageName,
        uploaderEmail: uploaderEmail,
      ),
    );
  }

  /// Invites a new contact email for the publisher.
  Future<api.InviteStatus> invitePublisherContact({
    required String publisherId,
    required String contactEmail,
  }) async {
    final authenticatedUser = await requireAuthenticatedWebUser();
    final user = authenticatedUser.user;
    return await _invite(
      activeAgent: authenticatedUser,
      email: contactEmail,
      kind: ConsentKind.publisherContact,
      args: [publisherId, contactEmail],
      auditLogRecord: await AuditLogRecord.publisherContactInvited(
        userId: user.userId,
        userEmail: user.email,
        publisherId: publisherId,
        contactEmail: contactEmail,
      ),
    );
  }

  /// Invites a new member for the publisher.
  Future<api.InviteStatus> invitePublisherMember({
    required AuthenticatedAgent authenticatedAgent,
    required String publisherId,
    required String invitedUserEmail,
  }) async {
    return await _invite(
      activeAgent: authenticatedAgent,
      email: invitedUserEmail,
      kind: ConsentKind.publisherMember,
      args: [publisherId],
      auditLogRecord: await AuditLogRecord.publisherMemberInvited(
        agent: authenticatedAgent,
        publisherId: publisherId,
        memberEmail: invitedUserEmail,
      ),
    );
  }

  Future<api.InviteStatus> _sendNotification(
    String activeUserEmail,
    String consentId,
  ) async {
    final (status, email, updated) = await primaryDatabase.transactWithRetry((
      db,
    ) async {
      final current = await db.consents.byKey(consentId).fetch();
      if (current == null) {
        throw NotFoundException.resource('consent: $consentId');
      }
      final notSent = (
        api.InviteStatus(
          emailSent: false,
          nextNotification: current.nextNotification,
        ),
        null,
        current,
      );
      if (!current.shouldNotify()) {
        return notSent;
      }
      // Guarded by the observed notificationCount: if a concurrent request
      // has already notified, nothing is updated and no email is sent.
      final updatedRows = await db.consents
          .where(
            (c) =>
                c.id.equalsValue(consentId) &
                c.notificationCount.equalsValue(current.notificationCount),
          )
          .update(
            (c, set) => set(
              notificationCount: c.notificationCount + 1.asExpr,
              lastNotifiedAt: clock.now().toUtc().asExpr,
            ),
          )
          .returnUpdated()
          .executeAndFetch();
      final row = updatedRows.firstOrNull;
      if (row == null) {
        return notSent;
      }
      final action = _actions[row.kind]!;
      final email = emailBackend.prepareEntity(
        createInviteEmail(
          invitedEmail: row.email,
          subject: action.renderEmailSubject(row.args),
          inviteText: action.renderInviteText(activeUserEmail, row.args),
          consentUrl: consentUrl(row.id),
        ),
      );
      await emailBackend.insertIntoSql(db, email);
      return (
        api.InviteStatus(
          emailSent: true,
          nextNotification: row.nextNotification,
        ),
        email,
        row,
      );
    });
    await _writeCopy(updated);
    if (email != null) {
      await emailBackend.trySendOutgoingEmail(email);
    }
    return status;
  }

  /// Removes obsolete/expired [Consent] entries.
  Future<void> deleteObsoleteConsents() async {
    await _migrateQuery(
      _db.query<Consent>()..filter('expires <', clock.now().toUtc()),
    );
    final rows = await primaryDatabase.withRetry(
      (db) => db.consents
          .where((c) => c.expiresAt.isBeforeValue(clock.now().toUtc()))
          .fetch(),
    );
    for (final row in rows) {
      try {
        await _delete(row, (a) => a.onExpire(row));
      } catch (e) {
        _logger.shout('Delete failed: ${row.id} ${row.kind} ${row.args}', e);
      }
    }
  }

  /// Returns the [Consent] for [consentId] and checks if it is for [userEmail].
  Future<ConsentRow> _lookupAndCheck(
    String consentId,
    String? userEmail,
  ) async {
    final c = await _lookup(consentId);
    if (c == null) {
      throw NotFoundException.resource('consent: $consentId');
    }
    final action = _actions[c.kind]!;
    if (!action.permitConfirmationWithOtherEmail) {
      // NOTE: the message must not reveal the invited email address, as it
      //       may be shown to a user that is not the intended recipient.
      InvalidInputException.check(
        c.email.toLowerCase() == userEmail?.toLowerCase(),
        'This invitation is not for the user account currently logged in '
        '(`$userEmail`).\n'
        'Invitations must be sent to the primary email address of a Google '
        'Account (email aliases are not supported).\n'
        'Sign in with the account the invitation was sent to, or ask the '
        'inviter to send a new invitation to `$userEmail`.',
      );
    }
    return c;
  }

  /// Returns the [ConsentRow] with [consentId].
  ///
  /// A Datastore entity without a SQL row (e.g. created by the previous
  /// release) is copied into SQL first.
  Future<ConsentRow?> _lookup(String consentId) async {
    final key = _db.emptyKey.append(Consent, id: consentId);
    final consent = await _db.lookupOrNull<Consent>(key);
    if (consent != null) {
      await _migrateFromDatastoreToSql(consent);
    }
    return await primaryDatabase.withRetry(
      (db) => db.consents.byKey(consentId).fetch(),
    );
  }

  /// Returns the [ConsentRow] with [dedupId].
  ///
  /// The matching Datastore entities without a SQL row are copied first.
  Future<ConsentRow?> _lookupByDedupId(String dedupId) async {
    await _migrateQuery(_db.query<Consent>()..filter('dedupId =', dedupId));
    return await primaryDatabase.withRetry(
      (db) => db.consents.byDedupId(dedupId).fetch(),
    );
  }

  Future<void> _delete(
    ConsentRow consent,
    Future Function(ConsentAction action) fn,
  ) async {
    final action = _actions[consent.kind];
    await retry(() async {
      if (action != null) await fn(action);
      // The Datastore copy is removed first, otherwise the previous release could
      // re-create the SQL row from it.
      await _db.commit(deletes: [_db.emptyKey.append(Consent, id: consent.id)]);
      await primaryDatabase.withRetry(
        (db) => db.consents.byKey(consent.id).delete().execute(),
      );
    }, maxAttempts: 3);
  }

  /// Inserts the new [consent] into SQL, failing if the id or dedupId exists.
  Future<void> _insertIntoSql(Database<PrimarySchema> db, Consent consent) => db
      .consents
      .insertValue(
        id: consent.consentId,
        email: consent.email!,
        dedupId: consent.dedupId!,
        kind: consent.kind!,
        argsJson: JsonValue(consent.args),
        fromAgent: consent.fromAgent!,
        createdAt: consent.created!,
        expiresAt: consent.expires!,
        lastNotifiedAt: consent.lastNotified,
        notificationCount: consent.notificationCount,
      )
      .execute();

  /// Writes the legacy [Consent] Datastore entity as a copy of the SQL [row].
  ///
  /// The SQL row is the source of truth. The previous release treats Datastore
  /// as the source of truth: it overwrites the SQL row from the entity, and
  /// removes the SQL row when the entity is missing.
  ///
  /// TODO: remove after the previous release is no longer running.
  Future<void> _writeCopy(ConsentRow row) async {
    final entity = Consent()
      ..id = row.id
      ..email = row.email
      ..dedupId = row.dedupId
      ..kind = row.kind
      ..args = row.args
      ..fromAgent = row.fromAgent
      ..created = row.createdAt
      ..expires = row.expiresAt
      ..lastNotified = row.lastNotifiedAt
      ..notificationCount = row.notificationCount;
    await _db.commit(inserts: [entity]);
  }

  /// Copies a Datastore [Consent] into SQL if there is no SQL row yet.
  Future<void> _migrateFromDatastoreToSql(Consent consent) async {
    final existing = await primaryDatabase.withRetry(
      (db) => db.consents.byKey(consent.consentId).fetch(),
    );
    if (existing != null) {
      return;
    }
    await primaryDatabase.transactWithRetry(
      (db) => db.consents
          .insertValue(
            id: consent.consentId,
            email: consent.email!,
            dedupId: consent.dedupId!,
            kind: consent.kind!,
            argsJson: JsonValue(consent.args),
            fromAgent: consent.fromAgent!,
            createdAt: consent.created!,
            expiresAt: consent.expires!,
            lastNotifiedAt: consent.lastNotified,
            notificationCount: consent.notificationCount,
          )
          .onConflict(.primaryKey)
          .doNothing()
          .execute(),
    );
    // The consent may have been resolved (and removed from both stores) after
    // the entity was read: do not leave a resurrected SQL row behind.
    final key = _db.emptyKey.append(Consent, id: consent.consentId);
    if (await _db.lookupOrNull<Consent>(key) == null) {
      await primaryDatabase.withRetry(
        (db) => db.consents.byKey(consent.consentId).delete().execute(),
      );
    }
  }

  /// Copies [Consent] entries older than [minAge] from Datastore into SQL, if
  /// they have no SQL row yet. The entities are kept as copies.
  Future<int> migrateFromDatastore({
    Duration minAge = const Duration(minutes: 1),
  }) async {
    final cutoff = clock.now().toUtc().subtract(minAge);
    return await _migrateQuery(
      _db.query<Consent>()..filter('created <', cutoff),
    );
  }

  /// Copies the [Consent] entries matching [query] from Datastore into SQL.
  ///
  /// Returns the number of migrated entries.
  Future<int> _migrateQuery(Query<Consent> query) async {
    var count = 0;
    await for (final consent in query.run()) {
      await _migrateFromDatastoreToSql(consent);
      count++;
    }
    return count;
  }

  /// Updates the `fromAgent` of the consents sent by [fromUserId] to
  /// [toUserId].
  Future<void> updateFromAgent(String fromUserId, String toUserId) async {
    await _migrateQuery(
      _db.query<Consent>()..filter('fromAgent =', fromUserId),
    );
    final updated = await primaryDatabase.transactWithRetry(
      (db) => db.consents
          .where((c) => c.fromAgent.equalsValue(fromUserId))
          .update((_, set) => set(fromAgent: toUserId.asExpr))
          .returnUpdated()
          .executeAndFetch(),
    );
    for (final row in updated) {
      await _writeCopy(row);
    }
  }
}

extension on ConsentRow {
  List<String> get args => (argsJson.value as List).cast<String>();

  bool isExpired() => clock.now().toUtc().isAfter(expiresAt);

  /// The timestamp when the next notification could be sent out.
  DateTime get nextNotification => (lastNotifiedAt ?? createdAt).add(
    Duration(minutes: 1 << notificationCount),
  );

  /// Whether a new notification should be sent.
  bool shouldNotify() =>
      notificationCount == 0 || clock.now().toUtc().isAfter(nextNotification);
}

/// Callback that will be called on consent actions.
abstract class ConsentAction {
  /// Callback on accepting the consent.
  Future<void> onAccept(ConsentRow consent);

  /// Callback on rejecting the consent.
  Future<void> onReject(
    ConsentRow consent, {
    String? userId,
    String? userEmail,
  });

  /// Callback on timeout of the consent.
  Future<void> onExpire(ConsentRow consent);

  /// Whether the user accepting the consent can have a different e-mail than
  /// the one the consent request was sent to.
  bool get permitConfirmationWithOtherEmail => false;

  /// The subject of the notification email sent.
  String renderEmailSubject(List<String> args) =>
      'You have a new invitation to confirm on $primaryHost';

  /// The body of the notification email sent.
  String renderInviteText(String invitingUserEmail, List<String> args);

  /// The title of the invite for use in list of invites, and headline when
  /// viewing a specific invite.
  String renderInviteTitleText(String invitingUserEmail, List<String> args);

  /// The HTML-formatted invitation message.
  ///
  /// This message should explain what accepting this invite implies. Who can
  /// see the user, what gets shared, how will user figure in permission
  /// history, and what permissions will the user be granted.
  ///
  /// If the current session is unauthenticated, [currentUserEmail] will be null.
  String renderInviteHtml({
    required String invitingUserEmail,
    required List<String> args,
    required String currentUserEmail,
  });
}

/// Callbacks for package uploader consents.
class _PackageUploaderAction extends ConsentAction {
  final DatastoreDB _db;
  _PackageUploaderAction(this._db);

  @override
  Future<void> onAccept(ConsentRow consent) async {
    final packageName = consent.args[0];
    final currentUser = await requireAuthenticatedWebUser();
    if (currentUser.email?.toLowerCase() != consent.email.toLowerCase()) {
      throw NotAcceptableException(
        'Current user and consent user does not match.',
      );
    }

    await packageBackend.confirmUploader(
      packageName,
      currentUser.userId,
      currentUser.email,
      consentRequestFromAgent: consent.fromAgent,
    );
  }

  @override
  Future<void> onReject(
    ConsentRow consent, {
    String? userId,
    String? userEmail,
  }) async {
    final packageName = consent.args[0];
    final record = await AuditLogRecord.uploaderInviteRejected(
      fromAgent: consent.fromAgent,
      package: packageName,
      uploaderEmail: userEmail ?? consent.email,
      userId: userId,
    );
    await withRetryTransaction(_db, (tx) async {
      tx.insert(record);
    });
    await auditBackend.migrateToSql(record);
  }

  @override
  Future<void> onExpire(ConsentRow consent) async {
    final packageName = consent.args[0];
    final record = await AuditLogRecord.uploaderInviteExpired(
      fromAgent: consent.fromAgent,
      package: packageName,
      uploaderEmail: consent.email,
    );
    await withRetryTransaction(_db, (tx) async {
      tx.insert(record);
    });
    await auditBackend.migrateToSql(record);
  }

  @override
  String renderInviteText(String invitingUserEmail, List<String> args) {
    final packageName = args[0];
    return '$invitingUserEmail has invited you to be an uploader of the package $packageName.';
  }

  @override
  String renderInviteTitleText(String invitingUserEmail, List<String> args) {
    final packageName = args[0];
    return 'Invitation for package: $packageName';
  }

  @override
  String renderInviteHtml({
    required String invitingUserEmail,
    required List<String> args,
    required String currentUserEmail,
  }) {
    final packageName = args[0];
    return renderPackageUploaderInvite(
      invitingUserEmail: invitingUserEmail,
      packageName: packageName,
      currentUserEmail: currentUserEmail,
    );
  }
}

/// Callbacks for requesting permission to use e-mail as publisher contact.
class _PublisherContactAction extends ConsentAction {
  final DatastoreDB _db;
  _PublisherContactAction(this._db);

  @override
  Future<void> onAccept(ConsentRow consent) async {
    final publisherId = consent.args[0];
    final contactEmail = consent.args[1];
    await publisherBackend.updateContactWithVerifiedEmail(
      publisherId,
      contactEmail,
      consentRequestFromAgent: consent.fromAgent,
    );
  }

  @override
  Future<void> onReject(
    ConsentRow consent, {
    String? userId,
    String? userEmail,
  }) async {
    final publisherId = consent.args[0];
    final record = await AuditLogRecord.publisherContactInviteRejected(
      fromAgent: consent.fromAgent,
      publisherId: publisherId,
      contactEmail: consent.email,
      userEmail: userEmail,
      userId: userId,
    );
    await withRetryTransaction(_db, (tx) async {
      tx.insert(record);
    });
    await auditBackend.migrateToSql(record);
  }

  @override
  Future<void> onExpire(ConsentRow consent) async {
    final publisherId = consent.args[0];
    final record = await AuditLogRecord.publisherContactInviteExpired(
      fromAgent: consent.fromAgent,
      publisherId: publisherId,
      contactEmail: consent.email,
    );
    await withRetryTransaction(_db, (tx) async {
      tx.insert(record);
    });
    await auditBackend.migrateToSql(record);
  }

  @override
  bool get permitConfirmationWithOtherEmail => true;

  @override
  String renderEmailSubject(List<String> args) =>
      'You have a new request to confirm on $primaryHost';

  @override
  String renderInviteText(String invitingUserEmail, List<String> args) {
    final publisherId = args[0];
    final contactEmail = args[1];
    return '$invitingUserEmail has requested to use `$contactEmail` as the '
        'contact email of the verified publisher $publisherId.';
  }

  @override
  String renderInviteTitleText(String invitingUserEmail, List<String> args) {
    final publisherId = args[0];
    return 'Request for publisher: $publisherId';
  }

  @override
  String renderInviteHtml({
    required String invitingUserEmail,
    required List<String> args,
    required String currentUserEmail,
  }) {
    final publisherId = args[0];
    final contactEmail = args[1];
    return renderPublisherContactInvite(
      invitingUserEmail: invitingUserEmail,
      publisherId: publisherId,
      contactEmail: contactEmail,
    );
  }
}

/// Callbacks for publisher member consents.
class _PublisherMemberAction extends ConsentAction {
  final DatastoreDB _db;
  _PublisherMemberAction(this._db);

  @override
  Future<void> onAccept(ConsentRow consent) async {
    final publisherId = consent.args[0];
    final currentUser = await requireAuthenticatedWebUser();
    if (consent.email.toLowerCase() != currentUser.email?.toLowerCase()) {
      throw NotAcceptableException('Consent is not for the current user.');
    }
    await publisherBackend.inviteConsentGranted(
      publisherId,
      currentUser.userId,
      consentRequestFromAgent: consent.fromAgent,
    );
  }

  @override
  Future<void> onReject(
    ConsentRow consent, {
    String? userId,
    String? userEmail,
  }) async {
    final publisherId = consent.args[0];
    final record = await AuditLogRecord.publisherMemberInviteRejected(
      fromAgent: consent.fromAgent,
      publisherId: publisherId,
      memberEmail: userEmail ?? consent.email,
      userId: userId,
    );
    await withRetryTransaction(_db, (tx) async {
      tx.insert(record);
    });
    await auditBackend.migrateToSql(record);
  }

  @override
  Future<void> onExpire(ConsentRow consent) async {
    final publisherId = consent.args[0];
    final record = await AuditLogRecord.publisherMemberInviteExpired(
      fromAgent: consent.fromAgent,
      publisherId: publisherId,
      memberEmail: consent.email,
    );
    await withRetryTransaction(_db, (tx) async {
      tx.insert(record);
    });
    await auditBackend.migrateToSql(record);
  }

  @override
  String renderInviteText(String invitingUserEmail, List<String> args) {
    final publisherId = args[0];
    return '$invitingUserEmail has invited you to be a member of the verified publisher $publisherId.';
  }

  @override
  String renderInviteTitleText(String invitingUserEmail, List<String> args) {
    final publisherId = args[0];
    return 'Invitation for publisher: $publisherId';
  }

  @override
  String renderInviteHtml({
    required String invitingUserEmail,
    required List<String> args,
    required String currentUserEmail,
  }) {
    final publisherId = args[0];
    return renderPublisherMemberInvite(
      invitingUserEmail: invitingUserEmail,
      publisherId: publisherId,
    );
  }
}
