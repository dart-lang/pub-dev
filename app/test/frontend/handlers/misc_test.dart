// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import '../../shared/test_services.dart';
import '_utils.dart';

void main() {
  group('404 page', () {
    testWithProfile(
      'without additional action',
      fn: () async {
        final rs = await issueGet('/subdir/not-existing-package');
        await expectHtmlResponse(
          rs,
          status: 404,
          present: ['404 Not Found'],
          absent: [
            '/packages/not-existing-package', // link to package page
            '/packages?q=not-existing-package', // link to search page
          ],
        );
      },
    );

    testWithProfile(
      'link to package page',
      fn: () async {
        final rs = await issueGet('/oxygen');
        await expectHtmlResponse(
          rs,
          status: 404,
          present: [
            '404 Not Found',
            '/packages/oxygen', // link to package page
            '/packages?q=oxygen', // link to search page
          ],
        );
      },
    );

    testWithProfile(
      'link to search page',
      fn: () async {
        final rs = await issueGet('/not-oxygen');
        await expectHtmlResponse(
          rs,
          status: 404,
          present: [
            '404 Not Found',
            '/packages?q=not-oxygen', // link to search page
          ],
          absent: [
            '/packages/not-oxygen', // link to package page
          ],
        );
      },
    );
  });

  group('CSP reporting', () {
    testWithProfile(
      'HTML response contains reporting-endpoints and report-to in CSP',
      fn: () async {
        final rs = await issueGet('/');
        expect(rs.statusCode, 200);
        expect(
          rs.headers['reporting-endpoints'],
          'csp-endpoint="/api/csp-report"',
        );
        expect(
          rs.headers['content-security-policy'],
          contains('report-to csp-endpoint'),
        );
      },
    );

    testWithProfile(
      'Receives valid Reporting API report',
      fn: () async {
        final rs = await issueHttp(
          'POST',
          '/api/csp-report',
          headers: {'content-type': 'application/reports+json'},
          body:
              '[{"type":"csp-violation","body":{"effectiveDirective":"connect-src","blockedURL":"https://example.com"}}]',
        );
        expect(rs.statusCode, 204);
      },
    );

    testWithProfile(
      'Receives valid legacy CSP report',
      fn: () async {
        final rs = await issueHttp(
          'POST',
          '/api/csp-report',
          headers: {'content-type': 'application/csp-report'},
          body:
              '{"csp-report":{"effective-directive":"connect-src","blocked-uri":"https://example.com"}}',
        );
        expect(rs.statusCode, 204);
      },
    );

    testWithProfile(
      'Receives empty CSP report',
      fn: () async {
        final rs = await issueHttp('POST', '/api/csp-report', body: '');
        expect(rs.statusCode, 204);
      },
    );

    testWithProfile(
      'Rejects malformed CSP report payload',
      fn: () async {
        final rs = await issueHttp(
          'POST',
          '/api/csp-report',
          body: 'not a json',
        );
        expect(rs.statusCode, 400);
      },
    );
  });
}
