// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:_pub_shared/data/package_api.dart';
import 'package:clock/clock.dart';
import 'package:crypto/crypto.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/storage.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/admin/backend.dart';
import 'package:pub_dev/audit/backend.dart';
import 'package:pub_dev/audit/models.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/fake/backend/fake_email_sender.dart';
import 'package:pub_dev/frontend/handlers/pubapi.client.dart';
import 'package:pub_dev/package/attestation_verifier.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/package/name_tracker.dart';
import 'package:pub_dev/package/upload_signer_service.dart';
import 'package:pub_dev/service/async_queue/async_queue.dart';
import 'package:pub_dev/service/secret/backend.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';
import 'backend_test_utils.dart';

void main() {
  group('uploading', () {
    group('packageBackend.startUpload', () {
      testWithProfile(
        'no active user',
        fn: () async {
          final rs = packageBackend.startUpload(
            Uri.parse('http://example.com/'),
          );
          await expectLater(rs, throwsA(isA<AuthenticationException>()));
        },
      );

      testWithProfile(
        'successful',
        fn: () async {
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
        },
      );
    });

    group('packageBackend.publishUploadedBlob', () {
      testWithProfile(
        'uploaded zero-length file',
        fn: () async {
          await accountBackend.withBearerToken(adminClientToken, () async {
            final rs = createPubApiClient(
              authToken: adminClientToken,
            ).uploadPackageBytes(List.empty());
            await expectApiException(
              rs,
              status: 400,
              code: 'PackageRejected',
              message: 'Package archive is empty',
            );
          });
        },
      );

      testWithProfile(
        'upload-too-big',
        fn: () async {
          final chunk = List.filled(1024 * 1024, 42);
          final chunkCount = UploadSignerService.maxUploadSize ~/ chunk.length;
          final bigTarball = <List<int>>[];
          for (int i = 0; i < chunkCount; i++) {
            bigTarball.add(chunk);
          }
          // Add one more byte than allowed.
          bigTarball.add([1]);
          final bytes = bigTarball.fold<List<int>>(
            <int>[],
            (r, l) => r..addAll(l),
          );
          final rs = createPubApiClient(
            authToken: adminClientToken,
          ).uploadPackageBytes(bytes);
          await expectApiException(
            rs,
            status: 400,
            code: 'PackageRejected',
            message: 'Package archive exceeded ',
          );
        },
      );

      testWithProfile(
        'successful new package',
        fn: () async {
          final user = await accountBackend.lookupUserByEmail('user@pub.dev');
          expect(
            await packageBackend.cachedPackagesWhereUserIsUploader(user.userId),
            isEmpty,
          );

          final dateBeforeTest = clock.now().toUtc();
          final pubspecContent = generatePubspecYaml('new_package', '1.2.3');
          final message = await createPubApiClient(authToken: userClientToken)
              .uploadPackageBytes(
                await packageArchiveBytes(pubspecContent: pubspecContent),
              );
          expect(message.success.message, contains('Successfully uploaded'));
          expect(message.success.message, contains('new_package'));
          expect(message.success.message, contains('1.2.3'));

          // verify state
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

          await asyncQueue.ongoingProcessing;
          expect(
            await packageBackend.cachedPackagesWhereUserIsUploader(user.userId),
            ['new_package'],
          );

          expect(fakeEmailSender.sentMessages, hasLength(1));
          final email = fakeEmailSender.sentMessages.single;
          expect(email.recipients.single.email, user.email);
          expect(email.subject, 'Package uploaded: new_package 1.2.3');
          expect(
            email.bodyText,
            contains('https://pub.dev/packages/new_package/versions/1.2.3\n'),
          );
          // No relevant changelog entry for this version.
          expect(email.bodyText, isNot(contains('Excerpt of the changelog')));

          final audits = await auditBackend.listRecordsForPackageVersion(
            'new_package',
            '1.2.3',
          );
          final publishedAudit = audits.records.firstWhere(
            (e) => e.kind == AuditLogRecordKind.packagePublished,
          );
          expect(publishedAudit.kind, AuditLogRecordKind.packagePublished);
          expect(publishedAudit.created, isNotNull);
          expect(publishedAudit.expires!.year, greaterThan(9998));
          expect(publishedAudit.agent, user.userId);
          expect(publishedAudit.users, [user.userId]);
          expect(publishedAudit.packages, ['new_package']);
          expect(publishedAudit.packageVersions, ['new_package/1.2.3']);
          expect(publishedAudit.publishers, []);
          expect(
            publishedAudit.summary,
            'Package `new_package` version `1.2.3` was published by `user@pub.dev`.',
          );
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
          final readme = assets.firstWhere(
            (pva) => pva.kind == AssetKind.readme,
          );
          expect(readme.path, 'README.md');
          expect(readme.textContent, foobarReadmeContent);
          final changelog = assets.firstWhere(
            (pva) => pva.kind == AssetKind.changelog,
          );
          expect(changelog.path, 'CHANGELOG.md');
          expect(changelog.textContent, foobarChangelogContent);

          final canonicalInfo = await storageService
              .bucket(activeConfiguration.canonicalPackagesBucketName!)
              .info('packages/new_package-1.2.3.tar.gz');
          expect(canonicalInfo.length, greaterThan(200));

          final publicInfo = await storageService
              .bucket(activeConfiguration.exportedApiBucketName!)
              .info('latest/api/archives/new_package-1.2.3.tar.gz');
          expect(publicInfo.length, canonicalInfo.length);
        },
      );

      testWithProfile(
        'package under publisher',
        fn: () async {
          final dateBeforeTest = clock.now().toUtc();
          final pubspecContent = generatePubspecYaml('neon', '7.0.0');
          final message = await createPubApiClient(authToken: adminClientToken)
              .uploadPackageBytes(
                await packageArchiveBytes(pubspecContent: pubspecContent),
              );
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

          await asyncQueue.ongoingProcessing;
          expect(fakeEmailSender.sentMessages, hasLength(1));
          final email = fakeEmailSender.sentMessages.single;
          expect(email.recipients.single.email, user.email);
          expect(email.subject, 'Package uploaded: neon 7.0.0');
          expect(
            email.bodyText,
            contains('https://pub.dev/packages/neon/versions/7.0.0\n'),
          );

          final audits = await auditBackend.listRecordsForPackageVersion(
            'neon',
            '7.0.0',
          );
          final publishedAudit = audits.records.first;
          expect(publishedAudit.kind, AuditLogRecordKind.packagePublished);
          expect(
            publishedAudit.summary,
            'Package `neon` version `7.0.0` owned by publisher `example.com` was published by `admin@pub.dev`.',
          );
          expect(publishedAudit.publishers, ['example.com']);

          final assets = await dbService
              .query<PackageVersionAsset>()
              .run()
              .where((pva) => pva.qualifiedVersionKey == pv.qualifiedVersionKey)
              .toList();
          final readme = assets.firstWhere(
            (pva) => pva.kind == AssetKind.readme,
          );
          expect(readme.path, 'README.md');
          expect(readme.textContent, foobarReadmeContent);
          final changelog = assets.firstWhere(
            (pva) => pva.kind == AssetKind.changelog,
          );
          expect(changelog.path, 'CHANGELOG.md');
          expect(changelog.textContent, foobarChangelogContent);
        },
      );
    });

    group('Manual publishing overrides', () {
      testWithProfile(
        'manual publishing disabled',
        fn: () async {
          await withFakeAuthRetryPubApiClient(email: adminAtPubDevEmail, (
            client,
          ) async {
            await client.setAutomatedPublishing(
              'oxygen',
              PkgPublishingConfig(
                manual: ManualPublishingConfig(isEnabled: false),
              ),
            );
          });

          final bytes = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('oxygen', '2.2.0'),
          );
          final rs = createPubApiClient(
            authToken: adminClientToken,
          ).uploadPackageBytes(bytes);
          await expectApiException(
            rs,
            status: 403,
            code: 'InsufficientPermissions',
            message: 'Manual publishing has been disabled.',
          );
        },
      );
    });

    group('Uploading with service account', () {
      testWithProfile(
        'service account cannot upload new package',
        fn: () async {
          final token = createFakeServiceAccountToken(
            email: 'admin-action@pub.dev',
          );
          final pubspecContent = generatePubspecYaml('new_package', '1.2.3');
          final bytes = await packageArchiveBytes(
            pubspecContent: pubspecContent,
          );
          final rs = createPubApiClient(
            authToken: token,
          ).uploadPackageBytes(bytes);
          await expectApiException(
            rs,
            status: 400,
            code: 'PackageRejected',
            message: 'Only users are allowed to upload new packages.',
          );
        },
      );

      testWithProfile(
        'service account cannot upload new version to existing package',
        fn: () async {
          final token = createFakeServiceAccountToken(
            email: 'admin-action@pub.dev',
          );
          final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
          final bytes = await packageArchiveBytes(
            pubspecContent: pubspecContent,
          );
          final rs = createPubApiClient(
            authToken: token,
          ).uploadPackageBytes(bytes);
          await expectApiException(
            rs,
            status: 403,
            code: 'InsufficientPermissions',
            message: 'publishing with service account is not enabled',
          );
        },
      );

      testWithProfile(
        'service account cannot upload because email not matching',
        fn: () async {
          await withFakeAuthRetryPubApiClient(email: adminAtPubDevEmail, (
            client,
          ) async {
            await client.setAutomatedPublishing(
              'oxygen',
              PkgPublishingConfig(
                gcp: GcpPublishingConfig(
                  isEnabled: true,
                  serviceAccountEmail: 'admin@x.gserviceaccount.com',
                ),
              ),
            );
          });
          final token = createFakeServiceAccountToken(
            email: 'admin-action@pub.dev',
          );
          final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
          final bytes = await packageArchiveBytes(
            pubspecContent: pubspecContent,
          );
          final rs = createPubApiClient(
            authToken: token,
          ).uploadPackageBytes(bytes);
          await expectApiException(
            rs,
            status: 403,
            code: 'InsufficientPermissions',
            message:
                'publishing is not enabled for the "admin-action@pub.dev" service account',
          );
        },
      );

      testWithProfile(
        'service account cannot upload because id lock prevents it',
        fn: () async {
          await withFakeAuthRetryPubApiClient(email: adminAtPubDevEmail, (
            client,
          ) async {
            await client.setAutomatedPublishing(
              'oxygen',
              PkgPublishingConfig(
                gcp: GcpPublishingConfig(
                  isEnabled: true,
                  serviceAccountEmail: 'admin@x.gserviceaccount.com',
                ),
              ),
            );
          });
          final pkg = await packageBackend.lookupPackage('oxygen');
          pkg!.publishingConfig!.gcpLock = GcpPublishingLock(
            oauthUserId: 'other-user-id',
          );
          await dbService.commit(inserts: [pkg]);
          final token = createFakeServiceAccountToken(
            email: 'admin@x.gserviceaccount.com',
          );
          final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
          final bytes = await packageArchiveBytes(
            pubspecContent: pubspecContent,
          );
          final rs = createPubApiClient(
            authToken: token,
          ).uploadPackageBytes(bytes);
          await expectApiException(
            rs,
            status: 403,
            code: 'InsufficientPermissions',
            message:
                'Google Cloud Service account identifiers changed, disabling automated publishing',
          );

          final pkgAfter = await packageBackend.lookupPackage('oxygen');
          expect(pkgAfter!.publishingConfig!.gcpConfig!.toJson(), {
            'isEnabled': false,
            'serviceAccountEmail': 'admin@x.gserviceaccount.com',
          });
        },
      );

      testWithProfile(
        'successful upload with service account',
        fn: () async {
          await withFakeAuthRetryPubApiClient(email: adminAtPubDevEmail, (
            client,
          ) async {
            await client.setAutomatedPublishing(
              'oxygen',
              PkgPublishingConfig(
                gcp: GcpPublishingConfig(
                  isEnabled: true,
                  serviceAccountEmail: 'admin@x.gserviceaccount.com',
                ),
              ),
            );
          });
          final token = createFakeServiceAccountToken(
            email: 'admin@x.gserviceaccount.com',
          );
          final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
          final bytes = await packageArchiveBytes(
            pubspecContent: pubspecContent,
          );
          final rs = await createPubApiClient(
            authToken: token,
          ).uploadPackageBytes(bytes);
          expect(rs.success.message, contains('Successfully uploaded'));

          final pkg = await packageBackend.lookupPackage('oxygen');
          expect(pkg!.publishingConfig!.gcpLock!.toJson(), {
            'oauthUserId': 'admin-x-gserviceaccount-com',
          });
        },
      );
    });

    group('Uploading with GitHub Actions', () {
      testWithProfile(
        'GitHub Actions cannot upload new package',
        fn: () async {
          final token = createFakeGitHubActionToken(
            repository: 'x/y',
            ref: 'refs/tag/1',
          );
          final pubspecContent = generatePubspecYaml('new_package', '1.2.3');
          final bytes = await packageArchiveBytes(
            pubspecContent: pubspecContent,
          );
          final rs = createPubApiClient(
            authToken: token,
          ).uploadPackageBytes(bytes);
          // TODO: refactor upload to return better error message
          await expectApiException(
            rs,
            status: 400,
            code: 'PackageRejected',
            message: 'Only users are allowed to upload new packages.',
          );
        },
      );

      testWithProfile(
        'GitHub Actions cannot upload new version to existing package',
        fn: () async {
          final token = createFakeGitHubActionToken(
            repository: 'x/y',
            ref: 'refs/tag/1',
          );
          final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
          final bytes = await packageArchiveBytes(
            pubspecContent: pubspecContent,
          );
          final rs = createPubApiClient(
            authToken: token,
          ).uploadPackageBytes(bytes);
          await expectApiException(
            rs,
            status: 403,
            code: 'InsufficientPermissions',
            message: 'publishing from github is not enabled',
          );
        },
      );

      testWithProfile(
        'GitHub Actions cannot upload because repository not matching',
        fn: () async {
          await withFakeAuthRetryPubApiClient(email: adminAtPubDevEmail, (
            client,
          ) async {
            await client.setAutomatedPublishing(
              'oxygen',
              PkgPublishingConfig(
                github: GitHubPublishingConfig(
                  isEnabled: true,
                  repository: 'a/b',
                  tagPattern: '{{version}}',
                ),
              ),
            );
          });
          final token = createFakeGitHubActionToken(
            repository: 'x/y',
            ref: 'refs/tag/1',
          );
          final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
          final bytes = await packageArchiveBytes(
            pubspecContent: pubspecContent,
          );
          final rs = createPubApiClient(
            authToken: token,
          ).uploadPackageBytes(bytes);
          await expectApiException(
            rs,
            status: 403,
            code: 'InsufficientPermissions',
            message:
                'publishing is not enabled for the \"x/y\" repository, it may be enabled for another repository',
          );
        },
      );

      testWithProfile(
        'GitHub Actions cannot upload because ref type not matching',
        fn: () async {
          await withFakeAuthRetryPubApiClient(email: adminAtPubDevEmail, (
            client,
          ) async {
            await client.setAutomatedPublishing(
              'oxygen',
              PkgPublishingConfig(
                github: GitHubPublishingConfig(
                  isEnabled: true,
                  repository: 'a/b',
                  tagPattern: '{{version}}',
                ),
              ),
            );
          });
          final token = createFakeGitHubActionToken(
            repository: 'a/b',
            ref: 'refs/unknown-ref-type/1',
          );
          final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
          final bytes = await packageArchiveBytes(
            pubspecContent: pubspecContent,
          );
          final rs = createPubApiClient(
            authToken: token,
          ).uploadPackageBytes(bytes);
          await expectApiException(
            rs,
            status: 403,
            code: 'InsufficientPermissions',
            message:
                'publishing is only allowed from \"tag\" refType, this token has \"unknown-ref-type\" refType',
          );
        },
      );

      testWithProfile(
        'GitHub Actions cannot upload because version pattern not matching',
        fn: () async {
          await withFakeAuthRetryPubApiClient(email: adminAtPubDevEmail, (
            client,
          ) async {
            await client.setAutomatedPublishing(
              'oxygen',
              PkgPublishingConfig(
                github: GitHubPublishingConfig(
                  isEnabled: true,
                  repository: 'a/b',
                  tagPattern: '{{version}}',
                ),
              ),
            );
          });
          final token = createFakeGitHubActionToken(
            repository: 'a/b',
            ref: 'refs/tags/1',
          );
          final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
          final bytes = await packageArchiveBytes(
            pubspecContent: pubspecContent,
          );
          final rs = createPubApiClient(
            authToken: token,
          ).uploadPackageBytes(bytes);
          await expectApiException(
            rs,
            status: 403,
            code: 'InsufficientPermissions',
            message:
                'publishing is configured to only be allowed from actions with specific '
                'ref pattern, this token has \"refs/tags/1\" ref for which publishing is not allowed',
          );
        },
      );

      testWithProfile(
        'GitHub Actions cannot upload because workflow_dispatch is not enabled',
        fn: () async {
          await withFakeAuthRetryPubApiClient(email: adminAtPubDevEmail, (
            client,
          ) async {
            await client.setAutomatedPublishing(
              'oxygen',
              PkgPublishingConfig(
                github: GitHubPublishingConfig(
                  isEnabled: true,
                  repository: 'a/b',
                  tagPattern: '{{version}}',
                ),
              ),
            );
          });
          final token = createFakeGitHubActionToken(
            repository: 'a/b',
            ref: 'refs/tags/2.2.0',
            eventName: 'workflow_dispatch',
          );
          final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
          final bytes = await packageArchiveBytes(
            pubspecContent: pubspecContent,
          );
          final rs = createPubApiClient(
            authToken: token,
          ).uploadPackageBytes(bytes);
          await expectApiException(
            rs,
            status: 403,
            code: 'InsufficientPermissions',
            message:
                'publishing is not allowed from \"workflow_dispath\" events',
          );
        },
      );

      testWithProfile(
        'GitHub Actions cannot upload because event is not allowed',
        fn: () async {
          await withFakeAuthRetryPubApiClient(email: adminAtPubDevEmail, (
            client,
          ) async {
            await client.setAutomatedPublishing(
              'oxygen',
              PkgPublishingConfig(
                github: GitHubPublishingConfig(
                  isEnabled: true,
                  repository: 'a/b',
                  tagPattern: '{{version}}',
                ),
              ),
            );
          });
          final token = createFakeGitHubActionToken(
            repository: 'a/b',
            ref: 'refs/tags/2.2.0',
            eventName: 'unknown_event',
          );
          final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
          final bytes = await packageArchiveBytes(
            pubspecContent: pubspecContent,
          );
          final rs = createPubApiClient(
            authToken: token,
          ).uploadPackageBytes(bytes);
          await expectApiException(
            rs,
            status: 403,
            code: 'InsufficientPermissions',
            message: 'publishing is only allowed from',
          );
        },
      );

      testWithProfile(
        'GitHub Actions cannot upload because id lock prevents it',
        fn: () async {
          Future<void> setupPublishingAndLock() async {
            await withFakeAuthRetryPubApiClient(email: adminAtPubDevEmail, (
              client,
            ) async {
              await client.setAutomatedPublishing(
                'oxygen',
                PkgPublishingConfig(
                  github: GitHubPublishingConfig(
                    isEnabled: true,
                    repository: 'a/b',
                    tagPattern: '{{version}}',
                  ),
                ),
              );
            });
            final pkg = await packageBackend.lookupPackage('oxygen');
            pkg!.publishingConfig!.githubLock = GitHubPublishingLock(
              repositoryOwnerId: 'x',
              repositoryId: 'y',
            );
            await dbService.commit(inserts: [pkg]);
          }

          final badTokens = [
            createFakeGitHubActionToken(
              repository: 'a/b',
              ref: 'refs/tags/2.2.0',
              repositoryId: 'x2',
              repositoryOwnerId: 'y',
            ),
            createFakeGitHubActionToken(
              repository: 'a/b',
              ref: 'refs/tags/2.2.0',
              repositoryId: 'x',
              repositoryOwnerId: 'y2',
            ),
          ];
          final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
          final bytes = await packageArchiveBytes(
            pubspecContent: pubspecContent,
          );

          for (final token in badTokens) {
            await setupPublishingAndLock();
            final rs = createPubApiClient(
              authToken: token,
            ).uploadPackageBytes(bytes);
            await expectApiException(
              rs,
              status: 403,
              code: 'InsufficientPermissions',
              message:
                  'GitHub repository identifiers changed, disabling automated publishing',
            );
            final pkg = await packageBackend.lookupPackage('oxygen');
            expect(pkg!.publishingConfig!.githubConfig!.toJson(), {
              'isEnabled': false,
              'repository': 'a/b',
              'tagPattern': '{{version}}',
              'requireEnvironment': false,
              'isPushEventEnabled': true,
              'isWorkflowDispatchEventEnabled': false,
            });
          }
        },
      );

      testWithProfile(
        'successful upload with GitHub Actions (push, without environment)',
        fn: () async {
          await withFakeAuthRetryPubApiClient(email: adminAtPubDevEmail, (
            client,
          ) async {
            await client.setAutomatedPublishing(
              'oxygen',
              PkgPublishingConfig(
                github: GitHubPublishingConfig(
                  isEnabled: true,
                  repository: 'a/b',
                  tagPattern: '{{version}}',
                ),
              ),
            );
          });
          final token = createFakeGitHubActionToken(
            repository: 'a/b',
            ref: 'refs/tags/2.2.0',
          );
          final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
          final bytes = await packageArchiveBytes(
            pubspecContent: pubspecContent,
          );
          final rs = await createPubApiClient(
            authToken: token,
          ).uploadPackageBytes(bytes);
          expect(rs.success.message, contains('Successfully uploaded'));
        },
      );

      testWithProfile(
        'successful upload with GitHub Actions (workflow_dispatch, without environment)',
        fn: () async {
          await withFakeAuthRetryPubApiClient(email: adminAtPubDevEmail, (
            client,
          ) async {
            await client.setAutomatedPublishing(
              'oxygen',
              PkgPublishingConfig(
                github: GitHubPublishingConfig(
                  isEnabled: true,
                  repository: 'a/b',
                  tagPattern: '{{version}}',
                  isPushEventEnabled: false,
                  isWorkflowDispatchEventEnabled: true,
                ),
              ),
            );
          });
          final token = createFakeGitHubActionToken(
            repository: 'a/b',
            ref: 'refs/tags/2.2.0',
            eventName: 'workflow_dispatch',
          );
          final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
          final bytes = await packageArchiveBytes(
            pubspecContent: pubspecContent,
          );
          final rs = await createPubApiClient(
            authToken: token,
          ).uploadPackageBytes(bytes);
          expect(rs.success.message, contains('Successfully uploaded'));
        },
      );

      testWithProfile(
        'successful upload with GitHub Actions (exempted package)',
        testProfile: TestProfile(
          generatedPackages: [
            GeneratedTestPackage(name: '_dummy_pkg'),
            GeneratedTestPackage(name: 'oxygen'),
          ],
          defaultUser: 'admin@pub.dev',
        ),
        fn: () async {
          await withFakeAuthRetryPubApiClient(email: adminAtPubDevEmail, (
            client,
          ) async {
            await client.setAutomatedPublishing(
              '_dummy_pkg',
              PkgPublishingConfig(
                github: GitHubPublishingConfig(
                  isEnabled: true,
                  repository: 'a/b',
                  tagPattern: '{{version}}',
                ),
              ),
            );
          });
          final token = createFakeGitHubActionToken(
            repository: 'a/b',
            ref: 'refs/tags/2.2.0',
            repositoryId: 'repo-id-1',
            repositoryOwnerId: 'owner-id-234',
          );
          final pubspecContent = generatePubspecYaml('_dummy_pkg', '2.2.0');
          final bytes = await packageArchiveBytes(
            pubspecContent: pubspecContent,
          );
          final rs = await createPubApiClient(
            authToken: token,
          ).uploadPackageBytes(bytes);
          expect(rs.success.message, contains('Successfully uploaded'));

          final pkg = await packageBackend.lookupPackage('_dummy_pkg');
          expect(pkg!.publishingConfig!.githubLock!.toJson(), {
            'repositoryId': 'repo-id-1',
            'repositoryOwnerId': 'owner-id-234',
          });

          await asyncQueue.ongoingProcessing;
          expect(fakeEmailSender.sentMessages, hasLength(1));
          final email = fakeEmailSender.sentMessages.single;
          expect(email.recipients.single.email, 'admin@pub.dev');
          expect(email.subject, 'Package uploaded: _dummy_pkg 2.2.0');
          expect(
            email.bodyText,
            contains(
              'service:github-actions has published a new version (2.2.0)',
            ),
          );

          final audits = await auditBackend.listRecordsForPackageVersion(
            '_dummy_pkg',
            '2.2.0',
          );
          final publishedAudit = audits.records.first;
          expect(publishedAudit.kind, AuditLogRecordKind.packagePublished);
          expect(publishedAudit.created, isNotNull);
          expect(publishedAudit.expires!.year, greaterThan(9998));
          expect(
            publishedAudit.agent,
            'service:github-actions:owner-id-234/repo-id-1',
          );
          expect(publishedAudit.users, []);
          expect(publishedAudit.packages, ['_dummy_pkg']);
          expect(publishedAudit.packageVersions, ['_dummy_pkg/2.2.0']);
          expect(publishedAudit.publishers, []);
          expect(
            publishedAudit.summary,
            startsWith(
              'Package `_dummy_pkg` version `2.2.0` was published from GitHub Actions (`run_id`: [`',
            ),
          );
          expect(
            publishedAudit.summary,
            contains('triggered by pushing to the `a/b` repository.'),
          );
          expect(publishedAudit.data, {
            'package': '_dummy_pkg',
            'version': '2.2.0',
            'repository': 'a/b',
            'run_id': isNotEmpty,
          });
        },
      );

      testWithProfile(
        'GitHub Actions cannot upload because environment is missing',
        fn: () async {
          await withFakeAuthRetryPubApiClient(email: adminAtPubDevEmail, (
            client,
          ) async {
            await client.setAutomatedPublishing(
              'oxygen',
              PkgPublishingConfig(
                github: GitHubPublishingConfig(
                  isEnabled: true,
                  repository: 'a/b',
                  tagPattern: '{{version}}',
                  requireEnvironment: true,
                  environment: 'prod',
                ),
              ),
            );
          });
          final token = createFakeGitHubActionToken(
            repository: 'a/b',
            ref: 'refs/tags/2.2.0',
          );
          final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
          final bytes = await packageArchiveBytes(
            pubspecContent: pubspecContent,
          );
          final rs = createPubApiClient(
            authToken: token,
          ).uploadPackageBytes(bytes);
          await expectApiException(
            rs,
            status: 403,
            code: 'InsufficientPermissions',
            message:
                'publishing is configured to only be allowed from actions with an environment, '
                'this token originates from an action running in environment \"null\" for which publishing is not allowed',
          );
        },
      );

      testWithProfile(
        'GitHub Actions cannot upload because environment not matching',
        fn: () async {
          await withFakeAuthRetryPubApiClient(email: adminAtPubDevEmail, (
            client,
          ) async {
            await client.setAutomatedPublishing(
              'oxygen',
              PkgPublishingConfig(
                github: GitHubPublishingConfig(
                  isEnabled: true,
                  repository: 'a/b',
                  tagPattern: '{{version}}',
                  requireEnvironment: true,
                  environment: 'prod',
                ),
              ),
            );
          });
          final token = createFakeGitHubActionToken(
            repository: 'a/b',
            ref: 'refs/tags/2.2.0',
            environment: 'staging',
          );
          final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
          final bytes = await packageArchiveBytes(
            pubspecContent: pubspecContent,
          );
          final rs = createPubApiClient(
            authToken: token,
          ).uploadPackageBytes(bytes);
          await expectApiException(
            rs,
            status: 403,
            code: 'InsufficientPermissions',
            message:
                'publishing is configured to only be allowed from actions with an environment, '
                'this token originates from an action running in environment \"staging\" for which publishing is not allowed',
          );
        },
      );

      testWithProfile(
        'successful upload with GitHub Actions (with environment)',
        fn: () async {
          await withFakeAuthRetryPubApiClient(email: adminAtPubDevEmail, (
            client,
          ) async {
            await client.setAutomatedPublishing(
              'oxygen',
              PkgPublishingConfig(
                github: GitHubPublishingConfig(
                  isEnabled: true,
                  repository: 'a/b',
                  tagPattern: 'v{{version}}',
                  requireEnvironment: true,
                  environment: 'prod',
                ),
              ),
            );
          });
          final token = createFakeGitHubActionToken(
            repository: 'a/b',
            ref: 'refs/tags/v2.2.0',
            environment: 'prod',
          );
          final pubspecContent = generatePubspecYaml('oxygen', '2.2.0');
          final bytes = await packageArchiveBytes(
            pubspecContent: pubspecContent,
          );
          final rs = await createPubApiClient(
            authToken: token,
          ).uploadPackageBytes(bytes);
          expect(rs.success.message, contains('Successfully uploaded'));
        },
      );
    });

    group('packageBackend.upload', () {
      testWithProfile(
        'not logged in',
        fn: () async {
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
        },
      );

      testWithProfile(
        'not authorized',
        fn: () async {
          final p1 = await packageBackend.lookupPackage('oxygen');
          expect(p1!.versionCount, 3);
          final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('oxygen', '2.2.0'),
          );
          final rs = createPubApiClient(
            authToken: userClientToken,
          ).uploadPackageBytes(tarball);
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
        },
      );

      testWithProfile(
        'upload restriction - no uploads',
        fn: () async {
          (secretBackend as FakeSecretBackend).update(
            SecretKey.uploadRestriction,
            'no-uploads',
          );
          final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('oxygen', '2.3.0'),
          );
          final rs = createPubApiClient(
            authToken: adminClientToken,
          ).uploadPackageBytes(tarball);
          await expectApiException(
            rs,
            status: 400,
            code: 'PackageRejected',
            message: 'Uploads are restricted. Please try again later.',
          );
        },
      );

      testWithProfile(
        'upload restriction - no new packages',
        fn: () async {
          (secretBackend as FakeSecretBackend).update(
            SecretKey.uploadRestriction,
            'only-updates',
          );
          final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('some_new_package', '1.2.3'),
          );
          final rs = createPubApiClient(
            authToken: adminClientToken,
          ).uploadPackageBytes(tarball);
          await expectApiException(
            rs,
            status: 400,
            code: 'PackageRejected',
            message: 'Uploads are restricted. Please try again later.',
          );
        },
      );

      testWithProfile(
        'upload restriction - update is accepted',
        fn: () async {
          (secretBackend as FakeSecretBackend).update(
            SecretKey.uploadRestriction,
            'only-updates',
          );
          final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('oxygen', '3.4.5'),
          );
          final message = await createPubApiClient(
            authToken: adminClientToken,
          ).uploadPackageBytes(tarball);
          expect(message.success.message, contains('Successfully uploaded'));
        },
      );

      testWithProfile(
        'version already exist',
        fn: () async {
          final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('neon', '1.0.0'),
          );
          final rs = createPubApiClient(
            authToken: adminClientToken,
          ).uploadPackageBytes(tarball);
          await expectApiException(
            rs,
            status: 400,
            code: 'PackageRejected',
            message: 'Version 1.0.0 of package neon already exists',
          );
        },
      );

      testWithProfile(
        'version in non-canonical form',
        fn: () async {
          final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('neon', '1.0.001'),
          );
          final rs = createPubApiClient(
            authToken: adminClientToken,
          ).uploadPackageBytes(tarball);
          await expectApiException(
            rs,
            status: 400,
            code: 'InvalidInput',
            message:
                'Version is not in canonical form: "1.0.001", use "1.0.1" instead.',
          );
        },
      );

      testWithProfile(
        'same canonical archive already exist',
        fn: () async {
          final version = await packageBackend.lookupPackageVersion(
            'neon',
            '1.0.1',
          );
          expect(version, isNull);
          final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('neon', '1.0.1'),
          );
          final canonicalBucket = storageService.bucket(
            activeConfiguration.canonicalPackagesBucketName!,
          );
          await canonicalBucket.writeBytes(
            'packages/neon-1.0.1.tar.gz',
            tarball,
          );

          final message = await createPubApiClient(
            authToken: adminClientToken,
          ).uploadPackageBytes(tarball);
          expect(message.success.message, contains('Successfully uploaded'));
          expect(message.success.message, contains('neon'));
          expect(message.success.message, contains('1.0.1'));
        },
      );

      testWithProfile(
        'different canonical archive already exist',
        fn: () async {
          final version = await packageBackend.lookupPackageVersion(
            'neon',
            '1.0.1',
          );
          expect(version, isNull);
          final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('neon', '1.0.1'),
          );
          final canonicalBucket = storageService.bucket(
            activeConfiguration.canonicalPackagesBucketName!,
          );
          await canonicalBucket.writeBytes('packages/neon-1.0.1.tar.gz', [
            ...tarball,
            1,
            2,
            3,
          ]);

          final rs = createPubApiClient(
            authToken: adminClientToken,
          ).uploadPackageBytes(tarball);
          await expectApiException(
            rs,
            status: 400,
            code: 'PackageRejected',
            message: 'Version 1.0.1 of package neon already exists.',
          );
        },
      );

      testWithProfile(
        'versions has been deleted',
        fn: () async {
          await accountBackend.withBearerToken(siteAdminToken, () async {
            await adminBackend.removePackageVersion('oxygen', '1.0.0');
          });
          final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('oxygen', '1.0.0'),
          );
          final rs = createPubApiClient(
            authToken: adminClientToken,
          ).uploadPackageBytes(tarball);
          await expectApiException(
            rs,
            status: 400,
            code: 'PackageRejected',
            message:
                'Version 1.0.0 of package oxygen was deleted previously, re-upload is not allowed.',
          );
        },
      );

      // Returns the error message as String or null if it succeeded.
      Future<String?> fn(String name) async {
        final pubspecContent = generatePubspecYaml(name, '0.2.0');
        try {
          final tarball = await packageArchiveBytes(
            pubspecContent: pubspecContent,
          );
          await createPubApiClient(
            authToken: adminClientToken,
          ).uploadPackageBytes(tarball);
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

      testWithProfile(
        'bad package names are rejected',
        fn: () async {
          await nameTracker.reloadFromDatastore();
          await accountBackend.withBearerToken(adminClientToken, () async {
            expect(
              await fn('with'),
              'PackageRejected(400): Package name must not be a reserved word in Dart.',
            );
            expect(
              await fn('123test'),
              'PackageRejected(400): Package name must begin with a letter or underscore.',
            );
            expect(
              await fn('With Space'),
              'PackageRejected(400): Package name may only contain letters, numbers, and underscores.',
            );

            expect(await fn('ok_name'), isNull);
          });
        },
      );

      testWithProfile(
        'similar package names are rejected',
        fn: () async {
          await accountBackend.withBearerToken(adminClientToken, () async {
            expect(
              await fn('ox_ygen'),
              'PackageRejected(400): Package name `ox_ygen` is too similar to another active package: `oxygen` (https://pub.dev/packages/oxygen).',
            );

            expect(
              await fn('ox_y_ge_n'),
              'PackageRejected(400): Package name `ox_y_ge_n` is too similar to another active package: `oxygen` (https://pub.dev/packages/oxygen).',
            );
          });
        },
      );

      testWithProfile(
        'moderated package names are rejected',
        fn: () async {
          await accountBackend.withBearerToken(siteAdminToken, () async {
            await adminBackend.removePackage('neon');
          });
          await accountBackend.withBearerToken(adminClientToken, () async {
            await nameTracker.reloadFromDatastore();

            expect(
              await fn('neon'),
              'PackageRejected(400): Package name `neon` is too similar to a moderated package: `neon`.',
            );

            // similar names are accepted
            expect(await fn('ne_on'), isNull);
          });
        },
      );

      testWithProfile(
        'bad yaml file: duplicate key',
        fn: () async {
          final tarball = await packageArchiveBytes(
            pubspecContent: 'name: xyz\n' + generatePubspecYaml('xyz', '1.0.0'),
          );
          final rs = createPubApiClient(
            authToken: adminClientToken,
          ).uploadPackageBytes(tarball);
          await expectApiException(
            rs,
            status: 400,
            code: 'PackageRejected',
            message: 'Duplicate mapping key.',
          );
        },
      );

      testWithProfile(
        'bad pubspec content: bad version',
        fn: () async {
          final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('xyz', 'not-a-version'),
          );
          final rs = createPubApiClient(
            authToken: adminClientToken,
          ).uploadPackageBytes(tarball);
          await expectApiException(
            rs,
            status: 400,
            code: 'PackageRejected',
            message:
                'Unsupported value for "version". Could not parse "not-a-version".',
          );
        },
      );

      testWithProfile(
        'has dependency does not exist',
        fn: () async {
          final tarball = await packageArchiveBytes(
            pubspecContent:
                generatePubspecYaml('xyz', '1.0.0') + '  abc: ^1.0.0\n',
          );
          final rs = createPubApiClient(
            authToken: adminClientToken,
          ).uploadPackageBytes(tarball);
          await expectApiException(
            rs,
            status: 400,
            code: 'PackageRejected',
            message: 'Dependency `abc` does not exist.',
          );
        },
      );

      testWithProfile(
        'has SDK-dependency',
        fn: () async {
          final tarball = await packageArchiveBytes(
            pubspecContent:
                generatePubspecYaml('xyz', '1.2.3') +
                '  my_sdk_dep:\n'
                    '    sdk: dart\n',
          );
          final message = await createPubApiClient(
            authToken: adminClientToken,
          ).uploadPackageBytes(tarball);
          expect(message.success.message, contains('Successfully uploaded'));
          expect(message.success.message, contains('xyz'));
          expect(message.success.message, contains('1.2.3'));
        },
      );

      testWithProfile(
        'has git dependency',
        fn: () async {
          final tarball = await packageArchiveBytes(
            pubspecContent:
                generatePubspecYaml('xyz', '1.0.0') +
                '  abcd:\n'
                    '    git:\n'
                    '      url: git://github.com/a/b\n'
                    '      path: x/y/z\n',
          );
          final rs = createPubApiClient(
            authToken: adminClientToken,
          ).uploadPackageBytes(tarball);
          await expectApiException(
            rs,
            status: 400,
            code: 'PackageRejected',
            message: 'is a git dependency',
          );
        },
      );

      testWithProfile(
        'successful update + download',
        fn: () async {
          final p1 = await packageBackend.lookupPackage('oxygen');
          expect(p1!.versionCount, 3);
          final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml('oxygen', '3.0.0'),
            changelogContent:
                '# Changelog\n\n## v3.0.0\n\nSome bug fixes:\n- one,\n- Require `analyzer: \'>=10.0.0 <14.0.0\'`\n\n',
          );
          final message = await createPubApiClient(
            authToken: adminClientToken,
          ).uploadPackageBytes(tarball);
          expect(message.success.message, contains('Successfully uploaded'));
          expect(message.success.message, contains('oxygen'));
          expect(message.success.message, contains('3.0.0'));

          final p2 = await packageBackend.lookupPackage('oxygen');
          expect(p2!.versionCount, 4);

          await asyncQueue.ongoingProcessing;
          expect(fakeEmailSender.sentMessages, hasLength(1));
          final email = fakeEmailSender.sentMessages.single;
          expect(email.recipients.single.email, 'admin@pub.dev');
          expect(email.subject, 'Package uploaded: oxygen 3.0.0');
          expect(
            email.bodyText,
            contains('https://pub.dev/packages/oxygen/versions/3.0.0\n'),
          );
          expect(
            email.bodyText,
            contains(
              '\n'
              'Excerpt of the changelog:\n'
              '```\n'
              'Some bug fixes:\n'
              '- one,\n'
              '- Require `analyzer: \'>=10.0.0 <14.0.0\'`\n'
              '```\n\n',
            ),
          );

          await nameTracker.reloadFromDatastore();
          final lastPublished =
              nameTracker.visiblePackagesOrderedByLastPublished.first;
          expect(lastPublished.package, 'oxygen');
          expect(lastPublished.latestVersion, '3.0.0');

          final bytes = await createPubApiClient().fetchPackage(
            'oxygen',
            '3.0.0',
          );
          expect(bytes, tarball);
        },
      );
    });
  });

  group('other rejections', () {
    testWithProfile(
      'max version count',
      testProfile: TestProfile(
        defaultUser: 'admin@pub.dev',
        generatedPackages: [
          GeneratedTestPackage(name: 'oxygen'),
          GeneratedTestPackage(
            name: 'busy_pkg',
            versions: List.generate(
              100,
              (i) => GeneratedTestVersion(version: '1.0.$i'),
            ),
          ),
        ],
      ),
      fn: () async {
        packageBackend.maxVersionsPerPackage = 102;

        final tarball101 = await packageArchiveBytes(
          pubspecContent: generatePubspecYaml('busy_pkg', '1.0.101'),
        );
        final rs101 = await createPubApiClient(
          authToken: adminClientToken,
        ).uploadPackageBytes(tarball101);
        expect(
          rs101.success.message,
          contains(
            'The package "busy_pkg" has 1 version left before reaching the limit of 102. '
            'Please contact support@pub.dev',
          ),
        );

        final tarball102 = await packageArchiveBytes(
          pubspecContent: generatePubspecYaml('busy_pkg', '1.0.102'),
        );
        final rs102 = await createPubApiClient(
          authToken: adminClientToken,
        ).uploadPackageBytes(tarball102);
        expect(
          rs102.success.message,
          contains(
            'The package "busy_pkg" has 0 versions left before reaching the limit of 102. '
            'Please contact support@pub.dev',
          ),
        );
        await asyncQueue.ongoingProcessing;
        expect(
          fakeEmailSender.sentMessages.last.bodyText,
          contains('has 0 versions left before reaching the limit'),
        );

        final tarball = await packageArchiveBytes(
          pubspecContent: generatePubspecYaml('busy_pkg', '2.0.0'),
        );
        final rs = createPubApiClient(
          authToken: adminClientToken,
        ).uploadPackageBytes(tarball);
        await expectApiException(
          rs,
          status: 400,
          code: 'PackageRejected',
          message: 'has reached the maximum version limit of',
        );
      },
      timeout: Timeout.factor(1.5),
    );

    testWithProfile(
      'moderated package immediately re-published',
      fn: () async {
        final pubspecContent = generatePubspecYaml('abcd_package', '1.0.0');
        final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
        final message = await createPubApiClient(
          authToken: adminClientToken,
        ).uploadPackageBytes(bytes);
        expect(message.success.message, contains('Successfully uploaded'));

        await asyncQueue.ongoingProcessing;
        await nameTracker.reloadFromDatastore();

        await accountBackend.withBearerToken(
          siteAdminToken,
          () => adminBackend.removePackage('abcd_package'),
        );

        // NOTE: do not refresh name tracker and publish again
        final rs1 = createPubApiClient(
          authToken: adminClientToken,
        ).uploadPackageBytes(bytes);
        await expectApiException(
          rs1,
          status: 400,
          code: 'PackageRejected',
          message: 'Package name abcd_package is reserved',
        );

        // NOTE: refresh name tracker and publish again
        await nameTracker.reloadFromDatastore();
        final rs2 = createPubApiClient(
          authToken: adminClientToken,
        ).uploadPackageBytes(bytes);
        await expectApiException(
          rs2,
          status: 400,
          code: 'PackageRejected',
          message: 'is too similar to a moderated package',
        );
      },
    );

    testWithProfile(
      'getPackageUploadUrl returns attestationUrl and attestationFields',
      fn: () async {
        final client = createPubApiClient(authToken: adminClientToken);
        final uploadInfo = await client.getPackageUploadUrl();
        expect(uploadInfo.url, isNotEmpty);
        expect(uploadInfo.fields, isNotNull);
        expect(uploadInfo.attestationUrl, isNotEmpty);
        expect(uploadInfo.attestationFields, isNotNull);
        expect(
          uploadInfo.attestationFields!['key'],
          endsWith('.sigstore.json'),
        );
      },
    );

    testWithProfile(
      'successful upload with valid attestation bundle and api retrieval',
      fn: () async {
        AttestationVerifier.skipSignatureCheckInTest = true;
        try {
          final pubspecContent =
              'name: attested_pkg\nversion: 1.0.0\ndescription: A package with attestation.\nrepository: https://github.com/mosuem/attested_pkg\nenvironment:\n  sdk: ">=2.12.0 <4.0.0"\n';
          final archiveBytes = await packageArchiveBytes(
            pubspecContent: pubspecContent,
          );

          final bundleJson = _buildProvenanceBundleJson(
            subjectName: 'attested_pkg-1.0.0.tar.gz',
            subjectSha256: sha256.convert(archiveBytes).toString(),
            repository: 'https://github.com/mosuem/attested_pkg',
          );
          final attestationBytes = utf8.encode(bundleJson);
          final client = createPubApiClient(authToken: adminClientToken);
          final message = await client.uploadPackageBytes(
            archiveBytes,
            attestationBytes: attestationBytes,
          );
          expect(message.success.message, contains('Successfully uploaded'));

          // Verify attestation asset was stored in Datastore
          final asset = await packageBackend.lookupPackageVersionAsset(
            'attested_pkg',
            '1.0.0',
            AssetKind.attestation,
          );
          expect(asset, isNotNull);
          expect(asset!.textContent, isNotNull);
          final storedJson =
              jsonDecode(asset.textContent!) as Map<String, dynamic>;
          expect(
            storedJson['mediaType'],
            equals('application/vnd.dev.sigstore.bundle+json;version=0.3'),
          );

          // Verify attestation can be retrieved via the API endpoint
          final retrievedBytes = await client.getPackageVersionAttestation(
            'attested_pkg',
            '1.0.0',
          );
          final retrievedJson =
              jsonDecode(utf8.decode(retrievedBytes)) as Map<String, dynamic>;
          expect(
            retrievedJson['mediaType'],
            equals('application/vnd.dev.sigstore.bundle+json;version=0.3'),
          );
        } finally {
          AttestationVerifier.skipSignatureCheckInTest = false;
        }
      },
    );

    testWithProfile(
      'upload fails when provenance repository mismatches pubspec.yaml or configured GitHub repository',
      fn: () async {
        AttestationVerifier.skipSignatureCheckInTest = true;
        try {
          // 1. Mismatch between provenance repository and pubspec.yaml repository
          final pubspecContent =
              'name: mismatched_repo_pkg\nversion: 1.0.0\ndescription: Package with mismatched repo.\nrepository: https://github.com/dart-lang/mismatched_repo_pkg\nenvironment:\n  sdk: ">=2.12.0 <4.0.0"\n';
          final archiveBytes = await packageArchiveBytes(
            pubspecContent: pubspecContent,
          );
          final mismatchedBundle = _buildProvenanceBundleJson(
            subjectName: 'mismatched_repo_pkg-1.0.0.tar.gz',
            subjectSha256: sha256.convert(archiveBytes).toString(),
            repository: 'https://github.com/evil/mismatched_repo_pkg',
          );
          final rs1 = createPubApiClient(authToken: adminClientToken)
              .uploadPackageBytes(
                archiveBytes,
                attestationBytes: utf8.encode(mismatchedBundle),
              );
          await expectApiException(
            rs1,
            status: 400,
            code: 'PackageRejected',
            message:
                'Attestation states the package was built from "https://github.com/evil/mismatched_repo_pkg", but the pubspec.yaml of mismatched_repo_pkg 1.0.0 declares `repository: https://github.com/dart-lang/mismatched_repo_pkg`.',
          );

          // 2. Mismatch between provenance repository and pub.dev's stored
          // GitHub Actions automated publishing configuration (even when
          // pubspec.yaml inside the tarball self-asserts the attacker's repo).
          await withFakeAuthRetryPubApiClient(email: adminAtPubDevEmail, (
            client,
          ) async {
            await client.setAutomatedPublishing(
              'oxygen',
              PkgPublishingConfig(
                github: GitHubPublishingConfig(
                  isEnabled: true,
                  repository: 'dart-lang/oxygen',
                  tagPattern: '{{version}}',
                ),
              ),
            );
          });

          final oxygenPubspec =
              'name: oxygen\nversion: 2.2.0\ndescription: oxygen is awesome\nrepository: https://github.com/evil/oxygen\nenvironment:\n  sdk: ">=2.12.0 <4.0.0"\n';
          final oxygenBytes = await packageArchiveBytes(
            pubspecContent: oxygenPubspec,
          );
          final spoofedBundle = _buildProvenanceBundleJson(
            subjectName: 'oxygen-2.2.0.tar.gz',
            subjectSha256: sha256.convert(oxygenBytes).toString(),
            repository: 'https://github.com/evil/oxygen',
          );
          final rs2 = createPubApiClient(authToken: adminClientToken)
              .uploadPackageBytes(
                oxygenBytes,
                attestationBytes: utf8.encode(spoofedBundle),
              );
          await expectApiException(
            rs2,
            status: 400,
            code: 'PackageRejected',
            message:
                'Attestation states the package was built from "https://github.com/evil/oxygen", which does not match the configured GitHub Actions automated publishing repository "dart-lang/oxygen".',
          );

          // 3. Untrusted signing workflow rejected
          final untrustedBuilderBundle = _buildProvenanceBundleJson(
            subjectName: 'mismatched_repo_pkg-1.0.0.tar.gz',
            subjectSha256: sha256.convert(archiveBytes).toString(),
            repository: 'https://github.com/dart-lang/mismatched_repo_pkg',
            builderId:
                'https://github.com/evil/workflows/.github/workflows/publish.yml@refs/tags/v1',
          );
          final rs3 = createPubApiClient(authToken: adminClientToken)
              .uploadPackageBytes(
                archiveBytes,
                attestationBytes: utf8.encode(untrustedBuilderBundle),
              );
          await expectApiException(
            rs3,
            status: 400,
            code: 'PackageRejected',
            message: 'not a workflow trusted to publish packages',
          );
        } finally {
          AttestationVerifier.skipSignatureCheckInTest = false;
        }
      },
    );

    test('verifies a real signed package attestation and provenance policies', () {
      final verifier = AttestationVerifier();

      final validResult = verifier.verify(
        packageName: 'helpful',
        packageVersion: Version(0, 1, 5),
        archiveBytes: _helpfulArchiveBytes,
        bundleJson: _helpfulBundleJson,
        pubspecRepository: 'https://github.com/mosuem/helpful',
        configuredGitHubRepository: 'mosuem/helpful',
      );
      expect(validResult.errors, isEmpty);
      expect(validResult.isValid, isTrue);
      expect(validResult.repository, 'https://github.com/mosuem/helpful');
      expect(
        validResult.provenance?.commitSha,
        '63216a3022ed606538399634cd1c525f8bd4657f',
      );

      final wrongPubspecRepo = verifier.verify(
        packageName: 'helpful',
        packageVersion: Version(0, 1, 5),
        archiveBytes: _helpfulArchiveBytes,
        bundleJson: _helpfulBundleJson,
        pubspecRepository: 'https://github.com/evil/helpful',
      );
      expect(wrongPubspecRepo.isValid, isFalse);
      expect(
        wrongPubspecRepo.errors.single,
        contains(
          'Attestation states the package was built from "https://github.com/mosuem/helpful", but the pubspec.yaml of helpful 0.1.5 declares `repository: https://github.com/evil/helpful`.',
        ),
      );

      final wrongConfiguredRepo = verifier.verify(
        packageName: 'helpful',
        packageVersion: Version(0, 1, 5),
        archiveBytes: _helpfulArchiveBytes,
        bundleJson: _helpfulBundleJson,
        pubspecRepository: 'https://github.com/mosuem/helpful',
        configuredGitHubRepository: 'dart-lang/helpful',
      );
      expect(wrongConfiguredRepo.isValid, isFalse);
      expect(
        wrongConfiguredRepo.errors.single,
        contains(
          'does not match the configured GitHub Actions automated publishing repository "dart-lang/helpful"',
        ),
      );

      // Plain artifact signature without dsseEnvelope is rejected even if
      // signature check is skipped.
      AttestationVerifier.skipSignatureCheckInTest = true;
      try {
        final noDsseResult = verifier.verify(
          packageName: 'helpful',
          packageVersion: Version(0, 1, 5),
          archiveBytes: _helpfulArchiveBytes,
          bundleJson: _sampleBundleJson,
          pubspecRepository: 'https://github.com/mosuem/helpful',
        );
        expect(noDsseResult.isValid, isFalse);
        expect(
          noDsseResult.errors.single,
          contains('carries no build provenance'),
        );
      } finally {
        AttestationVerifier.skipSignatureCheckInTest = false;
      }
    });

    testWithProfile(
      'retrieving attestation of a package without attestation returns 404',
      fn: () async {
        final pubspecContent =
            'name: unattested_pkg\nversion: 1.0.0\ndescription: A package without attestation.\nenvironment:\n  sdk: ">=2.12.0 <4.0.0"\n';
        final archiveBytes = await packageArchiveBytes(
          pubspecContent: pubspecContent,
        );

        final client = createPubApiClient(authToken: adminClientToken);
        final message = await client.uploadPackageBytes(archiveBytes);
        expect(message.success.message, contains('Successfully uploaded'));

        final rs = client.getPackageVersionAttestation(
          'unattested_pkg',
          '1.0.0',
        );
        await expectApiException(
          rs,
          status: 404,
          code: 'NotFound',
          message: 'Could not find `attestation for unattested_pkg 1.0.0`.',
        );
      },
    );

    testWithProfile(
      'upload fails when attestation bundle has invalid JSON or invalid bytes',
      fn: () async {
        final pubspecContent =
            'name: bad_attested_pkg\nversion: 1.0.0\ndescription: A package with bad attestation.\nenvironment:\n  sdk: ">=2.12.0 <4.0.0"\n';
        final archiveBytes = await packageArchiveBytes(
          pubspecContent: pubspecContent,
        );

        // 1. Invalid non-UTF8 / tampered raw bytes
        final rs1 = createPubApiClient(authToken: adminClientToken)
            .uploadPackageBytes(
              archiveBytes,
              attestationBytes: [0xFF, 0xFE, 0xFD],
            );
        await expectApiException(
          rs1,
          status: 400,
          code: 'PackageRejected',
          message: 'Invalid attestation bundle format',
        );

        // 2. Invalid non-JSON string
        final rs2 = createPubApiClient(authToken: adminClientToken)
            .uploadPackageBytes(
              archiveBytes,
              attestationBytes: utf8.encode('this is not json'),
            );
        await expectApiException(
          rs2,
          status: 400,
          code: 'PackageRejected',
          message: 'Invalid attestation bundle format',
        );

        // 3. Non-object JSON
        final rs3 = createPubApiClient(authToken: adminClientToken)
            .uploadPackageBytes(
              archiveBytes,
              attestationBytes: utf8.encode('[1, 2, 3]'),
            );
        await expectApiException(
          rs3,
          status: 400,
          code: 'PackageRejected',
          message: 'Invalid attestation bundle format',
        );
      },
    );

    testWithProfile(
      'upload fails when attestation is invalid or sha256 does not match',
      fn: () async {
        final pubspecContent =
            'name: invalid_attested_pkg\nversion: 1.0.0\ndescription: An invalid attested package.\nrepository: https://github.com/mosuem/invalid_attested_pkg\nenvironment:\n  sdk: ">=2.12.0 <4.0.0"\n';
        final archiveBytes = await packageArchiveBytes(
          pubspecContent: pubspecContent,
        );

        final attestationBytes = utf8.encode(_sampleBundleJson);
        final rs = createPubApiClient(
          authToken: adminClientToken,
        ).uploadPackageBytes(archiveBytes, attestationBytes: attestationBytes);
        await expectApiException(
          rs,
          status: 400,
          code: 'PackageRejected',
          message: 'Invalid package attestation',
        );
      },
    );
  });
}

