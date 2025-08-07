// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import '../../shared/test_services.dart';
import '_utils.dart';

void main() {
  group('404 page', () {
    testWithProfile('without additional action', fn: () async {
      final rs = await issueGet('/subdir/not-existing-package');
      await expectHtmlResponse(
        rs,
        status: 404,
        present: [
          '404 Not Found',
        ],
        absent: [
          '/packages/not-existing-package', // link to package page
          '/packages?q=not-existing-package', // link to search page
        ],
      );
    });

    testWithProfile('link to package page', fn: () async {
      final rs = await issueGet('/oxygen');
      await expectHtmlResponse(
        rs,
        status: 404,
        present: [
          '404 Not Found',
          '/packages/oxygen', // link to package page
        ],
        absent: [
          '/packages?q=oxygen', // link to search page
        ],
      );
    });

    testWithProfile('link to search page', fn: () async {
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
    });
  });
}
