// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';
import 'dart:js';

import 'package:_pub_shared/data/account_api.dart';

import '_authentication_proxy.dart';
import '_dom_helper.dart';
import 'admin_pages.dart' deferred as admin_pages;
import 'api_client/api_client.dart' deferred as api_client;
import 'google_auth_js.dart';
import 'google_js.dart';

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

  // Initialization hook that will run after the Google Identity Service library
  // is loaded and initialized. Method name is passed in as an attribute in the DOM.
  context['pubGsiClientInit'] = () {
    window.console.log('GIS client loaded.');
    // TODO: implement initialization
    // Some resources:
    // - https://developers.googleblog.com/2022/03/gis-jsweb-authz-migration.html
    // - https://developers.google.com/identity/gsi/web/guides/overview
    // - https://developers.google.com/identity/gsi/web/guides/migration#object_migration_reference_for_user_sign-in
    // - https://developers.google.com/identity/gsi/web/reference/js-reference
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

void _initWidgets() {
  document
      .getElementById('-account-login')
      ?.onClick
      .listen((_) => authenticationProxy.trySignIn());
  document.getElementById('-account-logout')?.onClick.listen((_) async {
    await authenticationProxy.signOut();
    // force-reload page if it was not reloaded after signing out
    if (document.getElementById('-account-logout') != null) {
      window.location.reload();
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
