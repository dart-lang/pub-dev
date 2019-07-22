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
import 'package:pub_dartlang_org/frontend/name_tracker.dart';
import 'package:pub_dartlang_org/frontend/upload_signer_service.dart';
import 'package:pub_dartlang_org/history/backend.dart';
import 'package:pub_dartlang_org/history/models.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/dartdoc_client.dart';
import 'package:pub_dartlang_org/shared/redis_cache.dart' show withCache;

import '../shared/test_models.dart';
import '../shared/test_services.dart';
import '../shared/utils.dart';

import 'backend_test_utils.dart';
import 'mocks.dart';

void testWithCache(String name, Function fn, {Timeout timeout}) =>
    scopedTest(name, () async {
      await withCache(() async {
        await fn();
      });
    }, timeout: timeout);

// TODO: Add missing tests when a query returns more than one result.
void main() {
  group('backend', () {
    group('Backend.latestPackages', () {
      testWithServices('empty', () async {
        await dbService.commit(deletes: [foobarPackage.key]);
        expect(await backend.latestPackages(), []);
      });

      testWithServices('one package', () async {
        final list = await backend.latestPackages();
        expect(list.map((p) => p.name), ['foobar_pkg']);
      });

      testWithServices('two packages, other earlier', () async {
        final p = createFoobarPackage(name: 'other')..updated = DateTime(2010);
        await dbService.commit(inserts: [p]);
        final list = await backend.latestPackages();
        expect(list.map((p) => p.name), ['foobar_pkg', 'other']);
      });

      testWithServices('two packages, other later', () async {
        final p = createFoobarPackage(name: 'other')..updated = DateTime(2018);
        await dbService.commit(inserts: [p]);
        final list = await backend.latestPackages();
        expect(list.map((p) => p.name), ['other', 'foobar_pkg']);
      });

      testWithServices('two packages, offset: 1', () async {
        final p = createFoobarPackage(name: 'other')..updated = DateTime(2018);
        await dbService.commit(inserts: [p]);
        final list = await backend.latestPackages(offset: 1);
        expect(list.map((p) => p.name), ['foobar_pkg']);
      });

      testWithServices('two packages, limit: 1', () async {
        final p = createFoobarPackage(name: 'other')..updated = DateTime(2018);
        await dbService.commit(inserts: [p]);
        final list = await backend.latestPackages(limit: 1);
        expect(list.map((p) => p.name), ['other']);
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
          return Stream.fromIterable([foobarPackage]);
        }

        List<PackageVersion> lookupFun(keys) {
          expect(keys, hasLength(1));
          expect(keys.first, foobarPackage.latestVersionKey);
          return [foobarStablePV];
        }

        final db = DatastoreDBMock(
            queryMock: QueryMock(queryRunFun),
            lookupFun: expectAsync1(lookupFun));
        final backend = Backend(db, null);

        final versions =
            await backend.latestPackageVersions(offset: 4, limit: 9);
        expect(versions, hasLength(1));
        expect(versions.first, equals(foobarStablePV));
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
        'exists': [foobarPackage],
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
        'exists': [foobarStablePV],
        'does not exist': [null],
      })
          .forEach((String testName, List<PackageVersion> expectedVersions) {
        test(testName, () async {
          List<PackageVersion> lookupFun(List<Key> keys) {
            expect(keys, hasLength(1));
            expect(keys.first, foobarStablePV.key);
            return expectedVersions;
          }

          final db = DatastoreDBMock(lookupFun: expectAsync1(lookupFun));
          final backend = Backend(db, null);

          final version = await backend.lookupPackageVersion(
              foobarStablePV.package, foobarStablePV.version);
          expect(version, equals(expectedVersions.first));
        });
      });
    });

    group('Backend.lookupLatestVersions', () {
      (<String, List<PackageVersion>>{
        'one version': [foobarStablePV],
        'empty': [null],
      })
          .forEach((String testName, List<PackageVersion> expectedVersions) {
        test(testName, () async {
          List<PackageVersion> lookupFun(List<Key> keys) {
            expect(keys, hasLength(1));
            expect(keys.first, foobarStablePV.key);
            return expectedVersions;
          }

          final db = DatastoreDBMock(lookupFun: expectAsync1(lookupFun));
          final backend = Backend(db, null);

          final versions = await backend.lookupLatestVersions([foobarPackage]);
          expect(versions, hasLength(1));
          expect(versions.first, equals(expectedVersions.first));
        });
      });
    });

    group('Backend.versionsOfPackage', () {
      (<String, List<PackageVersion>>{
        'one version': [foobarStablePV],
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
            expect(ancestorKey, foobarPackage.key);
            return Stream.fromIterable(expectedVersions);
          }

          final db = DatastoreDBMock(queryMock: QueryMock(queryRunFun));
          final backend = Backend(db, null);

          final versions = await backend.versionsOfPackage(foobarPackage.name);
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
      testWithCache('not logged in', () async {
        final db = DatastoreDBMock();
        final tarballStorage = TarballStorageMock();
        final repo = GCloudPackageRepository(db, tarballStorage);

        final pkg = foobarPackage.name;
        await repo.addUploader(pkg, 'a@b.com').catchError(expectAsync2((e, _) {
          expect(e is pub_server.UnauthorizedAccessException, isTrue);
        }));
      });

      testWithCache('not authorized', () async {
        final lookupFn = (keys) async {
          expect(keys, hasLength(1));
          expect(keys.first, foobarPackage.key);
          return [foobarPackage];
        };
        final db = DatastoreDBMock(
          lookupFun: lookupFn,
        );
        final tarballStorage = TarballStorageMock();
        final repo = GCloudPackageRepository(db, tarballStorage);

        final pkg = foobarPackage.name;
        registerAuthenticatedUser(
            AuthenticatedUser('uuid-foo-at-bar-dot-com', 'foo@bar.com'));
        final Future f = repo.addUploader(pkg, 'a@b.com');
        await f.catchError(expectAsync2((e, _) {
          expect(e.toString(),
              'UnauthorizedAccess: Calling user does not have permission to change uploaders.');
        }));
      });

      testWithCache('package does not exist', () async {
        final lookupFn = (keys) async {
          expect(keys, hasLength(1));
          expect(keys.first, foobarPackage.key);
          return [null];
        };
        final db = DatastoreDBMock(
          lookupFun: lookupFn,
        );
        final tarballStorage = TarballStorageMock();
        final repo = GCloudPackageRepository(db, tarballStorage);

        final pkg = foobarPackage.name;
        registerAuthenticatedUser(hansAuthenticated);
        final f = repo.addUploader(pkg, 'a@b.com');
        await f.catchError(expectAsync2((e, _) {
          expect(e.toString(), 'Package "null" does not exist');
        }));
      });

      Future testAlreadyExists(AuthenticatedUser user,
          List<AuthenticatedUser> uploaders, String newUploader) async {
        final testPackage = createFoobarPackage(uploaders: uploaders);
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
        final testPackage = createFoobarPackage(uploaders: uploaders);
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
      testWithCache('not logged in', () async {
        final db = DatastoreDBMock();
        final tarballStorage = TarballStorageMock();
        final repo = GCloudPackageRepository(db, tarballStorage);

        final pkg = foobarPackage.name;
        final f = repo.removeUploader(pkg, 'a@b.com');
        await f.catchError(expectAsync2((e, _) {
          expect(e is pub_server.UnauthorizedAccessException, isTrue);
        }));
      });

      testWithCache('not authorized', () async {
        final transactionMock = TransactionMock(
            lookupFun: expectAsync1((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, foobarPackage.key);
              return [foobarPackage];
            }),
            rollbackFun: expectAsync0(() {}));
        final db = DatastoreDBMock(transactionMock: transactionMock);
        final tarballStorage = TarballStorageMock();
        final repo = GCloudPackageRepository(db, tarballStorage);

        final pkg = foobarPackage.name;
        registerAuthenticatedUser(
            AuthenticatedUser('uuid-foo-at-bar-dot-com', 'foo@bar.com'));
        final f = repo.removeUploader(pkg, 'a@b.com');
        await f.catchError(expectAsync2((e, _) {
          expect(e is pub_server.UnauthorizedAccessException, isTrue);
        }));
      });

      testWithCache('package does not exist', () async {
        final transactionMock = TransactionMock(
            lookupFun: expectAsync1((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, foobarPackage.key);
              return [null];
            }),
            rollbackFun: expectAsync0(() {}));
        final db = DatastoreDBMock(transactionMock: transactionMock);
        final tarballStorage = TarballStorageMock();
        final repo = GCloudPackageRepository(db, tarballStorage);

        final pkg = foobarPackage.name;
        registerAuthenticatedUser(hansAuthenticated);
        final f = repo.removeUploader(pkg, 'a@b.com');
        await f.catchError(expectAsync2((e, _) {
          expect('$e', equals('Package "null" does not exist'));
        }));
      });

      testWithCache('cannot remove last uploader', () async {
        final testPackage = createFoobarPackage();
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
        registerAuthenticatedUser(hansAuthenticated);
        registerAccountBackend(
            AccountBackendMock(authenticatedUsers: [hansAuthenticated]));
        await repo
            .removeUploader(pkg, hansAuthenticated.email)
            .catchError(expectAsync2((e, _) {
          expect(e is pub_server.LastUploaderRemoveException, isTrue);
        }));
      });

      testWithCache('cannot remove non-existent uploader', () async {
        final transactionMock = TransactionMock(
            lookupFun: expectAsync1((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, foobarPackage.key);
              return [foobarPackage];
            }),
            rollbackFun: expectAsync0(() {}));
        final db = DatastoreDBMock(transactionMock: transactionMock);
        final tarballStorage = TarballStorageMock();
        final repo = GCloudPackageRepository(db, tarballStorage);

        final pkg = foobarPackage.name;
        registerAuthenticatedUser(hansAuthenticated);
        registerAccountBackend(AccountBackendMock());
        await repo
            .removeUploader(pkg, 'foo2@bar.com')
            .catchError(expectAsync2((e, _) {
          expect('$e', 'The uploader to remove does not exist.');
        }));
      });

      testWithCache('cannot remove self', () async {
        final foo1 = AuthenticatedUser('uuid-foo1', 'foo1@bar.com');
        final foo2 = AuthenticatedUser('uuid-foo2', 'foo2@bar.com');
        final testPackage = createFoobarPackage(uploaders: [foo1, foo2]);
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

      testWithCache('successful', () async {
        final userA = AuthenticatedUser('uuid-a', 'a@x.com');
        final userB = AuthenticatedUser('uuid-b', 'b@x.com');
        final testPackage = createFoobarPackage(uploaders: [userA, userB]);
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
          expect(keys.first, foobarStablePVKey);
          return [null];
        }));
        final repo = GCloudPackageRepository(db, null);
        final version = await repo.lookupVersion(
            foobarStablePV.package, foobarStablePV.version);
        expect(version, isNull);
      });

      test('successful', () async {
        final db = DatastoreDBMock(lookupFun: expectAsync1((keys) {
          expect(keys, hasLength(1));
          expect(keys.first, foobarStablePVKey);
          return [foobarStablePV];
        }));
        final repo = GCloudPackageRepository(db, null);
        final version = await repo.lookupVersion(
            foobarStablePV.package, foobarStablePV.version);
        expect(version, isNotNull);
        expect(version.packageName, foobarStablePV.package);
        expect(version.versionString, foobarStablePV.version);
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
          expect(ancestorKey, foobarPkgKey);
          return Stream.fromIterable(<PackageVersion>[]);
        }

        final queryMock = QueryMock(queryRunFun);
        final db = DatastoreDBMock(queryMock: queryMock);
        final repo = GCloudPackageRepository(db, null);
        final version = await repo.versions(foobarStablePV.package).toList();
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
          expect(ancestorKey, foobarPkgKey);
          return Stream.fromIterable([foobarStablePV]);
        }

        final queryMock = QueryMock(queryRunFun);
        final db = DatastoreDBMock(queryMock: queryMock);
        final repo = GCloudPackageRepository(db, null);
        final version = await repo.versions(foobarStablePV.package).toList();
        expect(version, hasLength(1));
        expect(version.first.packageName, foobarStablePV.package);
        expect(version.first.versionString, foobarStablePV.version);
      });
    });

    group('uploading', () {
      final dateBeforeTest = DateTime.now().toUtc();

      void validateSuccessfullUpdate(List<Model> inserts) {
        expect(inserts, hasLength(5));
        final package = inserts[0] as Package;
        final version = inserts[1] as PackageVersion;
        final versionPubspec = inserts[2] as PackageVersionPubspec;
        final versionInfo = inserts[3] as PackageVersionInfo;
        final history = inserts[4] as History;

        expect(package.key, foobarPackage.key);
        expect(package.name, foobarPackage.name);
        expect(package.latestVersionKey, foobarStablePV.key);
        expect(package.uploaders, ['hans-at-juergen-dot-com']);
        expect(package.created.compareTo(dateBeforeTest) >= 0, isTrue);
        expect(package.updated.compareTo(dateBeforeTest) >= 0, isTrue);

        expect(version.key, foobarStablePV.key);
        expect(version.packageKey, foobarPackage.key);
        expect(version.created.compareTo(dateBeforeTest) >= 0, isTrue);
        expect(version.readmeFilename, 'README.md');
        expect(version.readmeContent, foobarReadmeContent);
        expect(version.changelogFilename, 'CHANGELOG.md');
        expect(version.changelogContent, foobarChangelogContent);
        expect(version.pubspec.asJson, loadYaml(foobarStablePubspec));
        expect(version.libraries, ['test_library.dart']);
        expect(version.uploader, 'hans-at-juergen-dot-com');
        expect(version.downloads, 0);
        expect(version.sortOrder, 1);

        expect(versionPubspec.id, 'foobar_pkg-0.1.1+5');
        expect(versionPubspec.package, foobarPackage.name);
        expect(versionPubspec.version, foobarStablePV.version);
        expect(versionPubspec.updated.compareTo(dateBeforeTest) >= 0, isTrue);
        expect(versionPubspec.pubspec.asJson, loadYaml(foobarStablePubspec));

        expect(versionInfo.id, 'foobar_pkg-0.1.1+5');
        expect(versionInfo.package, foobarPackage.name);
        expect(versionInfo.version, foobarStablePV.version);
        expect(versionInfo.updated.compareTo(dateBeforeTest) >= 0, isTrue);
        expect(versionInfo.libraries, ['test_library.dart']);
        expect(versionInfo.libraryCount, 1);

        expect(history.packageName, foobarPackage.name);
        expect(history.packageVersion, foobarStablePV.version);
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
        expect(ancestorKey, foobarPackage.key);
        foobarStablePV.sortOrder = 50;
        return Stream.fromIterable([foobarStablePV]);
      }

      group('GCloudRepository.startAsyncUpload', () {
        final Uri redirectUri = Uri.parse('http://blobstore.com/upload');

        testWithCache('no active user', () async {
          final db = DatastoreDBMock();
          final repo = GCloudPackageRepository(db, null);
          registerUploadSigner(UploadSignerServiceMock(null));
          await repo
              .startAsyncUpload(redirectUri)
              .catchError(expectAsync2((e, _) {
            expect(e is pub_server.UnauthorizedAccessException, isTrue);
          }));
        });

        testWithCache('successful', () async {
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
          registerAuthenticatedUser(hansAuthenticated);
          final uploadInfo = await repo.startAsyncUpload(redirectUri);
          expect(identical(uploadInfo, expectedUploadInfo), isTrue);
        });
      });

      group('GCloudRepository.finishAsyncUpload', () {
        final Uri redirectUri =
            Uri.parse('http://blobstore.com/upload?upload_id=myguid');

        testWithCache('upload-too-big', () async {
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
          registerAuthenticatedUser(hansAuthenticated);
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

        testWithCache('successful', () async {
          return withTestPackage((List<int> tarball) async {
            final tarballStorage = TarballStorageMock(
                readTempObjectFun: (guid) {
              expect(guid, 'myguid');
              return Stream.fromIterable([tarball]);
            }, uploadViaTempObjectFun:
                    (String guid, String package, String version) {
              expect(guid, 'myguid');
              expect(package, foobarPackage.name);
              expect(version, foobarStablePV.version);
            }, removeTempObjectFun: (guid) {
              expect(guid, 'myguid');
            });
            final queryMock = QueryMock(sortOrderUpdateQueryMock);
            int queueMutationCallNr = 0;
            final transactionMock = TransactionMock(
                lookupFun: (keys) {
                  expect(keys, hasLength(2));
                  expect(keys.first, foobarStablePV.key);
                  expect(keys.last, foobarPackage.key);
                  return [null, null];
                },
                queueMutationFun: ({List<Model> inserts, deletes}) {
                  if (queueMutationCallNr == 0) {
                    validateSuccessfullUpdate(inserts);
                  } else {
                    expect(queueMutationCallNr, 1);
                    expect(inserts, [foobarStablePV]);
                    validateSuccessfullSortOrderUpdate(
                        inserts.first as PackageVersion);
                  }
                  queueMutationCallNr++;
                },
                commitFun: expectAsync0(() {}, count: 2),
                queryMock: queryMock);
            final db = DatastoreDBMock(transactionMock: transactionMock);
            final repo = GCloudPackageRepository(db, tarballStorage);
            registerAuthenticatedUser(hansAuthenticated);
            registerAccountBackend(
                AccountBackendMock(authenticatedUsers: [hansAuthenticated]));
            final emailSenderMock = EmailSenderMock();
            registerEmailSender(emailSenderMock);
            registerHistoryBackend(HistoryBackendMock());
            registerAnalyzerClient(AnalyzerClientMock());
            registerDartdocClient(DartdocClientMock());
            registerNameTracker(NameTracker(null));
            final version = await repo.finishAsyncUpload(redirectUri);
            expect(version.packageName, foobarPackage.name);
            expect(version.versionString, foobarStablePV.version);
            expect(emailSenderMock.sentMessages, hasLength(1));
            final email = emailSenderMock.sentMessages.single;
            expect(email.subject, contains('foobar_pkg'));
            expect(email.subject, contains('0.1.1+5'));
            expect(email.recipients.join(', '), 'hans@juergen.com');
          });
        });
      });

      group('GCloudRepository.upload', () {
        testWithCache('not logged in', () async {
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

        testWithCache('not authorized', () async {
          return withTestPackage((List<int> tarball) async {
            final tarballStorage = TarballStorageMock();
            final transactionMock = TransactionMock(
                lookupFun: expectAsync1((keys) {
                  expect(keys, hasLength(2));
                  expect(keys.first, foobarStablePV.key);
                  expect(keys.last, foobarPackage.key);
                  return [null, foobarPackage];
                }),
                rollbackFun: expectAsync0(() {}));
            final db = DatastoreDBMock(transactionMock: transactionMock);
            final repo = GCloudPackageRepository(db, tarballStorage);
            registerAuthenticatedUser(AuthenticatedUser(
                'uuid-no-at-authorized-dot-com', 'un@authorized.com'));
            registerNameTracker(NameTracker(null));
            await repo
                .upload(Stream.fromIterable([tarball]))
                .catchError(expectAsync2((error, _) {
              expect(error is pub_server.UnauthorizedAccessException, isTrue);
            }));
          });
        });

        testWithCache('versions already exist', () async {
          return withTestPackage((List<int> tarball) async {
            final tarballStorage = TarballStorageMock();
            final transactionMock = TransactionMock(
                lookupFun: expectAsync1((keys) {
                  expect(keys, hasLength(2));
                  expect(keys.first, foobarStablePV.key);
                  expect(keys.last, foobarPackage.key);
                  return [foobarStablePV, foobarPackage];
                }),
                rollbackFun: expectAsync0(() {}));
            final db = DatastoreDBMock(transactionMock: transactionMock);
            final repo = GCloudPackageRepository(db, tarballStorage);
            registerAuthenticatedUser(AuthenticatedUser(
                'uuid-no-at-authorized-dot-com', 'un@authorized.com'));
            registerNameTracker(NameTracker(null));
            await repo
                .upload(Stream.fromIterable([tarball]))
                .catchError(expectAsync2((error, _) {
              expect(
                  '$error'.contains(
                      'Version 0.1.1+5 of package foobar_pkg already exists'),
                  isTrue);
            }));
          });
        });

        testWithCache('bad package names are rejected', () async {
          final tarballStorage = TarballStorageMock();
          final transactionMock = TransactionMock();
          final db = DatastoreDBMock(transactionMock: transactionMock);
          final repo = GCloudPackageRepository(db, tarballStorage);
          registerAuthenticatedUser(hansAuthenticated);
          registerNameTracker(NameTracker(null));
          nameTracker.add('foobar_pkg');

          // Returns the error message as String or null if it succeeded.
          Future<String> fn(String name) async {
            final String pubspecContent =
                foobarStablePubspec.replaceAll('foobar_pkg', name);
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

        testWithCache('upload-too-big', () async {
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
          registerAuthenticatedUser(hansAuthenticated);
          registerAnalyzerClient(AnalyzerClientMock());
          registerDartdocClient(DartdocClientMock());
          final historyBackendMock = HistoryBackendMock();
          registerHistoryBackend(historyBackendMock);
          registerNameTracker(NameTracker(null));
          final Future result = repo.upload(Stream.fromIterable(bigTarball));
          await result.catchError(expectAsync2((error, _) {
            expect(
                error,
                contains(
                    'Exceeded ${UploadSignerService.maxUploadSize} upload size'));
          }));
          expect(historyBackendMock.storedHistories, hasLength(0));
        }, timeout: Timeout.factor(2));

        testWithCache('successful', () async {
          return withTestPackage((List<int> tarball) async {
            final completion = TestDelayCompletion(count: 2);
            final tarballStorage = TarballStorageMock(uploadFun:
                (String package, String version,
                    Stream<List<int>> uploadTarball) async {
              expect(package, foobarPackage.name);
              expect(version, foobarStablePV.version);

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
                  expect(keys.first, foobarStablePV.key);
                  expect(keys.last, foobarPackage.key);
                  return [null, null];
                }),
                queueMutationFun: ({List<Model> inserts, deletes}) {
                  if (queueMutationCallNr == 0) {
                    validateSuccessfullUpdate(inserts);
                  } else {
                    expect(queueMutationCallNr, 1);
                    expect(inserts, [foobarStablePV]);
                    validateSuccessfullSortOrderUpdate(
                        inserts.first as PackageVersion);
                  }
                  queueMutationCallNr++;
                  completion.complete();
                },
                commitFun: expectAsync0(() {}, count: 2),
                queryMock: queryMock);

            final db = DatastoreDBMock(transactionMock: transactionMock);
            final repo = GCloudPackageRepository(db, tarballStorage);
            registerAuthenticatedUser(hansAuthenticated);
            registerAnalyzerClient(AnalyzerClientMock());
            registerDartdocClient(DartdocClientMock());
            registerAccountBackend(
                AccountBackendMock(authenticatedUsers: [hansAuthenticated]));
            registerHistoryBackend(HistoryBackendMock());
            final emailSenderMock = EmailSenderMock();
            registerEmailSender(emailSenderMock);
            registerNameTracker(NameTracker(null));
            final version = await repo.upload(Stream.fromIterable([tarball]));
            expect(version.packageName, foobarPackage.name);
            expect(version.versionString, foobarStablePV.version);
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

class TestDelayCompletion {
  final int count;
  final Function _complete = expectAsync0(() {});
  int _got = 0;

  TestDelayCompletion({this.count = 1});

  void complete() {
    _got++;
    if (_got == count) _complete();
  }
}
