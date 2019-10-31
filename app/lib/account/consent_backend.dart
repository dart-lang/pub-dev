// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:client_data/account_api.dart' as api;
import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:retry/retry.dart';

import '../frontend/email_sender.dart';
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

/// Represents the backend for the consent handling and authentication.
class ConsentBackend {
  final DatastoreDB _db;
  final _actions = <String, ConsentAction>{
    'PackageUploader': _PackageUploaderAction(),
    'PublisherMember': _PublisherMemberAction(),
  };

  ConsentBackend(this._db);

  /// Returns the consent details.
  Future<api.Consent> getConsent(String consentId, User user) async {
    InvalidInputException.checkUlid(consentId, 'consentId');
    final c = await _lookupAndCheck(consentId, user);
    if (c == null) {
      throw NotFoundException.resource('consent: $consentId');
    }
    final action = _actions[c.kind];
    final activeAccountEmail =
        await accountBackend.getEmailOfUserId(c.fromUserId);
    return api.Consent(
      titleText: action.renderInviteTitleText(activeAccountEmail, c.args),
      descriptionHtml: action.renderInviteHtml(activeAccountEmail, c.args),
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
      if (c == null) {
        throw NotFoundException('Could not find invite with id: $consentId. '
            'It probably has expired.');
      }
      await _accept(c);
      return api.ConsentResult(granted: true);
    } else {
      if (c != null) {
        await _delete(c);
      }
      return api.ConsentResult(granted: false);
    }
  }

  /// Create a new invitation, or
  /// - if it already exists, re-send the notification, or
  /// - if it was sent recently, do nothing.
  Future<api.InviteStatus> invite({
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

  Future<api.InviteStatus> _sendNotification(
      String activeUserEmail, Consent consent) async {
    final invitedEmail = consent.email ??
        await accountBackend.getEmailOfUserId(consent.userIdOfConsent);
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
  Future deleteObsoleteConsents() async {
    final query = _db.query<Consent>()
      ..filter('expires <', DateTime.now().toUtc());
    await for (var entry in query.run()) {
      try {
        await _delete(entry);
      } catch (e) {
        _logger.shout(
            'Delete failed: ${entry.userIdOfConsent} ${entry.kind} ${entry.args}',
            e);
      }
    }
  }

  /// Returns the [Consent] for [consentId] and checks if it is for [user].
  ///
  /// Returns null if the consent cannot be found.
  Future<Consent> _lookupAndCheck(String consentId, User user) async {
    // legacy Consent store: under the User entity
    final legacyKey = _db.emptyKey
        .append(User, id: user.userId)
        .append(Consent, id: consentId);
    final legacyValue =
        await _db.lookupValue<Consent>(legacyKey, orElse: () => null);
    if (legacyValue != null) {
      // the request is under the User entity, we don't need to do any check
      return legacyValue;
    }

    // future Consent store: separately from the User entity
    final c = await _db.lookupValue<Consent>(
        _db.emptyKey.append(Consent, id: consentId),
        orElse: () => null);
    if (c == null) return null;

    // Checking that consent is for the current user.
    if (c.userIdOfConsent != null && c.userIdOfConsent != user.userId) {
      return null;
    }
    if (c.email != null && c.email != user.email) {
      return null;
    }
    return c;
  }

  Future _accept(Consent consent) async {
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

  Future _delete(Consent consent) async {
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
  Future onAccept(Consent consent);

  /// Callback on rejecting the consent or timeout.
  Future onDelete(Consent consent);

  /// The subject of the notification email sent.
  String renderEmailSubject(List<String> args) =>
      'You have a new invitation to confirm on $primaryHost';

  /// The body of the notification email sent.
  String renderInviteText(String activeAccountEmail, List<String> args);

  /// The title of the invite for use in list of invites, and headline when
  /// viewing a specific invite.
  String renderInviteTitleText(String activeAccountEmail, List<String> args);

  /// The HTML-formatted invitation message.
  ///
  /// This message should explain what accepting this invite implies. Who can
  /// see the user, what gets shared, how will user figure in permission
  /// history, and what permissions will the user be granted.
  String renderInviteHtml(String activeAccountEmail, List<String> args);
}

/// Callbacks for package uploader consents.
class _PackageUploaderAction extends ConsentAction {
  @override
  Future onAccept(Consent consent) async {
    final packageName = consent.args.single;
    final fromUserEmail =
        await accountBackend.getEmailOfUserId(consent.fromUserId);
    final uploader = consent.userId != null
        ? await accountBackend.lookupUserById(consent.userId)
        : await accountBackend.lookupOrCreateUserByEmail(consent.email);

    await packageBackend.repository.confirmUploader(
        consent.fromUserId, fromUserEmail, packageName, uploader);
  }

  @override
  Future onDelete(Consent consent) async {
    // nothing to do
  }

  @override
  String renderInviteText(String activeAccountEmail, List<String> args) {
    final packageName = args.single;
    return '$activeAccountEmail has invited you to be an uploader of the package $packageName.';
  }

  @override
  String renderInviteTitleText(String activeAccountEmail, List<String> args) {
    final packageName = args.single;
    return 'Invitation for package: $packageName';
  }

  @override
  String renderInviteHtml(String activeAccountEmail, List<String> args) {
    final packageName = args.single;
    final url = pkgPageUrl(packageName);
    return '<code>$activeAccountEmail</code> has invited you to be an uploader of '
        'the package '
        '<a href="$url" target="_blank" rel="noreferrer"><code>$packageName</code></a>.';
  }
}

/// Callbacks for publisher member consents.
class _PublisherMemberAction extends ConsentAction {
  @override
  Future onAccept(Consent consent) async {
    final member = consent.userId != null
        ? await accountBackend.lookupUserById(consent.userId)
        : await accountBackend.lookupOrCreateUserByEmail(consent.email);
    final publisherId = consent.args.single;
    await publisherBackend.inviteConsentGranted(publisherId, member.userId);
  }

  @override
  Future onDelete(Consent consent) async {
    // nothing to do
  }

  @override
  String renderInviteText(String activeAccountEmail, List<String> args) {
    final publisherId = args[0];
    return '$activeAccountEmail has invited you to be a member of the verified publisher $publisherId.';
  }

  @override
  String renderInviteTitleText(String activeAccountEmail, List<String> args) {
    final publisherId = args[0];
    return 'Invitation for publisher: $publisherId';
  }

  @override
  String renderInviteHtml(String activeAccountEmail, List<String> args) {
    final publisherId = args[0];
    final url = publisherUrl(publisherId);
    return '<code>$activeAccountEmail</code> has invited you to be a member of '
        'the <a href="https://dart.dev/tools/pub/verified-publishers" target="_blank" rel="noreferrer">verified publisher</a> '
        '<a href="$url" target="_blank" rel="noreferrer"><code>$publisherId</code></a>.';
  }
}
