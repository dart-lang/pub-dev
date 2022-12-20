// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/data/account_api.dart' as account_api;
import 'package:_pub_shared/data/admin_api.dart';
import 'package:_pub_shared/data/package_api.dart';
import 'package:clock/clock.dart';
import 'package:gcloud/db.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/admin/backend.dart';
import 'package:pub_dev/audit/backend.dart';
import 'package:pub_dev/audit/models.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/frontend/handlers/pubapi.client.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/publisher/backend.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('Admin API', () {
    group('List users', () {
      setupTestsWithAdminTokenIssues((client) => client.adminListUsers());

      testWithProfile('OK', fn: () async {
        final client = createPubApiClient(authToken: siteAdminToken);
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
        await accountBackend.withBearerToken(siteAdminToken, () async {
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
        await accountBackend.withBearerToken(siteAdminToken, () async {
          final page = await adminBackend.listUsers(email: 'no@such.email');
          expect(_json(page.toJson()), {
            'users': [],
            'continuationToken': null,
          });
        });
      });

      testWithProfile('lookup by email - found', fn: () async {
        await accountBackend.withBearerToken(siteAdminToken, () async {
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
        await accountBackend.withBearerToken(siteAdminToken, () async {
          final page = await adminBackend.listUsers(oauthUserId: 'no-such-id');
          expect(_json(page.toJson()), {
            'users': [],
            'continuationToken': null,
          });
        });
      });

      testWithProfile('lookup by oauthUserId - found', fn: () async {
        await accountBackend.withBearerToken(siteAdminToken, () async {
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
        await accountBackend.withBearerToken(siteAdminToken, () async {
          final rs =
              adminBackend.listUsers(email: 'x', oauthUserId: 'no-such-id');
          await expectLater(rs, throwsA(isA<InvalidInputException>()));
        });
      });
    });

    group('Delete package', () {
      setupTestsWithAdminTokenIssues(
          (client) => client.adminRemovePackage('oxygen'));

      testWithProfile('OK', fn: () async {
        final client = createPubApiClient(authToken: siteAdminToken);

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
          final user = await requireAuthenticatedWebUser();
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

        final timeBeforeRemoval = clock.now().toUtc();
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
      setupTestsWithAdminTokenIssues(
          (client) => client.adminRemovePackageVersion('oxygen', '1.2.0'));

      testWithProfile('OK', fn: () async {
        final client = createPubApiClient(authToken: siteAdminToken);
        final removeVersion = '1.2.0';

        final pkgKey = dbService.emptyKey.append(Package, id: 'oxygen');
        final package = await dbService.lookupValue<Package>(pkgKey);
        expect(package, isNotNull);
        expect(package.deletedVersions ?? [], isEmpty);

        final versionsQuery =
            dbService.query<PackageVersion>(ancestorKey: pkgKey);
        final versions = await versionsQuery.run().toList();
        expect(versions.map((v) => v.version), ['1.0.0', '1.2.0', '2.0.0-dev']);

        final userClient = createPubApiClient(authToken: userAtPubDevAuthToken);
        await userClient.likePackage('oxygen');

        late Key likeKey;
        await accountBackend.withBearerToken(userAtPubDevAuthToken, () async {
          final user = await requireAuthenticatedWebUser();
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

        final timeBeforeRemoval = clock.now().toUtc();
        final rs =
            await client.adminRemovePackageVersion('oxygen', removeVersion);

        expect(utf8.decode(rs), '{"status":"OK"}');

        final pkgAfter1stRemoval =
            await dbService.lookupOrNull<Package>(pkgKey);
        expect(pkgAfter1stRemoval, isNotNull);
        expect(Version.parse(pkgAfter1stRemoval!.latestVersion!),
            lessThan(Version.parse(removeVersion)));
        expect(pkgAfter1stRemoval.updated!.isAfter(timeBeforeRemoval), isTrue);
        expect(pkgAfter1stRemoval.versionCount, package.versionCount - 1);
        expect(pkgAfter1stRemoval.deletedVersions, [removeVersion]);

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

        // calling remove second time must not affect updated or version count
        final rs2 =
            await client.adminRemovePackageVersion('oxygen', removeVersion);
        expect(utf8.decode(rs2), '{"status":"OK"}');
        final pkgAfter2ndRemoval =
            await dbService.lookupOrNull<Package>(pkgKey);
        expect(pkgAfter2ndRemoval, isNotNull);
        expect(
          pkgAfter2ndRemoval!.latestVersion,
          pkgAfter1stRemoval.latestVersion,
        );
        expect(
          pkgAfter2ndRemoval.updated,
          pkgAfter1stRemoval.updated,
        );
        expect(
          pkgAfter2ndRemoval.versionCount,
          pkgAfter1stRemoval.versionCount,
        );
        expect(
          pkgAfter2ndRemoval.deletedVersions,
          pkgAfter1stRemoval.deletedVersions,
        );
      });
    });

    group('Delete user', () {
      setupTestsWithAdminTokenIssues(
        (client) async {
          final user = await accountBackend.lookupUserByEmail('user@pub.dev');
          await client.adminRemoveUser(user.userId);
        },
      );

      testWithProfile(
        'OK',
        testProfile: defaultTestProfile.changeDefaultUser('user@pub.dev'),
        fn: () async {
          final client = createPubApiClient(authToken: siteAdminToken);
          final user = await accountBackend.lookupUserByEmail('user@pub.dev');

          final rs = await client.adminRemoveUser(user.userId);
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
        final client = createPubApiClient(authToken: siteAdminToken);

        final user = await accountBackend.lookupUserByEmail('user@pub.dev');
        final userClient = createPubApiClient(authToken: userAtPubDevAuthToken);
        await userClient.likePackage('oxygen');

        final r2 = await client.getPackageLikes('oxygen');
        expect(r2.likes, 1);

        final likeKey = dbService.emptyKey
            .append(User, id: user.userId)
            .append(Like, id: 'oxygen');

        Like? like = await dbService.lookupOrNull<Like>(likeKey);
        expect(like, isNotNull);

        await client.adminRemoveUser(user.userId);

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
      setupTestsWithAdminTokenIssues(
          (client) => client.adminGetAssignedTags('oxygen'));

      testWithProfile('get assignedTags', fn: () async {
        final client = createPubApiClient(authToken: siteAdminToken);
        final result = await client.adminGetAssignedTags('oxygen');
        expect(result.assignedTags, isNot(contains('is:featured')));
      });
    });

    group('set assignedTags', () {
      setupTestsWithAdminTokenIssues(
        (client) => client.adminPostAssignedTags(
          'oxygen',
          PatchAssignedTags(assignedTagsAdded: ['is:featured']),
        ),
      );

      testWithProfile('set assignedTags', fn: () async {
        final client = createPubApiClient(authToken: siteAdminToken);

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
          final client = createPubApiClient(authToken: siteAdminToken);
          final rs = fn(client, 'missing_package');
          await expectLater(
              rs,
              throwsA(isA<RequestException>().having((e) => e.bodyAsString(),
                  'body', contains('Could not find `missing_package`.'))));
        });

        testWithProfile('invalid package with publisher', fn: () async {
          final client = createPubApiClient(authToken: siteAdminToken);
          final rs = fn(client, 'neon');
          await expectLater(
              rs,
              throwsA(isA<RequestException>().having((e) => e.bodyAsString(),
                  'body', contains('Package must not be under a publisher.'))));
        });
      }

      group('get', () {
        setupTestsWithAdminTokenIssues(
            (client) => client.adminGetPackageUploaders('oxygen'));
        setupTestsWithPackageFailures(
            (client, package) => client.adminGetPackageUploaders(package));

        testWithProfile('reading uploaders', fn: () async {
          final client = createPubApiClient(authToken: siteAdminToken);
          final rs = await client.adminGetPackageUploaders('oxygen');
          expect(rs.uploaders.single.toJson(), {
            'userId': isNotNull,
            'oauthUserId': isNotNull,
            'email': 'admin@pub.dev',
          });
        });
      });

      group('add', () {
        setupTestsWithAdminTokenIssues((client) =>
            client.adminAddPackageUploader('oxygen', 'someuser@pub.dev'));
        setupTestsWithPackageFailures((client, package) =>
            client.adminAddPackageUploader(package, 'someuser@pub.dev'));

        testWithProfile('adding existing uploader', fn: () async {
          final client = createPubApiClient(authToken: siteAdminToken);
          final rs =
              await client.adminAddPackageUploader('oxygen', 'admin@pub.dev');
          expect(rs.uploaders.single.toJson(), {
            'userId': isNotNull,
            'oauthUserId': isNotNull,
            'email': 'admin@pub.dev',
          });
        });

        testWithProfile('adding new uploader', fn: () async {
          final client = createPubApiClient(authToken: siteAdminToken);
          await client.adminAddPackageUploader('oxygen', 'someuser@pub.dev');

          final records1 = await auditBackend.listRecordsForPackage('oxygen');
          final inviteAuditRecord = records1.records
              .firstWhere((e) => e.kind == AuditLogRecordKind.uploaderInvited);
          expect(inviteAuditRecord.summary,
              '`admin@pub.dev` invited `someuser@pub.dev` to be an uploader for package `oxygen`.');

          final consentRow = await dbService.query<Consent>().run().single;
          expect(consentRow.args, ['oxygen']);
          expect(consentRow.createdBySiteAdmin, isTrue);

          await createPubApiClient(
            authToken: createFakeAuthTokenForEmail('someuser@pub.dev'),
          ).resolveConsent(
            consentRow.consentId,
            account_api.ConsentResult(granted: true),
          );

          final records2 = await auditBackend.listRecordsForPackage('oxygen');
          final acceptedAuditRecord = records2.records.firstWhere(
              (e) => e.kind == AuditLogRecordKind.uploaderInviteAccepted);
          expect(acceptedAuditRecord.summary,
              '`someuser@pub.dev` accepted uploader invite for package `oxygen`.');

          final uploaders = await client.adminGetPackageUploaders('oxygen');
          expect(uploaders.uploaders.map((u) => u.email).toSet(), {
            'admin@pub.dev',
            'someuser@pub.dev',
          });
        });
      });

      group('remove', () {
        setupTestsWithAdminTokenIssues((client) =>
            client.adminRemovePackageUploader('oxygen', 'admin@pub.dev'));

        setupTestsWithPackageFailures((client, package) =>
            client.adminRemovePackageUploader(package, 'admin@pub.dev'));

        testWithProfile('removing non-existing user', fn: () async {
          final client = createPubApiClient(authToken: siteAdminToken);
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
          final client = createPubApiClient(authToken: siteAdminToken);
          final rs =
              await client.adminRemovePackageUploader('oxygen', 'user@pub.dev');
          expect(rs.uploaders.single.toJson(), {
            'userId': isNotNull,
            'oauthUserId': isNotNull,
            'email': 'admin@pub.dev',
          });
        });

        testWithProfile('removing an uploader', fn: () async {
          final userAtPubDev =
              (await accountBackend.lookupUsersByEmail('user@pub.dev')).single;
          final someUser = await accountBackend.withBearerToken(
            createFakeAuthTokenForEmail('someuser@pub.dev'),
            () => requireAuthenticatedWebUser(),
          );

          final pkg = await packageBackend.lookupPackage('oxygen');
          pkg!.uploaders = [userAtPubDev.userId, someUser.userId];
          await dbService.commit(inserts: [pkg]);

          final client = createPubApiClient(authToken: siteAdminToken);
          final rs = await client.adminRemovePackageUploader(
              'oxygen', 'someuser@pub.dev');
          expect(rs.uploaders.single.email, 'user@pub.dev');
        });

        testWithProfile('removing last uploader', fn: () async {
          final client = createPubApiClient(authToken: siteAdminToken);
          final rs = await client.adminRemovePackageUploader(
              'oxygen', 'admin@pub.dev');
          expect(rs.uploaders, isEmpty);
        });
      });
    });

    group('retraction', () {
      setupTestsWithAdminTokenIssues(
        (client) => client.adminUpdateVersionOptions(
          'oxygen',
          '1.2.0',
          VersionOptions(isRetracted: true),
        ),
      );

      testWithProfile('bad retraction value', fn: () async {
        final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
        await expectApiException(
          client.adminUpdateVersionOptions(
            'oxygen',
            '1.0.0',
            VersionOptions(),
          ),
          status: 400,
          code: 'InvalidInput',
        );
      });

      testWithProfile('missing package', fn: () async {
        final client = createPubApiClient(authToken: siteAdminToken);
        await expectApiException(
          client.adminUpdateVersionOptions(
            'no_such_package',
            '1.0.0',
            VersionOptions(isRetracted: true),
          ),
          status: 404,
          code: 'NotFound',
        );
      });

      testWithProfile('missing version', fn: () async {
        final client = createPubApiClient(authToken: siteAdminToken);
        await expectApiException(
          client.adminUpdateVersionOptions(
            'oxygen',
            '1.0.0-no-such-version',
            VersionOptions(isRetracted: true),
          ),
          status: 404,
          code: 'NotFound',
        );
      });

      testWithProfile('no change', fn: () async {
        final v1 = await packageBackend.lookupPackageVersion('oxygen', '1.0.0');
        expect(v1!.isRetracted, false);
        expect(v1.retracted, null);
        final client = createPubApiClient(authToken: siteAdminToken);
        final rs = await client.adminUpdateVersionOptions(
          'oxygen',
          '1.0.0',
          VersionOptions(isRetracted: false),
        );
        final v2 = await packageBackend.lookupPackageVersion('oxygen', '1.0.0');
        expect(v2!.isRetracted, false);
        expect(v2.retracted, null);
        expect(rs.isRetracted, v2.isRetracted);
      });

      testWithProfile('update value and revert', fn: () async {
        final v1 = await packageBackend.lookupPackageVersion('oxygen', '1.0.0');
        expect(v1!.isRetracted, false);
        expect(v1.retracted, null);
        final client = createPubApiClient(authToken: siteAdminToken);

        // retract
        final rs1 = await client.adminUpdateVersionOptions(
          'oxygen',
          '1.0.0',
          VersionOptions(isRetracted: true),
        );
        final v2 = await packageBackend.lookupPackageVersion('oxygen', '1.0.0');
        expect(v2!.isRetracted, true);
        expect(v2.retracted, isNotNull);
        expect(rs1.isRetracted, v2.isRetracted);

        // retract again
        final rs2 = await client.adminUpdateVersionOptions(
          'oxygen',
          '1.0.0',
          VersionOptions(isRetracted: true),
        );
        final v3 = await packageBackend.lookupPackageVersion('oxygen', '1.0.0');
        expect(v3!.isRetracted, true);
        expect(v3.retracted, v2.retracted);
        expect(rs2.isRetracted, v3.isRetracted);

        // revert
        final rs3 = await client.adminUpdateVersionOptions(
          'oxygen',
          '1.0.0',
          VersionOptions(isRetracted: false),
        );
        final v4 = await packageBackend.lookupPackageVersion('oxygen', '1.0.0');
        expect(v4!.isRetracted, false);
        expect(v4.retracted, null);
        expect(rs3.isRetracted, v4.isRetracted);
      });
    });
  });
}

dynamic _json(value) => json.decode(json.encode(value));
