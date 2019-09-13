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
    'PublisherMember': _PublisherMemberAction(),
  };

  ConsentBackend(this._db);

  /// Returns the consent details.
  Future<api.Consent> getConsent(String consentId) async {
    final user = await requireAuthenticatedUser();
    final key = _db.emptyKey
        .append(User, id: user.userId)
        .append(Consent, id: consentId);
    final c = (await _db.lookup<Consent>([key])).single;
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

  /// Resolves the consent.
  Future<api.ConsentResult> resolveConsent(
      String consentId, api.ConsentResult result) async {
    final user = await requireAuthenticatedUser();

    final key = _db.emptyKey
        .append(User, id: user.userId)
        .append(Consent, id: consentId);
    final c = (await _db.lookup<Consent>([key])).single;
    InvalidInputException.checkNotNull(result.granted, 'granted');
    if (result.granted) {
      if (c == null) {
        throw NotFoundException.resource('consent: $consentId');
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
    @required String kind,
    @required List<String> args,
  }) async {
    return retry(() async {
      await requireAuthenticatedUser();
      // First check for existing consents with identical dedupId.
      final dedupId = consentDedupId(kind, args);
      final userKey = _db.emptyKey.append(User, id: userId);
      final query = _db.query<Consent>(ancestorKey: userKey)
        ..filter('dedupId =', dedupId);
      final list = await query.run().toList();
      if (list.isNotEmpty) {
        final old = list.first;
        if (old.isExpired()) {
          // expired entries should be deleted
          await _delete(old);
        } else if (old.shouldNotify()) {
          // non-expired entries just re-send the notification
          return await _sendNotification(old);
        } else {
          return api.InviteStatus(
              emailSent: false, nextNotification: old.nextNotification);
        }
      }
      // Create a new entry.
      final consent = Consent.init(
        parentKey: userKey,
        kind: kind,
        args: args,
        fromUserId: authenticatedUser.userId,
      );
      await _db.commit(inserts: [consent]);
      return await _sendNotification(consent);
    });
  }

  Future<api.InviteStatus> _sendNotification(Consent consent) async {
    final invitedEmail = await accountBackend.getEmailOfUserId(consent.userId);
    final action = _actions[consent.kind];
    await emailSender.sendMessage(createInviteEmail(
      invitedEmail: invitedEmail,
      subject: action.renderEmailSubject(consent.args),
      inviteText:
          action.renderInviteText(authenticatedUser.email, consent.args),
      consentUrl: consentUrl(consent.consentId),
    ));
    return await _db.withTransaction((tx) async {
      final c = (await tx.lookup<Consent>([consent.key])).single;
      c.notificationCount++;
      c.lastNotified = DateTime.now().toUtc();
      tx.queueMutations(inserts: [c]);
      await tx.commit();
      return api.InviteStatus(
          emailSent: true, nextNotification: c.nextNotification);
    }) as api.InviteStatus;
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
            'Delete failed: ${entry.userId} ${entry.kind} ${entry.args}', e);
      }
    }
  }

  Future _accept(Consent consent) async {
    final action = _actions[consent.kind];
    await retry(
      () async {
        await action?.onAccept(consent.userId, consent.args);
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
        await action?.onDelete(consent.userId, consent.args);
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
  Future onAccept(String userId, List<String> args);

  /// Callback on rejecting the consent or timeout.
  Future onDelete(String userId, List<String> args);

  /// The subject of the notification e-mail sent.
  String renderEmailSubject(List<String> args) =>
      'You have a new invitation to confirm on $primaryHost';

  /// The body of the notification e-mail sent.
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

/// Callbacks for publisher member consents.
class _PublisherMemberAction extends ConsentAction {
  @override
  Future onAccept(String userId, List<String> args) async {
    await publisherBackend.inviteConsentGranted(args.single, userId);
  }

  @override
  Future onDelete(String userId, List<String> args) async {
    await publisherBackend.inviteDeleted(args.single, userId);
  }

  @override
  String renderInviteText(String activeAccountEmail, List<String> args) {
    final publisherId = args[0];
    return '$activeAccountEmail has invited you to be a member of publisher $publisherId.';
  }

  @override
  String renderInviteTitleText(String activeAccountEmail, List<String> args) {
    final publisherId = args[0];
    return 'Invitation for publisher: $publisherId';
  }

  @override
  String renderInviteHtml(String activeAccountEmail, List<String> args) {
    final publisherId = args[0];
    return '<code>$activeAccountEmail</code> has invited you to be a member of publisher <code>$publisherId</code>.';
  }
}
