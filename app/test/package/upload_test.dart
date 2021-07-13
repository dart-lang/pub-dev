// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/admin/backend.dart';
import 'package:pub_dev/audit/backend.dart';
import 'package:pub_dev/audit/models.dart';
import 'package:pub_dev/fake/backend/fake_email_sender.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/package/name_tracker.dart';
import 'package:pub_dev/package/upload_signer_service.dart';
import 'package:pub_dev/service/secret/backend.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_dev/tool/test_profile/models.dart';

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
        await accountBackend.withBearerToken(userAtPubDevAuthToken, () async {
          final info = await packageBackend.startUpload(redirectUri);
          expect(info.url, startsWith('http://localhost:'));
          expect(info.url, contains('/fake-bucket-pub/tmp/'));
          expect(info.fields, {
            'key': startsWith('fake-bucket-pub/tmp/'),
            'success_action_redirect': startsWith('$redirectUri?upload_id='),
          });
        });
      });
    });

    group('packageBackend.publishUploadedBlob', () {
      final uploadId = 'my-uuid';

      testWithProfile('uploaded zero-length file', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          // create empty file
          await tarballStorage.bucket.write('tmp/$uploadId').close();

          final rs = packageBackend.publishUploadedBlob(uploadId);
          await expectLater(
            rs,
            throwsA(
              isA<PackageRejectedException>().having(
                  (e) => '$e', 'text', contains('Package archive is empty')),
            ),
          );
        });
      });

      testWithProfile('upload-too-big', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final chunk = List.filled(1024 * 1024, 42);
          final chunkCount = UploadSignerService.maxUploadSize ~/ chunk.length;
          final bigTarball = <List<int>>[];
          for (int i = 0; i < chunkCount; i++) {
            bigTarball.add(chunk);
          }
          // Add one more byte than allowed.
          bigTarball.add([1]);

          final sink = tarballStorage.bucket.write('tmp/$uploadId');
          bigTarball.forEach(sink.add);
          await sink.close();

          final rs = packageBackend.publishUploadedBlob(uploadId);
          await expectLater(
            rs,
            throwsA(
              isA<PackageRejectedException>().having(
                  (e) => '$e', 'text', contains('Package archive exceeded ')),
            ),
          );
        });
      });

      testWithProfile('successful new package', fn: () async {
        await accountBackend.withBearerToken(userAtPubDevAuthToken, () async {
          final user =
              await accountBackend.lookupOrCreateUserByEmail('user@pub.dev');
          final dateBeforeTest = DateTime.now().toUtc();
          final pubspecContent = generatePubspecYaml('new_package', '1.2.3');
          await tarballStorage.bucket.writeBytes('tmp/$uploadId',
              await packageArchiveBytes(pubspecContent: pubspecContent));

          final version = await packageBackend.publishUploadedBlob(uploadId);
          expect(version.package, 'new_package');
          expect(version.version, '1.2.3');

          final pkgKey =
              dbService.emptyKey.append(Package, id: version.package);
          final package = (await dbService.lookup<Package>([pkgKey])).single!;
          expect(package.name, 'new_package');
          expect(package.latestVersion, '1.2.3');
          expect(package.uploaders, [user.userId]);
          expect(package.publisherId, isNull);
          expect(package.created!.compareTo(dateBeforeTest) >= 0, isTrue);
          expect(package.updated!.compareTo(dateBeforeTest) >= 0, isTrue);

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
          expect(
              email.bodyText,
              contains(
                  'https://pub.dev/packages/new_package/versions/1.2.3\n'));

          final audits = await auditBackend.listRecordsForPackageVersion(
              'new_package', '1.2.3');
          final publishedAudit = audits.first;
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
          final readme =
              assets.firstWhere((pva) => pva.kind == AssetKind.readme);
          expect(readme.path, 'README.md');
          expect(readme.textContent, foobarReadmeContent);
          final changelog =
              assets.firstWhere((pva) => pva.kind == AssetKind.changelog);
          expect(changelog.path, 'CHANGELOG.md');
          expect(changelog.textContent, foobarChangelogContent);
        });
      });

      testWithProfile('package under publisher', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final user =
              await accountBackend.lookupOrCreateUserByEmail('admin@pub.dev');
          final dateBeforeTest = DateTime.now().toUtc();
          final pubspecContent = generatePubspecYaml('neon', '7.0.0');
          await tarballStorage.bucket.writeBytes('tmp/$uploadId',
              await packageArchiveBytes(pubspecContent: pubspecContent));

          final version = await packageBackend.publishUploadedBlob(uploadId);
          expect(version.package, 'neon');
          expect(version.version, '7.0.0');

          final pkgKey =
              dbService.emptyKey.append(Package, id: version.package);
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
          final publishedAudit = audits.first;
          expect(publishedAudit.kind, AuditLogRecordKind.packagePublished);
          expect(publishedAudit.summary,
              'Package `neon` version `7.0.0` was published by `admin@pub.dev`.');
          expect(publishedAudit.publishers, []);

          final assets = await dbService
              .query<PackageVersionAsset>()
              .run()
              .where((pva) => pva.qualifiedVersionKey == pv.qualifiedVersionKey)
              .toList();
          final readme =
              assets.firstWhere((pva) => pva.kind == AssetKind.readme);
          expect(readme.path, 'README.md');
          expect(readme.textContent, foobarReadmeContent);
          final changelog =
              assets.firstWhere((pva) => pva.kind == AssetKind.changelog);
          expect(changelog.path, 'CHANGELOG.md');
          expect(changelog.textContent, foobarChangelogContent);
        });
      });
    });

    group('packageBackend.upload', () {
      testWithProfile('not logged in', fn: () async {
        final tarball = await packageArchiveBytes(pubspecContent: '');
        final rs = packageBackend.upload(Stream.fromIterable([tarball]));
        await expectLater(rs, throwsA(isA<AuthenticationException>()));
      });

      testWithProfile('not authorized', fn: () async {
        await accountBackend.withBearerToken(userAtPubDevAuthToken, () async {
          final tarball = await packageArchiveBytes(
              pubspecContent: generatePubspecYaml('oxygen', '2.2.0'));
          final rs = packageBackend.upload(Stream.fromIterable([tarball]));
          await expectLater(rs, throwsA(isA<AuthorizationException>()));
        });
      });

      testWithProfile('user is blocked', fn: () async {
        final user =
            await accountBackend.lookupOrCreateUserByEmail('user@pub.dev');
        await dbService.commit(inserts: [user..isBlocked = true]);
        await accountBackend.withBearerToken(userAtPubDevAuthToken, () async {
          final tarball = await packageArchiveBytes(
              pubspecContent: generatePubspecYaml('pkg', '1.2.3'));
          final rs = packageBackend.upload(Stream.fromIterable([tarball]));
          await expectLater(rs, throwsA(isA<AuthorizationException>()));
        });
      });

      testWithProfile('upload restriction - no uploads', fn: () async {
        await secretBackend.update(SecretKey.uploadRestriction, 'no-uploads');
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final tarball = await packageArchiveBytes(
              pubspecContent: generatePubspecYaml('oxygen', '2.3.0'));
          final rs = packageBackend.upload(Stream.fromIterable([tarball]));
          await expectLater(
              rs,
              throwsA(isA<PackageRejectedException>().having(
                (e) => '$e',
                'text',
                contains('Uploads are restricted. Please try again later.'),
              )));
        });
      });

      testWithProfile('upload restriction - no new packages', fn: () async {
        await secretBackend.update(SecretKey.uploadRestriction, 'only-updates');
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final tarball = await packageArchiveBytes(
              pubspecContent: generatePubspecYaml('some_new_package', '1.2.3'));
          final rs = packageBackend.upload(Stream.fromIterable([tarball]));
          await expectLater(
              rs,
              throwsA(isA<PackageRejectedException>().having(
                (e) => '$e',
                'text',
                contains('Uploads are restricted. Please try again later.'),
              )));
        });
      });

      testWithProfile('upload restriction - update is accepted', fn: () async {
        await secretBackend.update(SecretKey.uploadRestriction, 'only-updates');
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final tarball = await packageArchiveBytes(
              pubspecContent: generatePubspecYaml('oxygen', '3.4.5'));
          final rs =
              await packageBackend.upload(Stream.fromIterable([tarball]));
          expect(rs.package, 'oxygen');
        });
      });

      testWithProfile('versions already exist', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final tarball = await packageArchiveBytes(
              pubspecContent: generatePubspecYaml('neon', '1.0.0'));
          final rs = packageBackend.upload(Stream.fromIterable([tarball]));
          await expectLater(
              rs,
              throwsA(isA<Exception>().having(
                (e) => '$e',
                'text',
                contains('Version 1.0.0 of package neon already exists'),
              )));
        });
      });

      // Returns the error message as String or null if it succeeded.
      Future<String?> fn(String name) async {
        final pubspecContent = generatePubspecYaml(name, '0.2.0');
        try {
          final tarball =
              await packageArchiveBytes(pubspecContent: pubspecContent);
          await packageBackend.upload(Stream.fromIterable([tarball]));
        } catch (e) {
          return e.toString();
        }
        // no issues, return null
        return null;
      }

      testWithProfile('bad package names are rejected', fn: () async {
        await nameTracker.scanDatastore();
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
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
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          expect(await fn('ox_ygen'),
              'PackageRejected(400): Package name is too similar to another active or moderated package.');

          expect(await fn('ox_y_ge_n'),
              'PackageRejected(400): Package name is too similar to another active or moderated package.');
        });
      });

      testWithProfile('moderated package names are rejected', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          await adminBackend.removePackage('neon');
          await nameTracker.scanDatastore();

          expect(await fn('neon'),
              'PackageRejected(400): Package name is too similar to another active or moderated package.');

          expect(await fn('ne_on'),
              'PackageRejected(400): Package name is too similar to another active or moderated package.');
        });
      });

      testWithProfile('bad yaml file: duplicate key', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final tarball = await packageArchiveBytes(
              pubspecContent:
                  'name: xyz\n' + generatePubspecYaml('xyz', '1.0.0'));
          final rs = packageBackend.upload(Stream.fromIterable([tarball]));
          await expectLater(
              rs,
              throwsA(isA<PackageRejectedException>().having(
                (e) => '$e',
                'text',
                contains('Duplicate mapping key.'),
              )));
        });
      });

      testWithProfile('bad pubspec content: bad version', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final tarball = await packageArchiveBytes(
              pubspecContent: generatePubspecYaml('xyz', 'not-a-version'));
          final rs = packageBackend.upload(Stream.fromIterable([tarball]));
          await expectLater(
              rs,
              throwsA(isA<PackageRejectedException>().having(
                (e) => '$e',
                'text',
                contains(
                    'Unsupported value for "version". Could not parse "not-a-version".'),
              )));
        });
      });

      testWithProfile('has git dependency', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final tarball = await packageArchiveBytes(
              pubspecContent: generatePubspecYaml('xyz', '1.0.0') +
                  '  abcd:\n'
                      '    git:\n'
                      '      url: git://github.com/a/b\n'
                      '      path: x/y/z\n');
          final rs = packageBackend.upload(Stream.fromIterable([tarball]));
          await expectLater(
              rs,
              throwsA(isA<PackageRejectedException>().having(
                (e) => '$e',
                'text',
                contains('is a git dependency'),
              )));
        });
      });

      testWithProfile('upload-too-big', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final oneKB = List.filled(1024, 42);
          final List<List<int>> bigTarball = [];
          for (int i = 0; i < UploadSignerService.maxUploadSize ~/ 1024; i++) {
            bigTarball.add(oneKB);
          }
          // Add one more byte than allowed.
          bigTarball.add([1]);

          final rs = packageBackend.upload(Stream.fromIterable(bigTarball));
          await expectLater(
            rs,
            throwsA(
              isA<PackageRejectedException>().having(
                  (e) => '$e', 'text', contains('Package archive exceeded ')),
            ),
          );
        });
      });

      testWithProfile('successful update + download', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final tarball = await packageArchiveBytes(
              pubspecContent: generatePubspecYaml('oxygen', '3.0.0'));
          final version =
              await packageBackend.upload(Stream.fromIterable([tarball]));
          expect(version.package, 'oxygen');
          expect(version.version, '3.0.0');

          expect(fakeEmailSender.sentMessages, hasLength(1));
          final email = fakeEmailSender.sentMessages.single;
          expect(email.recipients.single.email, 'admin@pub.dev');
          expect(email.subject, 'Package uploaded: oxygen 3.0.0');
          expect(email.bodyText,
              contains('https://pub.dev/packages/oxygen/versions/3.0.0\n'));

          final pkgPage = await packageBackend.latestPackages();
          expect(pkgPage.packages.first.name, 'oxygen');
          expect(pkgPage.packages.first.latestVersion, '3.0.0');

          final stream = packageBackend.download('oxygen', '3.0.0');
          final chunks = await stream.toList();
          final bytes = chunks.fold<List<int>>(
              <int>[], (buffer, chunk) => buffer..addAll(chunk));
          expect(bytes, tarball);
        });
      });
    });
  });

  group('other limits', () {
    testWithProfile(
      'max versions',
      testProfile: TestProfile(
        defaultUser: 'admin@pub.dev',
        packages: <TestPackage>[
          TestPackage(
              name: 'busy_pkg', versions: List.generate(100, (i) => '1.0.$i')),
        ],
      ),
      fn: () async {
        registerPackageBackend(PackageBackend(
          dbService,
          tarballStorage,
          maxVersionsPerPackageOverride: 100,
        ));
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final tarball = await packageArchiveBytes(
              pubspecContent: generatePubspecYaml('busy_pkg', '2.0.0'));
          final rs = packageBackend.upload(Stream.fromIterable([tarball]));
          await expectLater(
              rs,
              throwsA(isA<PackageRejectedException>().having(
                (e) => '$e',
                'text',
                contains('has reached the maximum version limit of'),
              )));
        });
      },
      timeout: Timeout.factor(1.5),
    );
  });
}
