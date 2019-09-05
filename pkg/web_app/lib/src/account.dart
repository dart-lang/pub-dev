// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:js';

import 'package:client_data/package_api.dart';
import 'package:client_data/publisher_api.dart';
import 'package:http/http.dart' as http;

import '_authenticated_client.dart';
import '_dom_helper.dart';
import 'google_auth_js.dart';
import 'google_js.dart';
import 'hoverable.dart';
import 'page_data.dart';
import 'pubapi.client.dart';
import 'tabs.dart';

bool _initialized = false;
GoogleUser _currentUser;
bool _isAdmin = false;

/// Returns whether the user is currently signed-in.
bool get isSignedIn => _initialized && _currentUser != null;

/// Returns the currently signed-in user or null.
GoogleUser get currentUser => _currentUser;

PubApiClient _client;
http.Client _httpClient;
final _navWidget = _AccountNavWidget();
final _authorizationWidget = _AuthorizationWidget();
final _pkgAdminWidget = _PkgAdminWidget();
final _publisherAdminWidget = _PublisherAdminWidget();
final _createPublisherWidget = _CreatePublisherWidget();

/// The pub API client to use with account credentials.
PubApiClient get client {
  if (_client == null) {
    _httpClient ??=
        getAuthenticatedClient(currentUser.getAuthResponse(true)?.access_token);
    final uri = Uri.parse(window.location.href);
    _client = PubApiClient(uri.resolve('/').toString(), client: _httpClient);
  }
  return _client;
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
  _initialized = true;
  _navWidget.init();
  _authorizationWidget.init();
  _pkgAdminWidget.init();
  _createPublisherWidget.init();
  _publisherAdminWidget.init();
  _updateUser(getAuthInstance()?.currentUser?.get());
  getAuthInstance().currentUser.listen(allowInterop(_updateUser));
}

void _updateUser(GoogleUser user) {
  if (_initialized && !getAuthInstance().isSignedIn.get()) {
    user = null;
  }
  if (user?.getId() == null) {
    user = null;
  }
  _currentUser = user;

  // reset credentials used in the HTTP Client
  _httpClient?.close();
  _httpClient = null;
  _client = null;

  _updateOnCredChange();
  _updateUi();
}

Future _updateOnCredChange() async {
  if (isSignedIn) {
    try {
      if (pageData.isPackagePage) {
        final rs = await client.accountPackageOptions(pageData.pkgData.package);
        _isAdmin = rs.isAdmin ?? false;
        _updateUi();
      } else if (pageData.isPublisherPage) {
        final rs = await client
            .accountPublisherOptions(pageData.publisher.publisherId);
        _isAdmin = rs.isAdmin ?? false;
        _updateUi();
      }
    } catch (e) {
      print(e);
    }
  }
}

void _updateUi() {
  if (isSignedIn) {
    print('user: ${currentUser.getBasicProfile().getEmail()}');
  } else {
    print('No active user');
  }
  _navWidget.update();
  _authorizationWidget.update();
  _pkgAdminWidget.update();
  _createPublisherWidget.update();
  _publisherAdminWidget.update();
}

/// Active on all pages.
class _AccountNavWidget {
  Element _login;
  Element _profile;
  Element _image;
  Element _email;

  void init() {
    final navRoot = document.getElementById('account-nav');
    if (navRoot == null) return;
    _login = document.getElementById('-account-login');
    _profile = document.getElementById('-account-profile');
    _image = document.getElementById('-account-profile-img');
    _email = document.getElementById('-account-profile-email');
    final logout = document.getElementById('-account-logout');
    _login.onClick.listen((_) => getAuthInstance().signIn());
    logout.onClick.listen((_) => getAuthInstance().signOut());
    registerHoverable(_profile);
    update();
  }

  void update() {
    if (!_initialized) {
      return;
    }
    updateDisplay(_login, !isSignedIn, display: 'block');
    updateDisplay(_profile, isSignedIn, display: 'inline-block');
    if (isSignedIn) {
      _image.attributes['src'] = _currentUser.getBasicProfile().getImageUrl();
      _email.text = _currentUser.getBasicProfile().getEmail();
    }
  }
}

/// Active on multiple pages, including package and publisher admin pages.
class _AuthorizationWidget {
  Element _unauthenticatedRoot;
  Element _unauthorizedRoot;
  Element _authenticatedRoot;
  Element _authorizedRoot;