String _buildProvenanceBundleJson({
  required String subjectName,
  required String subjectSha256,
  required String repository,
  String ref = 'refs/tags/v1.0.0',
  String workflowPath = '.github/workflows/publish.yml',
  String commitSha = 'c0ffee7891abbe3dab159e9d0187fc1042d5e0cd',
  String builderId =
      'https://github.com/dart-lang/setup-dart/.github/workflows/publish.yml@refs/tags/v2',
}) {
  final statement = {
    '_type': 'https://in-toto.io/Statement/v1',
    'subject': [
      {
        'name': subjectName,
        'digest': {'sha256': subjectSha256},
      },
    ],
    'predicateType': 'https://slsa.dev/provenance/v1',
    'predicate': {
      'buildDefinition': {
        'buildType': 'https://actions.github.io/buildtypes/workflow/v1',
        'externalParameters': {
          'workflow': {
            'ref': ref,
            'repository': repository,
            'path': workflowPath,
          },
        },
        'resolvedDependencies': [
          {
            'uri': 'git+$repository@$ref',
            'digest': {'gitCommit': commitSha},
          },
        ],
      },
      'runDetails': {
        'builder': {'id': builderId},
      },
    },
  };
  return jsonEncode({
    'mediaType': 'application/vnd.dev.sigstore.bundle+json;version=0.3',
    'dsseEnvelope': {
      'payload': base64Encode(utf8.encode(jsonEncode(statement))),
      'payloadType': 'application/vnd.in-toto+json',
      'signatures': [
        {'sig': 'not-a-real-signature'},
      ],
    },
  });
}

