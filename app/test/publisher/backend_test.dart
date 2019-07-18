// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:test/test.dart';

import 'package:pub_dartlang_org/account/backend.dart';
import 'package:pub_dartlang_org/publisher/backend.dart';
import 'package:pub_dartlang_org/publisher/models.dart';

import '../frontend/utils.dart';
import '../shared/test_services.dart';

void main() {
  group('PublisherBackend', () {
    group('Update description', () {
      testWithServices('No active user', () async {
        await expectLater(
          publisherBackend.updatePublisherData(
              'example.com', 'new description'),
          throwsA(isException.having(
              (e) => '$e', 'text', 'UnauthorizedAccess: No active user.')),
        );
        final p = await publisherBackend.getPublisher('example.com');
        expect(p, isNull);
      });

      testWithServices('No publisher with given id', () async {
        registerAuthenticatedUser(testAuthenticatedUserHans);
        await expectLater(
          publisherBackend.updatePublisherData(
              'example.com', 'new description'),
          throwsA(isException.having((e) => '$e', 'text',
              'NotFoundException: Publisher example.com does not exists.')),
        );
        final p = await publisherBackend.getPublisher('example.com');
        expect(p, isNull);
      });

      testWithServices('Not a member', () async {
        await dbService.commit(inserts: [testPublisher]);
        registerAuthenticatedUser(testAuthenticatedUserHans);
        await expectLater(
          publisherBackend.updatePublisherData(
              'example.com', 'new description'),
          throwsA(isException.having((e) => '$e', 'text',
              'UnauthorizedAccess: User is not an admin.')),
        );
        final p = await publisherBackend.getPublisher('example.com');
        expect(p.description, testPublisher.description);
      });

      testWithServices('Not an admin yet', () async {
        await dbService.commit(inserts: [
          testPublisher,
          testMember(testUserHans.userId, PublisherMemberRole.pending),
        ]);
        registerAuthenticatedUser(testAuthenticatedUserHans);
        await expectLater(
          publisherBackend.updatePublisherData(
              'example.com', 'new description'),
          throwsA(isException.having((e) => '$e', 'text',
              'UnauthorizedAccess: User is not an admin.')),
        );
        final p = await publisherBackend.getPublisher('example.com');
        expect(p.description, testPublisher.description);
      });

      testWithServices('OK', () async {
        await dbService.commit(inserts: [
          testPublisher,
          testMember(testUserHans.userId, PublisherMemberRole.admin),
        ]);
        registerAuthenticatedUser(testAuthenticatedUserHans);
        await publisherBackend.updatePublisherData(
            'example.com', 'new description');
        final p = await publisherBackend.getPublisher('example.com');
        expect(p.description, 'new description');
      });
    });
  });
}

final testPublisher = Publisher()
  ..id = 'example.com'
  ..description = 'This is us!'
  ..created = DateTime(2019, 07, 15)
  ..updated = DateTime(2019, 07, 16);

PublisherMember testMember(String userId, String role) => PublisherMember()
  ..parentKey = testPublisher.key
  ..id = userId
  ..role = role;
