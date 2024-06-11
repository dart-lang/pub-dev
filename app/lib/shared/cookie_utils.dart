// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/shared/env_config.dart';

/// Returns a cookie name depending on the current environment:
/// - Local environments will get a regular cookie (with an arbitrary `_INSECURE` postfix)
/// - Prod environments will get a `__Host-`-prefixed cookie with better security .
String pubCookieName(String baseName) {
  if (envConfig.isRunningLocally) {
    return 'PUB_${baseName.toUpperCase()}_INSECURE'; // Note. this should only happen on localhost.
  }

  // Cookies prefixed '__Host-' must:
  //  * be set by a HTTPS response,
  //  * not feature a 'Domain' directive, and,
  //  * have 'Path=/' directive.
  // Hence, such a cookie cannot have been set by another website or an
  // HTTP proxy for this website.
  return '__Host-PUB_${baseName.toUpperCase()}';
}

/// Builds the Set-Cookie HTTP header value.
String buildSetCookieValue({
  required String name,
  required String value,
  required Duration maxAge,
  bool sameSiteStrict = false,
}) {
  if (maxAge < Duration.zero) {
    maxAge = Duration.zero;
  }
  if (value.isEmpty || maxAge == Duration.zero) {
    value = '""';
  }
  return [
    '$name=$value',
    // Send cookie to anything under '/' required by '__Host-' prefix.
    'Path=/',
    // Max-Age takes precedence over 'Expires', this also has the benefit of
    // not being corrupted by client-side clock skew.
    'Max-Age=${maxAge.inSeconds}',
    // Do not include the cookie in CORS requests, unless the request is a
    // top-level navigation to the site, as recommended in:
    // https://tools.ietf.org/html/draft-ietf-httpbis-rfc6265bis-02#section-8.8.2
    if (sameSiteStrict) 'SameSite=Strict' else 'SameSite=Lax',
    if (!envConfig.isRunningLocally)
      'Secure', // Only allow this cookie to be sent when making HTTPS requests.
    'HttpOnly', // Do not allow JavaScript access to this cookie.
  ].join('; ');
}

/// Parses the Cookie HTTP header and returns a map of the values.
///
/// This always return a non-null [Map], even if the [cookieHeader] is empty.
Map<String, String> parseCookieHeader(String? cookieHeader) {
  if (cookieHeader == null || cookieHeader.isEmpty) {
    return <String, String>{};
  }
  try {
    final r = <String, String>{};
    // The cookieString is separated by '; ', and contains 'name=value'
    // See: https://tools.ietf.org/html/rfc6265#section-5.4
    for (final s in cookieHeader.split('; ')) {
      final i = s.indexOf('=');
      if (i != -1) {
        r[s.substring(0, i)] = s.substring(i + 1);
      }
    }
    return r;
  } catch (_) {
    // Ignore broken cookies, we could throw a ResponseException instead, and
    // send the user a 400 error, this would be more correct. But unfortunately
    // it wouldn't help the user if the browser is sending a malformed 'cookie'
    // header. It would only serve to persistently break the site for the user.
    return <String, String>{};
  }
}
