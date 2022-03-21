// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';

import '../../shared/handlers_test_utils.dart';
import '../../shared/test_services.dart';
import '_utils.dart';

void main() {
  group('account handlers tests', () {
    // TODO: add test for /create-publisher page
    // TODO: add test for POST /api/publisher/<publisherId> API calls
    // TODO: add test for GET /api/publisher/<publisherId> API calls
    // TODO: add test for PUT /api/publisher/<publisherId> API calls
    // TODO: add test for POST /api/publisher/<publisherId>/invite-member API calls
    // TODO: add test for GET /api/publisher/<publisherId>/members API calls
    // TODO: add test for GET /api/publisher/<publisherId>/members/<userId> API calls
    // TODO: add test for PUT /api/publisher/<publisherId>/members/<userId> API calls
    // TODO: add test for DELETE /api/publisher/<publisherId>/members/<userId> API calls

    testWithProfile('publisher redirect', fn: () async {
      await expectRedirectResponse(
        await issueGet('/publishers/example.com'),
        '/publishers/example.com/packages',
      );
    });

    testWithProfile('publisher does not exists', fn: () async {
      await expectHtmlResponse(
        await issueGet('/publishers/no-such-publisher.com/packages'),
        status: 404,
      );
    });

    testWithProfile('publisher package with text search', fn: () async {
      await expectRedirectResponse(
        await issueGet('/publishers/example.com/packages?q=n'),
        '/packages?q=publisher%3Aexample.com+show%3Ahidden+n',
      );
    });

    testWithProfile('publisher package with tag search', fn: () async {
      await expectRedirectResponse(
        await issueGet('/publishers/example.com/packages?q=sdk:dart'),
        '/packages?q=publisher%3Aexample.com+sdk%3Adart+show%3Ahidden',
      );
    });

    testWithProfile('simple publisher packages', fn: () async {
      await expectHtmlResponse(
        await issueGet('/publishers/example.com/packages'),
        present: ['/packages/neon'],
        absent: ['/packages/oxygen'],
      );
    });

    testWithProfile(
      'paginated publisher packages',
      testProfile: TestProfile(
        packages: [
          TestPackage(name: 'non_publisher'),
          ...List.generate(
            11,
            (i) => TestPackage(
              name: 'pkg_$i',
              publisher: 'example.com',
            ),
          ),
        ],
        defaultUser: 'admin@pub.dev',
      ),
      fn: () async {
        await expectHtmlResponse(
          await issueGet('/publishers/example.com/packages'),
          present: ['"/publishers/example.com/packages?page=2"'],
          absent: ['non_publisher'],
        );
        await expectHtmlResponse(
          await issueGet('/publishers/example.com/packages?page=2'),
          present: ['"/publishers/example.com/packages"'],
          absent: ['non_publisher'],
        );
      },
    );
  });
}
