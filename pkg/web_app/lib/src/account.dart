// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:web_app/src/page_data.dart';

import 'admin_pages.dart' deferred as admin_pages;
import 'api_client/api_client.dart' deferred as api_client;

final _signInButton = document.getElementById('-account-login');

void setupAccount() {
  _initSessionMonitor();
  _initWidgets();
}

void _initSessionMonitor() {
  // No need to monitor session on non-editable pages,
  // where no action or state-change may be started.
  if (!pageData.isSessionAware) {
    return;
  }
  // No need to monitor if the page was created with an unauthenticated session.
  if (_signInButton != null) {
    return;
  }

  final defaultCheckDelay = Duration(minutes: 5);
  final authenticationThreshold = Duration(minutes: 55);
  final maxDurationBetweenChecks = authenticationThreshold - defaultCheckDelay;
  final sessionExpiresThreshold =
      authenticationThreshold - (defaultCheckDelay * 2);

  DivElement? lastDiv;
  String? lastMessage;
  void removeLast() {
    lastDiv?.remove();
    lastDiv = null;
    lastMessage = null;
  }

  /// Checks current session status and returns the last authentication timestamp
  /// (or null if session timed out).
  Future<DateTime?> checkSession() async {
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
    }
    return authenticatedAt;
  }

  Future<void> monitor() async {
    DateTime? authenticatedAt;
    for (;;) {
      if (authenticatedAt == null) {
        // On the first cycle this ensures that we wait ample time before
        // the first check. Subsequent cycles should have a non-zero value,
        // unless the user session timed out or expired.
        //
        // In any of the above cases, defaulting to the default frequency is safe.
        await Future.delayed(defaultCheckDelay);
      } else {
        // When the session is active, we can run the next check just before the
        // authentication threshold maxes out. Added sanity checks to bound the delay
        // within a reasonable timeframe.
        var nextCheck = authenticatedAt
            .add(maxDurationBetweenChecks)
            .difference(DateTime.now());
        if (nextCheck > maxDurationBetweenChecks) {
          nextCheck = maxDurationBetweenChecks;
        } else if (nextCheck < defaultCheckDelay) {
          nextCheck = defaultCheckDelay;
        }
        await Future.delayed(nextCheck);
      }

      // Update session information and label.
      authenticatedAt = await checkSession();
    }
  }

  // Start monitoring without waiting on the infinite loop to complete.
  unawaited(Future.microtask(monitor));
}

void _doSignIn({bool selectAccount = false}) {
  // fake sign-in hook for integration tests
  final fakeEmail = _signInButton?.dataset['fake-email'];
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
    _doSignIn();
  });
  document.getElementById('-account-switch')?.onClick.listen((_) {
    _doSignIn(selectAccount: true);
  });
  document.getElementById('-account-logout')?.onClick.listen((e) async {
    await api_client.loadLibrary();
    await api_client.client.invalidateSession();
    window.location.reload();
  });
  admin_pages.loadLibrary().then((_) => admin_pages.initAdminPages());
}
