// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';
import 'dart:js';

import 'package:client_data/account_api.dart';
import 'package:client_data/package_api.dart';
import 'package:client_data/publisher_api.dart';
import 'package:http/browser_client.dart' as http;

import '_authenticated_client.dart';
import '_dom_helper.dart';
import 'google_auth_js.dart';
import 'google_js.dart';
import 'page_data.dart';
import 'pubapi.client.dart';

final _initialized = Completer<void>();
GoogleUser _currentUser;

/// Returns whether the user is currently signed-in.
bool get isSignedIn =>
    _initialized.isCompleted &&
    _currentUser != null &&
    _currentUser.isSignedIn();

/// Returns the currently signed-in user or null.
GoogleUser get currentUser => _currentUser;

final _pkgAdminWidget = _PkgAdminWidget();
final _publisherAdminWidget = _PublisherAdminWidget();
final _createPublisherWidget = _CreatePublisherWidget();
final _consentWidget = _ConsentWidget();

String get _baseUrl {
  final location = Uri.parse(window.location.href);
  return Uri(
    scheme: location.scheme,
    host: location.host,
    port: location.port,
  ).toString();
}

/// The pub API client to use without credentials.
PubApiClient get unauthenticatedClient =>
    PubApiClient(_baseUrl, client: http.BrowserClient());

/// The pub API client to use with account credentials.
PubApiClient get client {
  return PubApiClient(_baseUrl, client: createAuthenticatedClient(() async {
    // Wait until we're initialized
    await _initialized.future;

    var user = getAuthInstance().currentUser.get();
    if (user == null || !user.isSignedIn()) {
      // Attempt a login flow
      user = await promiseAsFuture(
          getAuthInstance().signIn(SignInOptions(prompt: 'select_account')));
    }
    if (user == null || !user.isSignedIn()) {
      print('Login failed');
      throw StateError('User not logged in');
    }

    var authResponse = user.getAuthResponse(true);

    if (authResponse == null ||
        authResponse.expires_at == null ||
        DateTime.now().millisecondsSinceEpoch > authResponse.expires_at) {
      authResponse = await promiseAsFuture(user.reloadAuthResponse());
    }

    if (authResponse == null ||
        authResponse.expires_at == null ||
        DateTime.now().millisecondsSinceEpoch > authResponse.expires_at) {
      throw StateError(
          'Unable to get response object from the user\'s auth session.');
    }

    return authResponse.id_token;
  }));
}

void setupAccount() {
  // Initialization hook that will run after the auth library is loaded and
  // initialized. Method name is passed in as request parameter when loading
  // the auth library.
  context['pubAuthInit'] = () {
    final clientId = document
        .querySelector('meta[name="google-signin-client_id"]')
        .attributes['content'];
    if (clientId == null) return;
    load('auth2', allowInterop(() {
      init(JsObject.jsify({'client_id': clientId}))
          .then(allowInterop((_) => _init()));
    }));
  };
}

void _init() {
  _initialized.complete();
  document.getElementById('-account-login')?.onClick?.listen(
        (_) => getAuthInstance().signIn(
          SignInOptions(prompt: 'select_account'),
        ),
      );
  document
      .getElementById('-account-logout')
      ?.onClick
      ?.listen((_) => getAuthInstance().signOut());
  _pkgAdminWidget.init();
  _createPublisherWidget.init();
  _publisherAdminWidget.init();
  _consentWidget.init();
  _updateUser(getAuthInstance()?.currentUser?.get());
  getAuthInstance().currentUser.listen(allowInterop(_updateUser));
}

Future _updateUser(GoogleUser user) async {
  if (!getAuthInstance().isSignedIn.get()) {
    user = null;
  }
  if (user?.getId() == null) {
    user = null;
  }
  _currentUser = user;

  // update or delete session
  if (user == null) {
    final st1 = ClientSessionStatus.fromBytes(
        await unauthenticatedClient.invalidateSession());
    if (st1.changed) {
      final st2 = ClientSessionStatus.fromBytes(
        await unauthenticatedClient.invalidateSession(),
      );
      // Only reload if signing out again, didn't change anything.
      // If signing out a second time changes something, then clearly sign-out
      // isn't clearing the cookie and session correctly. We should not reload
      // to avoid degrading into a reload loop.
      if (!st2.changed) {
        window.location.reload();
        return;
      }
    }
  } else {
    final body = ClientSessionRequest(
      accessToken: currentUser.getAuthResponse(true).access_token,
    );
    final st1 = ClientSessionStatus.fromBytes(await client.updateSession(body));
    if (st1.changed) {
      final st2 =
          ClientSessionStatus.fromBytes(await client.updateSession(body));
      // If creating the session a second time changed anything then maybe the
      // client has disabled cookies. We should NOT reload to avoid degrading
      // into an infinite reload loop. We could show a message, but we have no
      // way of preventing this message from poping up on all pages, so it's
      // probably best to ignore this case.
      if (!st2.changed) {
        window.location.reload();
        return;
      } else {
        print('Sign-in will not work without session cookies');
      }
    }
  }

  _updateUi();
}

