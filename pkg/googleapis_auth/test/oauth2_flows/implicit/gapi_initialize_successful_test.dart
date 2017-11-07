// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('browser')
import 'package:test/test.dart';
import 'package:googleapis_auth/auth_browser.dart' as auth;
import 'package:googleapis_auth/src/oauth2_flows/implicit.dart' as impl;

import 'utils.dart';

main() {
  impl.GapiUrl = resource('gapi_initialize_successful.js');

  test('gapi-initialize-successful', () {
    var clientId = new auth.ClientId('a', 'b');
    var scopes = ['scope1', 'scope2'];

    expect(auth.createImplicitBrowserFlow(clientId, scopes), completes);
  });
}
