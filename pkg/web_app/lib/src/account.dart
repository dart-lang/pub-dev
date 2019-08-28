// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:html';
import 'dart:js';

import 'package:client_data/account_api.dart';
import 'package:client_data/package_api.dart';
import 'package:client_data/publisher_api.dart';
import 'package:http/http.dart';

import '_authenticated_client.dart';
import '_dom_helper.dart';
import 'google_auth_js.dart';
import 'google_js.dart';
import 'hoverable.dart';
import 'page_data.dart';
import 'tabs.dart';

bool _initialized = false;
GoogleUser _currentUser;
bool _isPkgUploader = false;

/// Returns whether the user is currently signed-in.
bool get isSignedIn => _initialized && _currentUser != null;

/// Returns the currently signed-in user or null.
GoogleUser get currentUser => _currentUser;

Client _client;
final _navWidget = _AccountNavWidget();
final _pkgAdminWidget = _PkgAdminWidget();
final _createPublisherWidget = _CreatePublisherWidget();

/// The HTTP Client to use with account credentials.
Client get client {
  return _client ??=
      getAuthenticatedClient(currentUser.getAuthResponse(true)?.access_token);
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
  _pkgAdminWidget.init();
  _createPublisherWidget.init();
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
  _client?.close();
  _client = null;

  _updateOnCredChange();
  _updateUi();
}

Future _updateOnCredChange() async {
  if (isSignedIn) {
    try {
      if (pageData.isPackagePage) {
        final rs = await client
            .get('/api/account/options/packages/${pageData.pkgData.package}');
        final map = json.decode(rs.body) as Map<String, dynamic>;
        final options = AccountPkgOptions.fromJson(map);
        _isPkgUploader = options.isAdmin ?? false;
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
  _pkgAdminWidget.update();
  _createPublisherWidget.update();
}

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

class _PkgAdminWidget {
  Element _unauthenticatedRoot;
  Element _unauthorizedRoot;
  Element _authorizedRoot;

  void init() {
    if (!pageData.isPackagePage) return;
    _unauthenticatedRoot = document.getElementById('-admin-unauthenticated');
    _unauthorizedRoot = document.getElementById('-admin-unauthorized');
    _authorizedRoot = document.getElementById('-admin-authorized');
    update();
  }

  Future _toogleDiscontinued() async {
    if (!window.confirm(
        'Are you sure you want change the "discontinued" status of the package?')) {
      return;
    }
    final options =
        PkgOptions(isDiscontinued: !pageData.pkgData.isDiscontinued);
    final rs = await client.put(
      '/api/packages/${pageData.pkgData.package}/options',
      body: json.encode(options.toJson()),
    );
    final map = json.decode(rs.body) as Map<String, dynamic>;
    if (rs.statusCode == 200) {
      window.location.reload();
    } else {
      window.alert(map['error'] as String);
    }
  }

  void update() {
    if (isActive) {
      final unauthenticated = !isSignedIn;
      final unauthorized = isSignedIn && !_isPkgUploader;
      final authorized = isSignedIn && _isPkgUploader;
      updateDisplay(_unauthenticatedRoot, unauthenticated);
      updateDisplay(_unauthorizedRoot, unauthorized, display: 'block');
      updateDisplay(_authorizedRoot, authorized, display: 'block');

      // initialize only once
      if (authorized && _authorizedRoot.dataset['initialized'] != '1') {
        document
            .querySelector('.-admin-is-discontinued-toggle')
            .onClick
            .listen((_) => _toogleDiscontinued());
        _authorizedRoot.dataset['initialized'] = '1';
      }
    }

    final adminTab = getTabElement('-admin-tab-');
    if (adminTab != null) {
      if (_initialized && _isPkgUploader) {
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
      _unauthenticatedRoot != null &&
      _unauthorizedRoot != null &&
      _authorizedRoot != null;
}

class _CreatePublisherWidget {
  Element _unauthenticatedRoot;
  Element _authenticatedRoot;
  Element _publisherIdInput;
  Element _createButton;

  void init() {
    _unauthenticatedRoot = document.getElementById('-admin-unauthenticated');
    _authenticatedRoot = document.getElementById('-admin-authenticated');
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
    updateDisplay(_unauthenticatedRoot, !isSignedIn);
    updateDisplay(_authenticatedRoot, isSignedIn, display: 'block');
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
    final rs = await client.post(
      '/api/publishers/$publisherId',
      body: json.encode(
        CreatePublisherRequest(
          accessToken: currentUser.getAuthResponse(true).access_token,
        ),
      ),
    );
    final map = json.decode(rs.body) as Map<String, dynamic>;
    if (rs.statusCode == 200) {
      final uri = Uri.parse(window.location.href);
      final newUri = uri.replace(path: '/publishers/$publisherId');
      window.location.href = newUri.toString();
    } else {
      // TODO: render this message as HTML on the page.
      window.alert(map['error'] as String ?? map['message'] as String);
    }
  }

  bool get isActive =>
      _unauthenticatedRoot != null &&
      _authenticatedRoot != null &&
      _publisherIdInput != null &&
      _createButton != null;
}