void _updateUi() {
  if (isSignedIn) {
    print('user: ${currentUser.getBasicProfile().getEmail()}');
  } else {
    print('No active user');
  }
}

/// Active on /packages/<package>/admin page.
class _PkgAdminWidget {
  Element _toggleDiscontinuedButton;
  SelectElement _setPublisherInput;
  Element _setPublisherButton;

  void init() {
    if (!pageData.isPackagePage) return;
    _toggleDiscontinuedButton =
        document.getElementById('-admin-is-discontinued-toggle');
    _setPublisherInput =
        document.getElementById('-admin-set-publisher-input') as SelectElement;
    _setPublisherButton =
        document.getElementById('-admin-set-publisher-button');
    _toggleDiscontinuedButton?.onClick?.listen((_) => _toogleDiscontinued());
    _setPublisherButton?.onClick?.listen((_) => _setPublisher());
  }

  Future<void> _toogleDiscontinued() async {
    await rpc(
      confirmQuestion: text(
          'Are you sure you want change the "discontinued" status of the package?'),
      fn: () async {
        await client.setPackageOptions(
            pageData.pkgData.package,
            PkgOptions(
              isDiscontinued: !pageData.pkgData.isDiscontinued,
            ));
      },
      successMessage:
          text('"discontinued" status changed. The page will reload.'),
      onSuccess: (_) => window.location.reload(),
    );
  }

  Future<void> _setPublisher() async {
    final publisherId = _setPublisherInput.value.trim();
    if (publisherId.isEmpty) {
      await modalMessage(
        'Input validation',
        text('Please specify a publisher.'),
      );
      return;
    }

    await rpc(
      confirmQuestion: markdown(
          'Are you sure you want to transfer the package to publisher `$publisherId`?'),
      fn: () async {
        final payload = PackagePublisherInfo(publisherId: publisherId);
        await client.setPackagePublisher(pageData.pkgData.package, payload);
      },
      successMessage: text(
          'Transfer completed. Caches and search index will update in the next 15-20 minutes. The page will reload.'),
      onSuccess: (_) => window.location.reload(),
    );
  }
}

/// Active on the /create-publisher page.
class _CreatePublisherWidget {
  Element _publisherIdInput;
  Element _createButton;

  void init() {
    _publisherIdInput = document.getElementById('-publisher-id');
    _createButton = document.getElementById('-admin-create-publisher');
    _createButton?.onClick?.listen((_) {
      final publisherId = (_publisherIdInput as InputElement).value.trim();
      _triggerCreate(publisherId);
    });
  }

  void _triggerCreate(String publisherId) async {
    // Some sanity validation, server-side will enforce proper validation.
    final publisherIdPattern = RegExp(r'^([a-z0-9-]{1,63}\.)+[a-z0-9-]{1,63}$');
    if (publisherId.isEmpty || !publisherIdPattern.hasMatch(publisherId)) {
      await modalMessage(
        'Input validation',
        text('Please use a domain name as publisher identifier.'),
      );
      return;
    }

    await rpc(
      confirmQuestion: markdown(
          'Are you sure you want to create publisher for `$publisherId`?'),
      fn: () async {
        GoogleUser currentUser = getAuthInstance()?.currentUser?.get();
        final extraScope =
            'https://www.googleapis.com/auth/webmasters.readonly';

        if (!currentUser.hasGrantedScopes(extraScope)) {
          // We don't have the extract scope, so let's ask for it
          currentUser = await promiseAsFuture(currentUser.grant(GrantOptions(
            scope: extraScope,
          )));
        }
        final payload = CreatePublisherRequest(
          accessToken: currentUser.getAuthResponse(true).access_token,
        );
        await client.createPublisher(publisherId, payload);
      },
      successMessage: text('Publisher created. The page will reload.'),
      onSuccess: (_) {
        window.location.pathname = '/publishers/$publisherId';
      },
    );
  }
}

/// Active on the /publishers/<publisherId>/admin page.
class _PublisherAdminWidget {
  Element _updateButton;
  TextAreaElement _descriptionTextArea;
  InputElement _websiteUrlInput;
  InputElement _contactEmailInput;
  InputElement _inviteMemberInput;
  Element _addMemberButton;
  Element _addMemberContent;
  Element _inviteMemberButton;
  String _originalContactEmail;

