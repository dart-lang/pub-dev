// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';
import 'dart:js';

import 'package:_pub_shared/data/account_api.dart';
import 'package:_pub_shared/data/package_api.dart';
import 'package:_pub_shared/data/publisher_api.dart';
import 'package:http/browser_client.dart' as http;

import '_authenticated_client.dart';
import '_authentication_proxy.dart';
import '_dom_helper.dart';
import 'google_auth_js.dart';
import 'google_js.dart';
import 'page_data.dart';
import 'pubapi.client.dart';

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
    await authProxyReady;

    if (!authenticationProxy.isSignedIn()) {
      await authenticationProxy.trySignIn();
    }
    if (!authenticationProxy.isSignedIn()) {
      print('Login failed');
      throw StateError('User not logged in');
    }
    return authenticationProxy.idToken();
  }));
}

void setupAccount() {
  final metaElem =
      document.querySelector('meta[name="google-signin-client_id"]');
  final clientId = metaElem == null ? null : metaElem.attributes['content'];

  // Handle missing clientId by not allowing the sign-in button at all.
  if (clientId == null || clientId.isEmpty) {
    _initFailed();
    return;
  }

  // Special value to use fake token authentication.
  if (clientId == 'fake-site-audience') {
    setupFakeTokenAuthenticationProxy(onUpdated: () => _updateSession());
    _initWidgets();
    return;
  }

  // Initialization hook that will run after the auth library is loaded and
  // initialized. Method name is passed in as request parameter when loading
  // the auth library.
  context['pubAuthInit'] = () {
    load('auth2', allowInterop(() {
      init(JsObject.jsify({'client_id': clientId})).then(
        allowInterop((_) => _initGoogleAuthAndWidgets()), // success
        allowInterop((_) => _initFailed()), // failure
      );
    }));
  };
}

void _initFailed() {
  // Unblocking the initialization of PubApiClient.
  setupGoogleAuthenticationProxy();

  // Login at this point is unlikely to work.
  _signInNotAvailable();
}

void _signInNotAvailable() {
  document.getElementById('-account-login')?.onClick.listen((_) async {
    await modalMessage(
        'Sign in is not available',
        markdown(
            '`pub.dev` uses third-party cookies and access to Google domains for accounts and sign in. '
            'Please enable third-party cookies and don\'t block content on `pub.dev`.'));
  });
}

void _initGoogleAuthAndWidgets() {
  setupGoogleAuthenticationProxy(
    onUpdated: () async {
      await _updateSession();
    },
  );
  _initWidgets();
}

void _initWidgets() {
  document
      .getElementById('-account-login')
      ?.onClick
      .listen((_) => authenticationProxy.trySignIn());
  document
      .getElementById('-account-logout')
      ?.onClick
      .listen((_) => authenticationProxy.signOut());
  _pkgAdminWidget.init();
  _createPublisherWidget.init();
  _publisherAdminWidget.init();
  _consentWidget.init();
}

/// update or delete session
Future _updateSession() async {
  if (!authenticationProxy.isSignedIn()) {
    final st1 = ClientSessionStatus.fromBytes(
        await unauthenticatedClient.invalidateSession());
    if (st1.changed == true) {
      final st2 = ClientSessionStatus.fromBytes(
        await unauthenticatedClient.invalidateSession(),
      );
      // Only reload if signing out again, didn't change anything.
      // If signing out a second time changes something, then clearly sign-out
      // isn't clearing the cookie and session correctly. We should not reload
      // to avoid degrading into a reload loop.
      if (st2.changed == false) {
        window.location.reload();
        return;
      }
    }
  } else {
    final body = ClientSessionRequest(
        accessToken: await authenticationProxy.accessToken());
    final st1 = ClientSessionStatus.fromBytes(await client.updateSession(body));
    if (st1.changed == true) {
      final st2 =
          ClientSessionStatus.fromBytes(await client.updateSession(body));
      // If creating the session a second time changed anything then maybe the
      // client has disabled cookies. We should NOT reload to avoid degrading
      // into an infinite reload loop. We could show a message, but we have no
      // way of preventing this message from poping up on all pages, so it's
      // probably best to ignore this case.
      if (st2.changed == false) {
        window.location.reload();
        return;
      } else {
        print('Sign-in will not work without session cookies');
      }
    }
  }
}

