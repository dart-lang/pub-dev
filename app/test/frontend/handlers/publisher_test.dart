// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/shared/datastore.dart';
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

    testWithProfile('publisher is blocked', fn: () async {
      final p = await dbService.lookupValue<Publisher>(
          dbService.emptyKey.append(Publisher, id: 'example.com'));
      p.isBlocked = true;
      await dbService.commit(inserts: [p]);
      await expectHtmlResponse(
        await issueGet('/publishers/example.com/packages'),
        status: 404,
      );
      await expectHtmlResponse(
        await issueGet('/publishers'),
        absent: ['example.com'],
      );
    });

    testWithProfile('publisher package with text search', fn: () async {
      await expectRedirectResponse(
        await issueGet('/publishers/example.com/packages?q=n'),
        '/packages?q=publisher%3Aexample.com+show%3Aunlisted+n',
      );
    });

    testWithProfile('publisher package with tag search', fn: () async {
      await expectRedirectResponse(
        await issueGet('/publishers/example.com/packages?q=sdk:dart'),
        '/packages?q=sdk%3Adart+publisher%3Aexample.com+show%3Aunlisted',
      );
    });

    testWithProfile(
      'publisher packages with pagination',
      fn: () async {
        await expectRedirectResponse(
          await issueGet('/publishers/example.com/packages?page=2'),
          '/packages?q=publisher%3Aexample.com+show%3Aunlisted&page=2',
        );
      },
    );

    testWithProfile(
      'publisher packages with sort order',
      fn: () async {
        await expectRedirectResponse(
          await issueGet('/publishers/example.com/packages?sort=updated'),
          '/packages?q=publisher%3Aexample.com+show%3Aunlisted&sort=updated',
        );
      },
    );

    testWithProfile('simple publisher packages', fn: () async {
      await expectHtmlResponse(
        await issueGet('/publishers/example.com/packages'),
        present: ['/packages/neon'],
        absent: ['/packages/oxygen'],
      );
    });
  });
}