final Uint8List _helpfulArchiveBytes = base64Decode(
  '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',
);

const String _helpfulBundleJson =
    r'''{"mediaType":"application/vnd.dev.sigstore.bundle.v0.3+json","verificationMaterial":{"certificate":{"rawBytes":"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"},"tlogEntries":[{"logIndex":"2676401329","logId":{"keyId":"wNI9atQGlz+VWfO6LRygH4QUfY/8W4RFwiT5i5WRgB0="},"kindVersion":{"kind":"dsse","version":"0.0.1"},"integratedTime":"1788270157","inclusionPromise":{"signedEntryTimestamp":"MEYCIQCF0fJPsDlo0/ETbGoj7P1Tv5t6/KnFTC4li5/hgfp+zQIhAMHiH5jQct+InQUDaLsvrj4ScaLttabrbOtgOOFNP5TB"},"inclusionProof":{"logIndex":"2554497067","rootHash":"3VYInn5w29R1Ik5hPXoKNUXLSpjYDA+eOe15tHZDf3Q=","treeSize":"2554497077","hashes":["vEJRC4WGQtYk/U8bQHZ1GSxv9gXkeDlMle2iNtj5oLk=","A+Z5tXgPG9hRnNyqfrNlhB/lSijIrKbBlghyVizPfDw=","34bE/cxzMRK5jIX0UnN60fixf7k7tlZnLfYP9WwTbAA=","xF6ied/Idor3bSwQm8r7l+4G+22wzhE4Yyo2TSTTJzU=","mI6+Jl7u+5zbsD2btfPoIi4JXtac2ZA3T4OQu5XBQv0=","+kWrmBfcvkeD3p6uiuVZRX0NzFhOAsr66BfgZXcY/gE=","Rt2No6mKQC0/Lm4I88OyNhBZctDQArHU/FWcBQXRKHk=","YnrIcUp47OZh4DKzWnPt6HbUJ47Z6J/60daOiLSJFhM=","PSk3xvEFw94Y6oOvFw7ze0gTgr7OTNkRO9qcIOHxQWc=","/7Mrva+smcuOSAUamgAAnlU6WDjX01mVt0u9CfyOS3w=","eXSLrLqKSxRTixSP/k4YimriB2lufao6trqTrsxxlyg=","SndbMKVtcTenAkwi2JBfGzD+mhexp1qJbRIY+A1JRIU=","xH/DCseLHr9eKoYT8qsORZK7zVdEGYWHuVtsVrD95wY="],"checkpoint":{"envelope":"rekor.sigstore.dev - 1193050959916656506\n2554497077\n3VYInn5w29R1Ik5hPXoKNUXLSpjYDA+eOe15tHZDf3Q=\n\n\u2014 rekor.sigstore.dev wNI9ajBFAiEA+vbOqxP76bar3G0xXiMl0qAQ249eIvk2LPNvYJjep64CIGC3cdY2YUlaa6vc0djTkh1irUcugzw9PpnCKsURbPHp\n"}},"canonicalizedBody":"eyJhcGlWZXJzaW9uIjoiMC4wLjEiLCJraW5kIjoiZHNzZSIsInNwZWMiOnsiZW52ZWxvcGVIYXNoIjp7ImFsZ29yaXRobSI6InNoYTI1NiIsInZhbHVlIjoiZDNkOTMxYjZjN2VjNWNhZjRmOTA0MWQwOWNhZTk4ODY5MjhlODUzMDg1NGY3NzQzMmZkY2QxNWYxM2Q4NjU4YSJ9LCJwYXlsb2FkSGFzaCI6eyJhbGdvcml0aG0iOiJzaGEyNTYiLCJ2YWx1ZSI6IjFhOWQ5MTFmZDBkM2Y2NGY1NmY1ZjZjNGIxMTEwN2VmMzY2MmI0ZGViZGM3YmJjZjY2NTliMzQ4NzY5NzQ4OWQifSwic2lnbmF0dXJlcyI6W3sic2lnbmF0dXJlIjoiTUVZQ0lRRGgzeXY1MXREZ1Q5UWFHemh0VXRBSEFsMWpQa2dqSXF2dlZBcFBmWUNaa3dJaEFNNExlaTZvZDFOc1RrdmZOY21zeVlyT3A0azRhNDljYlhWYVRPK0hoTzAwIiwidmVyaWZpZXIiOiJMUzB0TFMxQ1JVZEpUaUJEUlZKVVNVWkpRMEZVUlMwdExTMHRDazFKU1VoVFZFTkRRbk1yWjBGM1NVSkJaMGxWVTJKTGNuWTFjbkp5VlZVclZtOUtVRE5FYzFaelRVSlZhMkZOZDBObldVbExiMXBKZW1vd1JVRjNUWGNLVG5wRlZrMUNUVWRCTVZWRlEyaE5UV015Ykc1ak0xSjJZMjFWZFZwSFZqSk5ValIzU0VGWlJGWlJVVVJGZUZaNllWZGtlbVJIT1hsYVV6RndZbTVTYkFwamJURnNXa2RzYUdSSFZYZElhR05PVFdwWmQwOVVRWGhOVkUwd1RXcE5NMWRvWTA1TmFsbDNUMVJCZUUxVVRURk5hazB6VjJwQlFVMUdhM2RGZDFsSUNrdHZXa2w2YWpCRFFWRlpTVXR2V2tsNmFqQkVRVkZqUkZGblFVVnpNRmxLVTJSVU1saE9hRll3VUV0Q1lrUndOMVZ5V0hseU9FTTFjR2t4UTNrNFlsUUtNVmMwWkRKNWNEYzJhRzlrUTFZd0szUnZMMVo0WVhjeVJrTnVTa3R4WkVSNlpGWXJRMHR1WW1VeVlrVTVWM0pVYWt0UFEwSmxOSGRuWjFoeFRVRTBSd3BCTVZWa1JIZEZRaTkzVVVWQmQwbElaMFJCVkVKblRsWklVMVZGUkVSQlMwSm5aM0pDWjBWR1FsRmpSRUY2UVdSQ1owNVdTRkUwUlVablVWVnZlakZRQ25JdlZsbFBWVWRCYnpSRWJrbE5lWGRHTlU5UE9VTmpkMGgzV1VSV1VqQnFRa0puZDBadlFWVXpPVkJ3ZWpGWmEwVmFZalZ4VG1wd1MwWlhhWGhwTkZrS1drUTRkMlYzV1VSV1VqQlNRVkZJTDBKSVJYZGlORnAwWVVoU01HTklUVFpNZVRsdVlWaFNiMlJYU1hWWk1qbDBUREpTYUdOdVVYUmlSMFoxV25rNWVncGFXRkl4WTBNeGExbFlTakJNZVRWdVlWaFNiMlJYU1haa01qbDVZVEphYzJJelpIcE1NMEl4V1cxNGNHTXlaM1ZsVnpGelVVaEtiRnB1VFhaaFIxWm9DbHBJVFhaalNGWnBZa2RzZW1GRE1YZFpWMDV5V1Zka2JFeFhSakJrUjFaNlpFZEdNR0ZYT1hWamVrRTFRbWR2Y2tKblJVVkJXVTh2VFVGRlFrSkRkRzhLWkVoU2QyTjZiM1pNTTFKMllUSldkVXh0Um1wa1IyeDJZbTVOZFZveWJEQmhTRlpwWkZoT2JHTnRUblppYmxKc1ltNVJkVmt5T1hSTlFqaEhRMmx6UndwQlVWRkNaemM0ZDBGUlNVVkZXR1IyWTIxMGJXSkhPVE5ZTWxKd1l6TkNhR1JIVG05TlJGbEhRMmx6UjBGUlVVSm5OemgzUVZGTlJVdEVXWHBOYWtVeUNsbFVUWGROYWtwc1drUlpkMDVxVlhwUFJFMDFUMVJaZWs1SFRtdE5WMDB4VFdwV2JVOUhTbXRPUkZreFRqSlpkMHRCV1V0TGQxbENRa0ZIUkhaNlFVSUtRa0ZSWVZWSVZtbGlSMng2WVVOQ2IxcFhlSGRhYmxaelNVaFNka2xJUWpGWmFUVnJXbGhaZDBoQldVdExkMWxDUWtGSFJIWjZRVUpDVVZGUFlsYzVlZ3BrVjFaMFRESm9iR0pJUW0xa1YzZDNTRkZaUzB0M1dVSkNRVWRFZG5wQlFrSm5VVkJqYlZadFkzazViMXBYUm10amVUbDBXVmRzZFUxRWMwZERhWE5IQ2tGUlVVSm5OemgzUVZGblJVeFJkM0poU0ZJd1kwaE5Oa3g1T1RCaU1uUnNZbWsxYUZrelVuQmlNalY2VEcxa2NHUkhhREZaYmxaNldsaEthbUl5TlRBS1dsYzFNRXh0VG5aaVZFSTVRbWR2Y2tKblJVVkJXVTh2VFVGRlNrSkhPRTFpVjJnd1pFaENlazlwT0haYU1td3dZVWhXYVV4dFRuWmlVemxyV1ZoS01BcE1WM2hvWW0xamRtTXlWakJrV0VGMFdrZEdlV1JET0hWYU1td3dZVWhXYVV3elpIWmpiWFJ0WWtjNU0yTjVPWGRrVjBwellWaE9iMHh1YkhSaVJVSjVDbHBYV25wTU1taHNXVmRTZWt3elFqRlpiWGh3WXpKbmRHTkhSbXBoTWtadVdsTXhhR1JJVW14ak0xSm9aRWRzZG1KdVRYZFBRVmxMUzNkWlFrSkJSMFFLZG5wQlFrTm5VWEZFUTJocldtcGtiVmxxWkdoT2JVMTNXV3BuTlUxNlJYZGFWR2Q2VFVSbk1sbHRVVEpOVjBrelRucHJNVTR5VW0xUFZGbDVUMWROTUFwTlFqQkhRMmx6UjBGUlVVSm5OemgzUVZGelJVUjNkMDVhTW13d1lVaFdhVXhYYUhaak0xSnNXa1JCZUVKbmIzSkNaMFZGUVZsUEwwMUJSVTFDUTAxTkNrbFhhREJrU0VKNlQyazRkbG95YkRCaFNGWnBURzFPZG1KVE9YUmlNMDR4V2xjd2RtRkhWbk5qUjFveFlrUkJORUpuYjNKQ1owVkZRVmxQTDAxQlJVNEtRa052VFV0RVdYcE5ha1V5V1ZSTmQwMXFTbXhhUkZsM1RtcFZlazlFVFRWUFZGbDZUa2RPYTAxWFRURk5hbFp0VDBkS2EwNUVXVEZPTWxsM1NIZFpTd3BMZDFsQ1FrRkhSSFo2UVVKRVoxRlNSRUU1ZVZwWFducE1NbWhzV1ZkU2Vrd3lNV2hoVnpSM1IyZFpTMHQzV1VKQ1FVZEVkbnBCUWtSM1VVMUVRVzk0Q2sxNlRUVk5la1Y2VFVSSk1VMURhMGREYVhOSFFWRlJRbWMzT0hkQlVrRkZSM2QzV21GSVVqQmpTRTAyVEhrNWJtRllVbTlrVjBsMVdUSTVkRXd5TVhZS1l6TldiR0pVUVZsQ1oyOXlRbWRGUlVGWlR5OU5RVVZTUWtGdlRVTkVTVE5QUkZVMVRVUm5lVTFIUVVkRGFYTkhRVkZSUW1jM09IZEJVa2xGVldkNFVRcGhTRkl3WTBoTk5reDVPVzVoV0ZKdlpGZEpkVmt5T1hSTU1qRjJZek5XYkdKVE9XOWFWM2gzV201V2MweDVOVzVoV0ZKdlpGZEpkbVF5T1hsaE1scHpDbUl6WkhwTU0wSXhXVzE0Y0dNeVozVmxWMFowWWtWQ2VWcFhXbnBNTW1oc1dWZFNla3d5TVdoaFZ6UjNUMEZaUzB0M1dVSkNRVWRFZG5wQlFrVjNVWEVLUkVObk1rMTZTWGhPYlVWNlRVUkplVnBYVVRKTlJGa3hUWHBuZWs5VWF6Sk5lbEpxV2tSR2FrNVVTVEZhYW1ocFdrUlJNazVVWkcxTlEwVkhRMmx6UndwQlVWRkNaemM0ZDBGU1VVVkZkM2RTWkRJNWVXRXlXbk5pTTJSbVdrZHNlbU5IUmpCWk1tZDNWbEZaUzB0M1dVSkNRVWRFZG5wQlFrWlJVa2hFUlZadkNtUklVbmRqZW05MlRESmtjR1JIYURGWmFUVnFZakl3ZG1KWE9YcGtWMVowVERKb2JHSklRbTFrVjNkMldWZE9NR0ZYT1hWamVUbDVaRmMxZWt4NlRYb0tUbFJGTUU5VVVYcE9WRlV4VERKR01HUkhWblJqU0ZKNlRIcEZkMFpuV1V0TGQxbENRa0ZIUkhaNlFVSkdaMUZKUkVGYWQyUlhTbk5oVjAxM1UzZFpTd3BMZDFsQ1FrRkhSSFo2UVVKSFFWRTVSRVIwZVZwWVFuWlBiVEYyWXpOV2JHSlZRWGxPZW1jeFQxUkJORTFwT1c5YVYzaDNXbTVXYzFGRVJYcE5lbXQ2Q2sxVVRYZE5hbFUyWTIxV2JVOXVTbXhhYmsxMllVZFdhRnBJVFhaaVYwWndZbXBEUW1sM1dVdExkMWxDUWtGSVYyVlJTVVZCWjFJNVFraHpRV1ZSUWpNS1FVNHdPVTFIY2tkNGVFVjVXWGhyWlVoS2JHNU9kMHRwVTJ3Mk5ETnFlWFF2TkdWTFkyOUJka3RsTms5QlFVRkNiMFl3TVVodk5FRkJRVkZFUVVWbmR3cFNaMGxvUVV0c2RISTFaazlNV0djNFZqVnplRU13YzJKS2IwUm1kbWRzVm13MU5sSnZkSEp1T0hWUVYySnRjVzFCYVVWQk5USkRVWFY1WWxCSWRsRmpDbFV3YUN0c05DdGFZbUVyWlVoak9XdFFTV1J0TnpCVk5WVnVkRmhWZW5kM1EyZFpTVXR2V2tsNmFqQkZRWGROUkdGQlFYZGFVVWwzVG5CWmRtdEdlV1FLYTBOeVJ6VTNjVXgwUWk5NVpVOWhSMVp6YzAxUGFsRnBURkY0VTBwNVNHZzViUzkwTDB4VVZXUnhlbWRaVDB0cWVVZENSV2RNYUcxQmFrVkJNbVJwWXdwbVZHaGtWakZUYWtkdVdEZGFPVFZWUzBreFNWQk5VV1pQVHpJek1rSjBjWEkzUVhFeWJGZHNUbWR3TW5oRFJXeHJXV0V2YjBKa1RXdGpSRUlLTFMwdExTMUZUa1FnUTBWU1ZFbEdTVU5CVkVVdExTMHRMUW89In1dfX0="}],"timestampVerificationData":{}},"dsseEnvelope":{"payload":"eyJfdHlwZSI6Imh0dHBzOi8vaW4tdG90by5pby9TdGF0ZW1lbnQvdjEiLCJzdWJqZWN0IjpbeyJuYW1lIjoicGFja2FnZS50YXIuZ3oiLCJkaWdlc3QiOnsic2hhMjU2IjoiYzhlY2ZhNjExMDBlY2UxYTU1ZmNiNTI3MTZkYjc0ZjkyYjZkZWJlYjc1NzdhNGI4Y2E0NTQ4ZjQ0MGJmYTZiZiJ9fV0sInByZWRpY2F0ZVR5cGUiOiJodHRwczovL3Nsc2EuZGV2L3Byb3ZlbmFuY2UvdjEiLCJwcmVkaWNhdGUiOnsiYnVpbGREZWZpbml0aW9uIjp7ImJ1aWxkVHlwZSI6Imh0dHBzOi8vYWN0aW9ucy5naXRodWIuaW8vYnVpbGR0eXBlcy93b3JrZmxvdy92MSIsImV4dGVybmFsUGFyYW1ldGVycyI6eyJ3b3JrZmxvdyI6eyJyZWYiOiJyZWZzL2hlYWRzL21haW4iLCJyZXBvc2l0b3J5IjoiaHR0cHM6Ly9naXRodWIuY29tL21vc3VlbS9oZWxwZnVsIiwicGF0aCI6Ii5naXRodWIvd29ya2Zsb3dzL3B1Ymxpc2gueWFtbCJ9fSwiaW50ZXJuYWxQYXJhbWV0ZXJzIjp7ImdpdGh1YiI6eyJldmVudF9uYW1lIjoid29ya2Zsb3dfZGlzcGF0Y2giLCJyZXBvc2l0b3J5X2lkIjoiMTMzOTMxMzAyNSIsInJlcG9zaXRvcnlfb3duZXJfaWQiOiIyNzg1OTA4MiIsInJ1bm5lcl9lbnZpcm9ubWVudCI6ImdpdGh1Yi1ob3N0ZWQifX0sInJlc29sdmVkRGVwZW5kZW5jaWVzIjpbeyJ1cmkiOiJnaXQraHR0cHM6Ly9naXRodWIuY29tL21vc3VlbS9oZWxwZnVsQHJlZnMvaGVhZHMvbWFpbiIsImRpZ2VzdCI6eyJnaXRDb21taXQiOiI2MzIxNmEzMDIyZWQ2MDY1MzgzOTk2MzRjZDFjNTI1ZjhiZDQ2NTdmIn19XX0sInJ1bkRldGFpbHMiOnsiYnVpbGRlciI6eyJpZCI6Imh0dHBzOi8vZ2l0aHViLmNvbS9kYXJ0LWxhbmcvc2V0dXAtZGFydC8uZ2l0aHViL3dvcmtmbG93cy9wdWJsaXNoLnltbEByZWZzL2hlYWRzL3B1Ymxpc2gtcGFja2FnZS1hdHRlc3RhdGlvbnMifSwibWV0YWRhdGEiOnsiaW52b2NhdGlvbklkIjoiaHR0cHM6Ly9naXRodWIuY29tL21vc3VlbS9oZWxwZnVsL2FjdGlvbnMvcnVucy8zMzUxNDk0MzU1NS9hdHRlbXB0cy8xIn19fX0=","payloadType":"application/vnd.in-toto+json","signatures":[{"sig":"MEYCIQDh3yv51tDgT9QaGzhtUtAHAl1jPkgjIqvvVApPfYCZkwIhAM4Lei6od1NsTkvfNcmsyYrOp4k4a49cbXVaTO+HhO00"}]}}''';

