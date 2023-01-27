// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/data/package_api.dart';
import 'package:clock/clock.dart';
import 'package:gcloud/db.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/service/openid/jwt.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_dev/shared/utils.dart';
import 'package:test/test.dart';

import '../frontend/handlers/_utils.dart';
import '../shared/handlers_test_utils.dart';
import '../shared/test_services.dart';

void main() {
  group('AccountBackend', () {
    testWithProfile('No user', fn: () async {
      expect(await accountBackend.getEmailOfUserId(createUuid()), isNull);
    });

    testWithProfile('Invalid userId', fn: () async {
      await expectLater(
        accountBackend.getEmailOfUserId('bad-user-id'),
        throwsA(isA<InvalidInputException>()),
      );
    });

    testWithProfile('Successful lookup', fn: () async {
      final user = await accountBackend.lookupUserByEmail('user@pub.dev');
      final email = await accountBackend.getEmailOfUserId(user.userId);
      expect(email, 'user@pub.dev');
      final u = await accountBackend.lookupUserById(user.userId);
      expect(u!.email, 'user@pub.dev');
      expect(u.oauthUserId, isNotNull);
      expect(u.id, user.id);
    });

    testWithProfile('Create missing user', fn: () async {
      final oldIds =
          await dbService.query<User>().run().map((u) => u.userId).toList();

      final u = await accountBackend.withBearerToken(
        createFakeAuthTokenForEmail('new-user@pub.dev'),
        () => requireAuthenticatedWebUser(),
      );
      expect(u.userId, hasLength(36));
      expect(u.oauthUserId, isNotNull);
      expect(u.email, 'new-user@pub.dev');

      final ids =
          await dbService.query<User>().run().map((u) => u.userId).toList();
      expect(ids.length, oldIds.length + 1);
      expect(ids.contains(u.userId), isTrue);
    });

    testWithProfile('Authenticate: token failure', fn: () async {
      await expectLater(
          () => accountBackend.withBearerToken(
              '', () => requireAuthenticatedWebUser()),
          throwsA(isA<AuthenticationException>()));
    });

    testWithProfile('Authenticate: pre-created', fn: () async {
      final ids1 = await dbService
          .query<OAuthUserID>()
          .run()
          .map((u) => u.oauthUserId)
          .toSet();
      expect(ids1, {'admin-pub-dev', 'user-pub-dev'});

      String? userId;
      await accountBackend.withBearerToken(
          createFakeAuthTokenForEmail('a@example.com'), () async {
        final u1 = await requireAuthenticatedWebUser();
        expect(u1.userId, hasLength(36));
        expect(u1.email, 'a@example.com');
        userId = u1.userId;
      });

      final u2 = await accountBackend.lookupUserById(userId!);
      expect(u2!.email, 'a@example.com');
      expect(u2.oauthUserId, 'a-example-com');

      final ids2 = await dbService
          .query<OAuthUserID>()
          .run()
          .map((u) => u.oauthUserId)
          .toSet();
      expect(ids2, {'admin-pub-dev', 'user-pub-dev', 'a-example-com'});
    });

    testWithProfile('Authenticate: new user', fn: () async {
      final ids1 = await dbService
          .query<OAuthUserID>()
          .run()
          .map((u) => u.oauthUserId)
          .toSet();
      expect(ids1, {'admin-pub-dev', 'user-pub-dev'});

      await accountBackend.withBearerToken(
          createFakeAuthTokenForEmail('c@example.com'), () async {
        final u1 = await requireAuthenticatedWebUser();
        expect(u1.userId, hasLength(36));
        expect(u1.email, 'c@example.com');

        final u2 = await accountBackend.lookupUserById(u1.userId);
        expect(u2!.email, 'c@example.com');
        expect(u2.oauthUserId, 'c-example-com');
      });

      final ids2 = await dbService
          .query<OAuthUserID>()
          .run()
          .map((u) => u.oauthUserId)
          .toSet();
      expect(ids2, {'admin-pub-dev', 'c-example-com', 'user-pub-dev'});
    });
  });

  group('session and token', () {
    Future<String?> _getToken({
      required String? email,
      bool useExperimental = true,
      bool useRequestHeader = true,
    }) async {
      final sessionCookie = email == null
          ? ''
          : await acquireSessionCookie(createFakeAuthTokenForEmail(email));
      final rs = await issueGet(
        '/api/account/session',
        headers: {
          'cookie': [
            if (sessionCookie.isNotEmpty) sessionCookie,
            if (useExperimental) 'experimental=signin',
          ].join('; '),
          if (useRequestHeader) 'x-pub-dev-token-request': '1',
        },
        host: activeConfiguration.primaryApiUri!.host,
      );
      expect(rs.statusCode, 200);
      final body = await rs.readAsString();
      expect(json.decode(body), {
        if (email != null) 'expires': isNotEmpty,
      });
      return rs.headers['x-pub-dev-token'];
    }

    testWithProfile(
      'GET /api/account/session - without any session',
      fn: () async {
        expect(
            await _getToken(
              email: null,
              useExperimental: true,
            ),
            isNull);
      },
    );

    testWithProfile(
      'GET /api/account/session - without experimental flag',
      fn: () async {
        expect(
            await _getToken(
              email: 'user@pub.dev',
              useExperimental: false,
            ),
            isNull);
      },
    );

    testWithProfile(
      'GET /api/account/session - active session, without token request header',
      fn: () async {
        expect(
            await _getToken(
              email: 'user@pub.dev',
              useRequestHeader: false,
            ),
            isNull);
      },
    );

    testWithProfile(
      'getting the token + verification',
      fn: () async {
        final token = await _getToken(email: 'admin@pub.dev');
        final jwt = JsonWebToken.parse(token!);
        expect(jwt.header, {
          'typ': 'JWT',
          'alg': 'HS256',
        });
        final now = clock.now().toUtc();
        expect(jwt.payload, {
          'iss': 'https://pub.dev',
          'iat': isNot(greaterThan(now.millisecondsSinceEpoch ~/ 1000)),
          'exp': isNot(greaterThan(
              now.add(Duration(hours: 1)).millisecondsSinceEpoch ~/ 1000)),
          'tokenId': isNotEmpty,
        });
        expect(jwt.payload.isTimely(), isTrue);

        final user = await accountBackend.tryParseAndVerifyPubDevToken(token);
        expect(user, isNotNull);
        expect(user!.email, 'admin@pub.dev');
      },
    );

    testWithProfile(
      'using token on unauthorized resource',
      fn: () async {
        final token = await _getToken(email: 'user@pub.dev');
        final rs = createPubApiClient(authToken: token)
            .setPackageOptions('oxygen', PkgOptions(isDiscontinued: true));
        await expectApiException(rs,
            status: 403, code: 'InsufficientPermissions');
      },
    );

    testWithProfile(
      'using token on authorized resource',
      fn: () async {
        final token = await _getToken(email: 'admin@pub.dev');
        final rs = await createPubApiClient(authToken: token)
            .setPackageOptions('oxygen', PkgOptions(isDiscontinued: true));
        expect(rs.isDiscontinued, true);
      },
    );
  });
}
