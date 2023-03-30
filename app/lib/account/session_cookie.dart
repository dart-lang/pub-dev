// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Logic to do with session cookie parsing and reading.
library session_cookie;

import 'dart:io' show HttpHeaders;

import 'package:meta/meta.dart';

import '../shared/cookie_utils.dart';
import '../shared/exceptions.dart';

/// The client session cookie that will be sent on every kind of session.
@visibleForTesting
final clientSessionLaxCookieName = pubCookieName('SID');

/// The client session cookie that will be sent only on strictly top-level
/// sessions using SameSite=Strict.
@visibleForTesting
final clientSessionStrictCookieName = pubCookieName('SSID');

/// Create a set of HTTP headers that store the client session cookie.
Map<String, Object> createClientSessionCookie({
  required String sessionId,
  required Duration maxAge,
}) {
  return {
    HttpHeaders.setCookieHeader: [
      buildSetCookieValue(
        name: clientSessionLaxCookieName,
        value: sessionId,
        maxAge: maxAge,
      ),
      buildSetCookieValue(
        name: clientSessionStrictCookieName,
        value: sessionId,
        maxAge: maxAge,
        sameSiteStrict: true,
      ),
    ],
  };
}

/// Parses the cookie values and returns the status of client session cookies.
ClientSessionCookieStatus parseClientSessionCookies(
    Map<String, String> cookies) {
  final lax = cookies[clientSessionLaxCookieName]?.trim() ?? '';
  final strict = cookies[clientSessionStrictCookieName]?.trim() ?? '';
  final needsReset = (lax.isEmpty && strict.isNotEmpty) ||
      (lax.isNotEmpty && strict.isNotEmpty && lax != strict);
  if (needsReset) {
    throw AuthenticationException.cookieInvalid(
      headers: clearSessionCookies(),
    );
  }
  if (lax.isEmpty) {
    return ClientSessionCookieStatus.missing();
  } else {
    return ClientSessionCookieStatus(
      sessionId: lax,
      isStrict: strict.isNotEmpty,
    );
  }
}

/// Create a set of HTTP headers that clears a session cookie.
///
/// If clearing the session cookie, remember that the most important part is to
/// invalidate the serverside session. The user might be logging out because
/// the local session store was compromised.
Map<String, Object> clearSessionCookies() {
  return {
    HttpHeaders.setCookieHeader: [
      buildSetCookieValue(
        name: clientSessionLaxCookieName,
        value: '',
        maxAge: Duration.zero,
      ),
      buildSetCookieValue(
        name: clientSessionStrictCookieName,
        value: '',
        maxAge: Duration.zero,
      ),
    ],
  };
}

/// The session cookies present with the request, with the current session identifier.
class ClientSessionCookieStatus {
  final bool isStrict;
  final String? sessionId;

  ClientSessionCookieStatus.missing()
      : isStrict = false,
        sessionId = null;

  ClientSessionCookieStatus({
    required this.sessionId,
    required this.isStrict,
  });

  late final isPresent = sessionId != null && sessionId!.isNotEmpty;
}