  void init() {
    _unauthenticatedRoot = document.getElementById('-admin-unauthenticated');
    _unauthorizedRoot = document.getElementById('-admin-unauthorized');
    _authenticatedRoot = document.getElementById('-admin-authenticated');
    _authorizedRoot = document.getElementById('-admin-authorized');
    update();
  }

  void update() {
    final authorized = _authorizedRoot != null && isSignedIn && _isAdmin;
    final unauthorized =
        !authorized && _unauthorizedRoot != null && isSignedIn && !_isAdmin;
    final authenticated = !authorized &&
        !unauthorized &&
        _authenticatedRoot != null &&
        isSignedIn;
    final unauthenticated = !authorized &&
        !unauthorized &&
        !authenticated &&
        _unauthenticatedRoot != null;
    if (_unauthenticatedRoot != null) {
      updateDisplay(_unauthenticatedRoot, unauthenticated, display: 'block');
    }
    if (_unauthorizedRoot != null) {
      updateDisplay(_unauthorizedRoot, unauthorized, display: 'block');
    }
    if (_authenticatedRoot != null) {
      updateDisplay(_authenticatedRoot, authenticated, display: 'block');
    }
    if (_authorizedRoot != null) {
      updateDisplay(_authorizedRoot, authorized, display: 'block');
    }
  }
}

/// Active on /packages/<package>/admin page.
class _PkgAdminWidget {
  Element _toggleDiscontinuedButton;
  InputElement _setPublisherInput;
  Element _setPublisherButton;

  void init() {
    if (!pageData.isPackagePage) return;
    _toggleDiscontinuedButton =
        document.querySelector('.-admin-is-discontinued-toggle');
    _setPublisherInput =
        document.getElementById('-admin-set-publisher-input') as InputElement;
    _setPublisherButton =
        document.getElementById('-admin-set-publisher-button');
    if (isActive) {
      _toggleDiscontinuedButton.onClick.listen((_) => _toogleDiscontinued());
      _setPublisherButton?.onClick?.listen((_) => _setPublisher());
    }
    update();
  }

  Future _toogleDiscontinued() async {
    if (!window.confirm(
        'Are you sure you want change the "discontinued" status of the package?')) {
      return;
    }
    final options =
        PkgOptions(isDiscontinued: !pageData.pkgData.isDiscontinued);
    try {
      await client.setPackageOptions(pageData.pkgData.package, options);
      window.location.reload();
    } on RequestException catch (e) {
      final map = e.bodyAsJson();
      window.alert(map['message'] as String);
    }
  }

  Future _setPublisher() async {
    final publisherId = _setPublisherInput.value.trim();
    if (publisherId.isEmpty) {
      window.alert('Please specify a publisher.');
      return;
    }
    if (!window.confirm('Are you sure you want to transfer the package to '
        'publisher "$publisherId"?')) {
      return;
    }
    final payload = PackagePublisherInfo(publisherId: publisherId);
    try {
      await client.setPackagePublisher(pageData.pkgData.package, payload);
      window.location.reload();
    } on RequestException catch (e) {
      final map = e.bodyAsJson();
      window.alert(map['message'] as String);
    }
  }

  void update() {
    final adminTab = getTabElement('-admin-tab-');
    if (adminTab != null) {
      if (_initialized && _isAdmin) {
        final removed = adminTab.classes.remove('-hidden');
        // If this was the first change since the page load or login, and the
        // active hash is pointing to the tab, let's change it.
        if (removed && window.location.hash == '#-admin-tab-') {
          changeTab('-admin-tab-');
        }
      } else {
        if (!hasContentTab('-admin-tab-')) {
          adminTab.classes.add('-hidden');
        }
      }
    }
  }

  bool get isActive =>
      _toggleDiscontinuedButton != null &&
      _setPublisherButton != null &&
      _setPublisherInput != null;
}

/// Active on the /create-publisher page.
class _CreatePublisherWidget {
  Element _publisherIdInput;
  Element _createButton;

  void init() {
    _publisherIdInput = document.getElementById('-publisher-id');
    _createButton = document.getElementById('-admin-create-publisher');
    if (isActive) {
      update();
      _createButton.onClick.listen((_) {
        final publisherId = (_publisherIdInput as InputElement).value.trim();
        _triggerCreate(publisherId);
      });
    }
  }

