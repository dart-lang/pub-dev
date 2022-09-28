// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:js/js.dart';

import '_dom_helper.dart';
import 'google_auth_js.dart';

/// Callback to run when the authenticated user changes.
typedef OnUpdatedFn = void Function();

/// Abstraction for the client-side authentication service.
abstract class AuthenticationProxy {
  bool isSignedIn();
  Future<bool> trySignIn();
  Future<void> signOut();
  Future<String?> accessToken({String? extraScope});
  Future<String?> idToken();
}

final _authProxyReadyCompleter = Completer();
AuthenticationProxy? _proxy;
AuthenticationProxy get authenticationProxy => _proxy!;

Future<void> get authProxyReady => _authProxyReadyCompleter.future;

/// Initializes [authenticationProxy] with Google auth.
void setupGoogleAuthenticationProxy({
  OnUpdatedFn? onUpdated,
}) {
  _proxy = _GoogleAuthenticationProxy();
  if (!_authProxyReadyCompleter.isCompleted) {
    _authProxyReadyCompleter.complete();
  }
  if (onUpdated != null) {
    String? lastId;
    getAuthInstance().currentUser.listen(allowInterop((user) {
      final currentId = user.getId();
      if (currentId == lastId) return;
      lastId = currentId;
      onUpdated();
    }));
    onUpdated();
  }
}

/// Initializes [authenticationProxy] with fake account and fixed tokens stored
/// in the browser's local storage.
void setupFakeTokenAuthenticationProxy({
  required OnUpdatedFn onUpdated,
}) {
  if (_proxy is _GoogleAuthenticationProxy) {
    throw StateError('Authenticated user is already initialized.');
  }
  _proxy = _FakeAuthenticationProxy(onUpdated);
  if (!_authProxyReadyCompleter.isCompleted) {
    _authProxyReadyCompleter.complete();
  }
  onUpdated();
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
  Future<String?> accessToken({String? extraScope}) async {
    var user = _user();
    if (user == null || !user.isSignedIn()) return null;

    if (extraScope != null && !user.hasGrantedScopes(extraScope)) {
      // We don't have the extract scope, so let's ask for it
      user = await promiseAsFuture(user.grant(GrantOptions(
        scope: extraScope,
      )));
    }

    final authResponse = user.getAuthResponse(true);
    return authResponse?.access_token;
  }

  @override
  Future<String?> idToken() async {
    final user = _user();
    if (user == null || !user.isSignedIn()) return null;
    var authResponse = user.getAuthResponse(true);

    if (authResponse == null ||
        authResponse.expires_at == null ||
        DateTime.now().millisecondsSinceEpoch > authResponse.expires_at!) {
      authResponse = await promiseAsFuture(user.reloadAuthResponse());
    }

    if (authResponse == null ||
        authResponse.expires_at == null ||
        DateTime.now().millisecondsSinceEpoch > authResponse.expires_at!) {
      throw StateError(
          'Unable to get response object from the user\'s auth session.');
    }

    return authResponse.id_token;
  }

  GoogleUser? _user() => getAuthInstance().currentUser.get();
}

class _FakeAuthenticationProxy implements AuthenticationProxy {
  static const _accessTokenKey = '-pub-fake-access-token';
  static const _idTokenKey = '-pub-fake-id-token';

  void _updateTokens(String? accessToken, String? idToken) {
    if (_accessToken == accessToken && _idToken == idToken) {
      // no-op
    } else {
      if (accessToken == null || accessToken.isEmpty) {
        window.localStorage.remove(_accessTokenKey);
      } else {
        window.localStorage[_accessTokenKey] = accessToken;
      }

      if (idToken == null || idToken.isEmpty) {
        window.localStorage.remove(_idTokenKey);
      } else {
        window.localStorage[_idTokenKey] = idToken;
      }

      // TODO: also add expiry
      _onUpdatedFn();
    }
  }

  final OnUpdatedFn _onUpdatedFn;

  _FakeAuthenticationProxy(this._onUpdatedFn);

  String? get _accessToken => window.localStorage[_accessTokenKey];
  String? get _idToken => window.localStorage[_idTokenKey];

  @override
  bool isSignedIn() => _accessToken != null && _accessToken!.isNotEmpty;

  @override
  Future<bool> trySignIn() async {
    final input = InputElement()
      ..id = '-pub-custom-token-input'
      ..placeholder = 'Enter token here'
      ..style.width = '100%';
    final ok = await modalWindow(
      titleText: 'Use custom token',
      content: input,
      isQuestion: true,
    );
    if (ok) {
      final token = input.value?.trim();
      // TODO: consider shortcut for email -> fake token conversion
      _updateTokens(token, token);
    }
    return isSignedIn();
  }

  @override
  Future<void> signOut() async {
    _updateTokens(null, null);
  }

  @override
  Future<String?> accessToken({String? extraScope}) async => _accessToken;

  @override
  Future<String?> idToken() async => _idToken;
}
