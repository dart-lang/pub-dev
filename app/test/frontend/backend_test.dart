// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@Timeout(Duration(seconds: 15))
library pub_dartlang_org.backend_test;

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:pub_server/repository.dart' as pub_server;
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import 'package:pub_dartlang_org/account/backend.dart';
import 'package:pub_dartlang_org/frontend/backend.dart';
import 'package:pub_dartlang_org/frontend/email_sender.dart';
import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/upload_signer_service.dart';
import 'package:pub_dartlang_org/history/backend.dart';
import 'package:pub_dartlang_org/history/models.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/dartdoc_client.dart';

import '../shared/utils.dart';

import 'backend_test_utils.dart';
import 'mocks.dart';
import 'utils.dart';

// TODO: Add missing tests when a query returns more than one result.
void main() {
  group('backend', () {
    group('Backend.latestPackages', () {
      (<String, List<Package>>{
        'one package': [testPackage],
        'empty': [],
      })
          .forEach((String testName, List<Package> expectedPackages) {
        test(testName, () async {
          final completion = TestDelayCompletion();
          Stream<Package> queryRunFun(
              {partition,
              ancestorKey,
              filters,
              filterComparisonObjects,
              offset,
              limit,
              orders}) {
            completion.complete();
            expect(offset, 4);
            expect(limit, 9);
            expect(orders, ['-updated']);
            return Stream.fromIterable(expectedPackages);
          }

          final db = DatastoreDBMock(queryMock: QueryMock(queryRunFun));
          final backend = Backend(db, null);

          final packages = await backend.latestPackages(offset: 4, limit: 9);
          expect(packages, equals(expectedPackages));
        });
      });
    });

    group('Backend.latestPackageVersions', () {
      test('one package', () async {
        final completion = TestDelayCompletion();
        Stream<Package> queryRunFun(
            {partition,
            ancestorKey,
            filters,
            filterComparisonObjects,
            offset,
            limit,
            orders}) {
          completion.complete();
          expect(offset, 4);
          expect(limit, 9);
          expect(orders, ['-updated']);
          return Stream.fromIterable([testPackage]);
        }

        List<PackageVersion> lookupFun(keys) {
          expect(keys, hasLength(1));
          expect(keys.first, testPackage.latestVersionKey);
          return [testPackageVersion];
        }

        final db = DatastoreDBMock(
            queryMock: QueryMock(queryRunFun),
            lookupFun: expectAsync1(lookupFun));
        final backend = Backend(db, null);

        final versions =
            await backend.latestPackageVersions(offset: 4, limit: 9);
        expect(versions, hasLength(1));
        expect(versions.first, equals(testPackageVersion));
      });

      test('empty', () async {
        final completion = TestDelayCompletion();
        Stream<Package> queryRunFun(
            {partition,
            ancestorKey,
            filters,
            filterComparisonObjects,
            offset,
            limit,
            orders}) {
          completion.complete();
          expect(offset, 4);
          expect(limit, 9);
          expect(orders, ['-updated']);
          return Stream.fromIterable(<Package>[]);
        }

        List lookupFun(keys) {
          expect(keys, hasLength(0));
          return [];
        }

        final db = DatastoreDBMock(
            queryMock: QueryMock(queryRunFun),
            lookupFun: expectAsync1(lookupFun));
        final backend = Backend(db, null);

        final versions =
            await backend.latestPackageVersions(offset: 4, limit: 9);
        expect(versions, hasLength(0));
      });
    });

    group('Backend.lookupPackage', () {
      (<String, List<Package>>{
        'exists': [testPackage],
        'does not exist': [null],
      })
          .forEach((String testName, List<Package> expectedPackages) {
        test(testName, () async {
          List<Package> lookupFun(List<Key> keys) {
            expect(keys, hasLength(1));
            expect(keys.first.type, Package);
            expect(keys.first.id, 'foobar');
            return expectedPackages;
          }

          final db = DatastoreDBMock(lookupFun: expectAsync1(lookupFun));
          final backend = Backend(db, null);

          final package = await backend.lookupPackage('foobar');
          expect(package, equals(expectedPackages.first));
        });
      });
    });

    group('Backend.lookupPackageVersion', () {
      (<String, List<PackageVersion>>{
        'exists': [testPackageVersion],
        'does not exist': [null],
      })
          .forEach((String testName, List<PackageVersion> expectedVersions) {
        test(testName, () async {
          List<PackageVersion> lookupFun(List<Key> keys) {
            expect(keys, hasLength(1));
            expect(keys.first, testPackageVersion.key);
            return expectedVersions;
          }

          final db = DatastoreDBMock(lookupFun: expectAsync1(lookupFun));
          final backend = Backend(db, null);

          final version = await backend.lookupPackageVersion(
              testPackageVersion.package, testPackageVersion.version);
          expect(version, equals(expectedVersions.first));
        });
      });
    });

    group('Backend.lookupLatestVersions', () {
      (<String, List<PackageVersion>>{
        'one version': [testPackageVersion],
        'empty': [null],
      })
          .forEach((String testName, List<PackageVersion> expectedVersions) {
        test(testName, () async {
          List<PackageVersion> lookupFun(List<Key> keys) {
            expect(keys, hasLength(1));
            expect(keys.first, testPackageVersion.key);
            return expectedVersions;
          }

          final db = DatastoreDBMock(lookupFun: expectAsync1(lookupFun));
          final backend = Backend(db, null);

          final versions = await backend.lookupLatestVersions([testPackage]);
          expect(versions, hasLength(1));
          expect(versions.first, equals(expectedVersions.first));
        });
      });
    });

    group('Backend.versionsOfPackage', () {
      (<String, List<PackageVersion>>{
        'one version': [testPackageVersion],
        'empty': [null],
      })
          .forEach((String testName, List<PackageVersion> expectedVersions) {
        test(testName, () async {
          final completion = TestDelayCompletion();
          Stream<PackageVersion> queryRunFun(
              {partition,
              ancestorKey,
              filters,
              filterComparisonObjects,
              offset,
              limit,
              orders}) {
            completion.complete();
            expect(ancestorKey, testPackage.key);
            return Stream.fromIterable(expectedVersions);
          }

          final db = DatastoreDBMock(queryMock: QueryMock(queryRunFun));
          final backend = Backend(db, null);

          final versions = await backend.versionsOfPackage(testPackage.name);
          expect(versions, hasLength(1));
          expect(versions.first, equals(expectedVersions.first));
        });
      });
    });

    test('Backend.downloadUrl', () async {
      final db = DatastoreDBMock();
      final tarballStorage =
          TarballStorageMock(downloadUrlFun: expectAsync2((package, version) {
        expect(package, 'foobar');
        expect(version, '0.1.0');
        return Uri.parse('http://blob/foobar/0.1.0.tar.gz');
      }));
      final backend = Backend(db, tarballStorage);

      final url = await backend.downloadUrl('foobar', '0.1.0');
      expect(url.toString(), 'http://blob/foobar/0.1.0.tar.gz');
    });
  });

  group('backend.repository', () {
    group('GCloudRepository.addUploader', () {
      scopedTest('not logged in', () async {
        final db = DatastoreDBMock();
        final tarballStorage = TarballStorageMock();
        final repo = GCloudPackageRepository(db, tarballStorage);

        final pkg = testPackage.name;
        await repo.addUploader(pkg, 'a@b.com').catchError(expectAsync2((e, _) {
          expect(e is pub_server.UnauthorizedAccessException, isTrue);
        }));
      });

      scopedTest('not authorized', () async {
        final lookupFn = (keys) async {
          expect(keys, hasLength(1));
          expect(keys.first, testPackage.key);
          return [testPackage];
        };
        final db = DatastoreDBMock(
          lookupFun: lookupFn,
        );
        final tarballStorage = TarballStorageMock();
        final repo = GCloudPackageRepository(db, tarballStorage);

        final pkg = testPackage.name;
        registerAuthenticatedUser(
            AuthenticatedUser('uuid-foo-at-bar-dot-com', 'foo@bar.com'));
        final Future f = repo.addUploader(pkg, 'a@b.com');
        await f.catchError(expectAsync2((e, _) {
          expect(e.toString(),
              'UnauthorizedAccess: Calling user does not have permission to change uploaders.');
        }));
      });

      scopedTest('package does not exist', () async {
        final lookupFn = (keys) async {
          expect(keys, hasLength(1));
          expect(keys.first, testPackage.key);
          return [null];
        };
        final db = DatastoreDBMock(
          lookupFun: lookupFn,
        );
        final tarballStorage = TarballStorageMock();
        final repo = GCloudPackageRepository(db, tarballStorage);

        final pkg = testPackage.name;
        registerAuthenticatedUser(testUploaderUser);
        final f = repo.addUploader(pkg, 'a@b.com');
        await f.catchError(expectAsync2((e, _) {
          expect(e.toString(), 'Package "null" does not exist');
        }));
      });

      Future testAlreadyExists(AuthenticatedUser user,
          List<AuthenticatedUser> uploaders, String newUploader) async {
        final testPackage = createTestPackage(uploaders: uploaders);
        final db = DatastoreDBMock(
          lookupFun: expectAsync1((keys) async {
            expect(keys, hasLength(1));
            expect(keys.first, testPackage.key);
            return [testPackage];
          }),
        );
        final tarballStorage = TarballStorageMock();
        final repo = GCloudPackageRepository(db, tarballStorage);

        final pkg = testPackage.name;
        registerAuthenticatedUser(user);
        registerAccountBackend(
            AccountBackendMock(authenticatedUsers: uploaders));
        await repo.addUploader(pkg, newUploader);
      }

      test('already exists', () async {
        final foo = AuthenticatedUser('uuid-foo-at-b-com', 'foo@b.com');
        final bar = AuthenticatedUser('uuid-bar-at-b-com', 'bar@b.com');
        await scoped(() => testAlreadyExists(foo, [foo], 'foo@b.com'));
        await scoped(() => testAlreadyExists(foo, [foo], 'foo@B.com'));
        await scoped(() => testAlreadyExists(foo, [foo, bar], 'foo@B.com'));
        await scoped(() => testAlreadyExists(foo, [bar, foo], 'foo@B.com'));
      });

      Future testSuccessful(AuthenticatedUser user,
          List<AuthenticatedUser> uploaders, String newUploader) async {
        final testPackage = createTestPackage(uploaders: uploaders);
        registerHistoryBackend(HistoryBackendMock());
        final db = DatastoreDBMock(
          lookupFun: expectAsync1((keys) {
            expect(keys, hasLength(1));
            expect(keys.first, testPackage.key);
            return [testPackage];
          }),
        );
        final tarballStorage = TarballStorageMock();
        final repo = GCloudPackageRepository(db, tarballStorage);
        registerAccountBackend(
            AccountBackendMock(authenticatedUsers: uploaders));

        registerBackend(BackendMock(updatePackageInviteFn: (
            {packageName, type, recipientEmail, fromUserId, fromEmail}) async {
          return InviteStatus(urlNonce: 'abc1234');
        }));
        registerEmailSender(EmailSenderMock());

        final pkg = testPackage.name;
        registerAuthenticatedUser(user);
        final f = repo.addUploader(pkg, newUploader);
        await f.catchError(expectAsync2((e, _) {
          expect(
              e.toString(),
              'We have sent an invitation to $newUploader, '
              'they will be added as uploader after they confirm it.');
        }));
      }

      test('successful', () async {
        final foo = AuthenticatedUser('uuid-foo-at-b-com', 'foo@b.com');
        final bar = AuthenticatedUser('uuid-bar-at-b-com', 'bar@b.com');
        await scoped(() => testSuccessful(foo, [foo], 'bar@b.com'));
        await scoped(() => testSuccessful(foo, [foo, bar], 'baz@b.com'));
      });
    });

    group('GCloudRepository.removeUploader', () {
      scopedTest('not logged in', () async {
        final db = DatastoreDBMock();
        final tarballStorage = TarballStorageMock();
        final repo = GCloudPackageRepository(db, tarballStorage);

        final pkg = testPackage.name;
        final f = repo.removeUploader(pkg, 'a@b.com');
        await f.catchError(expectAsync2((e, _) {
          expect(e is pub_server.UnauthorizedAccessException, isTrue);
        }));
      });

      scopedTest('not authorized', () async {
        final transactionMock = TransactionMock(
            lookupFun: expectAsync1((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, testPackage.key);
              return [testPackage];
            }),
            rollbackFun: expectAsync0(() {}));
        final db = DatastoreDBMock(transactionMock: transactionMock);
        final tarballStorage = TarballStorageMock();
        final repo = GCloudPackageRepository(db, tarballStorage);

        final pkg = testPackage.name;
        registerAuthenticatedUser(
            AuthenticatedUser('uuid-foo-at-bar-dot-com', 'foo@bar.com'));
        final f = repo.removeUploader(pkg, 'a@b.com');
        await f.catchError(expectAsync2((e, _) {
          expect(e is pub_server.UnauthorizedAccessException, isTrue);
        }));
      });

      scopedTest('package does not exist', () async {
        final transactionMock = TransactionMock(
            lookupFun: expectAsync1((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, testPackage.key);
              return [null];
            }),
            rollbackFun: expectAsync0(() {}));
        final db = DatastoreDBMock(transactionMock: transactionMock);
        final tarballStorage = TarballStorageMock();
        final repo = GCloudPackageRepository(db, tarballStorage);

        final pkg = testPackage.name;
        registerAuthenticatedUser(testUploaderUser);
        final f = repo.removeUploader(pkg, 'a@b.com');
        await f.catchError(expectAsync2((e, _) {
          expect('$e', equals('Package "null" does not exist'));
        }));
      });

      scopedTest('cannot remove last uploader', () async {
        final testPackage = createTestPackage();
        final transactionMock = TransactionMock(
            lookupFun: expectAsync1((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, testPackage.key);
              return [testPackage];
            }),
            rollbackFun: expectAsync0(() {}));
        final db = DatastoreDBMock(transactionMock: transactionMock);
        final tarballStorage = TarballStorageMock();
        final repo = GCloudPackageRepository(db, tarballStorage);

        final pkg = testPackage.name;
        registerAuthenticatedUser(testUploaderUser);
        registerAccountBackend(
            AccountBackendMock(authenticatedUsers: [testUploaderUser]));
        await repo
            .removeUploader(pkg, testUploaderUser.email)
            .catchError(expectAsync2((e, _) {
          expect(e is pub_server.LastUploaderRemoveException, isTrue);
        }));
      });

      scopedTest('cannot remove non-existent uploader', () async {
        final transactionMock = TransactionMock(
            lookupFun: expectAsync1((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, testPackage.key);
              return [testPackage];
            }),
            rollbackFun: expectAsync0(() {}));
        final db = DatastoreDBMock(transactionMock: transactionMock);
        final tarballStorage = TarballStorageMock();
        final repo = GCloudPackageRepository(db, tarballStorage);

        final pkg = testPackage.name;
        registerAuthenticatedUser(testUploaderUser);
        registerAccountBackend(AccountBackendMock());
        await repo
            .removeUploader(pkg, 'foo2@bar.com')
            .catchError(expectAsync2((e, _) {
          expect('$e', 'The uploader to remove does not exist.');
        }));
      });

      scopedTest('cannot remove self', () async {
        final foo1 = AuthenticatedUser('uuid-foo1', 'foo1@bar.com');
        final foo2 = AuthenticatedUser('uuid-foo2', 'foo2@bar.com');
        final testPackage = createTestPackage(uploaders: [foo1, foo2]);
        final transactionMock = TransactionMock(
            lookupFun: expectAsync1((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, testPackage.key);
              return [testPackage];
            }),
            rollbackFun: expectAsync0(() {}));
        final db = DatastoreDBMock(transactionMock: transactionMock);
        final tarballStorage = TarballStorageMock();
        final repo = GCloudPackageRepository(db, tarballStorage);

        final pkg = testPackage.name;
        registerAuthenticatedUser(foo1);
        registerAccountBackend(AccountBackendMock(authenticatedUsers: [foo1]));
        await repo
            .removeUploader(pkg, 'foo1@bar.com')
            .catchError(expectAsync2((e, _) {
          expect('$e',
              'Self-removal is not allowed. Use another account to remove this e-mail address.');
        }));
      });

      scopedTest('successful', () async {
        final userA = AuthenticatedUser('uuid-a', 'a@x.com');
        final userB = AuthenticatedUser('uuid-b', 'b@x.com');
        final testPackage = createTestPackage(uploaders: [userA, userB]);
        registerHistoryBackend(HistoryBackendMock());
        final completion = TestDelayCompletion();
        final transactionMock = TransactionMock(
            lookupFun: expectAsync1((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, testPackage.key);
              return [testPackage];
            }),
            queueMutationFun: ({inserts, deletes}) {
              expect(inserts, hasLength(2));
              expect(inserts.first.uploaders.contains('uuid-b'), isFalse);
              expect(inserts[1] is History, isTrue);
              completion.complete();
            },
            commitFun: expectAsync0(() {}));
        final db = DatastoreDBMock(transactionMock: transactionMock);
        final tarballStorage = TarballStorageMock();
        final repo = GCloudPackageRepository(db, tarballStorage);

        final pkg = testPackage.name;
        registerAuthenticatedUser(userA);
        registerAccountBackend(
            AccountBackendMock(authenticatedUsers: [userA, userB]));
        await repo.removeUploader(pkg, 'b@x.com');
      });
    });

    group('GCloudRepository.downloadUrl', () {
      test('successful', () async {
        final tarballStorage =
            TarballStorageMock(downloadUrlFun: expectAsync2((package, version) {
          return Uri.parse('http://blobstore/$package/$version.tar.gz');
        }));
        final repo = GCloudPackageRepository(null, tarballStorage);

        final url = await repo.downloadUrl('foo', '0.1.0');
        expect('$url', 'http://blobstore/foo/0.1.0.tar.gz');
      });
    });

    group('GCloudRepository.download', () {
      test('successful', () async {
        final tarballStorage =
            TarballStorageMock(downloadFun: expectAsync2((package, version) {
          return Stream.fromIterable([
            [1, 2, 3]
          ]);
        }));
        final repo = GCloudPackageRepository(null, tarballStorage);

        final stream = await repo.download('foo', '0.1.0');
        final data = await stream.fold([], (b, d) => b..addAll(d));
        expect(data, [1, 2, 3]);
      });
    });

    group('GCloudRepository.lookupVersion', () {
      test('not found', () async {
        final db = DatastoreDBMock(lookupFun: expectAsync1((keys) {
          expect(keys, hasLength(1));
          expect(keys.first, testPackageVersionKey);
          return [null];
        }));
        final repo = GCloudPackageRepository(db, null);
        final version = await repo.lookupVersion(
            testPackageVersion.package, testPackageVersion.version);
        expect(version, isNull);
      });

      test('successful', () async {
        final db = DatastoreDBMock(lookupFun: expectAsync1((keys) {
          expect(keys, hasLength(1));
          expect(keys.first, testPackageVersionKey);
          return [testPackageVersion];
        }));
        final repo = GCloudPackageRepository(db, null);
        final version = await repo.lookupVersion(
            testPackageVersion.package, testPackageVersion.version);
        expect(version, isNotNull);
        expect(version.packageName, testPackageVersion.package);
        expect(version.versionString, testPackageVersion.version);
      });
    });

    group('GCloudRepository.versions', () {
      test('not found', () async {
        final completion = TestDelayCompletion();
        Stream<PackageVersion> queryRunFun(
            {partition,
            ancestorKey,
            filters,
            filterComparisonObjects,
            offset,
            limit,
            orders}) {
          completion.complete();
          expect(ancestorKey, testPackageKey);
          return Stream.fromIterable(<PackageVersion>[]);
        }

        final queryMock = QueryMock(queryRunFun);
        final db = DatastoreDBMock(queryMock: queryMock);
        final repo = GCloudPackageRepository(db, null);
        final version =
            await repo.versions(testPackageVersion.package).toList();
        expect(version, isEmpty);
      });

      test('found', () async {
        final completion = TestDelayCompletion();
        Stream<PackageVersion> queryRunFun(
            {partition,
            ancestorKey,
            filters,
            filterComparisonObjects,
            offset,
            limit,
            orders}) {
          completion.complete();
          expect(ancestorKey, testPackageKey);
          return Stream.fromIterable([testPackageVersion]);
        }

        final queryMock = QueryMock(queryRunFun);
        final db = DatastoreDBMock(queryMock: queryMock);
        final repo = GCloudPackageRepository(db, null);
        final version =
            await repo.versions(testPackageVersion.package).toList();
        expect(version, hasLength(1));
        expect(version.first.packageName, testPackageVersion.package);
        expect(version.first.versionString, testPackageVersion.version);
      });
    });

    group('uploading', () {
      final dateBeforeTest = DateTime.now().toUtc();

      void validateSuccessfullUpdate(List<Model> inserts) {
        expect(inserts, hasLength(8));
        final package = inserts[0] as Package;
        final version = inserts[1] as PackageVersion;
        final versionPubspec = inserts[2] as PackageVersionPubspec;
        final versionInfo = inserts[3] as PackageVersionInfo;
        final pubspecAsset = inserts[4] as PackageVersionAsset;
        final readmeAsset = inserts[5] as PackageVersionAsset;
        final changelogAsset = inserts[6] as PackageVersionAsset;
        final history = inserts[7] as History;

        expect(package.key, testPackage.key);
        expect(package.name, testPackage.name);
        expect(package.latestVersionKey, testPackageVersion.key);
        expect(package.uploaders, ['uuid-hans-at-juergen-dot-com']);
        expect(package.created.compareTo(dateBeforeTest) >= 0, isTrue);
        expect(package.updated.compareTo(dateBeforeTest) >= 0, isTrue);

        expect(version.key, testPackageVersion.key);
        expect(version.packageKey, testPackage.key);
        expect(version.created.compareTo(dateBeforeTest) >= 0, isTrue);
        expect(version.readmeFilename, 'README.md');
        expect(version.readmeContent, testPackageReadme);
        expect(version.changelogFilename, 'CHANGELOG.md');
        expect(version.changelogContent, testPackageChangelog);
        expect(version.pubspec.asJson, loadYaml(testPackagePubspec));
        expect(version.libraries, ['test_library.dart']);
        expect(version.uploader, 'uuid-hans-at-juergen-dot-com');
        expect(version.downloads, 0);
        expect(version.sortOrder, 1);

        expect(versionPubspec.id, 'foobar_pkg-0.1.1+5');
        expect(versionPubspec.package, testPackage.name);
        expect(versionPubspec.version, testPackageVersion.version);
        expect(versionPubspec.updated.compareTo(dateBeforeTest) >= 0, isTrue);
        expect(versionPubspec.pubspec.asJson, loadYaml(testPackagePubspec));

        expect(versionInfo.id, 'foobar_pkg-0.1.1+5');
        expect(versionInfo.package, testPackage.name);
        expect(versionInfo.version, testPackageVersion.version);
        expect(versionInfo.updated.compareTo(dateBeforeTest) >= 0, isTrue);
        expect(versionInfo.assetNames, ['pubspec', 'readme', 'changelog']);
        expect(versionInfo.libraries, ['test_library.dart']);
        expect(versionInfo.libraryCount, 1);

        expect(pubspecAsset.parentKey, testPackageVersion.key);
        expect(pubspecAsset.id, 'pubspec');
        expect(pubspecAsset.package, testPackage.name);
        expect(pubspecAsset.version, testPackageVersion.version);
        expect(pubspecAsset.name, 'pubspec');
        expect(pubspecAsset.path, 'pubspec.yaml');
        expect(pubspecAsset.content, testPackagePubspec);
        expect(pubspecAsset.contentLength, 175);

        expect(readmeAsset.parentKey, testPackageVersion.key);
        expect(readmeAsset.id, 'readme');
        expect(readmeAsset.package, testPackage.name);
        expect(readmeAsset.version, testPackageVersion.version);
        expect(readmeAsset.name, 'readme');
        expect(readmeAsset.path, 'README.md');
        expect(readmeAsset.content, testPackageReadme);
        expect(readmeAsset.contentLength, 79);

        expect(changelogAsset.parentKey, testPackageVersion.key);
        expect(changelogAsset.id, 'changelog');
        expect(changelogAsset.package, testPackage.name);
        expect(changelogAsset.version, testPackageVersion.version);
        expect(changelogAsset.name, 'changelog');
        expect(changelogAsset.path, 'CHANGELOG.md');
        expect(changelogAsset.content, testPackageChangelog);
        expect(changelogAsset.contentLength, 46);

        expect(history.packageName, testPackage.name);
        expect(history.packageVersion, testPackageVersion.version);
        expect(history.source, HistorySource.account);
        expect(history.eventType, 'packageUploaded');
        expect(history.historyEvent is PackageUploaded, isTrue);
        expect((history.historyEvent as PackageUploaded).uploaderEmail,
            'hans@juergen.com');
      }

      void validateSuccessfullSortOrderUpdate(PackageVersion model) {
        expect(model.sortOrder, 0);
      }

      Stream<PackageVersion> sortOrderUpdateQueryMock(
          {Partition partition,
          Key ancestorKey,
          List<String> filters,
          List filterComparisonObjects,
          int offset,
          int limit,
          List<String> orders}) {
        expect(orders, []);
        expect(filters, []);
        expect(offset, isNull);
        expect(limit, isNull);
        expect(ancestorKey, testPackage.key);
        testPackageVersion.sortOrder = 50;
        return Stream.fromIterable([testPackageVersion]);
      }

      group('GCloudRepository.startAsyncUpload', () {
        final Uri redirectUri = Uri.parse('http://blobstore.com/upload');

        scopedTest('no active user', () async {
          final db = DatastoreDBMock();
          final repo = GCloudPackageRepository(db, null);
          registerUploadSigner(UploadSignerServiceMock(null));
          await repo
              .startAsyncUpload(redirectUri)
              .catchError(expectAsync2((e, _) {
            expect(e is pub_server.UnauthorizedAccessException, isTrue);
          }));
        });

        scopedTest('successful', () async {
          final uri = Uri.parse('http://foobar.com');
          final expectedUploadInfo =
              pub_server.AsyncUploadInfo(uri, {'a': 'b'});
          final bucketMock = BucketMock('mbucket');
          final tarballStorage = TarballStorageMock(
              tmpObjectNameFun: expectAsync1((guid) {
                return 'obj/$guid';
              }),
              bucketMock: bucketMock);
          final db = DatastoreDBMock();
          final repo = GCloudPackageRepository(db, tarballStorage);
          final uploadSignerMock = UploadSignerServiceMock(
              (bucket, object, lifetime, successRedirectUrl,
                  {predefinedAcl, maxUploadSize}) {
            expect(bucket, 'mbucket');
            return expectedUploadInfo;
          });
          registerUploadSigner(uploadSignerMock);
          registerAuthenticatedUser(testUploaderUser);
          final uploadInfo = await repo.startAsyncUpload(redirectUri);
          expect(identical(uploadInfo, expectedUploadInfo), isTrue);
        });
      });

      group('GCloudRepository.finishAsyncUpload', () {
        final Uri redirectUri =
            Uri.parse('http://blobstore.com/upload?upload_id=myguid');

        scopedTest('upload-too-big', () async {
          final oneKB = List.filled(1024, 42);
          final bigTarball = <List<int>>[];
          for (int i = 0; i < UploadSignerService.maxUploadSize ~/ 1024; i++) {
            bigTarball.add(oneKB);
          }
          // Add one more byte than allowed.
          bigTarball.add([1]);

          final tarballStorage = TarballStorageMock(readTempObjectFun: (guid) {
            expect(guid, 'myguid');
            return Stream.fromIterable(bigTarball);
          }, removeTempObjectFun: (guid) {
            expect(guid, 'myguid');
          });
          final transactionMock = TransactionMock();
          final db = DatastoreDBMock(transactionMock: transactionMock);
          final repo = GCloudPackageRepository(db, tarballStorage);
          registerAuthenticatedUser(testUploaderUser);
          final historyBackendMock = HistoryBackendMock();
          registerHistoryBackend(historyBackendMock);
          final Future result = repo.finishAsyncUpload(redirectUri);
          await result.catchError(expectAsync2((error, _) {
            expect(
                error,
                contains(
                    'Exceeded ${UploadSignerService.maxUploadSize} upload size'));
          }));
          expect(historyBackendMock.storedHistories, hasLength(0));
        }, timeout: Timeout.factor(2));

        scopedTest('successful', () async {
          return withTestPackage((List<int> tarball) async {
            final tarballStorage = TarballStorageMock(
                readTempObjectFun: (guid) {
              expect(guid, 'myguid');
              return Stream.fromIterable([tarball]);
            }, uploadViaTempObjectFun:
                    (String guid, String package, String version) {
              expect(guid, 'myguid');
              expect(package, testPackage.name);
              expect(version, testPackageVersion.version);
            }, removeTempObjectFun: (guid) {
              expect(guid, 'myguid');
            });
            final queryMock = QueryMock(sortOrderUpdateQueryMock);
            int queueMutationCallNr = 0;
            final transactionMock = TransactionMock(
                lookupFun: (keys) {
                  expect(keys, hasLength(2));
                  expect(keys.first, testPackageVersion.key);
                  expect(keys.last, testPackage.key);
                  return [null, null];
                },
                queueMutationFun: ({List<Model> inserts, deletes}) {
                  if (queueMutationCallNr == 0) {
                    validateSuccessfullUpdate(inserts);
                  } else {
                    expect(queueMutationCallNr, 1);
                    expect(inserts, [testPackageVersion]);
                    validateSuccessfullSortOrderUpdate(
                        inserts.first as PackageVersion);
                  }
                  queueMutationCallNr++;
                },
                commitFun: expectAsync0(() {}, count: 2),
                queryMock: queryMock);
            final finishCallback = expectAsync1((PackageVersion pv) {
              expect(pv.package, 'foobar_pkg');
              expect(pv.version, '0.1.1+5');
            });
            final db = DatastoreDBMock(transactionMock: transactionMock);
            final repo = GCloudPackageRepository(db, tarballStorage,
                finishCallback: finishCallback);
            registerAuthenticatedUser(testUploaderUser);
            registerAccountBackend(
                AccountBackendMock(authenticatedUsers: [testUploaderUser]));
            final emailSenderMock = EmailSenderMock();
            registerEmailSender(emailSenderMock);
            registerHistoryBackend(HistoryBackendMock());
            registerAnalyzerClient(AnalyzerClientMock());
            registerDartdocClient(DartdocClientMock());
            final version = await repo.finishAsyncUpload(redirectUri);
            expect(version.packageName, testPackage.name);
            expect(version.versionString, testPackageVersion.version);
            expect(emailSenderMock.sentMessages, hasLength(1));
            final email = emailSenderMock.sentMessages.single;
            expect(email.subject, contains('foobar_pkg'));
            expect(email.subject, contains('0.1.1+5'));
            expect(email.recipients.join(', '), 'hans@juergen.com');
          });
        });
      });

      group('GCloudRepository.upload', () {
        scopedTest('not logged in', () async {
          return withTestPackage((List<int> tarball) async {
            final tarballStorage = TarballStorageMock();
            final transactionMock = TransactionMock();
            final db = DatastoreDBMock(transactionMock: transactionMock);
            final repo = GCloudPackageRepository(db, tarballStorage);
            repo
                .upload(Stream.fromIterable([tarball]))
                .catchError(expectAsync2((error, _) {
              expect(error is pub_server.UnauthorizedAccessException, isTrue);
            }));
          });
        });

        scopedTest('not authorized', () async {
          return withTestPackage((List<int> tarball) async {
            final tarballStorage = TarballStorageMock();
            final transactionMock = TransactionMock(
                lookupFun: expectAsync1((keys) {
                  expect(keys, hasLength(2));
                  expect(keys.first, testPackageVersion.key);
                  expect(keys.last, testPackage.key);
                  return [null, testPackage];
                }),
                rollbackFun: expectAsync0(() {}));
            final db = DatastoreDBMock(transactionMock: transactionMock);
            final repo = GCloudPackageRepository(db, tarballStorage);
            registerAuthenticatedUser(AuthenticatedUser(
                'uuid-no-at-authorized-dot-com', 'un@authorized.com'));
            repo
                .upload(Stream.fromIterable([tarball]))
                .catchError(expectAsync2((error, _) {
              expect(error is pub_server.UnauthorizedAccessException, isTrue);
            }));
          });
        });

        scopedTest('versions already exist', () async {
          return withTestPackage((List<int> tarball) async {
            final tarballStorage = TarballStorageMock();
            final transactionMock = TransactionMock(
                lookupFun: expectAsync1((keys) {
                  expect(keys, hasLength(2));
                  expect(keys.first, testPackageVersion.key);
                  expect(keys.last, testPackage.key);
                  return [testPackageVersion, testPackage];
                }),
                rollbackFun: expectAsync0(() {}));
            final db = DatastoreDBMock(transactionMock: transactionMock);
            final repo = GCloudPackageRepository(db, tarballStorage);
            registerAuthenticatedUser(AuthenticatedUser(
                'uuid-no-at-authorized-dot-com', 'un@authorized.com'));
            repo
                .upload(Stream.fromIterable([tarball]))
                .catchError(expectAsync2((error, _) {
              expect(
                  '$error'.contains(
                      'Version 0.1.1+5 of package foobar_pkg already exists'),
                  isTrue);
            }));
          });
        });

        scopedTest('bad package names are rejected', () async {
          final tarballStorage = TarballStorageMock();
          final transactionMock = TransactionMock();
          final db = DatastoreDBMock(transactionMock: transactionMock);
          final repo = GCloudPackageRepository(db, tarballStorage);
          registerAuthenticatedUser(testUploaderUser);

          // Returns the error message as String or null if it succeeded.
          Future<String> fn(String name) async {
            final String pubspecContent =
                testPackagePubspec.replaceAll('foobar_pkg', name);
            try {
              await withTestPackage((List<int> tarball) async {
                await repo.upload(Stream.fromIterable([tarball]));
              }, pubspecContent: pubspecContent);
            } catch (e) {
              return e.toString();
            }
            // no issues, return null
            return null;
          }

          expect(await fn('with'),
              'Package name must not be a reserved word in Dart.');
          expect(await fn('123test'),
              'Package name must begin with a letter or underscore.');
          expect(await fn('With Space'),
              'Package name may only contain letters, numbers, and underscores.');

          expect(await fn('ok_name'), 'Exception: no lookupFun');
        });

        scopedTest('upload-too-big', () async {
          final oneKB = List.filled(1024, 42);
          final List<List<int>> bigTarball = [];
          for (int i = 0; i < UploadSignerService.maxUploadSize ~/ 1024; i++) {
            bigTarball.add(oneKB);
          }
          // Add one more byte than allowed.
          bigTarball.add([1]);

          final tarballStorage = TarballStorageMock();
          final transactionMock = TransactionMock();
          final db = DatastoreDBMock(transactionMock: transactionMock);
          final repo = GCloudPackageRepository(db, tarballStorage);
          registerAuthenticatedUser(testUploaderUser);
          registerAnalyzerClient(AnalyzerClientMock());
          registerDartdocClient(DartdocClientMock());
          final historyBackendMock = HistoryBackendMock();
          registerHistoryBackend(historyBackendMock);
          final Future result = repo.upload(Stream.fromIterable(bigTarball));
          await result.catchError(expectAsync2((error, _) {
            expect(
                error,
                contains(
                    'Exceeded ${UploadSignerService.maxUploadSize} upload size'));
          }));
          expect(historyBackendMock.storedHistories, hasLength(0));
        }, timeout: Timeout.factor(2));

        scopedTest('successful', () async {
          return withTestPackage((List<int> tarball) async {
            final completion = TestDelayCompletion(count: 2);
            final tarballStorage = TarballStorageMock(uploadFun:
                (String package, String version,
                    Stream<List<int>> uploadTarball) async {
              expect(package, testPackage.name);
              expect(version, testPackageVersion.version);

              final bytes =
                  await uploadTarball.fold([], (b, d) => b..addAll(d));

              expect(bytes, tarball);
            });

            // NOTE: There will be two transactions:
            //  a) for inserting a new Package + PackageVersion
            //  b) for inserting a new PackageVersions sorted by `sort_order`.
            int queueMutationCallNr = 0;
            final queryMock = QueryMock(sortOrderUpdateQueryMock);
            final transactionMock = TransactionMock(
                lookupFun: expectAsync1((keys) {
                  expect(queueMutationCallNr, 0);

                  expect(keys, hasLength(2));
                  expect(keys.first, testPackageVersion.key);
                  expect(keys.last, testPackage.key);
                  return [null, null];
                }),
                queueMutationFun: ({List<Model> inserts, deletes}) {
                  if (queueMutationCallNr == 0) {
                    validateSuccessfullUpdate(inserts);
                  } else {
                    expect(queueMutationCallNr, 1);
                    expect(inserts, [testPackageVersion]);
                    validateSuccessfullSortOrderUpdate(
                        inserts.first as PackageVersion);
                  }
                  queueMutationCallNr++;
                  completion.complete();
                },
                commitFun: expectAsync0(() {}, count: 2),
                queryMock: queryMock);
            final finishCallback = expectAsync1((PackageVersion pv) {
              expect(pv.package, 'foobar_pkg');
              expect(pv.version, '0.1.1+5');
            });

            final db = DatastoreDBMock(transactionMock: transactionMock);
            final repo = GCloudPackageRepository(db, tarballStorage,
                finishCallback: finishCallback);
            registerAuthenticatedUser(testUploaderUser);
            registerAnalyzerClient(AnalyzerClientMock());
            registerDartdocClient(DartdocClientMock());
            registerAccountBackend(
                AccountBackendMock(authenticatedUsers: [testUploaderUser]));
            registerHistoryBackend(HistoryBackendMock());
            final emailSenderMock = EmailSenderMock();
            registerEmailSender(emailSenderMock);
            final version = await repo.upload(Stream.fromIterable([tarball]));
            expect(version.packageName, testPackage.name);
            expect(version.versionString, testPackageVersion.version);
            expect(emailSenderMock.sentMessages, hasLength(1));
            final email = emailSenderMock.sentMessages.single;
            expect(email.subject, contains('foobar_pkg'));
            expect(email.subject, contains('0.1.1+5'));
            expect(email.recipients.join(', '), 'hans@juergen.com');
          });
        });
      });
    }, timeout: Timeout.factor(2));
  });
}
