// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/admin_api.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/session_cookie.dart' as session_cookie;
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:test/test.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('create-session-cookie admin action', () {
    testWithProfile(
      'successful cookie creation',
      fn: () async {
        final client = createPubApiClient(authToken: siteAdminToken);
        final accessToken = createFakeServiceAccountToken(
          email: 'user@pub.dev',
          audience: activeConfiguration.pubClientAudience,
        );

        final result = await client.adminInvokeAction(
          'create-session-cookie',
          AdminInvokeActionArguments(arguments: {'access-token': accessToken}),
        );

        expect(result.output, contains('cookie'));
        final cookieHeaders = result.output['cookie'] as Map<String, dynamic>;
        expect(cookieHeaders, contains('set-cookie'));
        final setCookies = cookieHeaders['set-cookie'] as List;
        expect(setCookies, hasLength(2));
        expect(
          setCookies[0],
          contains('${session_cookie.clientSessionLaxCookieName}='),
        );
        expect(
          setCookies[1],
          contains('${session_cookie.clientSessionStrictCookieName}='),
        );

        // Verify the session is actually created and authenticated
        final sessionId = (setCookies[0] as String)
            .split(';')
            .first
            .split('=')
            .last;
        final sessionData = await accountBackend.getSessionData(sessionId);
        expect(sessionData, isNotNull);
        expect(sessionData!.isAuthenticated, isTrue);
        expect(sessionData.email, 'user@pub.dev');
      },
    );

    testWithProfile(
      'invalid token fails',
      fn: () async {
        final client = createPubApiClient(authToken: siteAdminToken);
        final rs = client.adminInvokeAction(
          'create-session-cookie',
          AdminInvokeActionArguments(
            arguments: {'access-token': 'invalid-token'},
          ),
        );
        await expectApiException(rs, status: 400, code: 'InvalidInput');
      },
    );
  });
}
