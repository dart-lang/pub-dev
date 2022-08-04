// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../shared/env_config.dart';

final _none = <String>["'none'"];

/// Content Security Policy (CSP) is an added layer of security that helps to
/// detect and mitigate certain types of attacks, including Cross Site Scripting
/// (XSS) and data injection attacks.
///
/// https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP
final defaultContentSecurityPolicySerialized = _serializeCSP(null);

final _defaultContentSecurityPolicyMap = <String, List<String>>{
  'default-src': <String>[
    "'self'",
    'https:',
  ],
  'font-src': <String>[
    "'self'",
    'data:',
    'https://fonts.googleapis.com/',
    'https://fonts.gstatic.com/',
  ],
  'img-src': <String>[
    "'self'",
    'https:',
    'data:',
    if (envConfig.isRunningLocally) 'http://localhost:8081',
  ],
  'manifest-src': _none,
  'object-src': _none,
  'script-src': <String>[
    // See: https://developers.google.com/tag-manager/web/csp
    "'self'",
    'https://tagmanager.google.com',
    'https://www.googletagmanager.com/',
    'https://www.google.com/',
    'https://www.google-analytics.com/',
    'https://ssl.google-analytics.com',
    'https://adservice.google.com/',
    'https://ajax.googleapis.com/',
    'https://apis.google.com/',
    'https://unpkg.com/',
    'https://www.gstatic.com/',
    'https://gstatic.com',
    // required by Google Identity Services library
    // https://developers.google.com/identity/gsi/web/guides/get-google-api-clientid#content_security_policy
    'https://accounts.google.com/gsi/client',
  ],
  'style-src': <String>[
    "'self'",
    'https://unpkg.com/',
    'https://pub.dartlang.org/static/', // older dartdoc content requires it
    "'unsafe-inline'", // package page (esp. analysis tab) required is
    'https://fonts.googleapis.com/',
    'https://gstatic.com',
    'https://www.gstatic.com/',
    'https://tagmanager.google.com',
    // required by Google Identity Services library
    // https://developers.google.com/identity/gsi/web/guides/get-google-api-clientid#content_security_policy
    'https://accounts.google.com/gsi/style',
  ],
};

/// Returns the serialized string of the CSP header.
String _serializeCSP(Map<String, String>? extraValues) {
  final keys = <String>{
    ..._defaultContentSecurityPolicyMap.keys,
    if (extraValues != null) ...extraValues.keys,
  };
  return keys.map((key) {
    final list = _defaultContentSecurityPolicyMap[key];
    final extra = extraValues == null ? null : extraValues[key];
    final extraStr = (extra == null || extra.trim().isEmpty) ? '' : ' $extra';
    return '$key ${list!.join(' ')}$extraStr';
  }).join(';');
}