  void update() {
    if (!isActive) return;
  }

  void _triggerCreate(String publisherId) async {
    if (publisherId.isEmpty || !publisherId.contains('.')) {
      window.alert('Please use a domain name as publisher id.');
      return;
    }
    if (!window.confirm(
        'Are you sure you want to create publisher for "$publisherId"?')) {
      return;
    }
    GoogleUser currentUser = getAuthInstance()?.currentUser?.get();
    final extraScope = 'https://www.googleapis.com/auth/webmasters.readonly';

    if (!currentUser.hasGrantedScopes(extraScope)) {
      // We don't have the extract scope, so let's ask for it
      currentUser = await promiseAsFuture(currentUser.grant(GrantOptions(
        scope: extraScope,
      )));
    }
    final payload = CreatePublisherRequest(
      accessToken: currentUser.getAuthResponse(true).access_token,
    );
    try {
      await client.createPublisher(publisherId, payload);
      window.location.pathname = '/publishers/$publisherId';
    } on RequestException catch (e) {
      final map = e.bodyAsJson();
      // TODO: render this message as HTML on the page.
      window.alert(map['message'] as String);
    }
  }

  bool get isActive => _publisherIdInput != null && _createButton != null;
}

/// Active on the /publishers/<publisherId>/admin page.
class _PublisherAdminWidget {
  Element _updateButton;
  TextAreaElement _descriptionTextArea;
  InputElement _inviteMemberInput;
  Element _inviteMemberButton;
  Future<PublisherMembers> membersFuture;

  void init() {
    if (!pageData.isPublisherPage) return;
    _updateButton = document.getElementById('-publisher-update-button');
    _descriptionTextArea =
        document.getElementById('-publisher-description') as TextAreaElement;
    _inviteMemberInput =
        document.getElementById('-admin-invite-member-input') as InputElement;
    _inviteMemberButton =
        document.getElementById('-admin-invite-member-button');
    if (isActive) {
      _updateButton.onClick.listen((_) => _updatePublisher());
      _inviteMemberButton.onClick.listen((_) => _inviteMember());
    }
    update();
  }

  Future _updatePublisher() async {
    final payload =
        UpdatePublisherRequest(description: _descriptionTextArea.value);
    try {
      await client.updatePublisher(pageData.publisher.publisherId, payload);
      window.location.pathname =
          '/publishers/${pageData.publisher.publisherId}';
    } on RequestException catch (e) {
      final map = e.bodyAsJson();
      window.alert(map['message'] as String);
    }
  }

  Future _inviteMember() async {
    final email = _inviteMemberInput.value.trim();
    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      window.alert('Please specify a valid e-mail.');
      return;
    }
    if (!window.confirm('Are you sure you want to invite "$email" as an '
        'administrator member to this publisher?')) {
      return;
    }
    final payload = InviteMemberRequest(email: email);
    try {
      await client.invitePublisherMember(
          pageData.publisher.publisherId, payload);
    } on RequestException catch (e) {
      final map = e.bodyAsJson();
      window.alert(map['message'] as String);
    }
  }

  Future _removeMember(PublisherMember pm) async {
    if (!window.confirm(
        'Are you sure you want to remove "${pm.email}" from this publisher?')) {
      return;
    }
    try {
      await client.removePublisherMember(
          pageData.publisher.publisherId, pm.userId);
      window.location.reload();
    } on RequestException catch (e) {
      final map = e.bodyAsJson();
      window.alert(map['message'] as String);
    }
  }

  void update() {
    // only load trigger the loading of the members list once
    if (_isAdmin && membersFuture == null) {
      final publisherId = pageData.publisher.publisherId;
      membersFuture = client.listPublisherMembers(publisherId);
      membersFuture.then((pms) async {
        final table = Element.table()
          ..children = pms.members.map((pm) {
            final button = Element.tag('button')
              ..className = 'pub-button'
              ..text = 'Remove member'
              ..onClick.listen((_) => _removeMember(pm));

            return Element.tr()
              ..children = [
                Element.td()..text = pm.email,
                Element.td()..children = [button],
              ];
          }).toList();

        document
            .getElementById('-admin-members-loading')
            .replaceWith(table);
      });
    }
  }

  bool get isActive =>
      _descriptionTextArea != null &&
      _updateButton != null &&
      _inviteMemberInput != null &&
      _inviteMemberButton != null;
}
