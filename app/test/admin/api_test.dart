// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:client_data/admin_api.dart';
import 'package:gcloud/db.dart';
import 'package:pub_dev/frontend/handlers/pubapi.client.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/publisher/backend.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/admin/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/shared/exceptions.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('Admin API', () {
    group('List users', () {
      setupTestsWithCallerAuthorizationIssues(
          (client) => client.adminListUsers());

      testWithProfile('OK', fn: () async {
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final rs = await client.adminListUsers();
        expect(
          _json(rs.toJson()),
          {
            'users': [
              {
                'userId': isNotNull,
                'oauthUserId': isNotNull,
                'email': isNotNull,
              },
              {
                'userId': isNotNull,
                'oauthUserId': isNotNull,
                'email': isNotNull,
              },
            ],
            'continuationToken': null
          },
        );
        expect(rs.users.map((u) => u.email).toSet(), <String>{
          'admin@pub.dev',
          'user@pub.dev',
        });
      });

      testWithProfile('pagination', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final page1 = await adminBackend.listUsers(limit: 1);
          expect(
            _json(page1.toJson()),
            {
              'users': [isNotNull],
              'continuationToken': isNotNull,
            },
          );

          final page2 = await adminBackend.listUsers(
              continuationToken: page1.continuationToken);
          expect(
            _json(page2.toJson()),
            {
              'users': [isNotNull],
              'continuationToken': null,
            },
          );

          expect({
            page1.users.single.email,
            page2.users.single.email
          }, {
            'admin@pub.dev',
            'user@pub.dev',
          });
        });
      });

      testWithProfile('lookup by email - not found', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final page = await adminBackend.listUsers(email: 'no@such.email');
          expect(_json(page.toJson()), {
            'users': [],
            'continuationToken': null,
          });
        });
      });

      testWithProfile('lookup by email - found', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final page = await adminBackend.listUsers(email: 'user@pub.dev');
          expect(_json(page.toJson()), {
            'users': [
              {
                'userId': isNotNull,
                'oauthUserId': isNotNull,
                'email': 'user@pub.dev',
              },
            ],
            'continuationToken': null,
          });
        });
      });

      testWithProfile('lookup by oauthUserId - not found', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final page = await adminBackend.listUsers(oauthUserId: 'no-such-id');
          expect(_json(page.toJson()), {
            'users': [],
            'continuationToken': null,
          });
        });
      });

      testWithProfile('lookup by oauthUserId - found', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final page =
              await adminBackend.listUsers(oauthUserId: 'admin-pub-dev');
          expect(_json(page.toJson()), {
            'users': [
              {
                'userId': isNotNull,
                'oauthUserId': 'admin-pub-dev',
                'email': 'admin@pub.dev',
              },
            ],
            'continuationToken': null,
          });
        });
      });

      testWithProfile('lookup by multiple attribute', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final rs =
              adminBackend.listUsers(email: 'x', oauthUserId: 'no-such-id');
          await expectLater(rs, throwsA(isA<InvalidInputException>()));
        });
      });
    });

    group('Delete package', () {
      setupTestsWithCallerAuthorizationIssues(
          (client) => client.adminRemovePackage('oxygen'));

      testWithProfile('OK', fn: () async {
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);

        final pkgKey = dbService.emptyKey.append(Package, id: 'oxygen');
        final package = await dbService.lookupValue<Package>(pkgKey);
        expect(package, isNotNull);

        final versionsQuery =
            dbService.query<PackageVersion>(ancestorKey: pkgKey);
        final versions = await versionsQuery.run().toList();
        expect(versions.map((v) => v.version), ['1.0.0', '1.2.0', '2.0.0-dev']);

        final userClient = createPubApiClient(authToken: userAtPubDevAuthToken);
        await userClient.likePackage('oxygen');

        late Key likeKey;
        await accountBackend.withBearerToken(userAtPubDevAuthToken, () async {
          final user = await requireAuthenticatedUser();
          likeKey = dbService.emptyKey
              .append(User, id: user.userId)
              .append(Like, id: 'oxygen');
          final like = await dbService.lookupOrNull<Like>(likeKey);
          expect(like, isNotNull);
        });

        final moderatedPkgKey =
            dbService.emptyKey.append(ModeratedPackage, id: 'oxygen');
        var moderatedPkg =
            await dbService.lookupOrNull<ModeratedPackage>(moderatedPkgKey);
        expect(moderatedPkg, isNull);

        final timeBeforeRemoval = DateTime.now().toUtc();
        final rs = await client.adminRemovePackage('oxygen');

        expect(utf8.decode(rs), '{"status":"OK"}');

        final pkgAfterRemoval = await dbService.lookupOrNull<Package>(pkgKey);
        expect(pkgAfterRemoval, isNull);

        final versionsAfterRemoval = await versionsQuery.run().toList();
        expect(versionsAfterRemoval, isEmpty);

        final likeAfterRemoval = await dbService.lookupOrNull<Like>(likeKey);
        expect(likeAfterRemoval, isNull);

        moderatedPkg =
            await dbService.lookupValue<ModeratedPackage>(moderatedPkgKey);
        expect(moderatedPkg, isNotNull);
        expect(moderatedPkg.name, package.name);
        expect(moderatedPkg.moderated.isAfter(timeBeforeRemoval), isTrue);
        expect(moderatedPkg.uploaders, package.uploaders);
        expect(moderatedPkg.publisherId, package.publisherId);
        expect(moderatedPkg.versions, ['1.0.0', '1.2.0', '2.0.0-dev']);
      });
    });

    group('Delete package version', () {
      setupTestsWithCallerAuthorizationIssues(
          (client) => client.adminRemovePackageVersion('oxygen', '1.2.0'));

      testWithProfile('OK', fn: () async {
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final removeVersion = '1.2.0';

        final pkgKey = dbService.emptyKey.append(Package, id: 'oxygen');
        final package = await dbService.lookupValue<Package>(pkgKey);
        expect(package, isNotNull);

        final versionsQuery =
            dbService.query<PackageVersion>(ancestorKey: pkgKey);
        final versions = await versionsQuery.run().toList();
        expect(versions.map((v) => v.version), ['1.0.0', '1.2.0', '2.0.0-dev']);

        final userClient = createPubApiClient(authToken: userAtPubDevAuthToken);
        await userClient.likePackage('oxygen');

        late Key likeKey;
        await accountBackend.withBearerToken(userAtPubDevAuthToken, () async {
          final user = await requireAuthenticatedUser();
          likeKey = dbService.emptyKey
              .append(User, id: user.userId)
              .append(Like, id: 'oxygen');
          final like = await dbService.lookupOrNull<Like>(likeKey);
          expect(like, isNotNull);
        });

        final moderatedPkgKey =
            dbService.emptyKey.append(ModeratedPackage, id: 'oxygen');
        var moderatedPkg =
            await dbService.lookupOrNull<ModeratedPackage>(moderatedPkgKey);
        expect(moderatedPkg, isNull);

        final timeBeforeRemoval = DateTime.now().toUtc();
        final rs =
            await client.adminRemovePackageVersion('oxygen', removeVersion);

        expect(utf8.decode(rs), '{"status":"OK"}');

        final pkgAfterRemoval = await dbService.lookupOrNull<Package>(pkgKey);
        expect(pkgAfterRemoval, isNotNull);
        expect(Version.parse(pkgAfterRemoval!.latestVersion!),
            lessThan(Version.parse(removeVersion)));
        expect(pkgAfterRemoval.updated!.isAfter(timeBeforeRemoval), isTrue);

        final versionsAfterRemoval = await versionsQuery.run().toList();
        final missingVersion = versions
            .map((pv) => pv.version)
            .where((version) =>
                !versionsAfterRemoval.any((v) => v.version == version))
            .single;
        expect(versionsAfterRemoval, hasLength(versions.length - 1));
        expect(missingVersion, removeVersion);

        final likeAfterRemoval = await dbService.lookupOrNull<Like>(likeKey);
        expect(likeAfterRemoval, isNotNull);

        moderatedPkg =
            await dbService.lookupOrNull<ModeratedPackage>(moderatedPkgKey);
        expect(moderatedPkg, isNull);
      });
    });

    group('Delete user', () {
      setupTestsWithCallerAuthorizationIssues((client) async {
        final user =
            await accountBackend.lookupOrCreateUserByEmail('user@pub.dev');
        await client.adminRemoveUser(user.userId!);
      });

      testWithProfile(
        'OK',
        testProfile: defaultTestProfile.changeDefaultUser('user@pub.dev'),
        fn: () async {
          final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
          final user =
              await accountBackend.lookupOrCreateUserByEmail('user@pub.dev');

          final rs = await client.adminRemoveUser(user.userId!);
          expect(utf8.decode(rs), '{"status":"OK"}');

          final oxygen = await packageBackend.lookupPackage('oxygen');
          expect(oxygen!.publisherId, isNull);
          expect(oxygen.uploaders, []);
          expect(oxygen.isDiscontinued, true);

          final publisher = await publisherBackend.getPublisher('example.com');
          expect(publisher!.contactEmail, isNull);
          expect(publisher.isAbandoned, isTrue);

          final members = await dbService
              .query<PublisherMember>(ancestorKey: publisher.key)
              .run()
              .toList();
          expect(members, isEmpty);
        },
      );

      testWithProfile('Likes are cleaned up on user deletion', fn: () async {
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);

        final user =
            await accountBackend.lookupOrCreateUserByEmail('user@pub.dev');
        final userClient = createPubApiClient(authToken: userAtPubDevAuthToken);
        await userClient.likePackage('oxygen');

        final r2 = await client.getPackageLikes('oxygen');
        expect(r2.likes, 1);

        final likeKey = dbService.emptyKey
            .append(User, id: user.userId)
            .append(Like, id: 'oxygen');

        Like? like = await dbService.lookupOrNull<Like>(likeKey);
        expect(like, isNotNull);

        await client.adminRemoveUser(user.userId!);

        final r3 = await client.getPackageLikes('oxygen');
        expect(r3.likes, 0);

        like = await dbService.lookupOrNull<Like>(likeKey);
        expect(like, null);
      });

      // TODO: delete with multiple uploaders
      // TODO: delete with multiple members (contact email not changed)
      // TODO: delete with multiple members (contact email changes)
    });

    group('get assignedTags', () {
      setupTestsWithCallerAuthorizationIssues(
          (client) => client.adminGetAssignedTags('oxygen'));

      testWithProfile('get assignedTags', fn: () async {
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        final result = await client.adminGetAssignedTags('oxygen');
        expect(result.assignedTags, isNot(contains('is:featured')));
      });
    });

    group('set assignedTags', () {
      setupTestsWithCallerAuthorizationIssues(
          (client) => client.adminPostAssignedTags(
                'oxygen',
                PatchAssignedTags(assignedTagsAdded: ['is:featured']),
              ));

      testWithProfile('set assignedTags', fn: () async {
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);

        // Is initially not featured
        final r1 = await client.adminGetAssignedTags('oxygen');
        expect(r1.assignedTags, isNot(contains('is:featured')));

        // Set updating with no change, should have no effect
        await client.adminPostAssignedTags(
          'oxygen',
          PatchAssignedTags(assignedTagsAdded: r1.assignedTags),
        );
        final r2 = await client.adminGetAssignedTags('oxygen');
        expect(r2.assignedTags, isNot(contains('is:featured')));

        // Check that we can set is:featured
        await client.adminPostAssignedTags(
          'oxygen',
          PatchAssignedTags(assignedTagsAdded: ['is:featured']),
        );
        final r3 = await client.adminGetAssignedTags('oxygen');
        expect(r3.assignedTags, contains('is:featured'));

        // Check that we can set is:featured (again)
        await client.adminPostAssignedTags(
          'oxygen',
          PatchAssignedTags(assignedTagsAdded: ['is:featured']),
        );
        final r4 = await client.adminGetAssignedTags('oxygen');
        expect(r4.assignedTags, contains('is:featured'));

        // Check that we can remove the tag.
        await client.adminPostAssignedTags(
          'oxygen',
          PatchAssignedTags(assignedTagsRemoved: ['is:featured']),
        );
        final r5 = await client.adminGetAssignedTags('oxygen');
        expect(r5.assignedTags, isNot(contains('is:featured')));

        // Check that we can remove the tag (again).
        await client.adminPostAssignedTags(
          'oxygen',
          PatchAssignedTags(assignedTagsRemoved: ['is:featured']),
        );
        final r6 = await client.adminGetAssignedTags('oxygen');
        expect(r6.assignedTags, isNot(contains('is:featured')));
      });
    });

    group('package uploaders', () {
      void setupTestsWithPackageFailures(
        Future Function(PubApiClient client, String package) fn,
      ) {
        testWithProfile('missing package', fn: () async {
          final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
          final rs = fn(client, 'missing_package');
          await expectLater(
              rs,
              throwsA(isA<RequestException>().having((e) => e.bodyAsString(),
                  'body', contains('Could not find `missing_package`.'))));
        });

        testWithProfile('invalid package with publisher', fn: () async {
          final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
          final rs = fn(client, 'neon');
          await expectLater(
              rs,
              throwsA(isA<RequestException>().having((e) => e.bodyAsString(),
                  'body', contains('Package must not be under a publisher.'))));
        });
      }

      group('get', () {
        setupTestsWithCallerAuthorizationIssues(
            (client) => client.adminGetPackageUploaders('oxygen'));
        setupTestsWithPackageFailures(
            (client, package) => client.adminGetPackageUploaders(package));

        testWithProfile('reading uploaders', fn: () async {
          final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
          final rs = await client.adminGetPackageUploaders('oxygen');
          expect(rs.uploaders.single.toJson(), {
            'userId': isNotNull,
            'oauthUserId': null,
            'email': 'admin@pub.dev',
          });
        });
      });

      group('add', () {
        setupTestsWithCallerAuthorizationIssues((client) =>
            client.adminAddPackageUploader('oxygen', 'someuser@pub.dev'));
        setupTestsWithPackageFailures((client, package) =>
            client.adminAddPackageUploader(package, 'someuser@pub.dev'));

        testWithProfile('adding existing uploader', fn: () async {
          final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
          final rs =
              await client.adminAddPackageUploader('oxygen', 'admin@pub.dev');
          expect(rs.uploaders.single.toJson(), {
            'userId': isNotNull,
            'oauthUserId': null,
            'email': 'admin@pub.dev',
          });
        });

        testWithProfile('adding new uploader', fn: () async {
          final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
          final rs = await client.adminAddPackageUploader(
              'oxygen', 'someuser@pub.dev');
          expect(rs.uploaders.map((u) => u.email).toSet(), {
            'admin@pub.dev',
            'someuser@pub.dev',
          });
        });
      });

      group('remove', () {
        setupTestsWithCallerAuthorizationIssues((client) =>
            client.adminRemovePackageUploader('oxygen', 'admin@pub.dev'));
        setupTestsWithPackageFailures((client, package) =>
            client.adminRemovePackageUploader(package, 'admin@pub.dev'));

        testWithProfile('removing non-existing user', fn: () async {
          final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
          final rs =
              client.adminRemovePackageUploader('oxygen', 'someuser@pub.dev');
          await expectLater(
              rs,
              throwsA(isA<RequestException>().having(
                  (e) => e.bodyAsString(),
                  'body',
                  contains('No users found for email: `someuser@pub.dev`.'))));
        });

        testWithProfile('removing non-uploader user', fn: () async {
          final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
          final rs =
              await client.adminRemovePackageUploader('oxygen', 'user@pub.dev');
          expect(rs.uploaders.single.toJson(), {
            'userId': isNotNull,
            'oauthUserId': null,
            'email': 'admin@pub.dev',
          });
        });

        testWithProfile('removing an uploader', fn: () async {
          final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
          final rs = await client.adminAddPackageUploader(
              'oxygen', 'someuser@pub.dev');
          expect(rs.uploaders.map((u) => u.email).toSet(), {
            'admin@pub.dev',
            'someuser@pub.dev',
          });
          final rs2 = await client.adminRemovePackageUploader(
              'oxygen', 'someuser@pub.dev');
          expect(rs2.uploaders.single.email, 'admin@pub.dev');
        });

        testWithProfile('removing last uploader', fn: () async {
          final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
          final rs = await client.adminRemovePackageUploader(
              'oxygen', 'admin@pub.dev');
          expect(rs.uploaders, isEmpty);
        });
      });
    });
  });
}

dynamic _json(value) => json.decode(json.encode(value));
