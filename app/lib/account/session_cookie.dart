// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Logic to do with session cookie parsing and reading.
library session_cookie;

import 'dart:io' show HttpHeaders;

import 'package:clock/clock.dart';

import '../shared/cookie_utils.dart';
import '../shared/env_config.dart';

/// The name of the session cookie.
///
/// Depends on whether we're running locally.
String get _pubSessionCookieName {
  if (envConfig.isRunningLocally) {
    return 'pub-sid-insecure'; // Note. this should only happen on localhost.
  }

  // Cookies prefixed '__Host-' must:
  //  * be set by a HTTPS response,
  //  * not feature a 'Domain' directive, and,
  //  * have 'Path=/' directive.
  // Hence, such a cookie cannot have been set by another website or an
  // HTTP proxy for this website.
  return '__Host-pub-sid';
}

/// Create a set of HTTP headers that store a session cookie.
Map<String, String> createSessionCookie(String sessionId, DateTime expires) {
  // Always create a cookie that expires 25 minutes before the session.
  // This way clock skew on the client is less likely to cause us to receive
  // an invalid cookie. Not that getting an expired cookie should be a problem.
  final expiration = expires.subtract(Duration(minutes: 25));
  final maxAge = expiration.difference(clock.now());
  // https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie
  return {
    HttpHeaders.setCookieHeader: buildSetCookieValue(
      name: _pubSessionCookieName,
      value: sessionId,
      maxAge: maxAge,
    ),
  };
}

/// Parse [cookieString] and return `sessionId` or `null`.
///
/// The [cookieString] is the value of the `cookie:` request header.
String? parseSessionCookie(String? cookieString) {
  final sessionId = parseCookieHeader(cookieString)['$_pubSessionCookieName'];
  // An empty sessionId cookie is the result of reseting the cookie.
  // Browser usually won't send this, but let's make sure we handle the case.
  if (sessionId != null && sessionId.isEmpty) {
    return null;
  }
  return sessionId;
}

/// Create a set of HTTP headers that clears a session cookie.
///
/// If clearing the session cookie, remember that the most important part is to
/// invalidate the serverside session. The user might be logging out because
/// the local session store was compromised.
Map<String, String> clearSessionCookie() {
  return {
    HttpHeaders.setCookieHeader: buildSetCookieValue(
      name: _pubSessionCookieName,
      value: '',
      maxAge: Duration.zero,
    ),
  };
}
