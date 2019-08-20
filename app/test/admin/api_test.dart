// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:gcloud/db.dart';
import 'package:test/test.dart';

import 'package:pub_dartlang_org/account/backend.dart';
import 'package:pub_dartlang_org/admin/backend.dart';
import 'package:pub_dartlang_org/frontend/handlers/pubapi.client.dart';
import 'package:pub_dartlang_org/package/models.dart';
import 'package:pub_dartlang_org/publisher/models.dart';

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
        registerAuthenticatedUser(
            AuthenticatedUser(adminUser.userId, adminUser.email));

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
            'continuationToken': 'CQUDGkNMFVlHBRAQSgEBWUkLEVsCCwA',
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
