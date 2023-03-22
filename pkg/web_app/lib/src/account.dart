// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';
import 'dart:js';

import 'package:_pub_shared/data/account_api.dart';
import 'package:web_app/src/page_data.dart';

import '_authentication_proxy.dart';
import '_dom_helper.dart';
import 'admin_pages.dart' deferred as admin_pages;
import 'api_client/api_client.dart' deferred as api_client;
import 'google_auth_js.dart';
import 'google_js.dart';

late final _newSigningMetaContent = document
    .querySelector('meta[name="pub-experiment-signin"]')
    ?.getAttribute('content');
late final useNewSignin = _newSigningMetaContent == '1';

void setupAccount() {
  if (useNewSignin) {
    _initSessionMonitor();
    _initWidgets();
    return;
  } else {
    _setupOldAccount();
  }
}

void _initSessionMonitor() {
  // No need to monitor session on non-editable pages,
  // where no action or state-change may be started.
  if (!pageData.isSessionAware) {
    return;
  }

  final checkFrequency = Duration(minutes: 5);
  final sessionExpiresThreshold = Duration(minutes: 45);
  final authenticationThreshold = Duration(minutes: 55);

  DivElement? lastDiv;
  String? lastMessage;
  void removeLast() {
    lastDiv?.remove();
    lastDiv = null;
    lastMessage = null;
  }

  Future<void> checkSession() async {
    await api_client.loadLibrary();
    final status = await api_client.unauthenticatedClient.getAccountSession();
    final now = DateTime.now();
    final expires = status.expires;
    final authenticatedAt = status.authenticatedAt;
    String? displayMessage;
    if (expires == null || authenticatedAt == null) {
      displayMessage = 'Your session has expired.';
    } else if (expires.isBefore(now.add(sessionExpiresThreshold)) ||
        authenticatedAt.isBefore(now.subtract(authenticationThreshold))) {
      displayMessage = 'Your session will expire soon.';
    }
    if (lastMessage != displayMessage) {
      removeLast();
      lastMessage = displayMessage;

      if (displayMessage != null) {
        final div = DivElement()
          ..classes.add('-pub-session-warning')
          ..innerText = displayMessage
          ..append(ButtonElement()
            ..text = 'X'
            ..onClick.listen((_) => removeLast()));
        document.body!.append(div);
        lastDiv = div;
      }
      return;
    }
  }

  /// TODO: rewrite this to just make a while loop and then do await
  /// Future.delayed(sessionExpiresThreshold.subtract(now.subtract(authenticatedAt)))
  Timer.periodic(checkFrequency, (timer) async {
    await checkSession();
  });
}

void _setupOldAccount() {
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
        await markdown(
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

void _doSignIn({bool selectAccount = false}) {
  final signInButton = document.getElementById('-account-login');
  // fake sign-in hook for integration tests
  final fakeEmail =
      signInButton == null ? null : signInButton.dataset['fake-email'];
  final uri = Uri.parse(window.location.href);
  final relativeUri = Uri(
    path: uri.path,
    query: uri.hasQuery ? uri.query : null,
  );
  final newLocation = Uri(
    scheme: uri.scheme,
    host: uri.host,
    port: uri.port,
    path: '/sign-in',
    queryParameters: {
      'go': relativeUri.toString(),
      if (selectAccount) 'select': '1',
      if (fakeEmail != null) 'fake-email': fakeEmail,
    },
  );
  window.location.assign(newLocation.toString());
}

void _initWidgets() {
  document.getElementById('-account-login')?.onClick.listen((_) {
    if (useNewSignin) {
      _doSignIn();
    } else {
      authenticationProxy.trySignIn();
    }
  });
  document.getElementById('-account-switch')?.onClick.listen((_) {
    _doSignIn(selectAccount: true);
  });
  document.getElementById('-account-logout')?.onClick.listen((e) async {
    if (useNewSignin) {
      await api_client.loadLibrary();
      await api_client.client.invalidateSession();
      window.location.reload();
    } else {
      await authenticationProxy.signOut();
      // Force session invalidation in case the signOut() wouldn't trigger it at this point.
      await api_client.unauthenticatedClient.invalidateSession();
      // Force page reload if it was not done after signing out.
      if (document.getElementById('-account-logout') != null) {
        window.location.reload();
      }
    }
  });
  admin_pages.loadLibrary().then((_) => admin_pages.initAdminPages());
}

/// update or delete session
Future _updateSession() async {
  await api_client.loadLibrary();
  if (!authenticationProxy.isSignedIn()) {
    final st1 = ClientSessionStatus.fromBytes(
        await api_client.unauthenticatedClient.invalidateSession());
    if (st1.changed == true) {
      final st2 = ClientSessionStatus.fromBytes(
        await api_client.unauthenticatedClient.invalidateSession(),
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
    final st1 = ClientSessionStatus.fromBytes(
        await api_client.client.updateSession(body));
    if (st1.changed == true) {
      final st2 = ClientSessionStatus.fromBytes(
          await api_client.client.updateSession(body));
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
