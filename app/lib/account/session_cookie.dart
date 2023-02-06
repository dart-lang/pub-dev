// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Logic to do with session cookie parsing and reading.
library session_cookie;

import 'dart:io' show HttpHeaders;

import '../shared/env_config.dart';
import '../shared/utils.dart' show buildSetCookieValue, parseCookieHeader;

/// The name of the session cookie.
///
/// Depends on whether we're running locally.
final _pubLegacySessionCookieName = '__Host-pub-sid';
final _pubLaxSessionCookieName = _cookieName('SID');
final _pubStrictSessionCookieName = _cookieName('SSID');

String _cookieName(String base) {
  if (envConfig.isRunningLocally) {
    return 'PUB_${base}_INSECURE'; // Note. this should only happen on localhost.
  }

  // Cookies prefixed '__Host-' must:
  //  * be set by a HTTPS response,
  //  * not feature a 'Domain' directive, and,
  //  * have 'Path=/' directive.
  // Hence, such a cookie cannot have been set by another website or an
  // HTTP proxy for this website.
  return '__HOST_PUB_$base';
}

/// Create a set of HTTP headers that store a session cookie.
/// https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie
Map<String, List<String>> updateSessionCookies(
  String sessionId, {
  required Duration maxAge,
}) {
  return {
    HttpHeaders.setCookieHeader: [
      buildSetCookieValue(
        name: _pubLaxSessionCookieName,
        value: sessionId,
        maxAge: maxAge,
        sameSiteStrict: false,
      ),
      buildSetCookieValue(
        name: _pubStrictSessionCookieName,
        value: sessionId,
        maxAge: maxAge,
        sameSiteStrict: true,
      ),
    ],
  };
}

/// Parse [cookieString] and return `sessionId` or `null`.
///
/// The [cookieString] is the value of the `cookie:` request header.
String? parseSessionCookie(String? cookieString) {
  final cookies = parseCookieHeader(cookieString);
  final sessionId =
      // TODO: remove legacy cookie name support two weeks after launching this
      cookies[_pubLegacySessionCookieName] ?? cookies[_pubLaxSessionCookieName];
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
Map<String, List<String>> clearSessionCookie() {
  return updateSessionCookies('', maxAge: Duration.zero);
}
