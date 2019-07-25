// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:test/test.dart';

import 'package:pub_dartlang_org/publisher/models.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('Publisher API', () {
    group('Update description', () {
      // invoke the API endpoint
      Future<shelf.Response> update(String publisherId,
          {Map<String, dynamic> jsonBody, String authToken}) async {
        return await httpRequest('PUT', '/api/publishers/$publisherId',
            jsonBody: jsonBody, authToken: authToken);
      }

      testWithServices('No active user', () async {
        await expectJsonResponse(
          await update('example.com',
              jsonBody: {'description': 'new description'}),
          status: 401,
          body: {
            'code': 'MissingAuthentication',
            'message':
                'authenication is required, please add `authorization` header.',
          },
        );
      });

      testWithServices('No publisher with given id', () async {
        await expectJsonResponse(
          await update('example.com',
              jsonBody: {'description': 'new description'},
              authToken: hansAuthenticated.userId),
          status: 404,
          body: {
            'code': 'NotFound',
            'message': 'Publisher example.com does not exists.',
          },
        );
      });

      testWithServices('Not a member', () async {
        await dbService.commit(inserts: [exampleComPublisher]);
        await expectJsonResponse(
          await update('example.com',
              jsonBody: {'description': 'new description'},
              authToken: hansAuthenticated.userId),
          status: 403,
          body: {
            'code': 'InsufficientPermissions',
            'message':
                'Insufficient permissions to perform administrative actions on package `example.com`.',
          },
        );
      });

      testWithServices('Not an admin yet', () async {
        await dbService.commit(inserts: [
          exampleComPublisher,
          publisherMember(hansUser.userId, PublisherMemberRole.pending),
        ]);
        await expectJsonResponse(
          await update('example.com',
              jsonBody: {'description': 'new description'},
              authToken: hansAuthenticated.userId),
          status: 403,
          body: {
            'code': 'InsufficientPermissions',
            'message':
                'Insufficient permissions to perform administrative actions on package `example.com`.',
          },
        );
      });

      testWithServices('OK', () async {
        await dbService.commit(inserts: [
          exampleComPublisher,
          publisherMember(hansUser.userId, PublisherMemberRole.admin),
        ]);
        await expectJsonResponse(
          await update('example.com',
              jsonBody: {'description': 'new description'},
              authToken: hansAuthenticated.userId),
          status: 200,
          body: {
            'description': 'new description',
            'contact': null,
          },
        );
      });
    });
  });
}
