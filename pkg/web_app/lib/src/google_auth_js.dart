// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Partial bindings for the Google Auth JS APIs.
/// https://developers.google.com/identity/sign-in/web/reference
@JS('gapi.auth2')
library google_auth_js;

import 'dart:async';
import 'package:js/js.dart';

/// Minimal interface for promise.
@JS('Promise')
class Promise<T> {
  external Promise then(
    void Function(T) onAccept,
    void Function(Exception) onReject,
  );
}

/// Convert a promise to a future.
Future<T> promiseAsFuture<T>(Promise<T> promise) {
  ArgumentError.checkNotNull(promise, 'promise');

  final c = Completer<T>();
  promise.then(allowInterop(Zone.current.bindUnaryCallback((T result) {
    c.complete(result);
  })), allowInterop(Zone.current.bindUnaryCallback((Object e) {
    c.completeError(e);
  })));
  return c.future;
}

/// Initializes the GoogleAuth object. You must call this method before calling
/// gapi.auth2.GoogleAuth's methods.
@JS()
external GoogleAuth init(dynamic params);

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

  /// Triggers a sign-in, and returns a Promise that will complete when the
  /// sign-in is finalized.
  external Promise<GoogleUser> signIn([SignInOptions options]);

  /// Triggers a sign-out, and returns a Promise that will complete when the
  /// sign-out is finalized.
  external dynamic signOut();

  /// Revokes all of the scopes that the user granted.
  ///
  /// (Useful when debugging oauth2 scope grant flow).
  external void disconnect();

  /// Calls the onInit function when the GoogleAuth object is fully initialized.
  /// If an error is raised while initializing, the onError function will be
  /// called instead.
  external dynamic then(Function onInit);
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

  /// Get the response object from the user's auth session.
  external AuthResponse getAuthResponse(bool includeAuthorizationData);

  /// Forces a refresh of the access token, and then returns a Promise for the
  /// new AuthResponse.
  external Promise<AuthResponse> reloadAuthResponse();

  /// Returns true if the user granted the specified scopes.
  ///
  /// The [scopes] is a space-delemited list of scopes.
  external bool hasGrantedScopes(String scopes);

  /// Request additional scopes to the user.
  ///
  /// **Example**
  /// ```dart
  /// GoogleUser currentUser = getAuthInstance()?.currentUser?.get();
  ///
  /// final extraScope = 'https://www.googleapis.com/auth/webmasters.readonly';
  ///
  /// if (!currentUser.hasGrantedScopes(extraScope)) {
  ///   // We don't have the extract scope, so let's ask for it
  ///   currentUser = await promiseAsFuture(currentUser.grant(GrantOptions(
  ///     scope: extraScope,
  ///   )));
  /// }
  /// ```
  external Promise<GoogleUser> grant(GrantOptions options);

  /// The basic profile info.
  external BasicProfile getBasicProfile();

  /// Returns true if the user is signed in.
  external bool isSignedIn();
}

/// The auth response data.
@JS()
abstract class AuthResponse {
  /// The access token to use for requests to googleapis.
  external String get access_token; // ignore: non_constant_identifier_names

  /// The openid-connect ID token for authenticating requests pub.dev
  external String get id_token; // ignore: non_constant_identifier_names

  /// The scopes granted in the Access Token.
  external String get scope; // ignore: non_constant_identifier_names

  /// The timestamp at which the Access Token will expire.
  external int get expires_at; // ignore: non_constant_identifier_names
}

/// The basic profile data of the user.
@JS()
abstract class BasicProfile {
  /// The profile image URL of the user.
  external String getImageUrl();

  /// The e-mail address of the user.
  external String getEmail();
}

@JS()
@anonymous
abstract class GrantOptions {
  external String get scope;

  external factory GrantOptions({
    String scope,
  });
}

/// https://developers.google.com/identity/sign-in/web/reference#gapiauth2signinoptions
@JS()
@anonymous
abstract class SignInOptions {
  /// `consent`, `select_account`, `none`
  external String get prompt;

  external factory SignInOptions({
    /// `consent`, `select_account`, `none`
    String prompt,
  });
}