/// Active on /packages/<package>/admin page.
class _PkgAdminWidget {
  Element? _setPublisherInput;
  Element? _setPublisherButton;
  InputElement? _discontinuedCheckbox;
  InputElement? _replacedByInput;
  Element? _replacedByButton;
  InputElement? _unlistedCheckbox;
  Element? _inviteUploaderButton;
  Element? _inviteUploaderContent;
  InputElement? _inviteUploaderInput;
  Element? _retractPackageVersionInput;
  Element? _retractPackageVersionButton;
  Element? _restoreRetractPackageVersionInput;
  Element? _restoreRetractPackageVersionButton;

  void init() {
    if (!pageData.isPackagePage) return;
    _setPublisherInput = document.getElementById('-admin-set-publisher-input');
    _setPublisherButton =
        document.getElementById('-admin-set-publisher-button');
    _setPublisherButton?.onClick.listen((_) => _setPublisher());
    _discontinuedCheckbox = document
        .getElementById('-admin-is-discontinued-checkbox') as InputElement?;
    _discontinuedCheckbox?.onChange.listen((_) => _toogleDiscontinued());
    _replacedByInput =
        document.getElementById('-package-replaced-by') as InputElement?;
    _replacedByButton = document.getElementById('-package-replaced-by-button');
    _replacedByButton?.onClick.listen((_) => _updateReplacedBy());
    _unlistedCheckbox =
        document.getElementById('-admin-is-unlisted-checkbox') as InputElement?;
    _unlistedCheckbox?.onChange.listen((_) => _toggleUnlisted());
    _inviteUploaderButton =
        document.getElementById('-pkg-admin-invite-uploader-button');
    _inviteUploaderContent =
        document.getElementById('-pkg-admin-invite-uploader-content');
    _inviteUploaderButton?.onClick.listen((_) => _inviteUploader());
    _inviteUploaderInput = document
        .getElementById('-pkg-admin-invite-uploader-input') as InputElement?;
    _retractPackageVersionInput =
        document.getElementById('-admin-retract-package-version-input');
    _retractPackageVersionButton =
        document.getElementById('-admin-retract-package-version-button');
    _retractPackageVersionButton?.onClick.listen((_) => _setRetracted());
    _restoreRetractPackageVersionInput =
        document.getElementById('-admin-restore-retract-package-version-input');
    _restoreRetractPackageVersionButton = document
        .getElementById('-admin-restore-retract-package-version-button');
    _restoreRetractPackageVersionButton?.onClick
        .listen((_) => _restoreRetracted());
    if (_inviteUploaderContent != null) {
      _inviteUploaderContent!.remove();
      _inviteUploaderContent!.classes.remove('modal-content-hidden');
    }
    for (final btn
        in document.querySelectorAll('.-pub-remove-uploader-button')) {
      btn.onClick.listen((_) => _removeUploader(btn.dataset['email']!));
    }
  }

  Future<void> _inviteUploader() async {
    await modalWindow(
      titleText: 'Invite new uploader',
      isQuestion: true,
      okButtonText: 'Invite',
      content: _inviteUploaderContent!,
      onExecute: () => _doInviteUploader(),
    );
  }

  Future<bool> _doInviteUploader() async {
    final email = _inviteUploaderInput!.value!.trim();
    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      await modalMessage(
          'Input validation', text('Please specify a valid e-mail.'));
      return false;
    }

