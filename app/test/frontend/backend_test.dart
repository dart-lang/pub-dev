// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@Timeout(const Duration(seconds: 15))
library pub_dartlang_org.backend_test;

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:pub_server/repository.dart' as pub_server;
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import 'package:pub_dartlang_org/frontend/backend.dart';
import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/upload_signer_service.dart';
import 'package:pub_dartlang_org/history/backend.dart';

import '../shared/utils.dart';

import 'backend_test_utils.dart';
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
          final completion = new TestDelayCompletion();
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
            return new Stream.fromIterable(expectedPackages);
          }

          final db = new DatastoreDBMock(queryMock: new QueryMock(queryRunFun));
          final backend = new Backend(db, null);

          final packages = await backend.latestPackages(offset: 4, limit: 9);
          expect(packages, equals(expectedPackages));
        });
      });
    });

    group('Backend.latestPackageVersions', () {
      test('one package', () async {
        final completion = new TestDelayCompletion();
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
          return new Stream.fromIterable([testPackage]);
        }

        List<PackageVersion> lookupFun(keys) {
          expect(keys, hasLength(1));
          expect(keys.first, testPackage.latestVersionKey);
          return [testPackageVersion];
        }

        final db = new DatastoreDBMock(
            queryMock: new QueryMock(queryRunFun),
            lookupFun: expectAsync1(lookupFun));
        final backend = new Backend(db, null);

        final versions =
            await backend.latestPackageVersions(offset: 4, limit: 9);
        expect(versions, hasLength(1));
        expect(versions.first, equals(testPackageVersion));
      });

      test('empty', () async {
        final completion = new TestDelayCompletion();
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
          return new Stream.fromIterable(<Package>[]);
        }

        List lookupFun(keys) {
          expect(keys, hasLength(0));
          return [];
        }

        final db = new DatastoreDBMock(
            queryMock: new QueryMock(queryRunFun),
            lookupFun: expectAsync1(lookupFun));
        final backend = new Backend(db, null);

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

          final db = new DatastoreDBMock(lookupFun: expectAsync1(lookupFun));
          final backend = new Backend(db, null);

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

          final db = new DatastoreDBMock(lookupFun: expectAsync1(lookupFun));
          final backend = new Backend(db, null);

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

          final db = new DatastoreDBMock(lookupFun: expectAsync1(lookupFun));
          final backend = new Backend(db, null);

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
          final completion = new TestDelayCompletion();
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
            return new Stream.fromIterable(expectedVersions);
          }

          final db = new DatastoreDBMock(queryMock: new QueryMock(queryRunFun));
          final backend = new Backend(db, null);

          final versions = await backend.versionsOfPackage(testPackage.name);
          expect(versions, hasLength(1));
          expect(versions.first, equals(expectedVersions.first));
        });
      });
    });

    test('Backend.downloadUrl', () async {
      final db = new DatastoreDBMock();
      final tarballStorage = new TarballStorageMock(
          downloadUrlFun: expectAsync2((package, version) {
        expect(package, 'foobar');
        expect(version, '0.1.0');
        return Uri.parse('http://blob/foobar/0.1.0.tar.gz');
      }));
      final backend = new Backend(db, tarballStorage);

      final url = await backend.downloadUrl('foobar', '0.1.0');
      expect(url.toString(), 'http://blob/foobar/0.1.0.tar.gz');
    });
  });

  group('backend.repository', () {
    void negativeUploaderTests(Function getMethod(repo)) {
      scopedTest('not logged in', () async {
        final db = new DatastoreDBMock();
        final tarballStorage = new TarballStorageMock();
        final repo = new GCloudPackageRepository(db, tarballStorage);

        final pkg = testPackage.name;
        await getMethod(repo)(pkg, 'a@b.com').catchError(expectAsync2((e, _) {
          expect(e is pub_server.UnauthorizedAccessException, isTrue);
        }));
      });

      scopedTest('not authorized', () async {
        final transactionMock = new TransactionMock(
            lookupFun: expectAsync1((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, testPackage.key);
              return [testPackage];
            }),
            rollbackFun: expectAsync0(() {}));
        final db = new DatastoreDBMock(transactionMock: transactionMock);
        final tarballStorage = new TarballStorageMock();
        final repo = new GCloudPackageRepository(db, tarballStorage);

        final pkg = testPackage.name;
        registerLoggedInUser('foo@bar.com');
        await getMethod(repo)(pkg, 'a@b.com').catchError(expectAsync2((e, _) {
          expect(e is pub_server.UnauthorizedAccessException, isTrue);
        }));
      });

      scopedTest('package does not exist', () async {
        final transactionMock = new TransactionMock(
            lookupFun: expectAsync1((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, testPackage.key);
              return [null];
            }),
            rollbackFun: expectAsync0(() {}));
        final db = new DatastoreDBMock(transactionMock: transactionMock);
        final tarballStorage = new TarballStorageMock();
        final repo = new GCloudPackageRepository(db, tarballStorage);

        final pkg = testPackage.name;
        registerLoggedInUser(testPackage.uploaderEmails.first);
        await getMethod(repo)(pkg, 'a@b.com').catchError(expectAsync2((e, _) {
          expect('$e', equals('Package "null" does not exist'));
        }));
      });
    }

    group('GCloudRepository.addUploader', () {
      negativeUploaderTests((repo) => repo.addUploader as Function);

      Future testAlreadyExists(
          String user, List<String> uploaderEmails, String newUploader) async {
        final transactionMock = new TransactionMock(
            lookupFun: expectAsync1((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, testPackage.key);
              return [testPackage];
            }),
            rollbackFun: expectAsync0(() {}));
        final db = new DatastoreDBMock(transactionMock: transactionMock);
        final tarballStorage = new TarballStorageMock();
        final repo = new GCloudPackageRepository(db, tarballStorage);

        final pkg = testPackage.name;
        registerLoggedInUser(user);
        testPackage.uploaderEmails = uploaderEmails;
        await repo
            .addUploader(pkg, newUploader)
            .catchError(expectAsync2((e, _) {
          expect(e is pub_server.UploaderAlreadyExistsException, isTrue);
        }));
      }

      test('already exists', () async {
        await scoped(
            () => testAlreadyExists('foo@b.com', ['foo@b.com'], 'foo@b.com'));
        await scoped(
            () => testAlreadyExists('foo@B.com', ['foo@b.com'], 'foo@b.com'));
        await scoped(
            () => testAlreadyExists('foo@B.com', ['foo@B.com'], 'foo@b.com'));
        await scoped(
            () => testAlreadyExists('foo@b.com', ['foo@B.com'], 'foo@B.com'));
        await scoped(
            () => testAlreadyExists('foo@b.com', ['foo@b.com'], 'foo@B.com'));
        await scoped(
            () => testAlreadyExists('foo@B.com', ['foo@b.com'], 'foo@B.com'));
        await scoped(() => testAlreadyExists(
            'foo@b.com', ['foo@b.com', 'bar@b.com'], 'foo@B.com'));
        await scoped(() => testAlreadyExists(
            'foo@b.com', ['bar@b.com', 'foo@b.com'], 'foo@B.com'));
      });

      Future testSuccessful(
          String user, List<String> uploaderEmails, String newUploader) async {
        final historyBackendMock = new HistoryBackendMock();
        registerHistoryBackend(historyBackendMock);
        final completion = new TestDelayCompletion();
        final transactionMock = new TransactionMock(
            lookupFun: expectAsync1((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, testPackage.key);
              return [testPackage];
            }),
            queueMutationFun: ({inserts, deletes}) {
              expect(inserts, hasLength(1));
              for (final email in uploaderEmails) {
                expect(inserts.first.uploaderEmails, contains(email));
              }
              expect(inserts.first.uploaderEmails, contains(newUploader));
              completion.complete();
            },
            commitFun: expectAsync0(() {}));
        final db = new DatastoreDBMock(transactionMock: transactionMock);
        final tarballStorage = new TarballStorageMock();
        final repo = new GCloudPackageRepository(db, tarballStorage);

        final pkg = testPackage.name;
        testPackage.uploaderEmails = uploaderEmails;
        registerLoggedInUser(user);
        await repo.addUploader(pkg, newUploader);
        expect(historyBackendMock.storedHistories, hasLength(1));
      }

      test('successful', () async {
        await scoped(
            () => testSuccessful('foo@b.com', ['foo@b.com'], 'bar@b.com'));
        await scoped(
            () => testSuccessful('foo@B.com', ['foo@b.com'], 'bar@B.com'));
        await scoped(() => testSuccessful(
            'foo@B.com', ['foo@B.com', 'bar@b.com'], 'baz@b.com'));
        await scoped(() => testSuccessful(
            'foo@b.com', ['foo@B.com', 'bar@B.com'], 'baz@B.com'));
      });
    });

    group('GCloudRepository.removeUploader', () {
      negativeUploaderTests((repo) => repo.removeUploader as Function);

      scopedTest('cannot remove last uploader', () async {
        final transactionMock = new TransactionMock(
            lookupFun: expectAsync1((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, testPackage.key);
              return [testPackage];
            }),
            rollbackFun: expectAsync0(() {}));
        final db = new DatastoreDBMock(transactionMock: transactionMock);
        final tarballStorage = new TarballStorageMock();
        final repo = new GCloudPackageRepository(db, tarballStorage);

        final pkg = testPackage.name;
        testPackage.uploaderEmails = ['foo@bar.com'];
        registerLoggedInUser(testPackage.uploaderEmails.first);
        await repo
            .removeUploader(pkg, 'foo@bar.com')
            .catchError(expectAsync2((e, _) {
          expect(e is pub_server.LastUploaderRemoveException, isTrue);
        }));
      });

      scopedTest('cannot remove non-existent uploader', () async {
        final transactionMock = new TransactionMock(
            lookupFun: expectAsync1((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, testPackage.key);
              return [testPackage];
            }),
            rollbackFun: expectAsync0(() {}));
        final db = new DatastoreDBMock(transactionMock: transactionMock);
        final tarballStorage = new TarballStorageMock();
        final repo = new GCloudPackageRepository(db, tarballStorage);

        final pkg = testPackage.name;
        testPackage.uploaderEmails = ['foo1@bar.com'];
        registerLoggedInUser(testPackage.uploaderEmails.first);
        await repo
            .removeUploader(pkg, 'foo2@bar.com')
            .catchError(expectAsync2((e, _) {
          expect('$e', 'The uploader to remove does not exist.');
        }));
      });

      scopedTest('cannot remove self', () async {
        final transactionMock = new TransactionMock(
            lookupFun: expectAsync1((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, testPackage.key);
              return [testPackage];
            }),
            rollbackFun: expectAsync0(() {}));
        final db = new DatastoreDBMock(transactionMock: transactionMock);
        final tarballStorage = new TarballStorageMock();
        final repo = new GCloudPackageRepository(db, tarballStorage);

        final pkg = testPackage.name;
        testPackage.uploaderEmails = ['foo1@bar.com', 'foo2@bar.com'];
        registerLoggedInUser(testPackage.uploaderEmails.first);
        await repo
            .removeUploader(pkg, 'foo1@bar.com')
            .catchError(expectAsync2((e, _) {
          expect('$e',
              'Self-removal is not allowed. Use another account to remove this e-mail address.');
        }));
      });

      scopedTest('successful', () async {
        final historyBackendMock = new HistoryBackendMock();
        registerHistoryBackend(historyBackendMock);
        final completion = new TestDelayCompletion();
        final transactionMock = new TransactionMock(
            lookupFun: expectAsync1((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, testPackage.key);
              return [testPackage];
            }),
            queueMutationFun: ({inserts, deletes}) {
              expect(inserts, hasLength(1));
              expect(inserts.first.uploaderEmails.contains('b@x.com'), isFalse);
              completion.complete();
            },
            commitFun: expectAsync0(() {}));
        final db = new DatastoreDBMock(transactionMock: transactionMock);
        final tarballStorage = new TarballStorageMock();
        final repo = new GCloudPackageRepository(db, tarballStorage);

        final pkg = testPackage.name;
        testPackage.uploaderEmails = ['a@x.com', 'b@x.com'];
        registerLoggedInUser(testPackage.uploaderEmails.first);
        await repo.removeUploader(pkg, 'b@x.com');
        expect(historyBackendMock.storedHistories, hasLength(1));
      });
    });

    group('GCloudRepository.downloadUrl', () {
      test('successful', () async {
        final tarballStorage = new TarballStorageMock(
            downloadUrlFun: expectAsync2((package, version) {
          return Uri.parse('http://blobstore/$package/$version.tar.gz');
        }));
        final repo = new GCloudPackageRepository(null, tarballStorage);

        final url = await repo.downloadUrl('foo', '0.1.0');
        expect('$url', 'http://blobstore/foo/0.1.0.tar.gz');
      });
    });

    group('GCloudRepository.download', () {
      test('successful', () async {
        final tarballStorage = new TarballStorageMock(
            downloadFun: expectAsync2((package, version) {
          return new Stream.fromIterable([
            [1, 2, 3]
          ]);
        }));
        final repo = new GCloudPackageRepository(null, tarballStorage);

        final stream = await repo.download('foo', '0.1.0');
        final data = await stream.fold([], (b, d) => b..addAll(d));
        expect(data, [1, 2, 3]);
      });
    });

    group('GCloudRepository.lookupVersion', () {
      test('not found', () async {
        final db = new DatastoreDBMock(lookupFun: expectAsync1((keys) {
          expect(keys, hasLength(1));
          expect(keys.first, testPackageVersionKey);
          return [null];
        }));
        final repo = new GCloudPackageRepository(db, null);
        final version = await repo.lookupVersion(
            testPackageVersion.package, testPackageVersion.version);
        expect(version, isNull);
      });

      test('successful', () async {
        final db = new DatastoreDBMock(lookupFun: expectAsync1((keys) {
          expect(keys, hasLength(1));
          expect(keys.first, testPackageVersionKey);
          return [testPackageVersion];
        }));
        final repo = new GCloudPackageRepository(db, null);
        final version = await repo.lookupVersion(
            testPackageVersion.package, testPackageVersion.version);
        expect(version, isNotNull);
        expect(version.packageName, testPackageVersion.package);
        expect(version.versionString, testPackageVersion.version);
      });
    });

    group('GCloudRepository.versions', () {
      test('not found', () async {
        final completion = new TestDelayCompletion();
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
          return new Stream.fromIterable(<PackageVersion>[]);
        }

        final queryMock = new QueryMock(queryRunFun);
        final db = new DatastoreDBMock(queryMock: queryMock);
        final repo = new GCloudPackageRepository(db, null);
        final version =
            await repo.versions(testPackageVersion.package).toList();
        expect(version, isEmpty);
      });

      test('found', () async {
        final completion = new TestDelayCompletion();
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
          return new Stream.fromIterable([testPackageVersion]);
        }

        final queryMock = new QueryMock(queryRunFun);
        final db = new DatastoreDBMock(queryMock: queryMock);
        final repo = new GCloudPackageRepository(db, null);
        final version =
            await repo.versions(testPackageVersion.package).toList();
        expect(version, hasLength(1));
        expect(version.first.packageName, testPackageVersion.package);
        expect(version.first.versionString, testPackageVersion.version);
      });
    });

    group('uploading', () {
      final dateBeforeTest = new DateTime.now().toUtc();

      void validateSuccessfullUpdate(List<Model> inserts) {
        expect(inserts, hasLength(2));
        final Package package = inserts[0];
        final PackageVersion version = inserts[1];

        expect(package.key, testPackage.key);
        expect(package.name, testPackage.name);
        expect(package.latestVersionKey, testPackageVersion.key);
        expect(package.uploaderEmails, ['hans@juergen.com']);
        expect(package.created.compareTo(dateBeforeTest) >= 0, isTrue);
        expect(package.updated.compareTo(dateBeforeTest) >= 0, isTrue);

        expect(version.key, testPackageVersion.key);
        expect(version.packageKey, testPackage.key);
        expect(version.created.compareTo(dateBeforeTest) >= 0, isTrue);
        expect(version.readmeFilename, 'README.md');
        expect(version.readmeContent, TestPackageReadme);
        expect(version.changelogFilename, 'CHANGELOG.md');
        expect(version.changelogContent, TestPackageChangelog);
        expect(version.pubspec.asJson, loadYaml(TestPackagePubspec));
        expect(version.libraries, ['test_library.dart']);
        expect(version.downloads, 0);

        expect(version.sortOrder, 1);
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
        return new Stream.fromIterable([testPackageVersion]);
      }

      group('GCloudRepository.startAsyncUpload', () {
        final Uri redirectUri = Uri.parse('http://blobstore.com/upload');

        scopedTest('no active user', () async {
          final db = new DatastoreDBMock();
          final repo = new GCloudPackageRepository(db, null);
          registerUploadSigner(new UploadSignerServiceMock(null));
          await repo
              .startAsyncUpload(redirectUri)
              .catchError(expectAsync2((e, _) {
            expect(e is pub_server.UnauthorizedAccessException, isTrue);
          }));
        });

        scopedTest('successful', () async {
          final uri = Uri.parse('http://foobar.com');
          final expectedUploadInfo =
              new pub_server.AsyncUploadInfo(uri, {'a': 'b'});
          final bucketMock = new BucketMock('mbucket');
          final tarballStorage = new TarballStorageMock(
              tmpObjectNameFun: expectAsync1((guid) {
                return 'obj/$guid';
              }),
              bucketMock: bucketMock);
          final db = new DatastoreDBMock();
          final repo = new GCloudPackageRepository(db, tarballStorage);
          final uploadSignerMock = new UploadSignerServiceMock(
              (bucket, object, lifetime, successRedirectUrl,
                  {predefinedAcl, maxUploadSize}) {
            expect(bucket, 'mbucket');
            return expectedUploadInfo;
          });
          registerUploadSigner(uploadSignerMock);
          registerLoggedInUser('hans@juergen.com');
          final uploadInfo = await repo.startAsyncUpload(redirectUri);
          expect(identical(uploadInfo, expectedUploadInfo), isTrue);
        });
      });

      group('GCloudRepository.finishAsyncUpload', () {
        final Uri redirectUri =
            Uri.parse('http://blobstore.com/upload?upload_id=myguid');

        scopedTest('upload-too-big', () async {
          final oneKB = new List.filled(1024, 42);
          final bigTarball = <List<int>>[];
          for (int i = 0; i < UploadSignerService.maxUploadSize ~/ 1024; i++) {
            bigTarball.add(oneKB);
          }
          // Add one more byte than allowed.
          bigTarball.add([1]);

          final tarballStorage =
              new TarballStorageMock(readTempObjectFun: (guid) {
            expect(guid, 'myguid');
            return new Stream.fromIterable(bigTarball);
          }, removeTempObjectFun: (guid) {
            expect(guid, 'myguid');
          });
          final transactionMock = new TransactionMock();
          final db = new DatastoreDBMock(transactionMock: transactionMock);
          final repo = new GCloudPackageRepository(db, tarballStorage);
          registerLoggedInUser('hans@juergen.com');
          final Future result = repo.finishAsyncUpload(redirectUri);
          await result.catchError(expectAsync2((error, _) {
            expect(
                error,
                contains(
                    'Exceeded ${UploadSignerService.maxUploadSize} upload size'));
          }));
        }, timeout: new Timeout.factor(2));

        scopedTest('successful', () async {
          return withTestPackage((List<int> tarball) async {
            final tarballStorage = new TarballStorageMock(
                readTempObjectFun: (guid) {
              expect(guid, 'myguid');
              return new Stream.fromIterable([tarball]);
            }, uploadViaTempObjectFun:
                    (String guid, String package, String version) {
              expect(guid, 'myguid');
              expect(package, testPackage.name);
              expect(version, testPackageVersion.version);
            }, removeTempObjectFun: (guid) {
              expect(guid, 'myguid');
            });
            final queryMock = new QueryMock(sortOrderUpdateQueryMock);
            int queueMutationCallNr = 0;
            final transactionMock = new TransactionMock(
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
            final db = new DatastoreDBMock(transactionMock: transactionMock);
            final repo = new GCloudPackageRepository(db, tarballStorage,
                finishCallback: finishCallback);
            registerLoggedInUser('hans@juergen.com');
            final version = await repo.finishAsyncUpload(redirectUri);
            expect(version.packageName, testPackage.name);
            expect(version.versionString, testPackageVersion.version);
          });
        });
      });

      group('GCloudRepository.upload', () {
        scopedTest('not logged in', () async {
          return withTestPackage((List<int> tarball) async {
            final tarballStorage = new TarballStorageMock();
            final transactionMock = new TransactionMock();
            final db = new DatastoreDBMock(transactionMock: transactionMock);
            final repo = new GCloudPackageRepository(db, tarballStorage);
            repo
                .upload(new Stream.fromIterable([tarball]))
                .catchError(expectAsync2((error, _) {
              expect(error is pub_server.UnauthorizedAccessException, isTrue);
            }));
          });
        });

        scopedTest('not authorized', () async {
          return withTestPackage((List<int> tarball) async {
            final tarballStorage = new TarballStorageMock();
            final transactionMock = new TransactionMock(
                lookupFun: expectAsync1((keys) {
                  expect(keys, hasLength(2));
                  expect(keys.first, testPackageVersion.key);
                  expect(keys.last, testPackage.key);
                  return [null, testPackage];
                }),
                rollbackFun: expectAsync0(() {}));
            final db = new DatastoreDBMock(transactionMock: transactionMock);
            final repo = new GCloudPackageRepository(db, tarballStorage);
            registerLoggedInUser('un@authorized.com');
            repo
                .upload(new Stream.fromIterable([tarball]))
                .catchError(expectAsync2((error, _) {
              expect(error is pub_server.UnauthorizedAccessException, isTrue);
            }));
          });
        });

        scopedTest('versions already exist', () async {
          return withTestPackage((List<int> tarball) async {
            final tarballStorage = new TarballStorageMock();
            final transactionMock = new TransactionMock(
                lookupFun: expectAsync1((keys) {
                  expect(keys, hasLength(2));
                  expect(keys.first, testPackageVersion.key);
                  expect(keys.last, testPackage.key);
                  return [testPackageVersion, testPackage];
                }),
                rollbackFun: expectAsync0(() {}));
            final db = new DatastoreDBMock(transactionMock: transactionMock);
            final repo = new GCloudPackageRepository(db, tarballStorage);
            registerLoggedInUser('un@authorized.com');
            repo
                .upload(new Stream.fromIterable([tarball]))
                .catchError(expectAsync2((error, _) {
              expect(
                  '$error'.contains(
                      'Version 0.1.1+5 of package foobar_pkg already exists'),
                  isTrue);
            }));
          });
        });

        scopedTest('bad package names are rejected', () async {
          final tarballStorage = new TarballStorageMock();
          final transactionMock = new TransactionMock();
          final db = new DatastoreDBMock(transactionMock: transactionMock);
          final repo = new GCloudPackageRepository(db, tarballStorage);
          registerLoggedInUser('hans@juergen.com');

          // Returns the error message as String or null if it succeeded.
          Future<String> fn(String name) async {
            final String pubspecContent =
                TestPackagePubspec.replaceAll('foobar_pkg', name);
            try {
              await withTestPackage((List<int> tarball) async {
                await repo.upload(new Stream.fromIterable([tarball]));
              }, pubspecContent: pubspecContent);
            } catch (e) {
              return e.toString();
            }
            // no issues, return null
            return null;
          }

          expect(await fn('with'),
              'Exception: Package name must not be a reserved word in Dart.');
          expect(await fn('123test'),
              'Exception: Package name must begin with a letter or underscore.');
          expect(
              await fn('With Space'),
              'Exception: Package name may only contain '
              'letters, numbers, and underscores.');

          expect(await fn('ok_name'), 'Exception: no lookupFun');
        });

        scopedTest('upload-too-big', () async {
          final oneKB = new List.filled(1024, 42);
          final List<List<int>> bigTarball = [];
          for (int i = 0; i < UploadSignerService.maxUploadSize ~/ 1024; i++) {
            bigTarball.add(oneKB);
          }
          // Add one more byte than allowed.
          bigTarball.add([1]);

          final tarballStorage = new TarballStorageMock();
          final transactionMock = new TransactionMock();
          final db = new DatastoreDBMock(transactionMock: transactionMock);
          final repo = new GCloudPackageRepository(db, tarballStorage);
          registerLoggedInUser('hans@juergen.com');
          final Future result =
              repo.upload(new Stream.fromIterable(bigTarball));
          await result.catchError(expectAsync2((error, _) {
            expect(
                error,
                contains(
                    'Exceeded ${UploadSignerService.maxUploadSize} upload size'));
          }));
        }, timeout: new Timeout.factor(2));

        scopedTest('successful', () async {
          return withTestPackage((List<int> tarball) async {
            final completion = new TestDelayCompletion(count: 2);
            final tarballStorage = new TarballStorageMock(uploadFun:
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
            final queryMock = new QueryMock(sortOrderUpdateQueryMock);
            final transactionMock = new TransactionMock(
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

            final db = new DatastoreDBMock(transactionMock: transactionMock);
            final repo = new GCloudPackageRepository(db, tarballStorage,
                finishCallback: finishCallback);
            registerLoggedInUser('hans@juergen.com');
            final version =
                await repo.upload(new Stream.fromIterable([tarball]));
            expect(version.packageName, testPackage.name);
            expect(version.versionString, testPackageVersion.version);
          });
        });
      });
    }, timeout: new Timeout.factor(2));
  });
}