  void init() {
    if (!pageData.isPublisherPage) return;
    _updateButton = document.getElementById('-publisher-update-button');
    _descriptionTextArea =
        document.getElementById('-publisher-description') as TextAreaElement;
    _websiteUrlInput =
        document.getElementById('-publisher-website-url') as InputElement;
    _contactEmailInput =
        document.getElementById('-publisher-contact-email') as InputElement;
    _inviteMemberInput =
        document.getElementById('-admin-invite-member-input') as InputElement;
    _addMemberButton = document.getElementById('-admin-add-member-button');
    _addMemberContent = document.getElementById('-admin-add-member-content');
    _inviteMemberButton =
        document.getElementById('-admin-invite-member-button');
    _originalContactEmail = _contactEmailInput?.value;
    _updateButton?.onClick?.listen((_) => _updatePublisher());
    _addMemberButton?.onClick?.listen((_) => _addMember());
    if (_addMemberContent != null) {
      _addMemberContent.remove();
      _addMemberContent.classes.remove('modal-content-hidden');
    }
    // TODO: remove _inviteMemberButton after migrating to the new UI
    _inviteMemberButton?.onClick?.listen((_) => _inviteMember(true));
    for (final btn in document.querySelectorAll('.-pub-remove-user-button')) {
      btn.onClick.listen((_) => _removeMember(
            btn.dataset['user-id'],
            btn.dataset['email'],
          ));
    }
  }

  Future<void> _updatePublisher() async {
    String confirmQuestion;
    if (_originalContactEmail != _contactEmailInput.value) {
      confirmQuestion = 'You are changing the contact email of the publisher. '
          'Changing it to an admin member email happens immediately, for other '
          'addresses we will send a confirmation request.';
    }
    await rpc(
      confirmQuestion: text(confirmQuestion),
      fn: () async {
        final payload = UpdatePublisherRequest(
          description: _descriptionTextArea.value,
          websiteUrl: _websiteUrlInput.value,
          contactEmail: _contactEmailInput.value,
        );
        await client.updatePublisher(pageData.publisher.publisherId, payload);
      },
      successMessage: text('Publisher was updated. The page will reload.'),
      onSuccess: (_) => window.location.reload(),
    );
  }

  Future<void> _addMember() async {
    await modalWindow(
      titleText: 'Invite new member',
      isQuestion: true,
      okButtonText: 'Add',
      content: _addMemberContent,
      onExecute: () => _inviteMember(false),
    );
  }

  // TODO: remove [requestConfirm] after we've migrated to the new UI.
  Future<bool> _inviteMember(bool requestConfirm) async {
    final email = _inviteMemberInput.value.trim();
    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      await modalMessage(
          'Input validation', text('Please specify a valid e-mail.'));
      return false;
    }

    await rpc(
      confirmQuestion: requestConfirm
          ? markdown('Are you sure you want to invite `$email` '
              'as an administrator member to this publisher?')
          : null,
      fn: () async {
        await client.invitePublisherMember(
            pageData.publisher.publisherId, InviteMemberRequest(email: email));
      },
      successMessage: markdown('`$email` was invited.'),
      onSuccess: (_) {
        _inviteMemberInput.value = '';
      },
    );
    return true;
  }

  Future<void> _removeMember(String userId, String email) async {
    await rpc(
      confirmQuestion: markdown(
          'Are you sure you want to remove `$email` from this publisher?'),
      fn: () async {
        await client.removePublisherMember(
            pageData.publisher.publisherId, userId);
      },
      successMessage: markdown(
          '`$email` removed from this publisher. The page will reload.'),
      onSuccess: (_) => window.location.reload(),
    );
  }
}

class _ConsentWidget {
  Element _buttons;

  void init() {
    if (!pageData.isConsentPage) return;
    _buttons = document.getElementById('-admin-consent-buttons');
    document
        .getElementById('-admin-consent-accept-button')
        .onClick
        .listen((_) => _accept());
    document
        .getElementById('-admin-consent-reject-button')
        .onClick
        .listen((_) => _reject());
  }

  void _updateButtons(bool granted) {
    final text = granted ? 'Consent accepted.' : 'Consent rejected.';
    _buttons.replaceWith(Element.p()..text = text);
  }

  Future<void> _accept() async {
    await rpc(
      confirmQuestion: text('Are you sure you want to accept?'),
      fn: () async {
        final rs = await client.resolveConsent(
            pageData.consentId, ConsentResult(granted: true));
        return rs.granted;
      },
      successMessage: text('Consent accepted.'),
      onSuccess: _updateButtons,
    );
  }

  Future<void> _reject() async {
    await rpc(
      confirmQuestion: text('Are you sure you want to reject?'),
      fn: () async {
        final rs = await client.resolveConsent(
            pageData.consentId, ConsentResult(granted: false));
        return rs.granted;
      },
      successMessage: text('Consent rejected.'),
      onSuccess: _updateButtons,
    );
  }
}
