// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

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

          final attestationBytes = utf8.encode(_sampleBundleJson);
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

const _sampleBundleJson =
    r'''{"mediaType": "application/vnd.dev.sigstore.bundle+json;version=0.3", "verificationMaterial": {"certificate": {"rawBytes": "MIIIMTCCB7egAwIBAgIUaL/tsmQTHk21mt1Uuk+w7avDBz4wCgYIKoZIzj0EAwMwNzEVMBMGA1UEChMMc2lnc3RvcmUuZGV2MR4wHAYDVQQDExVzaWdzdG9yZS1pbnRlcm1lZGlhdGUwHhcNMjQwMzE5MTcyNjI2WhcNMjQwMzE5MTczNjI2WjAAMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE22S1j/NkEXzBPQAuamHXLpwx+RPnnzZQl/pkEZ8xorvKnzujCS1mVTBo9kBxmYWo2DHtyVyfgnuOqVTzLYmho6OCBtYwggbSMA4GA1UdDwEB/wQEAwIHgDATBgNVHSUEDDAKBggrBgEFBQcDAzAdBgNVHQ4EFgQUFv1SCziEKN2rRyrjeVlFbSLg1/QwHwYDVR0jBBgwFoAU39Ppz1YkEZb5qNjpKFWixi4YZD8wgaUGA1UdEQEB/wSBmjCBl4aBlGh0dHBzOi8vZ2l0aHViLmNvbS9zaWdzdG9yZS1jb25mb3JtYW5jZS9leHRyZW1lbHktZGFuZ2Vyb3VzLXB1YmxpYy1vaWRjLWJlYWNvbi8uZ2l0aHViL3dvcmtmbG93cy9leHRyZW1lbHktZGFuZ2Vyb3VzLW9pZGMtYmVhY29uLnltbEByZWZzL2hlYWRzL21haW4wOQYKKwYBBAGDvzABAQQraHR0cHM6Ly90b2tlbi5hY3Rpb25zLmdpdGh1YnVzZXJjb250ZW50LmNvbTAfBgorBgEEAYO/MAECBBF3b3JrZmxvd19kaXNwYXRjaDA2BgorBgEEAYO/MAEDBChjN2IzZGZiMzM1ZjA1MWUxYzg2YmRhNGM3MTZmYWM5N2RmNjJhZDgxMC0GCisGAQQBg78wAQQEH0V4dHJlbWVseSBkYW5nZXJvdXMgT0lEQyBiZWFjb24wSQYKKwYBBAGDvzABBQQ7c2lnc3RvcmUtY29uZm9ybWFuY2UvZXh0cmVtZWx5LWRhbmdlcm91cy1wdWJsaWMtb2lkYy1iZWFjb24wHQYKKwYBBAGDvzABBgQPcmVmcy9oZWFkcy9tYWluMDsGCisGAQQBg78wAQgELQwraHR0cHM6Ly90b2tlbi5hY3Rpb25zLmdpdGh1YnVzZXJjb250ZW50LmNvbTCBpgYKKwYBBAGDvzABCQSBlwyBlGh0dHBzOi8vZ2l0aHViLmNvbS9zaWdzdG9yZS1jb25mb3JtYW5jZS9leHRyZW1lbHktZGFuZ2Vyb3VzLXB1YmxpYy1vaWRjLWJlYWNvbi8uZ2l0aHViL3dvcmtmbG93cy9leHRyZW1lbHktZGFuZ2Vyb3VzLW9pZGMtYmVhY29uLnltbEByZWZzL2hlYWRzL21haW4wOAYKKwYBBAGDvzABCgQqDChjN2IzZGZiMzM1ZjA1MWUxYzg2YmRhNGM3MTZmYWM5N2RmNjJhZDgxMB0GCisGAQQBg78wAQsEDwwNZ2l0aHViLWhvc3RlZDBeBgorBgEEAYO/MAEMBFAMTmh0dHBzOi8vZ2l0aHViLmNvbS9zaWdzdG9yZS1jb25mb3JtYW5jZS9leHRyZW1lbHktZGFuZ2Vyb3VzLXB1YmxpYy1vaWRjLWJlYWNvbjA4BgorBgEEAYO/MAENBCoMKGM3YjNkZmIzMzVmMDUxZTFjODZiZGE0YzcxNmZhYzk3ZGY2MmFkODEwHwYKKwYBBAGDvzABDgQRDA9yZWZzL2hlYWRzL21haW4wGQYKKwYBBAGDvzABDwQLDAk2MzI1OTY4OTcwNwYKKwYBBAGDvzABEAQpDCdodHRwczovL2dpdGh1Yi5jb20vc2lnc3RvcmUtY29uZm9ybWFuY2UwGQYKKwYBBAGDvzABEQQLDAkxMzE4MDQ1NjMwgaYGCisGAQQBg78wARIEgZcMgZRodHRwczovL2dpdGh1Yi5jb20vc2lnc3RvcmUtY29uZm9ybWFuY2UvZXh0cmVtZWx5LWRhbmdlcm91cy1wdWJsaWMtb2lkYy1iZWFjb24vLmdpdGh1Yi93b3JrZmxvd3MvZXh0cmVtZWx5LWRhbmdlcm91cy1vaWRjLWJlYWNvbi55bWxAcmVmcy9oZWFkcy9tYWluMDgGCisGAQQBg78wARMEKgwoYzdiM2RmYjMzNWYwNTFlMWM4NmJkYTRjNzE2ZmFjOTdkZjYyYWQ4MTAhBgorBgEEAYO/MAEUBBMMEXdvcmtmbG93X2Rpc3BhdGNoMIGBBgorBgEEAYO/MAEVBHMMcWh0dHBzOi8vZ2l0aHViLmNvbS9zaWdzdG9yZS1jb25mb3JtYW5jZS9leHRyZW1lbHktZGFuZ2Vyb3VzLXB1YmxpYy1vaWRjLWJlYWNvbi9hY3Rpb25zL3J1bnMvODM0NzQ4MTYyOC9hdHRlbXB0cy8xMBYGCisGAQQBg78wARYECAwGcHVibGljMIGKBgorBgEEAdZ5AgQCBHwEegB4AHYA3T0wasbHETJjGR4cmWc3AqJKXrjePK3/h4pygC8p7o4AAAGOV8AHpgAABAMARzBFAiBFeMbpFarlPwb0naTr4mjWDvXApOd9ORqOk36Brt9SmwIhAJJvjor+DXUXr7S3Vm9jVFT3CL0BxcKGj86m5mYzQvubMAoGCCqGSM49BAMDA2gAMGUCMA8lTixdS4iN9mAUduObcSJmhZLyvK7zaX05DLEDCgPWxDHk+JBZUKYRIuHHgwFnOwIxALMamo9dfENMzRgNCzYfp/y+rSOhVjXXE9mCn6BuJETlpRDfGvxUg/5LF9f4lYqozA=="}, "tlogEntries": [{"logIndex": "79571823", "logId": {"keyId": "wNI9atQGlz+VWfO6LRygH4QUfY/8W4RFwiT5i5WRgB0="}, "kindVersion": {"kind": "hashedrekord", "version": "0.0.1"}, "integratedTime": "1710869186", "inclusionPromise": {"signedEntryTimestamp": "MEYCIQDMNM49CNrcrpuvB9G3likdSse0miAkY0ILCqzRGP5ZJQIhAKnSS9GUSFVCar1+Sq3qoRtJIJ8x9tqRnQ8kuS1ojtTH"}, "inclusionProof": {"logIndex": "75408392", "rootHash": "Fnnj13Uu1jdksPc4HZLapKX329dVlD5+MGNsiqBq1XM=", "treeSize": "75408393", "hashes": ["1J7hRIEGvYdAyzEs+GhAE9L+38oHye3BhalgoQRZoo4=", "W/OUCkh/lqDDwbBkZgP7eTV/wx4WifD1wtfRLbavfxI=", "9wya2BEhfLGDfDRVN46OU2RXkozWCM1Z4qMu6SPiWoY=", "ZRs3lKAIlu0t0GtLupAcOu1y20nOaOshSKosWAqFO+w=", "BGqH+LzVuhuqCLiUvBJaB2hlsvtu2a15qq1WGw6mG44=", "OeS7D4kPES7ChE7kWSEmhbAMqBcKVj/z8/afMK4Y3pI=", "JtjqvAqFyXXYjWlZfDzElHpEzdBjsz1LmGFJuYx0kTU=", "s/ZIVcfcD4/nuZwUtQf4ydGsIAkGTPTzk3b0zhUC95k=", "YU1jZY/fp5tJdGF/i+/7ez8107O4/lOUp7acMPFEaOA=", "7Z18YLBAvejEV4nJHIKoks/xlijnhR005qTW2w4QtHg=", "98enzMaC+x5oCMvIZQA5z8vu2apDMCFvE/935NfuPw8="], "checkpoint": {"envelope": "rekor.sigstore.dev - 2605736670972794746\n75408393\nFnnj13Uu1jdksPc4HZLapKX329dVlD5+MGNsiqBq1XM=\n\n— rekor.sigstore.dev wNI9ajBFAiBTyiBM9WtyOTgohje6QZ5rFGJUdMq7Wk3A6oThE98SUgIhAMvxDwa7FyqRqg+YV3rdPPrfS23w19iK+piMSGVOmP5w\n"}}, "canonicalizedBody": "eyJhcGlWZXJzaW9uIjoiMC4wLjEiLCJraW5kIjoiaGFzaGVkcmVrb3JkIiwic3BlYyI6eyJkYXRhIjp7Imhhc2giOnsiYWxnb3JpdGhtIjoic2hhMjU2IiwidmFsdWUiOiJhMGNmYzcxMjcxZDZlMjc4ZTU3Y2QzMzJmZjk1N2MzZjcwNDNmZGRhMzU0YzRjYmIxOTBhMzBkNTZlZmEwMWJmIn19LCJzaWduYXR1cmUiOnsiY29udGVudCI6Ik1FVUNJQ1lGcS80YlRFZGx1cmdxVnVObXdDY0lXdTNOS09DZ3ZlV0FKQmllekowdUFpRUEyaTdVMTgrYVJwRnhMWWtzcjVIS0JRUXkwOHpFMDUwV0ljMFJ6S3VuRElBPSIsInB1YmxpY0tleSI6eyJjb250ZW50IjoiTFMwdExTMUNSVWRKVGlCRFJWSlVTVVpKUTBGVVJTMHRMUzB0Q2sxSlNVbE5WRU5EUWpkbFowRjNTVUpCWjBsVllVd3ZkSE50VVZSSWF6SXhiWFF4VlhWckszYzNZWFpFUW5vMGQwTm5XVWxMYjFwSmVtb3dSVUYzVFhjS1RucEZWazFDVFVkQk1WVkZRMmhOVFdNeWJHNWpNMUoyWTIxVmRWcEhWakpOVWpSM1NFRlpSRlpSVVVSRmVGWjZZVmRrZW1SSE9YbGFVekZ3WW01U2JBcGpiVEZzV2tkc2FHUkhWWGRJYUdOT1RXcFJkMDE2UlRWTlZHTjVUbXBKTWxkb1kwNU5hbEYzVFhwRk5VMVVZM3BPYWtreVYycEJRVTFHYTNkRmQxbElDa3R2V2tsNmFqQkRRVkZaU1V0dldrbDZhakJFUVZGalJGRm5RVVV5TWxNeGFpOU9hMFZZZWtKUVVVRjFZVzFJV0V4d2QzZ3JVbEJ1Ym5wYVVXd3ZjR3NLUlZvNGVHOXlka3R1ZW5WcVExTXhiVlpVUW04NWEwSjRiVmxYYnpKRVNIUjVWbmxtWjI1MVQzRldWSHBNV1cxb2J6WlBRMEowV1hkbloySlRUVUUwUndwQk1WVmtSSGRGUWk5M1VVVkJkMGxJWjBSQlZFSm5UbFpJVTFWRlJFUkJTMEpuWjNKQ1owVkdRbEZqUkVGNlFXUkNaMDVXU0ZFMFJVWm5VVlZHZGpGVENrTjZhVVZMVGpKeVVubHlhbVZXYkVaaVUweG5NUzlSZDBoM1dVUldVakJxUWtKbmQwWnZRVlV6T1ZCd2VqRlphMFZhWWpWeFRtcHdTMFpYYVhocE5Ga0tXa1E0ZDJkaFZVZEJNVlZrUlZGRlFpOTNVMEp0YWtOQ2JEUmhRbXhIYURCa1NFSjZUMms0ZGxveWJEQmhTRlpwVEcxT2RtSlRPWHBoVjJSNlpFYzVlUXBhVXpGcVlqSTFiV0l6U25SWlZ6VnFXbE01YkdWSVVubGFWekZzWWtocmRGcEhSblZhTWxaNVlqTldla3hZUWpGWmJYaHdXWGt4ZG1GWFVtcE1WMHBzQ2xsWFRuWmlhVGgxV2pKc01HRklWbWxNTTJSMlkyMTBiV0pIT1ROamVUbHNaVWhTZVZwWE1XeGlTR3QwV2tkR2RWb3lWbmxpTTFaNlRGYzVjRnBIVFhRS1dXMVdhRmt5T1hWTWJteDBZa1ZDZVZwWFducE1NbWhzV1ZkU2Vrd3lNV2hoVnpSM1QxRlpTMHQzV1VKQ1FVZEVkbnBCUWtGUlVYSmhTRkl3WTBoTk5ncE1lVGt3WWpKMGJHSnBOV2haTTFKd1lqSTFla3h0WkhCa1IyZ3hXVzVXZWxwWVNtcGlNalV3V2xjMU1FeHRUblppVkVGbVFtZHZja0puUlVWQldVOHZDazFCUlVOQ1FrWXpZak5LY2xwdGVIWmtNVGxyWVZoT2QxbFlVbXBoUkVFeVFtZHZja0puUlVWQldVOHZUVUZGUkVKRGFHcE9Na2w2V2tkYWFVMTZUVEVLV21wQk1VMVhWWGhaZW1jeVdXMVNhRTVIVFROTlZGcHRXVmROTlU0eVVtMU9ha3BvV2tSbmVFMURNRWREYVhOSFFWRlJRbWMzT0hkQlVWRkZTREJXTkFwa1NFcHNZbGRXYzJWVFFtdFpWelZ1V2xoS2RtUllUV2RVTUd4RlVYbENhVnBYUm1waU1qUjNVMUZaUzB0M1dVSkNRVWRFZG5wQlFrSlJVVGRqTW14dUNtTXpVblpqYlZWMFdUSTVkVnB0T1hsaVYwWjFXVEpWZGxwWWFEQmpiVlowV2xkNE5VeFhVbWhpYldSc1kyMDVNV041TVhka1YwcHpZVmROZEdJeWJHc0tXWGt4YVZwWFJtcGlNalIzU0ZGWlMwdDNXVUpDUVVkRWRucEJRa0puVVZCamJWWnRZM2s1YjFwWFJtdGplVGwwV1Zkc2RVMUVjMGREYVhOSFFWRlJRZ3BuTnpoM1FWRm5SVXhSZDNKaFNGSXdZMGhOTmt4NU9UQmlNblJzWW1rMWFGa3pVbkJpTWpWNlRHMWtjR1JIYURGWmJsWjZXbGhLYW1JeU5UQmFWelV3Q2t4dFRuWmlWRU5DY0dkWlMwdDNXVUpDUVVkRWRucEJRa05SVTBKc2QzbENiRWRvTUdSSVFucFBhVGgyV2pKc01HRklWbWxNYlU1MllsTTVlbUZYWkhvS1pFYzVlVnBUTVdwaU1qVnRZak5LZEZsWE5XcGFVemxzWlVoU2VWcFhNV3hpU0d0MFdrZEdkVm95Vm5saU0xWjZURmhDTVZsdGVIQlplVEYyWVZkU2FncE1WMHBzV1ZkT2RtSnBPSFZhTW13d1lVaFdhVXd6WkhaamJYUnRZa2M1TTJONU9XeGxTRko1V2xjeGJHSklhM1JhUjBaMVdqSldlV0l6Vm5wTVZ6bHdDbHBIVFhSWmJWWm9XVEk1ZFV4dWJIUmlSVUo1V2xkYWVrd3lhR3haVjFKNlRESXhhR0ZYTkhkUFFWbExTM2RaUWtKQlIwUjJla0ZDUTJkUmNVUkRhR29LVGpKSmVscEhXbWxOZWsweFdtcEJNVTFYVlhoWmVtY3lXVzFTYUU1SFRUTk5WRnB0V1ZkTk5VNHlVbTFPYWtwb1drUm5lRTFDTUVkRGFYTkhRVkZSUWdwbk56aDNRVkZ6UlVSM2QwNWFNbXd3WVVoV2FVeFhhSFpqTTFKc1drUkNaVUpuYjNKQ1owVkZRVmxQTDAxQlJVMUNSa0ZOVkcxb01HUklRbnBQYVRoMkNsb3liREJoU0ZacFRHMU9kbUpUT1hwaFYyUjZaRWM1ZVZwVE1XcGlNalZ0WWpOS2RGbFhOV3BhVXpsc1pVaFNlVnBYTVd4aVNHdDBXa2RHZFZveVZua0tZak5XZWt4WVFqRlpiWGh3V1hreGRtRlhVbXBNVjBwc1dWZE9kbUpxUVRSQ1oyOXlRbWRGUlVGWlR5OU5RVVZPUWtOdlRVdEhUVE5aYWs1cldtMUplZ3BOZWxadFRVUlZlRnBVUm1wUFJGcHBXa2RGTUZsNlkzaE9iVnBvV1hwck0xcEhXVEpOYlVaclQwUkZkMGgzV1V0TGQxbENRa0ZIUkhaNlFVSkVaMUZTQ2tSQk9YbGFWMXA2VERKb2JGbFhVbnBNTWpGb1lWYzBkMGRSV1V0TGQxbENRa0ZIUkhaNlFVSkVkMUZNUkVGck1rMTZTVEZQVkZrMFQxUmpkMDUzV1VzS1MzZFpRa0pCUjBSMmVrRkNSVUZSY0VSRFpHOWtTRkozWTNwdmRrd3laSEJrUjJneFdXazFhbUl5TUhaak1teHVZek5TZG1OdFZYUlpNamwxV20wNWVRcGlWMFoxV1RKVmQwZFJXVXRMZDFsQ1FrRkhSSFo2UVVKRlVWRk1SRUZyZUUxNlJUUk5SRkV4VG1wTmQyZGhXVWREYVhOSFFWRlJRbWMzT0hkQlVrbEZDbWRhWTAxbldsSnZaRWhTZDJONmIzWk1NbVJ3WkVkb01WbHBOV3BpTWpCMll6SnNibU16VW5aamJWVjBXVEk1ZFZwdE9YbGlWMFoxV1RKVmRscFlhREFLWTIxV2RGcFhlRFZNVjFKb1ltMWtiR050T1RGamVURjNaRmRLYzJGWFRYUmlNbXhyV1hreGFWcFhSbXBpTWpSMlRHMWtjR1JIYURGWmFUa3pZak5LY2dwYWJYaDJaRE5OZGxwWWFEQmpiVlowV2xkNE5VeFhVbWhpYldSc1kyMDVNV041TVhaaFYxSnFURmRLYkZsWFRuWmlhVFUxWWxkNFFXTnRWbTFqZVRsdkNscFhSbXRqZVRsMFdWZHNkVTFFWjBkRGFYTkhRVkZSUW1jM09IZEJVazFGUzJkM2IxbDZaR2xOTWxKdFdXcE5lazVYV1hkT1ZFWnNUVmROTkU1dFNtc0tXVlJTYWs1NlJUSmFiVVpxVDFSa2ExcHFXWGxaVjFFMFRWUkJhRUpuYjNKQ1owVkZRVmxQTDAxQlJWVkNRazFOUlZoa2RtTnRkRzFpUnpreldESlNjQXBqTTBKb1pFZE9iMDFKUjBKQ1oyOXlRbWRGUlVGWlR5OU5RVVZXUWtoTlRXTlhhREJrU0VKNlQyazRkbG95YkRCaFNGWnBURzFPZG1KVE9YcGhWMlI2Q21SSE9YbGFVekZxWWpJMWJXSXpTblJaVnpWcVdsTTViR1ZJVW5sYVZ6RnNZa2hyZEZwSFJuVmFNbFo1WWpOV2VreFlRakZaYlhod1dYa3hkbUZYVW1vS1RGZEtiRmxYVG5aaWFUbG9XVE5TY0dJeU5YcE1NMG94WW01TmRrOUVUVEJPZWxFMFRWUlplVTlET1doa1NGSnNZbGhDTUdONU9IaE5RbGxIUTJselJ3cEJVVkZDWnpjNGQwRlNXVVZEUVhkSFkwaFdhV0pIYkdwTlNVZExRbWR2Y2tKblJVVkJaRm8xUVdkUlEwSklkMFZsWjBJMFFVaFpRVE5VTUhkaGMySklDa1ZVU21wSFVqUmpiVmRqTTBGeFNrdFljbXBsVUVzekwyZzBjSGxuUXpod04yODBRVUZCUjA5V09FRkljR2RCUVVKQlRVRlNla0pHUVdsQ1JtVk5ZbkFLUm1GeWJGQjNZakJ1WVZSeU5HMXFWMFIyV0VGd1QyUTVUMUp4VDJzek5rSnlkRGxUYlhkSmFFRktTblpxYjNJclJGaFZXSEkzVXpOV2JUbHFWa1pVTXdwRFREQkNlR05MUjJvNE5tMDFiVmw2VVhaMVlrMUJiMGREUTNGSFUwMDBPVUpCVFVSQk1tZEJUVWRWUTAxQk9HeFVhWGhrVXpScFRqbHRRVlZrZFU5aUNtTlRTbTFvV2t4NWRrczNlbUZZTURWRVRFVkVRMmRRVjNoRVNHc3JTa0phVlV0WlVrbDFTRWhuZDBadVQzZEplRUZNVFdGdGJ6bGtaa1ZPVFhwU1owNEtRM3BaWm5BdmVTdHlVMDlvVm1wWVdFVTViVU51TmtKMVNrVlViSEJTUkdaSGRuaFZaeTgxVEVZNVpqUnNXWEZ2ZWtFOVBRb3RMUzB0TFVWT1JDQkRSVkpVU1VaSlEwRlVSUzB0TFMwdENnPT0ifX19fQ=="}]}, "messageSignature": {"messageDigest": {"algorithm": "SHA2_256", "digest": "oM/HEnHW4njlfNMy/5V8P3BD/do1TEy7GQow1W76Ab8="}, "signature": "MEUCICYFq/4bTEdlurgqVuNmwCcIWu3NKOCgveWAJBiezJ0uAiEA2i7U18+aRpFxLYksr5HKBQQy08zE050WIc0RzKunDIA="}}''';
