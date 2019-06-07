// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Partial bindings for the Google Auth JS APIs.
/// https://developers.google.com/identity/sign-in/web/reference
@JS('gapi.auth2')
library google_auth_js;

import 'package:js/js.dart';

/// Returns the auth library's main instance (if initialized).
@JS()
external GoogleAuth getAuthInstance();

/// The auth library's main instance.
@JS()
abstract class GoogleAuth {
  /// The sign in status.
  external GoogleAuthIsSignedIn get isSignedIn;

  /// The current user.
  external GoogleAuthCurrentUser get currentUser;

  /// Triggers a sign-out, and returns a Promise that will complete when the
  /// sign-out is finalized.
  external dynamic signOut();
}

@anonymous
@JS()
abstract class GoogleAuthIsSignedIn {
  /// Returns the current sign-in status.
  external bool get();
}

@anonymous
@JS()
abstract class GoogleAuthCurrentUser {
  /// Returns the current authenticated user.
  external GoogleUser get();

  /// Listen on authenticated user changes.
  external void listen(void Function(GoogleUser user) fn);
}

/// The authenticated user object.
@JS()
abstract class GoogleUser {
  /// The external id of the user.
  external String getId();

  /// The auth response.
  external AuthResponse getAuthResponse(bool includeAuthorizationData);

  /// The basic profile info.
  external BasicProfile getBasicProfile();
}

/// The auth response data.
@JS()
abstract class AuthResponse {
  /// The access token to use for requests.
  // ignore: non_constant_identifier_names
  external String get access_token;
}

/// The basic profile data of the user.
@JS()
abstract class BasicProfile {
  /// The e-mail address of the user
  external String getEmail();
}
