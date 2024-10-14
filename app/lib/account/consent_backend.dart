// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/account_api.dart' as api;
import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:retry/retry.dart';

import '../account/agent.dart';
import '../audit/models.dart';
import '../frontend/templates/consent.dart';
import '../package/backend.dart';
import '../publisher/backend.dart';
import '../service/email/backend.dart';
import '../shared/datastore.dart';
import '../shared/email.dart' show createInviteEmail;
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
  final _actions = <String, ConsentAction>{
    ConsentKind.packageUploader: _PackageUploaderAction(),
    ConsentKind.publisherContact: _PublisherContactAction(),
    ConsentKind.publisherMember: _PublisherMemberAction(),
  };

  ConsentBackend(this._db);

  /// Returns the consent details.
  Future<api.Consent> getConsent(String consentId, User user) async {
    InvalidInputException.checkUlid(consentId, 'consentId');
    final c = await _lookupAndCheck(consentId, user);
    final action = _actions[c.kind]!;
    final fromAgent = c.fromAgent!;
    late String invitingUserEmail;
    if (looksLikeUserId(fromAgent)) {
      invitingUserEmail = (await accountBackend.getEmailOfUserId(fromAgent))!;
    } else {
      invitingUserEmail = fromAgent;
    }
    return api.Consent(
      titleText: action.renderInviteTitleText(invitingUserEmail, c.args!),
      descriptionHtml: action.renderInviteHtml(
        invitingUserEmail: invitingUserEmail,
        args: c.args!,
        currentUserEmail: user.email!,
      ),
    );
  }

  /// Returns the consent details for API calls.
  Future<api.Consent> handleGetConsent(String consentId) async {
    final authenticatedUser = await requireAuthenticatedWebUser();
    return getConsent(consentId, authenticatedUser.user);
  }

  /// Resolves the consent.
  Future<api.ConsentResult> resolveConsent(
      String consentId, api.ConsentResult result) async {
    InvalidInputException.checkUlid(consentId, 'consentId');
    final authenticatedUser = await requireAuthenticatedWebUser();
    final user = authenticatedUser.user;

    final c = await _lookupAndCheck(consentId, user);
    InvalidInputException.checkNotNull(result.granted, 'granted');
    if (result.granted) {
      await _delete(c, (a) => a.onAccept(c));
      return api.ConsentResult(granted: true);
    } else {
      await _delete(c, (a) => a.onReject(c, user));
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
      final query = _db.query<Consent>()..filter('dedupId =', dedupId);
      final list = await query.run().toList();
      if (list.isNotEmpty) {
        final old = list.first;
        if (old.isExpired()) {
          // expired entries should be deleted
          await _delete(old, (a) => a.onExpire(old));
        } else if (old.shouldNotify()) {
          // non-expired entries just re-send the notification
          return await _sendNotification(activeAgent.displayId, old);
        } else {
          return api.InviteStatus(
              emailSent: false, nextNotification: old.nextNotification);
        }
      }
      // Create a new entry.
      final consent = Consent.init(
        fromAgent: activeAgent.agentId,
        email: email,
        kind: kind,
        args: args,
      );
      await _db.commit(inserts: [
        consent,
        auditLogRecord,
      ]);
      return await _sendNotification(activeAgent.displayId, consent);
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
          user: user, publisherId: publisherId, contactEmail: contactEmail),
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
      String activeUserEmail, Consent consent) async {
    final invitedEmail = consent.email!;
    final action = _actions[consent.kind]!;
    final email = emailBackend.prepareEntity(createInviteEmail(
      invitedEmail: invitedEmail,
      subject: action.renderEmailSubject(consent.args!),
      inviteText: action.renderInviteText(activeUserEmail, consent.args!),
      consentUrl: consentUrl(consent.consentId),
    ));
    final status = await withRetryTransaction(_db, (tx) async {
      final c = await tx.lookupValue<Consent>(consent.key);
      c.notificationCount++;
      c.lastNotified = clock.now().toUtc();
      tx.insert(c);
      tx.insert(email);
      return api.InviteStatus(
          emailSent: true, nextNotification: c.nextNotification);
    });
    await emailBackend.trySendOutgoingEmail(email);
    return status;
  }

  /// Removes obsolete/expired [Consent] entries from Datastore.
  Future<void> deleteObsoleteConsents() async {
    final query = _db.query<Consent>()
      ..filter('expires <', clock.now().toUtc());
    await for (final entry in query.run()) {
      try {
        await _delete(entry, (a) => a.onExpire(entry));
      } catch (e) {
        _logger.shout(
            'Delete failed: ${entry.consentId} ${entry.kind} ${entry.args}', e);
      }
    }
  }

  /// Returns the [Consent] for [consentId] and checks if it is for [user].
  Future<Consent> _lookupAndCheck(String consentId, User user) async {
    final key = _db.emptyKey.append(Consent, id: consentId);
    final c = await _db.lookupOrNull<Consent>(key);
    if (c == null) {
      throw NotFoundException.resource('consent: $consentId');
    }
    final action = _actions[c.kind]!;
    if (!action.permitConfirmationWithOtherEmail && c.email != null) {
      InvalidInputException.check(
          c.email?.toLowerCase() == user.email?.toLowerCase(),
          'This invitation is not for the user account currently logged in.');
    }
    return c;
  }

  Future<void> _delete(
    Consent consent,
    Future Function(ConsentAction action) fn,
  ) async {
    final action = _actions[consent.kind];
    await retry(
      () async {
        if (action != null) await fn(action);
        await withRetryTransaction(_db, (tx) async {
          final c = await tx.lookupOrNull<Consent>(consent.key);
          if (c != null) tx.delete(c.key);
        });
      },
      maxAttempts: 3,
    );
  }
}