    await rpc<void>(
      fn: () async {
        await client.invitePackageUploader(
            pageData.pkgData!.package, InviteUploaderRequest(email: email));
      },
      successMessage: markdown('`$email` was invited.'),
      onSuccess: (_) {
        _inviteUploaderInput!.value = '';
      },
    );
    return true;
  }

  Future<void> _removeUploader(String email) async {
    await rpc<void>(
      confirmQuestion: markdown(
          'Are you sure you want to remove uploader `$email` from this package?'),
      fn: () async {
        await client.removeUploader(pageData.pkgData!.package, email);
      },
      successMessage: markdown(
          'Uploader `$email` removed from this package. The page will reload.'),
      onSuccess: (_) => window.location.reload(),
    );
  }

  Future<void> _toogleDiscontinued() async {
    final oldValue = _discontinuedCheckbox!.defaultChecked ?? false;
    final newValue = await rpc<bool>(
      confirmQuestion: text(
          'Are you sure you want change the "discontinued" status of the package?'),
      fn: () async {
        final rs = await client.setPackageOptions(
            pageData.pkgData!.package,
            PkgOptions(
              isDiscontinued: !oldValue,
            ));
        return rs.isDiscontinued;
      },
      successMessage:
          text('"discontinued" status changed. The page will reload.'),
      onSuccess: (_) => window.location.reload(),
      onError: (err) => null,
    );
    if (newValue == null || newValue == oldValue) {
      _discontinuedCheckbox!.checked = oldValue;
    }
  }

  Future<void> _updateReplacedBy() async {
    await rpc<bool?>(
      confirmQuestion: text(
          'Are you sure you want change the "suggested replacement" field of the package?'),
      fn: () async {
        final rs = await client.setPackageOptions(
            pageData.pkgData!.package,
            PkgOptions(
              isDiscontinued: true,
              replacedBy: _replacedByInput?.value,
            ));
        return rs.isDiscontinued;
      },
      successMessage:
          text('"suggested replacement" field changed. The page will reload.'),
      onSuccess: (_) => window.location.reload(),
    );
  }

  Future<void> _toggleUnlisted() async {
    final oldValue = _unlistedCheckbox!.defaultChecked ?? false;
    final newValue = await rpc(
      confirmQuestion: text(
          'Are you sure you want change the "unlisted" status of the package?'),
      fn: () async {
        final rs = await client.setPackageOptions(
            pageData.pkgData!.package,
            PkgOptions(
              isUnlisted: !oldValue,
            ));
        return rs.isUnlisted;
      },
      successMessage: text('"unlisted" status changed.'),
      onError: (err) => null,
    );
    if (newValue == null) {
      _unlistedCheckbox!.checked = oldValue;
    } else {
      _unlistedCheckbox!.defaultChecked = newValue;
      _unlistedCheckbox!.checked = newValue;
    }
  }

  Future<void> _setRetracted() async {
    final version =
        materialDropdownSelected(_retractPackageVersionInput)?.trim() ?? '';
    if (version.isEmpty) {
      await _validateVersionSelection();
      return;
    }

    await rpc<void>(
      confirmQuestion: markdown(
          'Are you sure you want to retract the package version `$version`?'),
      fn: () async {
        await client.setVersionOptions(pageData.pkgData!.package, version,
            VersionOptions(isRetracted: true));
      },
      successMessage: text('Retraction completed. The page will reload.'),
      onSuccess: (_) => window.location.reload(),
    );
  }

  Future<void> _restoreRetracted() async {
    final version =
        materialDropdownSelected(_restoreRetractPackageVersionInput)?.trim() ??
            '';
    if (version.isEmpty) {
      await _validateVersionSelection();
      return;
    }

    await rpc<void>(
      confirmQuestion: markdown(
          'Are you sure you want to restore package version `$version`?'),
      fn: () async {
        print('before setVersionOption');
        await client.setVersionOptions(pageData.pkgData!.package, version,
            VersionOptions(isRetracted: false));
      },
      successMessage: text('Restoring complete. The page will reload.'),
      onSuccess: (_) => window.location.reload(),
    );
  }

  Future<void> _validateVersionSelection() async {
    await modalMessage(
      'Input validation',
      text('Please select a version.'),
    );
  }

  Future<void> _setPublisher() async {
    final publisherId =
        materialDropdownSelected(_setPublisherInput)?.trim() ?? '';
    if (publisherId.isEmpty) {
      await modalMessage(
        'Input validation',
        text('Please specify a publisher.'),
      );
      return;
    }

    await rpc<void>(
      confirmQuestion: markdown(
          'Are you sure you want to transfer the package to publisher `$publisherId`?'),
      fn: () async {
        final payload = PackagePublisherInfo(publisherId: publisherId);
        await client.setPackagePublisher(pageData.pkgData!.package, payload);
      },
      successMessage: text(
          'Transfer completed. Caches and search index will update in the next 15-20 minutes. The page will reload.'),
      onSuccess: (_) => window.location.reload(),
    );
  }
}

/// Active on the /create-publisher page.
class _CreatePublisherWidget {
  Element? _publisherIdInput;
  Element? _createButton;

