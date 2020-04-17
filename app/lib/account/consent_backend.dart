// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:client_data/account_api.dart' as api;
import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pub_dev/shared/datastore_helper.dart';
import 'package:retry/retry.dart';

import '../frontend/email_sender.dart';
import '../frontend/templates/consent.dart';
import '../package/backend.dart';
import '../publisher/backend.dart';
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
    final action = _actions[c.kind];
    final invitingUserEmail =
        await accountBackend.getEmailOfUserId(c.fromUserId);
    return api.Consent(
      titleText: action.renderInviteTitleText(invitingUserEmail, c.args),
      descriptionHtml: action.renderInviteHtml(
        invitingUserEmail: invitingUserEmail,
        args: c.args,
        currentUserEmail: user.email,
      ),
    );
  }

  /// Returns the consent details for API calls.
  Future<api.Consent> handleGetConsent(String consentId) async {
    final user = await requireAuthenticatedUser();
    return getConsent(consentId, user);
  }

  /// Resolves the consent.
  Future<api.ConsentResult> resolveConsent(
      String consentId, api.ConsentResult result) async {
    InvalidInputException.checkUlid(consentId, 'consentId');
    final user = await requireAuthenticatedUser();

    final c = await _lookupAndCheck(consentId, user);
    InvalidInputException.checkNotNull(result.granted, 'granted');
    if (result.granted) {
      await _accept(c);
      return api.ConsentResult(granted: true);
    } else {
      await _delete(c);
      return api.ConsentResult(granted: false);
    }
  }

  /// Create a new invitation, or
  /// - if it already exists, re-send the notification, or
  /// - if it was sent recently, do nothing.
  Future<api.InviteStatus> _invite({
    @required String userId,
    @required String email,
    @required String kind,
    @required List<String> args,
  }) async {
    return retry(() async {
      final activeUser = await requireAuthenticatedUser();
      // First check for existing consents with identical dedupId.
      final dedupId = consentDedupId(
        fromUserId: activeUser.userId,
        userId: userId,
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
          await _delete(old);
        } else if (old.shouldNotify()) {
          // non-expired entries just re-send the notification
          return await _sendNotification(activeUser.email, old);
        } else {
          return api.InviteStatus(
              emailSent: false, nextNotification: old.nextNotification);
        }
      }
      // Create a new entry.
      final consent = Consent.init(
        fromUserId: activeUser.userId,
        userId: userId,
        email: email,
        kind: kind,
        args: args,
      );
      await _db.commit(inserts: [consent]);
      return await _sendNotification(activeUser.email, consent);
    });
  }

  /// Invites a new uploader to the package.
  Future<api.InviteStatus> invitePackageUploader({
    @required String packageName,
    @required String uploaderUserId,
    @required String uploaderEmail,
  }) async {
    return await _invite(
      userId: uploaderUserId,
      email: uploaderEmail,
      kind: ConsentKind.packageUploader,
      args: [packageName],
    );
  }

  /// Invites a new contact email for the publisher.
  Future<api.InviteStatus> invitePublisherContact({
    @required String publisherId,
    @required String contactEmail,
  }) async {
    return await _invite(
      userId: null,
      email: contactEmail,
      kind: ConsentKind.publisherContact,
      args: [publisherId, contactEmail],
    );
  }

  /// Invites a new member for the publisher.
  Future<api.InviteStatus> invitePublisherMember({
    @required String publisherId,
    @required String invitedUserId,
    @required String invitedUserEmail,
  }) async {
    return await _invite(
      userId: invitedUserId,
      email: invitedUserEmail,
      kind: ConsentKind.publisherMember,
      args: [publisherId],
    );
  }

  Future<api.InviteStatus> _sendNotification(
      String activeUserEmail, Consent consent) async {
    final invitedEmail =
        consent.email ?? await accountBackend.getEmailOfUserId(consent.userId);
    final action = _actions[consent.kind];
    await emailSender.sendMessage(createInviteEmail(
      invitedEmail: invitedEmail,
      subject: action.renderEmailSubject(consent.args),
      inviteText: action.renderInviteText(activeUserEmail, consent.args),
      consentUrl: consentUrl(consent.consentId),
    ));
    return await _db.withTransaction<api.InviteStatus>((tx) async {
      final c = (await tx.lookup<Consent>([consent.key])).single;
      c.notificationCount++;
      c.lastNotified = DateTime.now().toUtc();
      tx.queueMutations(inserts: [c]);
      await tx.commit();
      return api.InviteStatus(
          emailSent: true, nextNotification: c.nextNotification);
    });
  }

  /// Removes obsolete/expired [Consent] entries from Datastore.
  Future<void> deleteObsoleteConsents() async {
    final query = _db.query<Consent>()
      ..filter('expires <', DateTime.now().toUtc());
    await for (var entry in query.run()) {
      try {
        await _delete(entry);
      } catch (e) {
        _logger.shout(
            'Delete failed: ${entry.consentId} ${entry.kind} ${entry.args}', e);
      }
    }
  }

  /// Returns the [Consent] for [consentId] and checks if it is for [user].
  Future<Consent> _lookupAndCheck(String consentId, User user) async {
    final key = _db.emptyKey.append(Consent, id: consentId);
    return await withRetryTransaction(_db, (tx) async {
      final c = await tx.lookupOrNull<Consent>(key);
      if (c == null) {
        throw NotFoundException.resource('consent: $consentId');
      }
      if (c.userId == null && c.email == user.email) {
        c.userId = user.userId;
        tx.insert(c);
      }

      // Checking that consent is for the current user.
      InvalidInputException.check(c.userId == null || c.userId == user.userId,
          'This invitation is not for the user account currently logged in.');
      final action = _actions[c.kind];
      if (!action.permitConfirmationWithOtherEmail && c.email != null) {
        InvalidInputException.check(c.email == user.email,
            'This invitation is not for the user account currently logged in.');
      }
      return c;
    });
  }

  Future<void> _accept(Consent consent) async {
    final action = _actions[consent.kind];
    await retry(
      () async {
        await action?.onAccept(consent);
        await _db.withTransaction((tx) async {
          final c = (await tx.lookup<Consent>([consent.key])).single;
          if (c == null) return;
          tx.queueMutations(deletes: [c.key]);
          await tx.commit();
        });
      },
      maxAttempts: 3,
    );
  }

  Future<void> _delete(Consent consent) async {
    final action = _actions[consent.kind];
    await retry(
      () async {
        await action?.onDelete(consent);
        await _db.withTransaction((tx) async {
          final c = (await tx.lookup<Consent>([consent.key])).single;
          if (c == null) return;
          tx.queueMutations(deletes: [c.key]);
          await tx.commit();
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

  /// Callback on rejecting the consent or timeout.
  Future<void> onDelete(Consent consent);

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
  String renderInviteHtml({
    @required String invitingUserEmail,
    @required List<String> args,
    @required String currentUserEmail,
  });
}

/// Callbacks for package uploader consents.
class _PackageUploaderAction extends ConsentAction {
  @override
  Future<void> onAccept(Consent consent) async {
    final packageName = consent.args.single;
    final fromUserEmail =
        await accountBackend.getEmailOfUserId(consent.fromUserId);
    final uploader = consent.userId != null
        ? await accountBackend.lookupUserById(consent.userId)
        : await accountBackend.lookupUserByEmail(consent.email);
    if (uploader == null) {
      // NOTE: This should never happen because `userId` of the consent entity
      //       will be set when it is loaded.
      throw AuthenticationException.userNotFound();
    }

    await packageBackend.confirmUploader(
        consent.fromUserId, fromUserEmail, packageName, uploader);
  }

  @override
  Future<void> onDelete(Consent consent) async {
    // nothing to do
  }

  @override
  String renderInviteText(String invitingUserEmail, List<String> args) {
    final packageName = args.single;
    return '$invitingUserEmail has invited you to be an uploader of the package $packageName.';
  }

  @override
  String renderInviteTitleText(String invitingUserEmail, List<String> args) {
    final packageName = args.single;
    return 'Invitation for package: $packageName';
  }

  @override
  String renderInviteHtml({
    @required String invitingUserEmail,
    @required List<String> args,
    @required String currentUserEmail,
  }) {
    final packageName = args.single;
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
    final publisherId = consent.args[0];
    final contactEmail = consent.args[1];
    await publisherBackend.updateContactEmail(publisherId, contactEmail);
  }

  @override
  Future<void> onDelete(Consent consent) async {
    // nothing to do
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
    @required String invitingUserEmail,
    @required List<String> args,
    @required String currentUserEmail,
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
    final member = consent.userId != null
        ? await accountBackend.lookupUserById(consent.userId)
        : await accountBackend.lookupUserByEmail(consent.email);
    if (member == null) {
      // NOTE: This should never happen because `userId` of the consent entity
      //       will be set when it is loaded.
      throw AuthenticationException.userNotFound();
    }
    final publisherId = consent.args.single;
    await publisherBackend.inviteConsentGranted(publisherId, member.userId);
  }

  @override
  Future<void> onDelete(Consent consent) async {
    // nothing to do
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
    @required String invitingUserEmail,
    @required List<String> args,
    @required String currentUserEmail,
  }) {
    final publisherId = args[0];
    return renderPublisherMemberInvite(
      invitingUserEmail: invitingUserEmail,
      publisherId: publisherId,
    );
  }
}
