// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/service/csp/default_csp.dart';
import 'package:test/test.dart';

void main() {
  test('default CSP serialization', () {
    final csp = defaultContentSecurityPolicySerialized;
    expect(csp, contains("default-src 'self'"));
    expect(csp, contains('upgrade-insecure-requests'));
    expect(csp, contains("frame-ancestors 'none'"));
    expect(csp, contains("base-uri 'self'"));
    expect(csp, contains("form-action 'self'"));
    expect(
      csp,
      contains(
        "frame-src 'self' https://www.googletagmanager.com/ https://accounts.google.com/",
      ),
    );
    expect(
      csp,
      contains(
        "connect-src 'self' https://www.google-analytics.com/ https://stats.g.doubleclick.net/",
      ),
    );

    // Check that it's correctly formatted with semicolons and spaces
    expect(csp, contains('; '));

    // Check for some other directives
    expect(
      csp,
      contains(
        "font-src 'self' data: https://fonts.googleapis.com/ https://fonts.gstatic.com/",
      ),
    );
  });
}
