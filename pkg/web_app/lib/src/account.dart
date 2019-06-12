// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:html';
import 'dart:js';

import 'package:http/http.dart';

import '_authenticated_client.dart';
import 'google_auth_js.dart';
import 'google_js.dart';

bool _initialized = false;
Element _logoutElem;
Element _accountInfoElem;

GoogleUser _currentUser;

/// Returns whether the user is currently signed-in.
bool get isSignedIn => _initialized && _currentUser != null;

/// Returns the currently signed-in user or null.
GoogleUser get currentUser => _currentUser;

Client _client;

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
    load('auth2', allowInterop(_init));
  };
}

void _init() {
  _initialized = true;

  final accountHeaderElem = document.body.querySelector('.account-header');
  if (accountHeaderElem == null) {
    return;
  }

  _logoutElem = document.createElement('a')
    ..text = 'Logout'
    ..onClick.listen((_) {
      // TODO: await Promise
      getAuthInstance().signOut();
      _updateUser(null);
    });
  accountHeaderElem.append(_logoutElem);

  _accountInfoElem = document.createElement('div');
  accountHeaderElem.append(_accountInfoElem);

  _updateUser(null);
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
    _accountInfoElem.text = currentUser.getBasicProfile().getEmail();
    _logoutElem.style.display = 'block';
  } else {
    print('No active user');
    _accountInfoElem.text = '-';
    _logoutElem.style.display = 'none';
  }
}
