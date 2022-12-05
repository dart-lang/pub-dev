// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:_pub_shared/data/package_api.dart';
import 'package:clock/clock.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/storage.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/admin/backend.dart';
import 'package:pub_dev/audit/backend.dart';
import 'package:pub_dev/audit/models.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/fake/backend/fake_email_sender.dart';
import 'package:pub_dev/frontend/handlers/pubapi.client.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/package/name_tracker.dart';
import 'package:pub_dev/package/upload_signer_service.dart';
import 'package:pub_dev/service/secret/backend.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';
import 'backend_test_utils.dart';

void main() {
  group('uploading', () {
    group('packageBackend.startUpload', () {
      testWithProfile('no active user', fn: () async {
        final rs = packageBackend.startUpload(Uri.parse('http://example.com/'));
        await expectLater(rs, throwsA(isA<AuthenticationException>()));
      });

      testWithProfile('successful', fn: () async {
        final redirectUri = Uri.parse('http://blobstore.com/upload');
        await accountBackend.withBearerToken(userClientToken, () async {
          final info = await packageBackend.startUpload(redirectUri);
          expect(info.url, startsWith('http://localhost:'));
          expect(info.url, contains('/fake-incoming-packages/tmp/'));
          expect(info.fields, {
            'key': startsWith('fake-incoming-packages/tmp/'),
            'success_action_redirect': startsWith('$redirectUri?upload_id='),
          });
        });
      });
    });

    group('packageBackend.publishUploadedBlob', () {
      testWithProfile('uploaded zero-length file', fn: () async {
        await accountBackend.withBearerToken(adminClientToken, () async {
          final rs = createPubApiClient(authToken: adminClientToken)
              .uploadPackageBytes(List.empty());
          await expectApiException(
            rs,
            status: 400,
            code: 'PackageRejected',
            message: 'Package archive is empty',
          );
        });
      });

      testWithProfile('upload-too-big', fn: () async {
        final chunk = List.filled(1024 * 1024, 42);
        final chunkCount = UploadSignerService.maxUploadSize ~/ chunk.length;
        final bigTarball = <List<int>>[];
        for (int i = 0; i < chunkCount; i++) {
          bigTarball.add(chunk);
        }
        // Add one more byte than allowed.
        bigTarball.add([1]);
        final bytes =
            bigTarball.fold<List<int>>(<int>[], (r, l) => r..addAll(l));
        final rs = createPubApiClient(authToken: adminClientToken)
            .uploadPackageBytes(bytes);
        await expectApiException(
          rs,
          status: 400,
          code: 'PackageRejected',
          message: 'Package archive exceeded ',
        );
      });

      testWithProfile('successful new package', fn: () async {
        final dateBeforeTest = clock.now().toUtc();
        final pubspecContent = generatePubspecYaml('new_package', '1.2.3');
        final message = await createPubApiClient(authToken: userClientToken)
            .uploadPackageBytes(
                await packageArchiveBytes(pubspecContent: pubspecContent));
        expect(message.success.message, contains('Successfully uploaded'));
        expect(message.success.message, contains('new_package'));
        expect(message.success.message, contains('1.2.3'));

        // verify state
        final user = await accountBackend.lookupUserByEmail('user@pub.dev');

        final pkgKey = dbService.emptyKey.append(Package, id: 'new_package');
        final package = (await dbService.lookup<Package>([pkgKey])).single!;
        expect(package.name, 'new_package');
        expect(package.latestVersion, '1.2.3');
        expect(package.uploaders, [user.userId]);
        expect(package.publisherId, isNull);
        expect(package.created!.compareTo(dateBeforeTest) >= 0, isTrue);
        expect(package.updated!.compareTo(dateBeforeTest) >= 0, isTrue);
        expect(package.versionCount, 1);

        final pvKey = package.latestVersionKey;
        final pv = (await dbService.lookup<PackageVersion>([pvKey!])).single!;
        expect(pv.packageKey, package.key);
        expect(pv.created!.compareTo(dateBeforeTest) >= 0, isTrue);
        expect(pv.pubspec!.asJson, loadYaml(pubspecContent));
        expect(pv.libraries, ['test_library.dart']);
        expect(pv.uploader, user.userId);
        expect(pv.publisherId, isNull);

        expect(fakeEmailSender.sentMessages, hasLength(1));
        final email = fakeEmailSender.sentMessages.single;
        expect(email.recipients.single.email, user.email);
        expect(email.subject, 'Package uploaded: new_package 1.2.3');
        expect(email.bodyText,
            contains('https://pub.dev/packages/new_package/versions/1.2.3\n'));

        final audits = await auditBackend.listRecordsForPackageVersion(
            'new_package', '1.2.3');
        final publishedAudit = audits.records.first;
        expect(publishedAudit.kind, AuditLogRecordKind.packagePublished);
        expect(publishedAudit.created, isNotNull);
        expect(publishedAudit.expires!.year, greaterThan(9998));
        expect(publishedAudit.agent, user.userId);
        expect(publishedAudit.users, [user.userId]);
        expect(publishedAudit.packages, ['new_package']);
        expect(publishedAudit.packageVersions, ['new_package/1.2.3']);
        expect(publishedAudit.publishers, []);
        expect(publishedAudit.summary,
            'Package `new_package` version `1.2.3` was published by `user@pub.dev`.');
        expect(publishedAudit.data, {
          'package': 'new_package',
          'version': '1.2.3',
          'email': 'user@pub.dev',
        });

        final assets = await dbService
            .query<PackageVersionAsset>()
            .run()
            .where((pva) => pva.qualifiedVersionKey == pv.qualifiedVersionKey)
            .toList();
        final readme = assets.firstWhere((pva) => pva.kind == AssetKind.readme);
        expect(readme.path, 'README.md');
        expect(readme.textContent, foobarReadmeContent);
        final changelog =
            assets.firstWhere((pva) => pva.kind == AssetKind.changelog);
        expect(changelog.path, 'CHANGELOG.md');
        expect(changelog.textContent, foobarChangelogContent);

        final canonicalInfo = await storageService
            .bucket(activeConfiguration.canonicalPackagesBucketName!)
            .info('packages/new_package-1.2.3.tar.gz');
        expect(canonicalInfo.length, greaterThan(200));

        final publicInfo = await storageService
            .bucket(activeConfiguration.publicPackagesBucketName!)
            .info('packages/new_package-1.2.3.tar.gz');
        expect(publicInfo.length, canonicalInfo.length);
      });

      testWithProfile('package under publisher', fn: () async {
        final dateBeforeTest = clock.now().toUtc();
        final pubspecContent = generatePubspecYaml('neon', '7.0.0');
        final message = await createPubApiClient(authToken: adminClientToken)
            .uploadPackageBytes(
                await packageArchiveBytes(pubspecContent: pubspecContent));
        expect(message.success.message, contains('Successfully uploaded'));
        expect(message.success.message, contains('neon'));
        expect(message.success.message, contains('7.0.0'));

        // verify state
        final user = await accountBackend.lookupUserByEmail('admin@pub.dev');
        final pkgKey = dbService.emptyKey.append(Package, id: 'neon');
        final package = (await dbService.lookup<Package>([pkgKey])).single!;
        expect(package.name, 'neon');
        expect(package.latestVersion, '7.0.0');
        expect(package.publisherId, 'example.com');
        expect(package.uploaders, []);
        expect(package.created!.compareTo(dateBeforeTest) < 0, isTrue);
        expect(package.updated!.compareTo(dateBeforeTest) >= 0, isTrue);

        final pvKey = package.latestVersionKey;
        final pv = (await dbService.lookup<PackageVersion>([pvKey!])).single!;
        expect(pv.packageKey, package.key);
        expect(pv.created!.compareTo(dateBeforeTest) >= 0, isTrue);
        expect(pv.pubspec!.asJson, loadYaml(pubspecContent));
        expect(pv.libraries, ['test_library.dart']);
        expect(pv.uploader, user.userId);
        expect(pv.publisherId, 'example.com');

        expect(fakeEmailSender.sentMessages, hasLength(1));
        final email = fakeEmailSender.sentMessages.single;
        expect(email.recipients.single.email, user.email);
        expect(email.subject, 'Package uploaded: neon 7.0.0');
        expect(email.bodyText,
            contains('https://pub.dev/packages/neon/versions/7.0.0\n'));

        final audits =
            await auditBackend.listRecordsForPackageVersion('neon', '7.0.0');
        final publishedAudit = audits.records.first;
        expect(publishedAudit.kind, AuditLogRecordKind.packagePublished);
        expect(publishedAudit.summary,
            'Package `neon` version `7.0.0` owned by publisher `example.com` was published by `admin@pub.dev`.');
        expect(publishedAudit.publishers, ['example.com']);

        final assets = await dbService
            .query<PackageVersionAsset>()
            .run()
            .where((pva) => pva.qualifiedVersionKey == pv.qualifiedVersionKey)
            .toList();
        final readme = assets.firstWhere((pva) => pva.kind == AssetKind.readme);
        expect(readme.path, 'README.md');
        expect(readme.textContent, foobarReadmeContent);
        final changelog =
            assets.firstWhere((pva) => pva.kind == AssetKind.changelog);
        expect(changelog.path, 'CHANGELOG.md');
        expect(changelog.textContent, foobarChangelogContent);
      });
    });

    group('Uploading with service account', () {
      testWithProfile('service account cannot upload new package',
          fn: () async {
        final token =
            createFakeServiceAccountToken(email: 'admin-action@pub.dev');
        final pubspecContent = generatePubspecYaml('new_package', '1.2.3');
        final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
        final rs =
            createPubApiClient(authToken: token).uploadPackageBytes(bytes);
        await expectApiException(
          rs,
          status: 400,
          code: 'PackageRejected',
          message: 'Only users are allowed to upload new packages.',
        );
      });

      testWithProfile(
          'service account cannot upload new version to existing package',
          fn: () async {
        final token =
            createFakeServiceAccountToken(email: 'admin-action@pub.dev');
        final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
        final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
        final rs =
            createPubApiClient(authToken: token).uploadPackageBytes(bytes);
        await expectApiException(
          rs,
          status: 403,
          code: 'InsufficientPermissions',
          message: 'publishing with service account is not enabled',
        );
      });

      testWithProfile(
          'service account cannot upload because email not matching',
          fn: () async {
        await withHttpPubApiClient(
          bearerToken: adminAtPubDevAuthToken,
          fn: (client) async {
            await client.setAutomatedPublishing(
              'oxygen',
              AutomatedPublishing(
                gcp: GcpPublishing(
                  isEnabled: true,
                  serviceAccountEmail: 'admin@x.gserviceaccount.com',
                ),
              ),
            );
          },
        );
        final token =
            createFakeServiceAccountToken(email: 'admin-action@pub.dev');
        final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
        final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
        final rs =
            createPubApiClient(authToken: token).uploadPackageBytes(bytes);
        await expectApiException(
          rs,
          status: 403,
          code: 'InsufficientPermissions',
          message:
              'publishing is not enabled for the "admin-action@pub.dev" service account',
        );
      });

      testWithProfile(
          'service account cannot upload because id lock prevents it',
          fn: () async {
        await withHttpPubApiClient(
          bearerToken: adminAtPubDevAuthToken,
          fn: (client) async {
            await client.setAutomatedPublishing(
              'oxygen',
              AutomatedPublishing(
                gcp: GcpPublishing(
                  isEnabled: true,
                  serviceAccountEmail: 'admin@x.gserviceaccount.com',
                ),
              ),
            );
          },
        );
        final pkg = await packageBackend.lookupPackage('oxygen');
        pkg!.automatedPublishingLock = AutomatedPublishingLock(
          gcp: GcpPublishingLock(
            oauthUserId: 'other-user-id',
          ),
        );
        await dbService.commit(inserts: [pkg]);
        final token =
            createFakeServiceAccountToken(email: 'admin@x.gserviceaccount.com');
        final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
        final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
        final rs =
            createPubApiClient(authToken: token).uploadPackageBytes(bytes);
        await expectApiException(
          rs,
          status: 403,
          code: 'InsufficientPermissions',
          message:
              'Google Cloud Service account identifiers changed, disabling automated publishing',
        );

        final pkgAfter = await packageBackend.lookupPackage('oxygen');
        expect(pkgAfter!.automatedPublishing.gcp!.toJson(), {
          'isEnabled': false,
          'serviceAccountEmail': 'admin@x.gserviceaccount.com',
        });
      });

      testWithProfile('successful upload with service account', fn: () async {
        await withHttpPubApiClient(
          bearerToken: adminAtPubDevAuthToken,
          fn: (client) async {
            await client.setAutomatedPublishing(
              'oxygen',
              AutomatedPublishing(
                gcp: GcpPublishing(
                  isEnabled: true,
                  serviceAccountEmail: 'admin@x.gserviceaccount.com',
                ),
              ),
            );
          },
        );
        final token =
            createFakeServiceAccountToken(email: 'admin@x.gserviceaccount.com');
        final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
        final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
        final rs =
            createPubApiClient(authToken: token).uploadPackageBytes(bytes);
        await expectApiException(
          rs,
          status: 400,
          code: 'PackageRejected',
          message:
              'Google Cloud Service account recognized successful, but publishing is not enabled yet',
        );

        // TODO: once it is enabled, check for automatedPublishingLock
      });
    });

    group('Uploading with GitHub Actions', () {
      testWithProfile('GitHub Actions cannot upload new package', fn: () async {
        final token = createFakeGithubActionToken(
          repository: 'x/y',
          ref: 'refs/tag/1',
        );
        final pubspecContent = generatePubspecYaml('new_package', '1.2.3');
        final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
        final rs =
            createPubApiClient(authToken: token).uploadPackageBytes(bytes);
        // TODO: refactor upload to return better error message
        await expectApiException(
          rs,
          status: 400,
          code: 'PackageRejected',
          message: 'Only users are allowed to upload new packages.',
        );
      });

      testWithProfile(
          'GitHub Actions cannot upload new version to existing package',
          fn: () async {
        final token = createFakeGithubActionToken(
          repository: 'x/y',
          ref: 'refs/tag/1',
        );
        final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
        final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
        final rs =
            createPubApiClient(authToken: token).uploadPackageBytes(bytes);
        await expectApiException(
          rs,
          status: 403,
          code: 'InsufficientPermissions',
          message: 'publishing from github is not enabled',
        );
      });

      testWithProfile(
          'GitHub Actions cannot upload because repository not matching',
          fn: () async {
        await withHttpPubApiClient(
          bearerToken: adminAtPubDevAuthToken,
          fn: (client) async {
            await client.setAutomatedPublishing(
              'oxygen',
              AutomatedPublishing(
                github: GithubPublishing(
                  isEnabled: true,
                  repository: 'a/b',
                  tagPattern: '{{version}}',
                ),
              ),
            );
          },
        );
        final token = createFakeGithubActionToken(
          repository: 'x/y',
          ref: 'refs/tag/1',
        );
        final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
        final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
        final rs =
            createPubApiClient(authToken: token).uploadPackageBytes(bytes);
        await expectApiException(
          rs,
          status: 403,
          code: 'InsufficientPermissions',
          message:
              'publishing is not enabled for the \"x/y\" repository, it may be enabled for another repository',
        );
      });

      testWithProfile(
          'GitHub Actions cannot upload because ref type not matching',
          fn: () async {
        await withHttpPubApiClient(
          bearerToken: adminAtPubDevAuthToken,
          fn: (client) async {
            await client.setAutomatedPublishing(
              'oxygen',
              AutomatedPublishing(
                github: GithubPublishing(
                  isEnabled: true,
                  repository: 'a/b',
                  tagPattern: '{{version}}',
                ),
              ),
            );
          },
        );
        final token = createFakeGithubActionToken(
          repository: 'a/b',
          ref: 'refs/unknown-ref-type/1',
        );
        final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
        final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
        final rs =
            createPubApiClient(authToken: token).uploadPackageBytes(bytes);
        await expectApiException(
          rs,
          status: 403,
          code: 'InsufficientPermissions',
          message:
              'publishing is only allowed from \"tag\" refType, this token has \"unknown-ref-type\" refType',
        );
      });

      testWithProfile(
          'GitHub Actions cannot upload because version pattern not matching',
          fn: () async {
        await withHttpPubApiClient(
          bearerToken: adminAtPubDevAuthToken,
          fn: (client) async {
            await client.setAutomatedPublishing(
              'oxygen',
              AutomatedPublishing(
                github: GithubPublishing(
                  isEnabled: true,
                  repository: 'a/b',
                  tagPattern: '{{version}}',
                ),
              ),
            );
          },
        );
        final token = createFakeGithubActionToken(
          repository: 'a/b',
          ref: 'refs/tags/1',
        );
        final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
        final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
        final rs =
            createPubApiClient(authToken: token).uploadPackageBytes(bytes);
        await expectApiException(
          rs,
          status: 403,
          code: 'InsufficientPermissions',
          message:
              'publishing is configured to only be allowed from actions with specific '
              'ref pattern, this token has \"refs/tags/1\" ref for which publishing is not allowed',
        );
      });

      testWithProfile(
          'GitHub Actions cannot upload because id lock prevents it',
          fn: () async {
        Future<void> setupPublishingAndLock() async {
          await withHttpPubApiClient(
            bearerToken: adminAtPubDevAuthToken,
            fn: (client) async {
              await client.setAutomatedPublishing(
                'oxygen',
                AutomatedPublishing(
                  github: GithubPublishing(
                    isEnabled: true,
                    repository: 'a/b',
                    tagPattern: '{{version}}',
                  ),
                ),
              );
            },
          );
          final pkg = await packageBackend.lookupPackage('oxygen');
          pkg!.automatedPublishingLock = AutomatedPublishingLock(
            github: GithubPublishingLock(
              repositoryOwnerId: 'x',
              repositoryId: 'y',
            ),
          );
          await dbService.commit(inserts: [pkg]);
        }

        final badTokens = [
          createFakeGithubActionToken(
            repository: 'a/b',
            ref: 'refs/tags/2.2.0',
            repositoryId: 'x2',
            repositoryOwnerId: 'y',
          ),
          createFakeGithubActionToken(
            repository: 'a/b',
            ref: 'refs/tags/2.2.0',
            repositoryId: 'x',
            repositoryOwnerId: 'y2',
          ),
        ];
        final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
        final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);

        for (final token in badTokens) {
          await setupPublishingAndLock();
          final rs =
              createPubApiClient(authToken: token).uploadPackageBytes(bytes);
          await expectApiException(
            rs,
            status: 403,
            code: 'InsufficientPermissions',
            message:
                'GitHub repository identifiers changed, disabling automated publishing',
          );
          final pkg = await packageBackend.lookupPackage('oxygen');
          expect(pkg!.automatedPublishing.github!.toJson(), {
            'isEnabled': false,
            'repository': 'a/b',
            'tagPattern': '{{version}}',
          });
        }
      });

      testWithProfile(
          'successful upload with GitHub Actions (without environment)',
          fn: () async {
        await withHttpPubApiClient(
          bearerToken: adminAtPubDevAuthToken,
          fn: (client) async {
            await client.setAutomatedPublishing(
              'oxygen',
              AutomatedPublishing(
                github: GithubPublishing(
                  isEnabled: true,
                  repository: 'a/b',
                  tagPattern: '{{version}}',
                ),
              ),
            );
          },
        );
        final token = createFakeGithubActionToken(
          repository: 'a/b',
          ref: 'refs/tags/2.2.0',
        );
        final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
        final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
        final rs =
            createPubApiClient(authToken: token).uploadPackageBytes(bytes);
        await expectApiException(
          rs,
          status: 400,
          code: 'PackageRejected',
          message:
              'GitHub Action recognized successful, but publishing is not enabled yet.',
        );
      });

      testWithProfile(
          'successful upload with GitHub Actions (exempted package)',
          testProfile: TestProfile(
            packages: [
              TestPackage(name: '_dummy_pkg'),
              TestPackage(name: 'oxygen'),
            ],
            defaultUser: 'admin@pub.dev',
          ), fn: () async {
        await withHttpPubApiClient(
          bearerToken: adminAtPubDevAuthToken,
          fn: (client) async {
            await client.setAutomatedPublishing(
              '_dummy_pkg',
              AutomatedPublishing(
                github: GithubPublishing(
                  isEnabled: true,
                  repository: 'a/b',
                  tagPattern: '{{version}}',
                ),
              ),
            );
          },
        );
        final token = createFakeGithubActionToken(
          repository: 'a/b',
          ref: 'refs/tags/2.2.0',
          repositoryId: 'repo-id-1',
          repositoryOwnerId: 'owner-id-234',
        );
        final pubspecContent = generatePubspecYaml('_dummy_pkg', '2.2.0');
        final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
        final rs = await createPubApiClient(authToken: token)
            .uploadPackageBytes(bytes);
        expect(rs.success.message,
            'Successfully uploaded https://pub.dev/packages/_dummy_pkg version 2.2.0.');

        final pkg = await packageBackend.lookupPackage('_dummy_pkg');
        expect(pkg!.automatedPublishingLock.toJson(), {
          'github': {
            'repositoryId': 'repo-id-1',
            'repositoryOwnerId': 'owner-id-234',
          },
        });

        expect(fakeEmailSender.sentMessages, hasLength(1));
        final email = fakeEmailSender.sentMessages.single;
        expect(email.recipients.single.email, 'admin@pub.dev');
        expect(email.subject, 'Package uploaded: _dummy_pkg 2.2.0');
        expect(
            email.bodyText,
            contains(
                'service:github-actions has published a new version (2.2.0)'));

        final audits = await auditBackend.listRecordsForPackageVersion(
            '_dummy_pkg', '2.2.0');
        final publishedAudit = audits.records.first;
        expect(publishedAudit.kind, AuditLogRecordKind.packagePublished);
        expect(publishedAudit.created, isNotNull);
        expect(publishedAudit.expires!.year, greaterThan(9998));
        expect(publishedAudit.agent, 'service:github-actions');
        expect(publishedAudit.users, []);
        expect(publishedAudit.packages, ['_dummy_pkg']);
        expect(publishedAudit.packageVersions, ['_dummy_pkg/2.2.0']);
        expect(publishedAudit.publishers, []);
        expect(
          publishedAudit.summary,
          startsWith(
              'Package `_dummy_pkg` version `2.2.0` was published from GitHub Actions (`run_id`: [`'),
        );
        expect(publishedAudit.summary,
            contains('triggered by pushing to the `a/b` repository.'));
        expect(publishedAudit.data, {
          'package': '_dummy_pkg',
          'version': '2.2.0',
          'repository': 'a/b',
          'run_id': isNotEmpty,
        });
      });

      testWithProfile(
          'GitHub Actions cannot upload because environment is missing',
          fn: () async {
        await withHttpPubApiClient(
          bearerToken: adminAtPubDevAuthToken,
          fn: (client) async {
            await client.setAutomatedPublishing(
              'oxygen',
              AutomatedPublishing(
                github: GithubPublishing(
                  isEnabled: true,
                  repository: 'a/b',
                  tagPattern: '{{version}}',
                  requireEnvironment: true,
                  environment: 'prod',
                ),
              ),
            );
          },
        );
        final token = createFakeGithubActionToken(
          repository: 'a/b',
          ref: 'refs/tags/2.2.0',
        );
        final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
        final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
        final rs =
            createPubApiClient(authToken: token).uploadPackageBytes(bytes);
        await expectApiException(
          rs,
          status: 403,
          code: 'InsufficientPermissions',
          message:
              'publishing is configured to only be allowed from actions with an environment, '
              'this token originates from an action running in environment \"null\" for which publishing is not allowed',
        );
      });

      testWithProfile(
          'GitHub Actions cannot upload because environment not matching',
          fn: () async {
        await withHttpPubApiClient(
          bearerToken: adminAtPubDevAuthToken,
          fn: (client) async {
            await client.setAutomatedPublishing(
              'oxygen',
              AutomatedPublishing(
                github: GithubPublishing(
                  isEnabled: true,
                  repository: 'a/b',
                  tagPattern: '{{version}}',
                  requireEnvironment: true,
                  environment: 'prod',
                ),
              ),
            );
          },
        );
        final token = createFakeGithubActionToken(
          repository: 'a/b',
          ref: 'refs/tags/2.2.0',
          environment: 'staging',
        );
        final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
        final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
        final rs =
            createPubApiClient(authToken: token).uploadPackageBytes(bytes);
        await expectApiException(
          rs,
          status: 403,
          code: 'InsufficientPermissions',
          message:
              'publishing is configured to only be allowed from actions with an environment, '
              'this token originates from an action running in environment \"staging\" for which publishing is not allowed',
        );
      });

      testWithProfile(
          'successful upload with GitHub Actions (with environment)',
          fn: () async {
        await withHttpPubApiClient(
          bearerToken: adminAtPubDevAuthToken,
          fn: (client) async {
            await client.setAutomatedPublishing(
              'oxygen',
              AutomatedPublishing(
                github: GithubPublishing(
                  isEnabled: true,
                  repository: 'a/b',
                  tagPattern: 'v{{version}}',
                  requireEnvironment: true,
                  environment: 'prod',
                ),
              ),
            );
          },
        );
        final token = createFakeGithubActionToken(
          repository: 'a/b',
          ref: 'refs/tags/v2.2.0',
          environment: 'prod',
        );
        final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
        final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
        final rs =
            createPubApiClient(authToken: token).uploadPackageBytes(bytes);
        await expectApiException(
          rs,
          status: 400,
          code: 'PackageRejected',
          message:
              'GitHub Action recognized successful, but publishing is not enabled yet.',
        );
      });
    });

    group('packageBackend.upload', () {
      testWithProfile('not logged in', fn: () async {
        final tarball = await packageArchiveBytes(pubspecContent: '');
        final rs = createPubApiClient().uploadPackageBytes(tarball);
        await expectApiException(
          rs,
          status: 401,
          code: 'MissingAuthentication',
          headers: {
            'www-authenticate': contains('Bearer realm="pub", message="'),
          },
        );
      });

      testWithProfile('not authorized', fn: () async {
        final p1 = await packageBackend.lookupPackage('oxygen');
        expect(p1!.versionCount, 3);
        final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('oxygen', '2.2.0'));
        final rs = createPubApiClient(authToken: userClientToken)
            .uploadPackageBytes(tarball);
        await expectApiException(
          rs,
          status: 403,
          code: 'InsufficientPermissions',
          headers: {
            'www-authenticate': contains('Bearer realm="pub", message="'),
          },
        );
        final p2 = await packageBackend.lookupPackage('oxygen');
        expect(p2!.versionCount, 3);
      });

      testWithProfile('user is blocked', fn: () async {
        final user = await accountBackend.lookupUserByEmail('user@pub.dev');
        await dbService.commit(inserts: [user..isBlocked = true]);
        final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('pkg', '1.2.3'));
        final rs = createPubApiClient(authToken: userClientToken)
            .uploadPackageBytes(tarball);
        await expectApiException(rs,
            status: 403, code: 'InsufficientPermissions');
      });

      testWithProfile('upload restriction - no uploads', fn: () async {
        await secretBackend.update(SecretKey.uploadRestriction, 'no-uploads');
        final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('oxygen', '2.3.0'));
        final rs = createPubApiClient(authToken: adminClientToken)
            .uploadPackageBytes(tarball);
        await expectApiException(
          rs,
          status: 400,
          code: 'PackageRejected',
          message: 'Uploads are restricted. Please try again later.',
        );
      });

      testWithProfile('upload restriction - no new packages', fn: () async {
        await secretBackend.update(SecretKey.uploadRestriction, 'only-updates');
        final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('some_new_package', '1.2.3'));
        final rs = createPubApiClient(authToken: adminClientToken)
            .uploadPackageBytes(tarball);
        await expectApiException(
          rs,
          status: 400,
          code: 'PackageRejected',
          message: 'Uploads are restricted. Please try again later.',
        );
      });

      testWithProfile('upload restriction - update is accepted', fn: () async {
        await secretBackend.update(SecretKey.uploadRestriction, 'only-updates');
        final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('oxygen', '3.4.5'));
        final message = await createPubApiClient(authToken: adminClientToken)
            .uploadPackageBytes(tarball);
        expect(message.success.message, contains('Successfully uploaded'));
      });

      testWithProfile('versions already exist', fn: () async {
        final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('neon', '1.0.0'));
        final rs = createPubApiClient(authToken: adminClientToken)
            .uploadPackageBytes(tarball);
        await expectApiException(
          rs,
          status: 400,
          code: 'PackageRejected',
          message: 'Version 1.0.0 of package neon already exists',
        );
      });

      testWithProfile('same canonical archive already exist', fn: () async {
        final version =
            await packageBackend.lookupPackageVersion('neon', '1.0.1');
        expect(version, isNull);
        final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('neon', '1.0.1'));
        final canonicalBucket = storageService
            .bucket(activeConfiguration.canonicalPackagesBucketName!);
        await canonicalBucket.writeBytes('packages/neon-1.0.1.tar.gz', tarball);

        final message = await createPubApiClient(authToken: adminClientToken)
            .uploadPackageBytes(tarball);
        expect(message.success.message, contains('Successfully uploaded'));
        expect(message.success.message, contains('neon'));
        expect(message.success.message, contains('1.0.1'));
      });

      testWithProfile('different canonical archive already exist',
          fn: () async {
        final version =
            await packageBackend.lookupPackageVersion('neon', '1.0.1');
        expect(version, isNull);
        final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('neon', '1.0.1'));
        final canonicalBucket = storageService
            .bucket(activeConfiguration.canonicalPackagesBucketName!);
        await canonicalBucket
            .writeBytes('packages/neon-1.0.1.tar.gz', [...tarball, 1, 2, 3]);

        final rs = createPubApiClient(authToken: adminClientToken)
            .uploadPackageBytes(tarball);
        await expectApiException(
          rs,
          status: 400,
          code: 'PackageRejected',
          message: 'Version 1.0.1 of package neon already exists.',
        );
      });

      testWithProfile('versions has been deleted', fn: () async {
        await accountBackend.withBearerToken(siteAdminToken, () async {
          await adminBackend.removePackageVersion('oxygen', '1.0.0');
        });
        final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('oxygen', '1.0.0'));
        final rs = createPubApiClient(authToken: adminClientToken)
            .uploadPackageBytes(tarball);
        await expectApiException(
          rs,
          status: 400,
          code: 'PackageRejected',
          message:
              'Version 1.0.0 of package oxygen was deleted previously, re-upload is not allowed.',
        );
      });

      // Returns the error message as String or null if it succeeded.
      Future<String?> fn(String name) async {
        final pubspecContent = generatePubspecYaml(name, '0.2.0');
        try {
          final tarball =
              await packageArchiveBytes(pubspecContent: pubspecContent);
          await createPubApiClient(authToken: adminClientToken)
              .uploadPackageBytes(tarball);
        } on RequestException catch (e) {
          return [
            e.bodyAsJson()['error']['code'] as String,
            '(${e.status}): ',
            e.bodyAsJson()['error']['message'] as String,
          ].join();
        }
        // no issues, return null
        return null;
      }

      testWithProfile('bad package names are rejected', fn: () async {
        await nameTracker.reloadFromDatastore();
        await accountBackend.withBearerToken(adminClientToken, () async {
          expect(await fn('with'),
              'PackageRejected(400): Package name must not be a reserved word in Dart.');
          expect(await fn('123test'),
              'PackageRejected(400): Package name must begin with a letter or underscore.');
          expect(await fn('With Space'),
              'PackageRejected(400): Package name may only contain letters, numbers, and underscores.');

          expect(await fn('ok_name'), isNull);
        });
      });

      testWithProfile('similar package names are rejected', fn: () async {
        await accountBackend.withBearerToken(adminClientToken, () async {
          expect(await fn('ox_ygen'),
              'PackageRejected(400): Package name `ox_ygen` is too similar to another active package: `oxygen` (https://pub.dev/packages/oxygen).');

          expect(await fn('ox_y_ge_n'),
              'PackageRejected(400): Package name `ox_y_ge_n` is too similar to another active package: `oxygen` (https://pub.dev/packages/oxygen).');
        });
      });

      testWithProfile('moderated package names are rejected', fn: () async {
        await accountBackend.withBearerToken(siteAdminToken, () async {
          await adminBackend.removePackage('neon');
        });
        await accountBackend.withBearerToken(adminClientToken, () async {
          await nameTracker.reloadFromDatastore();

          expect(await fn('neon'),
              'PackageRejected(400): Package name `neon` is too similar to a moderated package: `neon`.');

          // similar names are accepted
          expect(await fn('ne_on'), isNull);
        });
      });

      testWithProfile('bad yaml file: duplicate key', fn: () async {
        final tarball = await packageArchiveBytes(
            pubspecContent:
                'name: xyz\n' + generatePubspecYaml('xyz', '1.0.0'));
        final rs = createPubApiClient(authToken: adminClientToken)
            .uploadPackageBytes(tarball);
        await expectApiException(
          rs,
          status: 400,
          code: 'PackageRejected',
          message: 'Duplicate mapping key.',
        );
      });

      testWithProfile('bad pubspec content: bad version', fn: () async {
        final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('xyz', 'not-a-version'));
        final rs = createPubApiClient(authToken: adminClientToken)
            .uploadPackageBytes(tarball);
        await expectApiException(
          rs,
          status: 400,
          code: 'PackageRejected',
          message:
              'Unsupported value for "version". Could not parse "not-a-version".',
        );
      });

      testWithProfile('has git dependency', fn: () async {
        final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('xyz', '1.0.0') +
                '  abcd:\n'
                    '    git:\n'
                    '      url: git://github.com/a/b\n'
                    '      path: x/y/z\n');
        final rs = createPubApiClient(authToken: adminClientToken)
            .uploadPackageBytes(tarball);
        await expectApiException(
          rs,
          status: 400,
          code: 'PackageRejected',
          message: 'is a git dependency',
        );
      });

      testWithProfile('successful update + download', fn: () async {
        final p1 = await packageBackend.lookupPackage('oxygen');
        expect(p1!.versionCount, 3);
        final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('oxygen', '3.0.0'));
        final message = await createPubApiClient(authToken: adminClientToken)
            .uploadPackageBytes(tarball);
        expect(message.success.message, contains('Successfully uploaded'));
        expect(message.success.message, contains('oxygen'));
        expect(message.success.message, contains('3.0.0'));

        final p2 = await packageBackend.lookupPackage('oxygen');
        expect(p2!.versionCount, 4);

        expect(fakeEmailSender.sentMessages, hasLength(1));
        final email = fakeEmailSender.sentMessages.single;
        expect(email.recipients.single.email, 'admin@pub.dev');
        expect(email.subject, 'Package uploaded: oxygen 3.0.0');
        expect(email.bodyText,
            contains('https://pub.dev/packages/oxygen/versions/3.0.0\n'));

        await nameTracker.reloadFromDatastore();
        final lastPublished =
            nameTracker.visiblePackagesOrderedByLastPublished.first;
        expect(lastPublished.package, 'oxygen');
        expect(lastPublished.latestVersion, '3.0.0');

        final bytes =
            await createPubApiClient().fetchPackage('oxygen', '3.0.0');
        expect(bytes, tarball);
      });
    });
  });

  group('other limits', () {
    testWithProfile(
      'max versions',
      testProfile: TestProfile(
        defaultUser: 'admin@pub.dev',
        packages: <TestPackage>[
          TestPackage(name: 'oxygen'),
          TestPackage(
              name: 'busy_pkg',
              versions:
                  List.generate(100, (i) => TestVersion(version: '1.0.$i'))),
        ],
      ),
      fn: () async {
        packageBackend.maxVersionsPerPackage = 100;
        final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('busy_pkg', '2.0.0'));
        final rs = createPubApiClient(authToken: adminClientToken)
            .uploadPackageBytes(tarball);
        await expectApiException(
          rs,
          status: 400,
          code: 'PackageRejected',
          message: 'has reached the maximum version limit of',
        );
      },
      timeout: Timeout.factor(1.5),
    );
  });
}