  void init() {
    _publisherIdInput = document.getElementById('-publisher-id');
    _createButton = document.getElementById('-admin-create-publisher');
    _createButton?.onClick.listen((_) {
      final publisherId =
          (_publisherIdInput as InputElement).value?.trim() ?? '';
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

    await rpc<void>(
      confirmQuestion: markdown(
          'Are you sure you want to create publisher for `$publisherId`?'),
      fn: () async {
        final extraScope =
            'https://www.googleapis.com/auth/webmasters.readonly';
        final payload = CreatePublisherRequest(
          accessToken:
              (await authenticationProxy.accessToken(extraScope: extraScope))!,
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
  Element? _updateButton;
  TextAreaElement? _descriptionTextArea;
  InputElement? _websiteUrlInput;
  InputElement? _contactEmailInput;
  InputElement? _inviteMemberInput;
  Element? _addMemberButton;
  Element? _addMemberContent;
  String? _originalContactEmail;

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
    _originalContactEmail = _contactEmailInput?.value;
    _updateButton?.onClick.listen((_) => _updatePublisher());
    _addMemberButton?.onClick.listen((_) => _addMember());
    if (_addMemberContent != null) {
      _addMemberContent!.remove();
      _addMemberContent!.classes.remove('modal-content-hidden');
    }
    for (final btn in document.querySelectorAll('.-pub-remove-user-button')) {
      btn.onClick.listen((_) => _removeMember(
            btn.dataset['user-id']!,
            btn.dataset['email']!,
          ));
    }
  }

  Future<void> _updatePublisher() async {
    String? confirmQuestion;
    if (_originalContactEmail != _contactEmailInput!.value) {
      confirmQuestion = 'You are changing the contact email of the publisher. '
          'Changing it to an admin member email happens immediately, for other '
          'addresses we will send a confirmation request.';
    }
    await rpc<void>(
      confirmQuestion: confirmQuestion == null ? null : text(confirmQuestion),
      fn: () async {
        final payload = UpdatePublisherRequest(
          description: _descriptionTextArea!.value,
          websiteUrl: _websiteUrlInput!.value,
          contactEmail: _contactEmailInput!.value,
        );
        await client.updatePublisher(pageData.publisher!.publisherId, payload);
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
      content: _addMemberContent!,
      onExecute: () => _inviteMember(),
    );
  }

  Future<bool> _inviteMember() async {
    final email = _inviteMemberInput!.value!.trim();
    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      await modalMessage(
          'Input validation', text('Please specify a valid e-mail.'));
      return false;
    }

    await rpc<void>(
      fn: () async {
        await client.invitePublisherMember(
            pageData.publisher!.publisherId, InviteMemberRequest(email: email));
      },
      successMessage: markdown('`$email` was invited.'),
      onSuccess: (_) {
        _inviteMemberInput!.value = '';
      },
    );
    return true;
  }

  Future<void> _removeMember(String userId, String email) async {
    await rpc<void>(
      confirmQuestion: markdown(
          'Are you sure you want to remove `$email` from this publisher?'),
      fn: () async {
        await client.removePublisherMember(
            pageData.publisher!.publisherId, userId);
      },
      successMessage: markdown(
          '`$email` removed from this publisher. The page will reload.'),
      onSuccess: (_) => window.location.reload(),
    );
  }
}

class _ConsentWidget {
  Element? _buttons;

  void init() {
    if (!pageData.isConsentPage) return;
    _buttons = document.getElementById('-admin-consent-buttons');
    document
        .getElementById('-admin-consent-accept-button')
        ?.onClick
        .listen((_) => _accept());
    document
        .getElementById('-admin-consent-reject-button')
        ?.onClick
        .listen((_) => _reject());
  }

  void _updateButtons(bool? granted) {
    final text = granted! ? 'Consent accepted.' : 'Consent rejected.';
    _buttons!.replaceWith(Element.p()..text = text);
  }

  Future<void> _accept() async {
    await rpc(
      confirmQuestion: text('Are you sure you want to accept?'),
      fn: () async {
        final rs = await client.resolveConsent(
            pageData.consentId!, ConsentResult(granted: true));
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
            pageData.consentId!, ConsentResult(granted: false));
        return rs.granted;
      },
      successMessage: text('Consent rejected.'),
      onSuccess: _updateButtons,
    );
  }
}
