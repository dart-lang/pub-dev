// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

/// The content of the fake credentials.json that can be used against fake_pub_server.
String fakeCredentialsFileContent() {
  return json.encode({
    'accessToken': 'user-at-example-dot-com',
    'refreshToken': 'refresh-token',
    'tokenEndpoint': 'http://localhost:9999/o/oauth2/token',
    'scopes': ['email', 'openid'],
    'expiration': 2558512791154,
  });
}
