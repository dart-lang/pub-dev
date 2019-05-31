// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@JS('gapi.auth2')
library google_auth_js;

import 'package:js/js.dart';

@JS()
external GoogleAuth getAuthInstance();

@JS()
abstract class GoogleAuth {
  external GoogleAuthIsSignedIn get isSignedIn;
  external GoogleAuthCurrentUser get currentUser;
  external dynamic signOut();
}

@anonymous
@JS()
abstract class GoogleAuthIsSignedIn {
  external bool get();
}

@anonymous
@JS()
abstract class GoogleAuthCurrentUser {
  external GoogleUser get();
  external void listen(void Function(GoogleUser user) fn);
}

@JS()
abstract class GoogleUser {
  external String getId();
  external AuthResponse getAuthResponse(bool includeAuthorizationData);
  external BasicProfile getBasicProfile();
}

@JS()
abstract class AuthResponse {
  // ignore: non_constant_identifier_names
  external String get access_token;
}

@JS()
abstract class BasicProfile {
  external String getEmail();
}
