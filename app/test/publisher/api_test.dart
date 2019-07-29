// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:gcloud/db.dart';
import 'package:test/test.dart';

import 'package:client_data/publisher_api.dart';
import 'package:pub_dartlang_org/frontend/handlers/pubapi.client.dart';
import 'package:pub_dartlang_org/publisher/models.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('Publisher API', () {
    group('Get publisher info', () {
      _testNoPublisher((client) => client.publisherInfo('no-domain.net'));

      testWithServices('OK', () async {
        final client = createPubApiClient();
        final rs = await client.publisherInfo('example.com');
        expect(rs.toJson(), {
          'description': 'This is us!',
          'contact': 'contact@example.com',
        });
      });
    });

    group('Update description', () {
      _testAdminAuthIssues(
        (client) => client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(description: 'new description'),
        ),
      );

      _testNoPublisher(
        (client) => client.updatePublisher(
          'example.net',
          UpdatePublisherRequest(description: 'new description'),
        ),
      );

      testWithServices('OK', () async {
        final client = createPubApiClient(authToken: hansAuthenticated.userId);
        final rs = await client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(description: 'new description'),
        );
        expect(rs.toJson(), {
          'description': 'new description',
          'contact': 'contact@example.com',
        });
        // Info request should return with the same content.
        final info = await client.publisherInfo('example.com');
        expect(info.toJson(), rs.toJson());
      });
    });

    group('List members', () {
      _testAdminAuthIssues(
        (client) => client.listPublisherMembers('example.com'),
      );

      _testNoPublisher(
        (client) => client.listPublisherMembers('no-domain.net'),
      );

      testWithServices('OK', () async {
        final client = createPubApiClient(authToken: hansAuthenticated.userId);
        final rs = await client.listPublisherMembers('example.com');
        expect(_json(rs.toJson()), {
          'members': [
            {
              'userId': 'hans-at-juergen-dot-com',
              'email': 'hans@juergen.com',
              'role': 'admin',
            },
          ],
        });
      });
    });

    group('Get member detail', () {
      _testAdminAuthIssues(
        (client) => client.publisherMemberInfo('example.com', hansUser.userId),
      );

      _testNoPublisher(
        (client) =>
            client.publisherMemberInfo('no-domain.net', hansUser.userId),
      );

      testWithServices('User is not a member', () async {
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs = client.publisherMemberInfo('example.com', 'not-a-user-id');
        await expectApiException(rs, status: 404, code: 'NotFound');
      });

      testWithServices('OK', () async {
        final client = createPubApiClient(authToken: hansUser.userId);
        final rs =
            await client.publisherMemberInfo('example.com', hansUser.userId);
        expect(rs.toJson(), {
          'userId': 'hans-at-juergen-dot-com',
          'email': 'hans@juergen.com',
          'role': 'admin',
        });
      });
    });
  });
}

dynamic _json(value) => json.decode(json.encode(value));

void _testAdminAuthIssues(Future fn(PubApiClient client)) {
  testWithServices('No active user', () async {
    final client = createPubApiClient();
    final rs = fn(client);
    await expectApiException(rs,
        status: 401,
        code: 'MissingAuthentication',
        message: 'please add `authorization` header');
  });

  testWithServices('Active user is not a member', () async {
    await dbService.commit(deletes: [exampleComHansAdmin.key]);
    final client = createPubApiClient(authToken: hansAuthenticated.userId);
    final rs = fn(client);
    await expectApiException(rs, status: 403, code: 'InsufficientPermissions');
  });

  testWithServices('Active user is not an admin yet', () async {
    await dbService.commit(inserts: [
      publisherMember(hansUser.userId, PublisherMemberRole.pending),
    ]);
    final client = createPubApiClient(authToken: hansAuthenticated.userId);
    final rs = fn(client);
    await expectApiException(rs, status: 403, code: 'InsufficientPermissions');
  });
}

void _testNoPublisher(Future fn(PubApiClient client)) {
  testWithServices('No publisher with given id', () async {
    final client = createPubApiClient(authToken: hansAuthenticated.userId);
    final rs = fn(client);
    await expectApiException(rs, status: 404, code: 'NotFound');
  });
}
