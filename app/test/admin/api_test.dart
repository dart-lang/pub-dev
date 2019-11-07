// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:client_data/admin_api.dart';
import 'package:gcloud/db.dart';
import 'package:test/test.dart';

import 'package:pub_dartlang_org/account/backend.dart';
import 'package:pub_dartlang_org/admin/backend.dart';
import 'package:pub_dartlang_org/frontend/handlers/pubapi.client.dart';
import 'package:pub_dartlang_org/package/models.dart';
import 'package:pub_dartlang_org/publisher/models.dart';
import 'package:pub_dartlang_org/shared/exceptions.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('Admin API', () {
    group('List users', () {
      _testNotAdmin((client) => client.adminListUsers());

      testWithServices('OK', () async {
        final client = createPubApiClient(authToken: adminUser.userId);
        final rs = await client.adminListUsers();
        expect(
          _json(rs.toJson()),
          {
            'users': [
              {
                'userId': 'a-example-com',
                'oauthUserId': null,
                'email': 'a@example.com',
              },
              {
                'userId': 'admin-at-pub-dot-dev',
                'oauthUserId': 'admin-pub-dev',
                'email': 'admin@pub.dev',
              },
              {
                'userId': 'hans-at-juergen-dot-com',
                'oauthUserId': null,
                'email': 'hans@juergen.com',
              },
              {
                'userId': 'joe-at-example-dot-com',
                'oauthUserId': null,
                'email': 'joe@example.com',
              }
            ],
            'continuationToken': null
          },
        );
      });

      testWithServices('pagination', () async {
        registerAuthenticatedUser(adminUser);

        final page1 = await adminBackend.listUsers(limit: 3);
        expect(
          _json(page1.toJson()),
          {
            'users': [
              {
                'userId': 'a-example-com',
                'oauthUserId': null,
                'email': 'a@example.com',
              },
              {
                'userId': 'admin-at-pub-dot-dev',
                'oauthUserId': 'admin-pub-dev',
                'email': 'admin@pub.dev',
              },
              {
                'userId': 'hans-at-juergen-dot-com',
                'oauthUserId': null,
                'email': 'hans@juergen.com',
              },
            ],
            'continuationToken':
                '68616e732d61742d6a75657267656e2d646f742d636f6d',
          },
        );

        final page2 = await adminBackend.listUsers(
            continuationToken: page1.continuationToken);
        expect(
          _json(page2.toJson()),
          {
            'users': [
              {
                'userId': 'joe-at-example-dot-com',
                'oauthUserId': null,
                'email': 'joe@example.com',
              }
            ],
            'continuationToken': null,
          },
        );
      });

      testWithServices('lookup by email - not found', () async {
        registerAuthenticatedUser(adminUser);
        final page = await adminBackend.listUsers(email: 'no@such.email');
        expect(_json(page.toJson()), {
          'users': [],
          'continuationToken': null,
        });
      });

      testWithServices('lookup by email - found', () async {
        registerAuthenticatedUser(adminUser);
        final page = await adminBackend.listUsers(email: joeUser.email);
        expect(_json(page.toJson()), {
          'users': [
            {
              'userId': 'joe-at-example-dot-com',
              'oauthUserId': null,
              'email': 'joe@example.com',
            },
          ],
          'continuationToken': null,
        });
      });

      testWithServices('lookup by oauthUserId - not found', () async {
        registerAuthenticatedUser(adminUser);
        final page = await adminBackend.listUsers(oauthUserId: 'no-such-id');
        expect(_json(page.toJson()), {
          'users': [],
          'continuationToken': null,
        });
      });

      testWithServices('lookup by oauthUserId - found', () async {
        registerAuthenticatedUser(adminUser);
        final page =
            await adminBackend.listUsers(oauthUserId: adminUser.oauthUserId);
        expect(_json(page.toJson()), {
          'users': [
            {
              'userId': 'admin-at-pub-dot-dev',
              'oauthUserId': 'admin-pub-dev',
              'email': 'admin@pub.dev',
            },
          ],
          'continuationToken': null,
        });
      });

      testWithServices('lookup by multiple attribute', () async {
        registerAuthenticatedUser(adminUser);
        final rs =
            adminBackend.listUsers(email: 'x', oauthUserId: 'no-such-id');
        await expectLater(rs, throwsA(isA<InvalidInputException>()));
      });
    });

    group('Delete user', () {
      _testNotAdmin((client) => client.adminRemoveUser(joeUser.userId));

      testWithServices('OK', () async {
        final client = createPubApiClient(authToken: adminUser.userId);
        final rs = await client.adminRemoveUser(hansUser.userId);
        expect(utf8.decode(rs), '{"status":"OK"}');

        final hydrogenKey = dbService.emptyKey.append(Package, id: 'hydrogen');
        final hydrogen =
            (await dbService.lookup<Package>([hydrogenKey])).single;
        expect(hydrogen.uploaders, []);
        expect(hydrogen.isDiscontinued, true);

        final publisher =
            (await dbService.lookup<Publisher>([exampleComPublisher.key]))
                .single;
        expect(publisher.contactEmail, isNull);
        expect(publisher.isAbandoned, isTrue);

        final members = await dbService
            .query<PublisherMember>(ancestorKey: exampleComPublisher.key)
            .run()
            .toList();
        expect(members, isEmpty);
      });

      // TODO: delete with multiple uploaders
      // TODO: delete with multiple members (contact email not changed)
      // TODO: delete with multiple members (contact email changes)
    });

    group('get isFlutterFavorite', () {
      _testNotAdmin((client) => client.adminGetFlutterFavorite('hydrogen'));

      testWithServices('get isFlutterFavorite', () async {
        final client = createPubApiClient(authToken: adminUser.userId);
        final status = await client.adminGetFlutterFavorite('hydrogen');
        expect(status.isFlutterFavorite, isFalse);
      });
    });

    group('set isFlutterFavorite', () {
      _testNotAdmin((client) => client.adminPutFlutterFavorite(
            'hydrogen',
            FlutterFavoriteStatus(isFlutterFavorite: true),
          ));

      testWithServices('set isFlutterFavorite', () async {
        final client = createPubApiClient(authToken: adminUser.userId);

        // Is false initially
        final s1 = await client.adminGetFlutterFavorite('hydrogen');
        expect(s1.isFlutterFavorite, isFalse);

        // Set it false should change anything
        await client.adminPutFlutterFavorite(
          'hydrogen',
          FlutterFavoriteStatus(isFlutterFavorite: false),
        );
        final s2 = await client.adminGetFlutterFavorite('hydrogen');
        expect(s2.isFlutterFavorite, isFalse);

        // Check that we can set it true
        await client.adminPutFlutterFavorite(
          'hydrogen',
          FlutterFavoriteStatus(isFlutterFavorite: true),
        );
        final s3 = await client.adminGetFlutterFavorite('hydrogen');
        expect(s3.isFlutterFavorite, isTrue);

        // Check that we can set it true (again)
        await client.adminPutFlutterFavorite(
          'hydrogen',
          FlutterFavoriteStatus(isFlutterFavorite: true),
        );
        final s4 = await client.adminGetFlutterFavorite('hydrogen');
        expect(s4.isFlutterFavorite, isTrue);

        // Check that we can set it back to false
        await client.adminPutFlutterFavorite(
          'hydrogen',
          FlutterFavoriteStatus(isFlutterFavorite: false),
        );
        final s5 = await client.adminGetFlutterFavorite('hydrogen');
        expect(s5.isFlutterFavorite, isFalse);
      });
    });
  });
}

void _testNotAdmin(Future fn(PubApiClient client)) {
  testWithServices('No active user', () async {
    final client = createPubApiClient();
    final rs = fn(client);
    await expectApiException(rs, status: 401, code: 'MissingAuthentication');
  });

  testWithServices('Active user is not an admin', () async {
    final client = createPubApiClient(authToken: hansUser.userId);
    final rs = fn(client);
    await expectApiException(rs, status: 403, code: 'InsufficientPermissions');
  });
}

dynamic _json(value) => json.decode(json.encode(value));
