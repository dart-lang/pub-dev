// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('browser')
import 'dart:html';
import 'dart:js' as js;

import 'package:test/test.dart';
import 'package:googleapis_auth/auth_browser.dart' as auth;
import 'package:googleapis_auth/src/oauth2_flows/implicit.dart' as impl;

import 'utils.dart';
import '../../test_utils.dart';

main() {
  // The default timeout is too small for us to detect the timeout of loading
  // the gapi.auth library.
  Timeout timeout = const Timeout(const Duration(hours: 1));

  var clientId = new auth.ClientId('a', 'b');
  var scopes = ['scope1', 'scope2'];

  test('gapi-load-failure', () {
    impl.GapiUrl = resource('non_existent.js');
    expect(auth.createImplicitBrowserFlow(clientId, scopes), throws);
  }, timeout: timeout);

  test('gapi-load-failure--syntax-error', () {
    impl.GapiUrl = resource('gapi_load_failure.js');

    // Reset test_controller.js's window.onerror registration.
    // This makes sure we can catch the onError callback when the syntax error
    // is produced.
    js.context['onerror'] = null;

    window.onError.listen(expectAsyncT((error) {
      error.preventDefault();
    }));

    var sw = new Stopwatch()..start();
    var flowFuture = auth.createImplicitBrowserFlow(clientId, scopes);
    flowFuture.catchError(expectAsync((_, __) {
      var elapsed = (sw.elapsed - impl.ImplicitFlow.CallbackTimeout).inSeconds;
      expect(-3 <= elapsed && elapsed <= 3, isTrue);
    }));
  }, timeout: timeout);
}