const _sampleBundleJson =
    r'''{"mediaType": "application/vnd.dev.sigstore.bundle+json;version=0.3", "verificationMaterial": {"certificate": {"rawBytes": "MIIIMTCCB7egAwIBAgIUaL/tsmQTHk21mt1Uuk+w7avDBz4wCgYIKoZIzj0EAwMwNzEVMBMGA1UEChMMc2lnc3RvcmUuZGV2MR4wHAYDVQQDExVzaWdzdG9yZS1pbnRlcm1lZGlhdGUwHhcNMjQwMzE5MTcyNjI2WhcNMjQwMzE5MTczNjI2WjAAMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE22S1j/NkEXzBPQAuamHXLpwx+RPnnzZQl/pkEZ8xorvKnzujCS1mVTBo9kBxmYWo2DHtyVyfgnuOqVTzLYmho6OCBtYwggbSMA4GA1UdDwEB/wQEAwIHgDATBgNVHSUEDDAKBggrBgEFBQcDAzAdBgNVHQ4EFgQUFv1SCziEKN2rRyrjeVlFbSLg1/QwHwYDVR0jBBgwFoAU39Ppz1YkEZb5qNjpKFWixi4YZD8wgaUGA1UdEQEB/wSBmjCBl4aBlGh0dHBzOi8vZ2l0aHViLmNvbS9zaWdzdG9yZS1jb25mb3JtYW5jZS9leHRyZW1lbHktZGFuZ2Vyb3VzLXB1YmxpYy1vaWRjLWJlYWNvbi8uZ2l0aHViL3dvcmtmbG93cy9leHRyZW1lbHktZGFuZ2Vyb3VzLW9pZGMtYmVhY29uLnltbEByZWZzL2hlYWRzL21haW4wOQYKKwYBBAGDvzABAQQraHR0cHM6Ly90b2tlbi5hY3Rpb25zLmdpdGh1YnVzZXJjb250ZW50LmNvbTAfBgorBgEEAYO/MAECBBF3b3JrZmxvd19kaXNwYXRjaDA2BgorBgEEAYO/MAEDBChjN2IzZGZiMzM1ZjA1MWUxYzg2YmRhNGM3MTZmYWM5N2RmNjJhZDgxMC0GCisGAQQBg78wAQQEH0V4dHJlbWVseSBkYW5nZXJvdXMgT0lEQyBiZWFjb24wSQYKKwYBBAGDvzABBQQ7c2lnc3RvcmUtY29uZm9ybWFuY2UvZXh0cmVtZWx5LWRhbmdlcm91cy1wdWJsaWMtb2lkYy1iZWFjb24wHQYKKwYBBAGDvzABBgQPcmVmcy9oZWFkcy9tYWluMDsGCisGAQQBg78wAQgELQwraHR0cHM6Ly90b2tlbi5hY3Rpb25zLmdpdGh1YnVzZXJjb250ZW50LmNvbTCBpgYKKwYBBAGDvzABCQSBlwyBlGh0dHBzOi8vZ2l0aHViLmNvbS9zaWdzdG9yZS1jb25mb3JtYW5jZS9leHRyZW1lbHktZGFuZ2Vyb3VzLXB1YmxpYy1vaWRjLWJlYWNvbi8uZ2l0aHViL3dvcmtmbG93cy9leHRyZW1lbHktZGFuZ2Vyb3VzLW9pZGMtYmVhY29uLnltbEByZWZzL2hlYWRzL21haW4wOAYKKwYBBAGDvzABCgQqDChjN2IzZGZiMzM1ZjA1MWUxYzg2YmRhNGM3MTZmYWM5N2RmNjJhZDgxMB0GCisGAQQBg78wAQsEDwwNZ2l0aHViLWhvc3RlZDBeBgorBgEEAYO/MAEMBFAMTmh0dHBzOi8vZ2l0aHViLmNvbS9zaWdzdG9yZS1jb25mb3JtYW5jZS9leHRyZW1lbHktZGFuZ2Vyb3VzLXB1YmxpYy1vaWRjLWJlYWNvbjA4BgorBgEEAYO/MAENBCoMKGM3YjNkZmIzMzVmMDUxZTFjODZiZGE0YzcxNmZhYzk3ZGY2MmFkODEwHwYKKwYBBAGDvzABDgQRDA9yZWZzL2hlYWRzL21haW4wGQYKKwYBBAGDvzABDwQLDAk2MzI1OTY4OTcwNwYKKwYBBAGDvzABEAQpDCdodHRwczovL2dpdGh1Yi5jb20vc2lnc3RvcmUtY29uZm9ybWFuY2UwGQYKKwYBBAGDvzABEQQLDAkxMzE4MDQ1NjMwgaYGCisGAQQBg78wARIEgZcMgZRodHRwczovL2dpdGh1Yi5jb20vc2lnc3RvcmUtY29uZm9ybWFuY2UvZXh0cmVtZWx5LWRhbmdlcm91cy1wdWJsaWMtb2lkYy1iZWFjb24vLmdpdGh1Yi93b3JrZmxvd3MvZXh0cmVtZWx5LWRhbmdlcm91cy1vaWRjLWJlYWNvbi55bWxAcmVmcy9oZWFkcy9tYWluMDgGCisGAQQBg78wARMEKgwoYzdiM2RmYjMzNWYwNTFlMWM4NmJkYTRjNzE2ZmFjOTdkZjYyYWQ4MTAhBgorBgEEAYO/MAEUBBMMEXdvcmtmbG93X2Rpc3BhdGNoMIGBBgorBgEEAYO/MAEVBHMMcWh0dHBzOi8vZ2l0aHViLmNvbS9zaWdzdG9yZS1jb25mb3JtYW5jZS9leHRyZW1lbHktZGFuZ2Vyb3VzLXB1YmxpYy1vaWRjLWJlYWNvbi9hY3Rpb25zL3J1bnMvODM0NzQ4MTYyOC9hdHRlbXB0cy8xMBYGCisGAQQBg78wARYECAwGcHVibGljMIGKBgorBgEEAdZ5AgQCBHwEegB4AHYA3T0wasbHETJjGR4cmWc3AqJKXrjePK3/h4pygC8p7o4AAAGOV8AHpgAABAMARzBFAiBFeMbpFarlPwb0naTr4mjWDvXApOd9ORqOk36Brt9SmwIhAJJvjor+DXUXr7S3Vm9jVFT3CL0BxcKGj86m5mYzQvubMAoGCCqGSM49BAMDA2gAMGUCMA8lTixdS4iN9mAUduObcSJmhZLyvK7zaX05DLEDCgPWxDHk+JBZUKYRIuHHgwFnOwIxALMamo9dfENMzRgNCzYfp/y+rSOhVjXXE9mCn6BuJETlpRDfGvxUg/5LF9f4lYqozA=="}, "tlogEntries": [{"logIndex": "79571823", "logId": {"keyId": "wNI9atQGlz+VWfO6LRygH4QUfY/8W4RFwiT5i5WRgB0="}, "kindVersion": {"kind": "hashedrekord", "version": "0.0.1"}, "integratedTime": "1710869186", "inclusionPromise": {"signedEntryTimestamp": "MEYCIQDMNM49CNrcrpuvB9G3likdSse0miAkY0ILCqzRGP5ZJQIhAKnSS9GUSFVCar1+Sq3qoRtJIJ8x9tqRnQ8kuS1ojtTH"}, "inclusionProof": {"logIndex": "75408392", "rootHash": "Fnnj13Uu1jdksPc4HZLapKX329dVlD5+MGNsiqBq1XM=", "treeSize": "75408393", "hashes": ["1J7hRIEGvYdAyzEs+GhAE9L+38oHye3BhalgoQRZoo4=", "W/OUCkh/lqDDwbBkZgP7eTV/wx4WifD1wtfRLbavfxI=", "9wya2BEhfLGDfDRVN46OU2RXkozWCM1Z4qMu6SPiWoY=", "ZRs3lKAIlu0t0GtLupAcOu1y20nOaOshSKosWAqFO+w=", "BGqH+LzVuhuqCLiUvBJaB2hlsvtu2a15qq1WGw6mG44=", "OeS7D4kPES7ChE7kWSEmhbAMqBcKVj/z8/afMK4Y3pI=", "JtjqvAqFyXXYjWlZfDzElHpEzdBjsz1LmGFJuYx0kTU=", "s/ZIVcfcD4/nuZwUtQf4ydGsIAkGTPTzk3b0zhUC95k=", "YU1jZY/fp5tJdGF/i+/7ez8107O4/lOUp7acMPFEaOA=", "7Z18YLBAvejEV4nJHIKoks/xlijnhR005qTW2w4QtHg=", "98enzMaC+x5oCMvIZQA5z8vu2apDMCFvE/935NfuPw8="], "checkpoint": {"envelope": "rekor.sigstore.dev - 2605736670972794746\n75408393\nFnnj13Uu1jdksPc4HZLapKX329dVlD5+MGNsiqBq1XM=\n\n— rekor.sigstore.dev wNI9ajBFAiBTyiBM9WtyOTgohje6QZ5rFGJUdMq7Wk3A6oThE98SUgIhAMvxDwa7FyqRqg+YV3rdPPrfS23w19iK+piMSGVOmP5w\n"}}, "canonicalizedBody": "eyJhcGlWZXJzaW9uIjoiMC4wLjEiLCJraW5kIjoiaGFzaGVkcmVrb3JkIiwic3BlYyI6eyJkYXRhIjp7Imhhc2giOnsiYWxnb3JpdGhtIjoic2hhMjU2IiwidmFsdWUiOiJhMGNmYzcxMjcxZDZlMjc4ZTU3Y2QzMzJmZjk1N2MzZjcwNDNmZGRhMzU0YzRjYmIxOTBhMzBkNTZlZmEwMWJmIn19LCJzaWduYXR1cmUiOnsiY29udGVudCI6Ik1FVUNJQ1lGcS80YlRFZGx1cmdxVnVObXdDY0lXdTNOS09DZ3ZlV0FKQmllekowdUFpRUEyaTdVMTgrYVJwRnhMWWtzcjVIS0JRUXkwOHpFMDUwV0ljMFJ6S3VuRElBPSIsInB1YmxpY0tleSI6eyJjb250ZW50IjoiTFMwdExTMUNSVWRKVGlCRFJWSlVTVVpKUTBGVVJTMHRMUzB0Q2sxSlNVbE5WRU5EUWpkbFowRjNTVUpCWjBsVllVd3ZkSE50VVZSSWF6SXhiWFF4VlhWckszYzNZWFpFUW5vMGQwTm5XVWxMYjFwSmVtb3dSVUYzVFhjS1RucEZWazFDVFVkQk1WVkZRMmhOVFdNeWJHNWpNMUoyWTIxVmRWcEhWakpOVWpSM1NFRlpSRlpSVVVSRmVGWjZZVmRrZW1SSE9YbGFVekZ3WW01U2JBcGpiVEZzV2tkc2FHUkhWWGRJYUdOT1RXcFJkMDE2UlRWTlZHTjVUbXBKTWxkb1kwNU5hbEYzVFhwRk5VMVVZM3BPYWtreVYycEJRVTFHYTNkRmQxbElDa3R2V2tsNmFqQkRRVkZaU1V0dldrbDZhakJFUVZGalJGRm5RVVV5TWxNeGFpOU9hMFZZZWtKUVVVRjFZVzFJV0V4d2QzZ3JVbEJ1Ym5wYVVXd3ZjR3NLUlZvNGVHOXlka3R1ZW5WcVExTXhiVlpVUW04NWEwSjRiVmxYYnpKRVNIUjVWbmxtWjI1MVQzRldWSHBNV1cxb2J6WlBRMEowV1hkbloySlRUVUUwUndwQk1WVmtSSGRGUWk5M1VVVkJkMGxJWjBSQlZFSm5UbFpJVTFWRlJFUkJTMEpuWjNKQ1owVkdRbEZqUkVGNlFXUkNaMDVXU0ZFMFJVWm5VVlZHZGpGVENrTjZhVVZMVGpKeVVubHlhbVZXYkVaaVUweG5NUzlSZDBoM1dVUldVakJxUWtKbmQwWnZRVlV6T1ZCd2VqRlphMFZhWWpWeFRtcHdTMFpYYVhocE5Ga0tXa1E0ZDJkaFZVZEJNVlZrUlZGRlFpOTNVMEp0YWtOQ2JEUmhRbXhIYURCa1NFSjZUMms0ZGxveWJEQmhTRlpwVEcxT2RtSlRPWHBoVjJSNlpFYzVlUXBhVXpGcVlqSTFiV0l6U25SWlZ6VnFXbE01YkdWSVVubGFWekZzWWtocmRGcEhSblZhTWxaNVlqTldla3hZUWpGWmJYaHdXWGt4ZG1GWFVtcE1WMHBzQ2xsWFRuWmlhVGgxV2pKc01HRklWbWxNTTJSMlkyMTBiV0pIT1ROamVUbHNaVWhTZVZwWE1XeGlTR3QwV2tkR2RWb3lWbmxpTTFaNlRGYzVjRnBIVFhRS1dXMVdhRmt5T1hWTWJteDBZa1ZDZVZwWFducE1NbWhzV1ZkU2Vrd3lNV2hoVnpSM1QxRlpTMHQzV1VKQ1FVZEVkbnBCUWtGUlVYSmhTRkl3WTBoTk5ncE1lVGt3WWpKMGJHSnBOV2haTTFKd1lqSTFla3h0WkhCa1IyZ3hXVzVXZWxwWVNtcGlNalV3V2xjMU1FeHRUblppVkVGbVFtZHZja0puUlVWQldVOHZDazFCUlVOQ1FrWXpZak5LY2xwdGVIWmtNVGxyWVZoT2QxbFlVbXBoUkVFeVFtZHZja0puUlVWQldVOHZUVUZGUkVKRGFHcE9Na2w2V2tkYWFVMTZUVEVLV21wQk1VMVhWWGhaZW1jeVdXMVNhRTVIVFROTlZGcHRXVmROTlU0eVVtMU9ha3BvV2tSbmVFMURNRWREYVhOSFFWRlJRbWMzT0hkQlVWRkZTREJXTkFwa1NFcHNZbGRXYzJWVFFtdFpWelZ1V2xoS2RtUllUV2RVTUd4RlVYbENhVnBYUm1waU1qUjNVMUZaUzB0M1dVSkNRVWRFZG5wQlFrSlJVVGRqTW14dUNtTXpVblpqYlZWMFdUSTVkVnB0T1hsaVYwWjFXVEpWZGxwWWFEQmpiVlowV2xkNE5VeFhVbWhpYldSc1kyMDVNV041TVhka1YwcHpZVmROZEdJeWJHc0tXWGt4YVZwWFJtcGlNalIzU0ZGWlMwdDNXVUpDUVVkRWRucEJRa0puVVZCamJWWnRZM2s1YjFwWFJtdGplVGwwV1Zkc2RVMUVjMGREYVhOSFFWRlJRZ3BuTnpoM1FWRm5SVXhSZDNKaFNGSXdZMGhOTmt4NU9UQmlNblJzWW1rMWFGa3pVbkJpTWpWNlRHMWtjR1JIYURGWmJsWjZXbGhLYW1JeU5UQmFWelV3Q2t4dFRuWmlWRU5DY0dkWlMwdDNXVUpDUVVkRWRucEJRa05SVTBKc2QzbENiRWRvTUdSSVFucFBhVGgyV2pKc01HRklWbWxNYlU1MllsTTVlbUZYWkhvS1pFYzVlVnBUTVdwaU1qVnRZak5LZEZsWE5XcGFVemxzWlVoU2VWcFhNV3hpU0d0MFdrZEdkVm95Vm5saU0xWjZURmhDTVZsdGVIQlplVEYyWVZkU2FncE1WMHBzV1ZkT2RtSnBPSFZhTW13d1lVaFdhVXd6WkhaamJYUnRZa2M1TTJONU9XeGxTRko1V2xjeGJHSklhM1JhUjBaMVdqSldlV0l6Vm5wTVZ6bHdDbHBIVFhSWmJWWm9XVEk1ZFV4dWJIUmlSVUo1V2xkYWVrd3lhR3haVjFKNlRESXhhR0ZYTkhkUFFWbExTM2RaUWtKQlIwUjJla0ZDUTJkUmNVUkRhR29LVGpKSmVscEhXbWxOZWsweFdtcEJNVTFYVlhoWmVtY3lXVzFTYUU1SFRUTk5WRnB0V1ZkTk5VNHlVbTFPYWtwb1drUm5lRTFDTUVkRGFYTkhRVkZSUWdwbk56aDNRVkZ6UlVSM2QwNWFNbXd3WVVoV2FVeFhhSFpqTTFKc1drUkNaVUpuYjNKQ1owVkZRVmxQTDAxQlJVMUNSa0ZOVkcxb01HUklRbnBQYVRoMkNsb3liREJoU0ZacFRHMU9kbUpUT1hwaFYyUjZaRWM1ZVZwVE1XcGlNalZ0WWpOS2RGbFhOV3BhVXpsc1pVaFNlVnBYTVd4aVNHdDBXa2RHZFZveVZua0tZak5XZWt4WVFqRlpiWGh3V1hreGRtRlhVbXBNVjBwc1dWZE9kbUpxUVRSQ1oyOXlRbWRGUlVGWlR5OU5RVVZPUWtOdlRVdEhUVE5aYWs1cldtMUplZ3BOZWxadFRVUlZlRnBVUm1wUFJGcHBXa2RGTUZsNlkzaE9iVnBvV1hwck0xcEhXVEpOYlVaclQwUkZkMGgzV1V0TGQxbENRa0ZIUkhaNlFVSkVaMUZTQ2tSQk9YbGFWMXA2VERKb2JGbFhVbnBNTWpGb1lWYzBkMGRSV1V0TGQxbENRa0ZIUkhaNlFVSkVkMUZNUkVGck1rMTZTVEZQVkZrMFQxUmpkMDUzV1VzS1MzZFpRa0pCUjBSMmVrRkNSVUZSY0VSRFpHOWtTRkozWTNwdmRrd3laSEJrUjJneFdXazFhbUl5TUhaak1teHVZek5TZG1OdFZYUlpNamwxV20wNWVRcGlWMFoxV1RKVmQwZFJXVXRMZDFsQ1FrRkhSSFo2UVVKRlVWRk1SRUZyZUUxNlJUUk5SRkV4VG1wTmQyZGhXVWREYVhOSFFWRlJRbWMzT0hkQlVrbEZDbWRhWTAxbldsSnZaRWhTZDJONmIzWk1NbVJ3WkVkb01WbHBOV3BpTWpCMll6SnNibU16VW5aamJWVjBXVEk1ZFZwdE9YbGlWMFoxV1RKVmRscFlhREFLWTIxV2RGcFhlRFZNVjFKb1ltMWtiR050T1RGamVURjNaRmRLYzJGWFRYUmlNbXhyV1hreGFWcFhSbXBpTWpSMlRHMWtjR1JIYURGWmFUa3pZak5LY2dwYWJYaDJaRE5OZGxwWWFEQmpiVlowV2xkNE5VeFhVbWhpYldSc1kyMDVNV041TVhaaFYxSnFURmRLYkZsWFRuWmlhVFUxWWxkNFFXTnRWbTFqZVRsdkNscFhSbXRqZVRsMFdWZHNkVTFFWjBkRGFYTkhRVkZSUW1jM09IZEJVazFGUzJkM2IxbDZaR2xOTWxKdFdXcE5lazVYV1hkT1ZFWnNUVmROTkU1dFNtc0tXVlJTYWs1NlJUSmFiVVpxVDFSa2ExcHFXWGxaVjFFMFRWUkJhRUpuYjNKQ1owVkZRVmxQTDAxQlJWVkNRazFOUlZoa2RtTnRkRzFpUnpreldESlNjQXBqTTBKb1pFZE9iMDFKUjBKQ1oyOXlRbWRGUlVGWlR5OU5RVVZXUWtoTlRXTlhhREJrU0VKNlQyazRkbG95YkRCaFNGWnBURzFPZG1KVE9YcGhWMlI2Q21SSE9YbGFVekZxWWpJMWJXSXpTblJaVnpWcVdsTTViR1ZJVW5sYVZ6RnNZa2hyZEZwSFJuVmFNbFo1WWpOV2VreFlRakZaYlhod1dYa3hkbUZYVW1vS1RGZEtiRmxYVG5aaWFUbG9XVE5TY0dJeU5YcE1NMG94WW01TmRrOUVUVEJPZWxFMFRWUlplVTlET1doa1NGSnNZbGhDTUdONU9IaE5RbGxIUTJselJ3cEJVVkZDWnpjNGQwRlNXVVZEUVhkSFkwaFdhV0pIYkdwTlNVZExRbWR2Y2tKblJVVkJaRm8xUVdkUlEwSklkMFZsWjBJMFFVaFpRVE5VTUhkaGMySklDa1ZVU21wSFVqUmpiVmRqTTBGeFNrdFljbXBsVUVzekwyZzBjSGxuUXpod04yODBRVUZCUjA5V09FRkljR2RCUVVKQlRVRlNla0pHUVdsQ1JtVk5ZbkFLUm1GeWJGQjNZakJ1WVZSeU5HMXFWMFIyV0VGd1QyUTVUMUp4VDJzek5rSnlkRGxUYlhkSmFFRktTblpxYjNJclJGaFZXSEkzVXpOV2JUbHFWa1pVTXdwRFREQkNlR05MUjJvNE5tMDFiVmw2VVhaMVlrMUJiMGREUTNGSFUwMDBPVUpCVFVSQk1tZEJUVWRWUTAxQk9HeFVhWGhrVXpScFRqbHRRVlZrZFU5aUNtTlRTbTFvV2t4NWRrczNlbUZZTURWRVRFVkVRMmRRVjNoRVNHc3JTa0phVlV0WlVrbDFTRWhuZDBadVQzZEplRUZNVFdGdGJ6bGtaa1ZPVFhwU1owNEtRM3BaWm5BdmVTdHlVMDlvVm1wWVdFVTViVU51TmtKMVNrVlViSEJTUkdaSGRuaFZaeTgxVEVZNVpqUnNXWEZ2ZWtFOVBRb3RMUzB0TFVWT1JDQkRSVkpVU1VaSlEwRlVSUzB0TFMwdENnPT0ifX19fQ=="}]}, "messageSignature": {"messageDigest": {"algorithm": "SHA2_256", "digest": "oM/HEnHW4njlfNMy/5V8P3BD/do1TEy7GQow1W76Ab8="}, "signature": "MEUCICYFq/4bTEdlurgqVuNmwCcIWu3NKOCgveWAJBiezJ0uAiEA2i7U18+aRpFxLYksr5HKBQQy08zE050WIc0RzKunDIA="}}''';
