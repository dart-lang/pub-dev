// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/frontend/static_files.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:test/test.dart';

import '../../shared/test_models.dart';
import '../../shared/test_services.dart';
import '_utils.dart';

void main() {
  group('bad authorization header', () {
    testWithProfile('no issue on public pages', fn: () async {
      await expectHtmlResponse(
        await issueGet(
          '/packages/oxygen',
          headers: {'authorization': 'bad value'},
        ),
        status: 200,
        absent: ['Authentication failed.'],
        present: ['/packages/oxygen'],
      );
    });

    testWithProfile('401 on private pages', fn: () async {
      final rs = await issueHttp(
        'PUT',
        '/api/packages/oxygen/options',
        headers: {'authorization': 'bad value'},
        body: '{}',
      );
      expect(rs.statusCode, 401);
      expect(await rs.readAsString(), contains('MissingAuthentication'));
    });
  });

  group('account handlers tests', () {
    // TODO: add test for /consent page
    // TODO: add test for GET /api/account/consent/<consentId> API calls
    // TODO: add test for PUT /api/account/consent/<consentId> API calls

    testWithProfile('/my-packages', fn: () async {
      final cookie = await acquireSessionCookie(adminAtPubDevAuthToken);
      await expectHtmlResponse(
        await issueGet(
          '/my-packages',
          headers: {'cookie': cookie},
          host: activeConfiguration.primaryApiUri!.host,
        ),
        present: ['/packages/flutter_titanium'],
      );
    });

    testWithProfile('/my-packages?next=o', fn: () async {
      final cookie = await acquireSessionCookie(adminAtPubDevAuthToken);
      await expectHtmlResponse(
        await issueGet(
          '/my-packages?next=o',
          headers: {'cookie': cookie},
          host: activeConfiguration.primaryApiUri!.host,
        ),
        present: ['/packages/oxygen'],
        absent: ['/packages/flutter_titanium'],
      );
    });
  });

  group('pub client authorization landing page', () {
    setUpAll(() => updateLocalBuiltFilesIfNeeded());

    testWithProfile('/authorized', fn: () async {
      await expectHtmlResponse(await issueGet('/authorized'));
    });
  });
}
