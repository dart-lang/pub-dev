// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:test/test.dart';

import 'package:client_data/publisher_api.dart';
import 'package:pub_dartlang_org/publisher/models.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('Publisher API', () {
    group('Update description', () {
      testWithServices('No active user', () async {
        final client = createPubApiClient();
        final rs = client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(description: 'new description'),
        );
        await expectApiException(rs, 401, 'MissingAuthentication',
            'authenication is required, please add `authorization` header.');
      });

      testWithServices('No publisher with given id', () async {
        final client = createPubApiClient(authToken: hansAuthenticated.userId);
        final rs = client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(description: 'new description'),
        );
        await expectApiException(
            rs, 404, 'NotFound', 'Publisher example.com does not exists.');
      });

      testWithServices('Not a member', () async {
        await dbService.commit(inserts: [exampleComPublisher]);
        final client = createPubApiClient(authToken: hansAuthenticated.userId);
        final rs = client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(description: 'new description'),
        );
        await expectApiException(rs, 403, 'InsufficientPermissions',
            'Insufficient permissions to perform administrative actions on package `example.com`.');
      });

      testWithServices('Not an admin yet', () async {
        await dbService.commit(inserts: [
          exampleComPublisher,
          publisherMember(hansUser.userId, PublisherMemberRole.pending),
        ]);
        final client = createPubApiClient(authToken: hansAuthenticated.userId);
        final rs = client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(description: 'new description'),
        );
        await expectApiException(rs, 403, 'InsufficientPermissions',
            'Insufficient permissions to perform administrative actions on package `example.com`.');
      });

      testWithServices('OK', () async {
        await dbService.commit(inserts: [
          exampleComPublisher,
          publisherMember(hansUser.userId, PublisherMemberRole.admin),
        ]);
        final client = createPubApiClient(authToken: hansAuthenticated.userId);
        final rs = await client.updatePublisher(
          'example.com',
          UpdatePublisherRequest(description: 'new description'),
        );
        expect(rs.toJson(), {
          'description': 'new description',
          'contact': null,
        });
      });
    });
  });
}
