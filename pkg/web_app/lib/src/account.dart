// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:html';
import 'dart:js';

import 'package:http/http.dart';

import '_authenticated_client.dart';
import '_dom_helper.dart';
import 'google_auth_js.dart';
import 'google_js.dart';
import 'hoverable.dart';

bool _initialized = false;
GoogleUser _currentUser;

/// Returns whether the user is currently signed-in.
bool get isSignedIn => _initialized && _currentUser != null;

/// Returns the currently signed-in user or null.
GoogleUser get currentUser => _currentUser;

Client _client;
final _navWidget = _AccountNavWidget();

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
  final navRoot = document.getElementById('account-nav');
  if (navRoot != null) _navWidget.init(navRoot);
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
      // Dummy placeholder to test if the auth is working.
      final rs = await client.get('/api/account/info');
      final map = json.decode(rs.body) as Map<String, dynamic>;
      final email = map['email'] as String;
      print('Server sent e-mail: $email');
      _updateUi();
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
}

class _AccountNavWidget {
  Element _root;

  Element _login;
  Element _profile;
  Element _image;
  Element _email;

  void init(Element root) {
    _root = root;
    _login = elem('a',
        classes: ['link'],
        text: 'Login',
        onClick: (_) => getAuthInstance().signIn());
    _profile = elem(
      'div',
      classes: ['sub-wrap', 'hoverable'],
      children: [
        _image = elem('img', classes: ['profile-img']),
        elem(
          'div',
          classes: ['sub-nav'],
          children: [
            _email = elem('div'),
            elem('a',
                classes: ['link'],
                text: 'Logout',
                onClick: (_) => getAuthInstance().signOut())
          ],
        ),
      ],
    );
    _root.append(_login);
    _root.append(_profile);
    registerHoverable(_profile);
    update();
  }

  void update() {
    if (!_initialized) {
      return;
    }
    updateDisplay(_login, !isSignedIn);
    updateDisplay(_profile, isSignedIn);
    if (isSignedIn) {
      _image.attributes['src'] = _currentUser.getBasicProfile().getImageUrl();
      _email.text = _currentUser.getBasicProfile().getEmail();
    }
  }
}
