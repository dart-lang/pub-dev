// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io' show HttpHeaders;

import '../shared/configuration.dart' show envConfig;
import '../shared/utils.dart' show buildSetCookieValue, parseCookieHeader;

import 'models.dart';

/// The name of the SearchPreference cookie.
///
/// Depends on whether we're running locally.
String get _pubSearchPreferenceCookieName {
  if (envConfig.isRunningLocally) {
    return 'pub-sp-insecure'; // Note. this should only happen on localhost.
  }

  // Cookies prefixed '__Host-' must:
  //  * be set by a HTTPS response,
  //  * not feature a 'Domain' directive, and,
  //  * have 'Path=/' directive.
  // Hence, such a cookie cannot have been set by another website or an
  // HTTP proxy for this website.
  return '__Host-pub-sp';
}

/// Create a set of HTTP headers that store the new current preference.
Map<String, String> createSearchPreferenceCookie(SearchPreference value) {
  final expiration = DateTime.now().add(Duration(days: 30));
  // https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie
  return {
    HttpHeaders.setCookieHeader: buildSetCookieValue(
      name: _pubSearchPreferenceCookieName,
      value: value.toCookieValue(),
      expires: expiration,
    ),
  };
}

/// Parse [cookieString] and return `SearchPreference` or `null`.
///
/// The [cookieString] is the value of the `cookie:` request header.
SearchPreference parseSearchPreferenceCookie(String cookieString) {
  ArgumentError.checkNotNull(cookieString, 'cookieString');
  final value = parseCookieHeader(cookieString)[_pubSearchPreferenceCookieName];
  return SearchPreference.tryParseCookieValue(value);
}
