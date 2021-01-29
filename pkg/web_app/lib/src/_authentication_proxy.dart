// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:js/js.dart';
import 'package:meta/meta.dart';

import 'google_auth_js.dart';

/// Abstraction for the client-side authentication service.
abstract class AuthenticationProxy {
  bool isSignedIn();
  Future<bool> trySignIn();
  Future<void> signOut();
  Future<String> accessToken({String extraScope});
  Future<String> idToken();
}

final _authProxyReadyCompleter = Completer();
AuthenticationProxy _proxy;
AuthenticationProxy get authenticationProxy => _proxy;

Future<void> get authProxyReady => _authProxyReadyCompleter.future;

/// Initializes [authenticationProxy] with Google auth.
void setupGoogleAuthenticationProxy({
  void Function() onUpdated,
}) {
  _proxy = _GoogleAuthenticationProxy();
  if (!_authProxyReadyCompleter.isCompleted) {
    _authProxyReadyCompleter.complete();
  }
  if (onUpdated != null) {
    String lastId;
    getAuthInstance().currentUser.listen(allowInterop((user) {
      final currentId = user?.getId();
      if (currentId == lastId) return;
      lastId = currentId;
      onUpdated();
    }));
    onUpdated();
  }
}

/// Initializes [authenticationProxy] with fake account and fixed tokens.
void setupFakeUser({
  @required String accessToken,
  @required String idToken,
}) {
  if (_proxy is _GoogleAuthenticationProxy) {
    throw StateError('Authenticated user is already initialized.');
  }
  _proxy = _FakeAuthenticationProxy(accessToken, idToken);
  if (!_authProxyReadyCompleter.isCompleted) {
    _authProxyReadyCompleter.complete();
  }
}

class _GoogleAuthenticationProxy implements AuthenticationProxy {
  @override
  bool isSignedIn() {
    final user = _user();
    return user != null && user.isSignedIn();
  }

  @override
  Future<bool> trySignIn() async {
    await promiseAsFuture(
        getAuthInstance().signIn(SignInOptions(prompt: 'select_account')));
    return isSignedIn();
  }

  @override
  Future<void> signOut() async {
    await promiseAsFuture(getAuthInstance().signOut());
  }

  @override
  Future<String> accessToken({String extraScope}) async {
    var user = _user();
    if (user == null || !user.isSignedIn()) return null;

    if (extraScope != null && !user.hasGrantedScopes(extraScope)) {
      // We don't have the extract scope, so let's ask for it
      user = await promiseAsFuture(user.grant(GrantOptions(
        scope: extraScope,
      )));
    }

    final authResponse = user.getAuthResponse(true);
    return authResponse.access_token;
  }

  @override
  Future<String> idToken() async {
    final user = _user();
    if (user == null || !user.isSignedIn()) return null;
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
  }

  GoogleUser _user() => getAuthInstance().currentUser.get();
}

class _FakeAuthenticationProxy implements AuthenticationProxy {
  final String _accessToken;
  final String _idToken;

  _FakeAuthenticationProxy(this._accessToken, this._idToken);

  @override
  bool isSignedIn() => _accessToken != null && _accessToken.isNotEmpty;

  @override
  Future<bool> trySignIn() async {
    return isSignedIn();
  }

  @override
  Future<void> signOut() async {
    setupFakeUser(accessToken: null, idToken: null);
  }

  @override
  Future<String> accessToken({String extraScope}) async => _accessToken;

  @override
  Future<String> idToken() async => _idToken;
}
