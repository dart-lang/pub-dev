// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/redis_cache.dart';
import 'package:test/test.dart';

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
      final cookies = await acquireSessionCookies('admin@pub.dev');
      await expectHtmlResponse(
        await issueGet(
          '/my-packages',
          headers: {'cookie': cookies},
          host: activeConfiguration.primaryApiUri!.host,
        ),
        present: ['/packages/flutter_titanium'],
      );
    });

    testWithProfile('/my-packages?next=o', fn: () async {
      final cookies = await acquireSessionCookies('admin@pub.dev');
      await expectHtmlResponse(
        await issueGet(
          '/my-packages?next=o',
          headers: {'cookie': cookies},
          host: activeConfiguration.primaryApiUri!.host,
        ),
        present: ['/packages/oxygen'],
        absent: ['/packages/flutter_titanium'],
      );
    });

    testWithProfile('/my-packages with re-authentication', fn: () async {
      final cookies = await acquireSessionCookies('admin@pub.dev');
      final sessionId = cookies.split(';').last.split('=').last;
      final session = await accountBackend.lookupValidUserSession(sessionId);
      expect(session, isNotNull);
      session!
        ..created = clock.now().subtract(Duration(days: 2))
        ..authenticatedAt = clock.now().subtract(Duration(days: 2));
      await dbService.commit(inserts: [session]);
      await cache.userSessionData(sessionId).purge();

      final rs = await issueGet(
        '/my-packages',
        headers: {'cookie': cookies},
        host: activeConfiguration.primaryApiUri!.host,
      );
      expect(rs.statusCode, 303);
      final location = rs.headers['location']!;
      expect(location, '/sign-in?go=%2Fmy-packages');
    });
  });

  group('pub client authorization landing page', () {
    testWithProfile('/authorized', fn: () async {
      await expectHtmlResponse(await issueGet('/authorized'));
    });
  });
}
