// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:client_data/admin_api.dart';
import 'package:gcloud/db.dart';
import 'package:pub_dev/account/models.dart';
import 'package:test/test.dart';

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/admin/backend.dart';
import 'package:pub_dev/frontend/handlers/pubapi.client.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/shared/exceptions.dart';

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
    group('Delete package', () {
      _testNotAdmin(
          (client) => client.adminRemovePackage(hydrogen.package.name));

      testWithServices('OK', () async {
        final client = createPubApiClient(authToken: adminUser.userId);

        final pkgKey =
            dbService.emptyKey.append(Package, id: hydrogen.package.name);
        final package = await dbService.lookupValue<Package>(pkgKey);
        expect(package, isNotNull);

        final versionsQuery =
            dbService.query<PackageVersion>(ancestorKey: pkgKey);
        final versions = await versionsQuery.run().toList();
        final expectedVersions = generateVersions(13, increment: 9);
        expect(versions.map((v) => v.version), expectedVersions);

        final hansClient = createPubApiClient(authToken: hansUser.userId);
        await hansClient.likePackage(hydrogen.package.name);

        final likeKey = dbService.emptyKey
            .append(User, id: hansUser.userId)
            .append(Like, id: hydrogen.package.name);
        final like =
            await dbService.lookupValue<Like>(likeKey, orElse: () => null);
        expect(like, isNotNull);

        final moderatedPkgKey = dbService.emptyKey
            .append(ModeratedPackage, id: hydrogen.package.name);
        ModeratedPackage moderatedPkg = await dbService
            .lookupValue<ModeratedPackage>(moderatedPkgKey, orElse: () => null);
        expect(moderatedPkg, isNull);

        final timeBeforeRemoval = DateTime.now().toUtc();
        final rs = await client.adminRemovePackage(hydrogen.package.name);

        expect(utf8.decode(rs), '{"status":"OK"}');

        final pkgAfterRemoval =
            await dbService.lookupValue<Package>(pkgKey, orElse: () => null);
        expect(pkgAfterRemoval, isNull);

        final versionsAfterRemoval = await versionsQuery.run().toList();
        expect(versionsAfterRemoval, isEmpty);

        final likeAfterRemoval =
            await dbService.lookupValue<Like>(likeKey, orElse: () => null);
        expect(likeAfterRemoval, isNull);

        moderatedPkg =
            await dbService.lookupValue<ModeratedPackage>(moderatedPkgKey);
        expect(moderatedPkg, isNotNull);
        expect(moderatedPkg.name, package.name);
        expect(moderatedPkg.moderated.isAfter(timeBeforeRemoval), isTrue);
        expect(moderatedPkg.uploaders, package.uploaders);
        expect(moderatedPkg.publisherId, package.publisherId);
        expect(moderatedPkg.versions, expectedVersions);
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

      testWithServices('Likes are cleaned up on user deletion', () async {
        final client = createPubApiClient(authToken: adminUser.userId);
        final hansClient = createPubApiClient(authToken: hansUser.userId);

        await hansClient.likePackage(helium.package.name);

        final r2 = await client.getPackageLikes(helium.package.name);
        expect(r2.likes, 1);

        final likeKey = dbService.emptyKey
            .append(User, id: hansUser.userId)
            .append(Like, id: helium.package.name);

        Like like =
            await dbService.lookupValue<Like>(likeKey, orElse: () => null);
        expect(like, isNotNull);

        await client.adminRemoveUser(hansUser.userId);

        final r3 = await client.getPackageLikes(helium.package.name);
        expect(r3.likes, 0);

        like = await dbService.lookupValue<Like>(likeKey, orElse: () => null);
        expect(like, null);
      });

      // TODO: delete with multiple uploaders
      // TODO: delete with multiple members (contact email not changed)
      // TODO: delete with multiple members (contact email changes)
    });

    group('get assignedTags', () {
      _testNotAdmin((client) => client.adminGetAssignedTags('hydrogen'));

      testWithServices('get assignedTags', () async {
        final client = createPubApiClient(authToken: adminUser.userId);
        final result = await client.adminGetAssignedTags('hydrogen');
        expect(result.assignedTags, isNot(contains('is:featured')));
      });
    });

    group('set assignedTags', () {
      _testNotAdmin((client) => client.adminPostAssignedTags(
            'hydrogen',
            PatchAssignedTags(assignedTagsAdded: ['is:featured']),
          ));

      testWithServices('set assignedTags', () async {
        final client = createPubApiClient(authToken: adminUser.userId);

        // Is initially not featured
        final r1 = await client.adminGetAssignedTags('hydrogen');
        expect(r1.assignedTags, isNot(contains('is:featured')));

        // Set updating with no change, should have no effect
        await client.adminPostAssignedTags(
          'hydrogen',
          PatchAssignedTags(assignedTagsAdded: r1.assignedTags),
        );
        final r2 = await client.adminGetAssignedTags('hydrogen');
        expect(r2.assignedTags, isNot(contains('is:featured')));

        // Check that we can set is:featured
        await client.adminPostAssignedTags(
          'hydrogen',
          PatchAssignedTags(assignedTagsAdded: ['is:featured']),
        );
        final r3 = await client.adminGetAssignedTags('hydrogen');
        expect(r3.assignedTags, contains('is:featured'));

        // Check that we can set is:featured (again)
        await client.adminPostAssignedTags(
          'hydrogen',
          PatchAssignedTags(assignedTagsAdded: ['is:featured']),
        );
        final r4 = await client.adminGetAssignedTags('hydrogen');
        expect(r4.assignedTags, contains('is:featured'));

        // Check that we can remove the tag.
        await client.adminPostAssignedTags(
          'hydrogen',
          PatchAssignedTags(assignedTagsRemoved: ['is:featured']),
        );
        final r5 = await client.adminGetAssignedTags('hydrogen');
        expect(r5.assignedTags, isNot(contains('is:featured')));

        // Check that we can remove the tag (again).
        await client.adminPostAssignedTags(
          'hydrogen',
          PatchAssignedTags(assignedTagsRemoved: ['is:featured']),
        );
        final r6 = await client.adminGetAssignedTags('hydrogen');
        expect(r6.assignedTags, isNot(contains('is:featured')));
      });
    });
  });
}

void _testNotAdmin(Future Function(PubApiClient client) fn) {
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