/// Callback that will be called on consent actions.
abstract class ConsentAction {
  /// Callback on accepting the consent.
  Future<void> onAccept(Consent consent);

  /// Callback on rejecting the consent.
  Future<void> onReject(Consent consent, User? user);

  /// Callback on timeout of the consent.
  Future<void> onExpire(Consent consent);

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
  @override
  Future<void> onAccept(Consent consent) async {
    final packageName = consent.args![0];
    final currentUser = await requireAuthenticatedWebUser();
    if (currentUser.email?.toLowerCase() != consent.email?.toLowerCase()) {
      throw NotAcceptableException(
          'Current user and consent user does not match.');
    }

    await packageBackend.confirmUploader(
      packageName,
      currentUser.user,
      consentRequestFromAgent: consent.fromAgent!,
    );
  }

  @override
  Future<void> onReject(Consent consent, User? user) async {
    final packageName = consent.args![0];
    await withRetryTransaction(dbService, (tx) async {
      tx.insert(await AuditLogRecord.uploaderInviteRejected(
        fromAgent: consent.fromAgent,
        package: packageName,
        uploaderEmail: user?.email ?? consent.email!,
        userId: user?.userId,
      ));
    });
  }

  @override
  Future<void> onExpire(Consent consent) async {
    final packageName = consent.args![0];
    await withRetryTransaction(dbService, (tx) async {
      tx.insert(await AuditLogRecord.uploaderInviteExpired(
        fromAgent: consent.fromAgent,
        package: packageName,
        uploaderEmail: consent.email!,
      ));
    });
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
  @override
  Future<void> onAccept(Consent consent) async {
    final publisherId = consent.args![0];
    final contactEmail = consent.args![1];
    await publisherBackend.updateContactWithVerifiedEmail(
      publisherId,
      contactEmail,
      consentRequestFromAgent: consent.fromAgent!,
    );
  }

  @override
  Future<void> onReject(Consent consent, User? user) async {
    final publisherId = consent.args![0];
    await withRetryTransaction(dbService, (tx) async {
      tx.insert(await AuditLogRecord.publisherContactInviteRejected(
        fromAgent: consent.fromAgent,
        publisherId: publisherId,
        contactEmail: consent.email!,
        userEmail: user?.email,
        userId: user?.userId,
      ));
    });
  }

  @override
  Future<void> onExpire(Consent consent) async {
    final publisherId = consent.args![0];
    await withRetryTransaction(dbService, (tx) async {
      tx.insert(await AuditLogRecord.publisherContactInviteExpired(
        fromAgent: consent.fromAgent,
        publisherId: publisherId,
        contactEmail: consent.email!,
      ));
    });
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
  @override
  Future<void> onAccept(Consent consent) async {
    final publisherId = consent.args![0];
    final currentUser = await requireAuthenticatedWebUser();
    if (consent.email?.toLowerCase() != currentUser.email?.toLowerCase()) {
      throw NotAcceptableException('Consent is not for the current user.');
    }
    await publisherBackend.inviteConsentGranted(
      publisherId,
      currentUser.userId,
      consentRequestFromAgent: consent.fromAgent!,
    );
  }

  @override
  Future<void> onReject(Consent consent, User? user) async {
    final publisherId = consent.args![0];
    await withRetryTransaction(dbService, (tx) async {
      tx.insert(await AuditLogRecord.publisherMemberInviteRejected(
        fromAgent: consent.fromAgent,
        publisherId: publisherId,
        memberEmail: user?.email ?? consent.email!,
        userId: user?.userId,
      ));
    });
  }

  @override
  Future<void> onExpire(Consent consent) async {
    final publisherId = consent.args![0];
    await withRetryTransaction(dbService, (tx) async {
      tx.insert(await AuditLogRecord.publisherMemberInviteExpired(
        fromAgent: consent.fromAgent,
        publisherId: publisherId,
        memberEmail: consent.email!,
      ));
    });
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
