// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@Timeout(const Duration(seconds: 15))
library pub_dartlang_org.backend_test;

import 'dart:async';

import 'package:test/test.dart';
import 'package:gcloud/db.dart';
import 'package:yaml/yaml.dart';

import 'package:pub_server/repository.dart' as pub_server;
import 'package:pub_dartlang_org/upload_signer_service.dart';
import 'package:pub_dartlang_org/backend.dart';
import 'package:pub_dartlang_org/models.dart';

import 'backend_test_utils.dart';

import 'utils.dart';

// TODO: Add missing tests when a query returns more than one result.
main() {
  group('backend', () {
    group('Backend.latestPackages', () {
      ({
        'one package' : [testPackage],
        'empty' : [],
      }).forEach((String testName, List<Package> expectedPackages) {
        test(testName, () async {
          var completion = new TestDelayCompletion();
          queryRunFun({kind, partition, ancestorKey, filters,
                       filterComparisonObjects, offset, limit, orders}) {
            completion.complete();
            expect(kind, Package);
            expect(offset, 4);
            expect(limit, 9);
            expect(orders, ['-updated']);
            return new Stream.fromIterable(expectedPackages);
          }

          var db = new DatastoreDBMock(queryMock: new QueryMock(queryRunFun));
          var backend = new Backend(db, null);

          var packages = await backend.latestPackages(offset: 4, limit: 9);
          expect(packages, equals(expectedPackages));
        });
      });
    });

    group('Backend.latestPackageVersions', () {
      test('one package', () async {
        var completion = new TestDelayCompletion();
        queryRunFun({kind, partition, ancestorKey, filters,
                     filterComparisonObjects, offset, limit, orders}) {
          completion.complete();
          expect(kind, Package);
          expect(offset, 4);
          expect(limit, 9);
          expect(orders, ['-updated']);
          return new Stream.fromIterable([testPackage]);
        }

        lookupFun(keys) {
          expect(keys, hasLength(1));
          expect(keys.first, testPackage.latestVersionKey);
          return [testPackageVersion];
        }

        var db = new DatastoreDBMock(queryMock: new QueryMock(queryRunFun),
                                     lookupFun: expectAsync(lookupFun));
        var backend = new Backend(db, null);

        var versions = await backend.latestPackageVersions(offset: 4, limit: 9);
        expect(versions, hasLength(1));
        expect(versions.first, equals(testPackageVersion));
      });

      test('empty', () async {
        var completion = new TestDelayCompletion();
        queryRunFun({kind, partition, ancestorKey, filters,
                     filterComparisonObjects, offset, limit, orders}) {
          completion.complete();
          expect(kind, Package);
          expect(offset, 4);
          expect(limit, 9);
          expect(orders, ['-updated']);
          return new Stream.fromIterable([]);
        }

        lookupFun(keys) {
          expect(keys, hasLength(0));
          return [];
        }

        var db = new DatastoreDBMock(queryMock: new QueryMock(queryRunFun),
                                     lookupFun: expectAsync(lookupFun));
        var backend = new Backend(db, null);

        var versions = await backend.latestPackageVersions(offset: 4, limit: 9);
        expect(versions, hasLength(0));
      });
    });

    group('Backend.lookupPackage', () {
      ({
        'exists' : [testPackage],
        'does not exist' : [null],
      }).forEach((String testName, List<Package> expectedPackages) {
        test(testName, () async {
          lookupFun(List<Key> keys) {
            expect(keys, hasLength(1));
            expect(keys.first.type, Package);
            expect(keys.first.id, 'foobar');
            return expectedPackages;
          }

          var db = new DatastoreDBMock(lookupFun: expectAsync(lookupFun));
          var backend = new Backend(db, null);

          var package = await backend.lookupPackage('foobar');
          expect(package, equals(expectedPackages.first));
        });
      });
    });

    group('Backend.lookupPackageVersion', () {
      ({
        'exists' : [testPackageVersion],
        'does not exist' : [null],
      }).forEach((String testName, List<PackageVersion> expectedVersions) {
        test(testName, () async {
          lookupFun(List<Key> keys) {
            expect(keys, hasLength(1));
            expect(keys.first, testPackageVersion.key);
            return expectedVersions;
          }

          var db = new DatastoreDBMock(lookupFun: expectAsync(lookupFun));
          var backend = new Backend(db, null);

          var version = await backend.lookupPackageVersion(
              testPackageVersion.package, testPackageVersion.version);
          expect(version, equals(expectedVersions.first));
        });
      });
    });


    group('Backend.lookupLatestVersions', () {
      ({
        'one version' : [testPackageVersion],
        'empty' : [null],
      }).forEach((String testName, List<PackageVersion> expectedVersions) {
        test(testName, () async {
          lookupFun(List<Key> keys) {
            expect(keys, hasLength(1));
            expect(keys.first, testPackageVersion.key);
            return expectedVersions;
          }

          var db = new DatastoreDBMock(lookupFun: expectAsync(lookupFun));
          var backend = new Backend(db, null);

          var versions = await backend.lookupLatestVersions([testPackage]);
          expect(versions, hasLength(1));
          expect(versions.first, equals(expectedVersions.first));
        });
      });
    });


    group('Backend.versionsOfPackage', () {
      ({
        'one version' : [testPackageVersion],
        'empty' : [null],
      }).forEach((String testName, List<PackageVersion> expectedVersions) {
        test(testName, () async {
          var completion = new TestDelayCompletion();
          queryRunFun({kind, partition, ancestorKey, filters,
                       filterComparisonObjects, offset, limit, orders}) {
            completion.complete();
            expect(kind, PackageVersion);
            expect(ancestorKey, testPackage.key);
            return new Stream.fromIterable(expectedVersions);
          }

          var db = new DatastoreDBMock(queryMock: new QueryMock(queryRunFun));
          var backend = new Backend(db, null);

          var versions = await backend.versionsOfPackage(testPackage.name);
          expect(versions, hasLength(1));
          expect(versions.first, equals(expectedVersions.first));
        });
      });
    });

    test('Backend.downloadUrl', () async {
      var db = new DatastoreDBMock();
      var tarballStorage = new TarballStorageMock(
          downloadUrlFun: expectAsync((package, version) {
        expect(package, 'foobar');
        expect(version, '0.1.0');
        return Uri.parse('http://blob/foobar/0.1.0.tar.gz');
      }));
      var backend = new Backend(db, tarballStorage);

      var url = await backend.downloadUrl('foobar', '0.1.0');
      expect(url.toString(), 'http://blob/foobar/0.1.0.tar.gz');
    });
  });

  group('backend.repository', () {
    void negativeUploaderTests(Function getMethod(repo)) {
      scopedTest('not logged in', () async {
        var db = new DatastoreDBMock();
        var tarballStorage = new TarballStorageMock();
        var repo = new GCloudPackageRepository(db, tarballStorage);

        var pkg = testPackage.name;
        await getMethod(repo)(pkg, 'a@b.com').catchError(expectAsync((e, _) {
          expect(e is pub_server.UnauthorizedAccessException, isTrue);
        }));
      });

      scopedTest('not authorized', () async {
        var transactionMock = new TransactionMock(
            lookupFun: expectAsync((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, testPackage.key);
              return [testPackage];
            }),
            rollbackFun: expectAsync(() {}));
        var db = new DatastoreDBMock(transactionMock: transactionMock);
        var tarballStorage = new TarballStorageMock();
        var repo = new GCloudPackageRepository(db, tarballStorage);

        var pkg = testPackage.name;
        registerLoggedInUser('foo@bar.com');
        await getMethod(repo)(pkg, 'a@b.com').catchError(expectAsync((e, _) {
          expect(e is pub_server.UnauthorizedAccessException, isTrue);
        }));
      });

      scopedTest('package does not exist', () async {
        var transactionMock = new TransactionMock(
            lookupFun: expectAsync((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, testPackage.key);
              return [null];
            }),
            rollbackFun: expectAsync(() {}));
        var db = new DatastoreDBMock(transactionMock: transactionMock);
        var tarballStorage = new TarballStorageMock();
        var repo = new GCloudPackageRepository(db, tarballStorage);

        var pkg = testPackage.name;
        registerLoggedInUser(testPackage.uploaderEmails.first);
        await getMethod(repo)(pkg, 'a@b.com').catchError(expectAsync((e, _) {
          expect('$e', equals('Exception: Package "null" does not exist'));
        }));
      });
    }

    group('GCloudRepository.addUploader', () {
      negativeUploaderTests((repo) => repo.addUploader);

      testAlreadyExists(user, uploaderEmails, newUploader) async {
        var transactionMock = new TransactionMock(
            lookupFun: expectAsync((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, testPackage.key);
              return [testPackage];
            }),
            rollbackFun: expectAsync(() {}));
        var db = new DatastoreDBMock(transactionMock: transactionMock);
        var tarballStorage = new TarballStorageMock();
        var repo = new GCloudPackageRepository(db, tarballStorage);

        var pkg = testPackage.name;
        registerLoggedInUser(user);
        testPackage.uploaderEmails = uploaderEmails;
        await repo.addUploader(pkg, newUploader).catchError(expectAsync((e,_) {
          expect(e is pub_server.UploaderAlreadyExistsException, isTrue);
        }));
      }

      test('already exists', () async {
        await scoped(() => testAlreadyExists(
            'foo@b.com', ['foo@b.com'], 'foo@b.com'));
        await scoped(() => testAlreadyExists(
            'foo@B.com', ['foo@b.com'], 'foo@b.com'));
        await scoped(() => testAlreadyExists(
            'foo@B.com', ['foo@B.com'], 'foo@b.com'));
        await scoped(() => testAlreadyExists(
            'foo@b.com', ['foo@B.com'], 'foo@B.com'));
        await scoped(() => testAlreadyExists(
            'foo@b.com', ['foo@b.com'], 'foo@B.com'));
        await scoped(() => testAlreadyExists(
            'foo@B.com', ['foo@b.com'], 'foo@B.com'));
        await scoped(() => testAlreadyExists(
            'foo@b.com', ['foo@b.com', 'bar@b.com'], 'foo@B.com'));
        await scoped(() => testAlreadyExists(
            'foo@b.com', ['bar@b.com', 'foo@b.com'], 'foo@B.com'));
      });

      testSuccessful(user, uploaderEmails, newUploader) async {
        var completion = new TestDelayCompletion();
        var transactionMock = new TransactionMock(
            lookupFun: expectAsync((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, testPackage.key);
              return [testPackage];
            }),
            queueMutationFun: ({inserts, deletes}) {
              expect(inserts, hasLength(1));
              for (var email in uploaderEmails) {
                expect(inserts.first.uploaderEmails, contains(email));
              }
              expect(inserts.first.uploaderEmails, contains(newUploader));
              completion.complete();
            },
            commitFun: expectAsync(() {}));
        var db = new DatastoreDBMock(transactionMock: transactionMock);
        var tarballStorage = new TarballStorageMock();
        var repo = new GCloudPackageRepository(db, tarballStorage);

        var pkg = testPackage.name;
        testPackage.uploaderEmails = uploaderEmails;
        registerLoggedInUser(user);
        await repo.addUploader(pkg, newUploader);
      };

      test('successful', () async {
        await scoped(() => testSuccessful(
            'foo@b.com', ['foo@b.com'], 'bar@b.com'));
        await scoped(() => testSuccessful(
            'foo@B.com', ['foo@b.com'], 'bar@B.com'));
        await scoped(() => testSuccessful(
            'foo@B.com', ['foo@B.com', 'bar@b.com'], 'baz@b.com'));
        await scoped(() => testSuccessful(
            'foo@b.com', ['foo@B.com', 'bar@B.com'], 'baz@B.com'));
      });
    });

    group('GCloudRepository.removeUploader', () {
      negativeUploaderTests((repo) => repo.removeUploader);

      scopedTest('cannot remove last uploader', () async {
        var transactionMock = new TransactionMock(
            lookupFun: expectAsync((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, testPackage.key);
              return [testPackage];
            }),
            rollbackFun: expectAsync(() {}));
        var db = new DatastoreDBMock(transactionMock: transactionMock);
        var tarballStorage = new TarballStorageMock();
        var repo = new GCloudPackageRepository(db, tarballStorage);

        var pkg = testPackage.name;
        testPackage.uploaderEmails = ['foo@bar.com'];
        registerLoggedInUser(testPackage.uploaderEmails.first);
        await repo.removeUploader(pkg, 'foo@bar.com')
            .catchError(expectAsync((e, _) {
          expect(e is pub_server.LastUploaderRemoveException, isTrue);
        }));
      });

      scopedTest('cannot remove non-existent uploader', () async {
        var transactionMock = new TransactionMock(
            lookupFun: expectAsync((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, testPackage.key);
              return [testPackage];
            }),
            rollbackFun: expectAsync(() {}));
        var db = new DatastoreDBMock(transactionMock: transactionMock);
        var tarballStorage = new TarballStorageMock();
        var repo = new GCloudPackageRepository(db, tarballStorage);

        var pkg = testPackage.name;
        testPackage.uploaderEmails = ['foo1@bar.com'];
        registerLoggedInUser(testPackage.uploaderEmails.first);
        await repo.removeUploader(pkg, 'foo2@bar.com')
            .catchError(expectAsync((e, _) {
          expect('$e', 'Exception: The uploader to remove does not exist.');
        }));
      });

      scopedTest('successful', () async {
        var completion = new TestDelayCompletion();
        var transactionMock = new TransactionMock(
            lookupFun: expectAsync((keys) {
              expect(keys, hasLength(1));
              expect(keys.first, testPackage.key);
              return [testPackage];
            }),
            queueMutationFun: ({inserts, deletes}) {
              expect(inserts, hasLength(1));
              expect(inserts.first.uploaderEmails.contains('b@x.com'), isFalse);
              completion.complete();
            },
            commitFun: expectAsync(() {}));
        var db = new DatastoreDBMock(transactionMock: transactionMock);
        var tarballStorage = new TarballStorageMock();
        var repo = new GCloudPackageRepository(db, tarballStorage);

        var pkg = testPackage.name;
        testPackage.uploaderEmails = ['a@x.com', 'b@x.com'];
        registerLoggedInUser(testPackage.uploaderEmails.first);
        await repo.removeUploader(pkg, 'b@x.com');
      });
    });

    group('GCloudRepository.downloadUrl', () {
      test('successful', () async {
        var tarballStorage = new TarballStorageMock(
            downloadUrlFun: expectAsync((package, version) {
          return Uri.parse('http://blobstore/$package/$version.tar.gz');
        }));
        var repo = new GCloudPackageRepository(null, tarballStorage);

        var url = await repo.downloadUrl('foo', '0.1.0');
        expect('$url', 'http://blobstore/foo/0.1.0.tar.gz');
      });
    });

    group('GCloudRepository.download', () {
      test('successful', () async {
        var tarballStorage = new TarballStorageMock(
            downloadFun: expectAsync((package, version) {
          return new Stream.fromIterable([[1, 2, 3]]);
        }));
        var repo = new GCloudPackageRepository(null, tarballStorage);

        var stream = await repo.download('foo', '0.1.0');
        var data = await stream.fold([], (b, d) => b..addAll(d));
        expect(data, [1, 2, 3]);
      });
    });

    group('GCloudRepository.lookupVersion', () {
      test('not found', () async {
        var db = new DatastoreDBMock(lookupFun: expectAsync((keys) {
          expect(keys, hasLength(1));
          expect(keys.first, testPackageVersionKey);
          return [null];
        }));
        var repo = new GCloudPackageRepository(db, null);
        var version = await repo.lookupVersion(testPackageVersion.package,
                                               testPackageVersion.version);
        expect(version, isNull);
      });

      test('successful', () async {
        var db = new DatastoreDBMock(lookupFun: expectAsync((keys) {
          expect(keys, hasLength(1));
          expect(keys.first, testPackageVersionKey);
          return [testPackageVersion];
        }));
        var repo = new GCloudPackageRepository(db, null);
        var version = await repo.lookupVersion(testPackageVersion.package,
                                               testPackageVersion.version);
        expect(version, isNotNull);
        expect(version.packageName, testPackageVersion.package);
        expect(version.versionString, testPackageVersion.version);
      });
    });

    group('GCloudRepository.versions', () {
      test('not found', () async {
        var completion = new TestDelayCompletion();
        queryRunFun({kind, partition, ancestorKey, filters,
                     filterComparisonObjects, offset, limit, orders}) {
          completion.complete();
          expect(kind, PackageVersion);
          expect(ancestorKey, testPackageKey);
          return new Stream.fromIterable([]);
        }
        var queryMock = new QueryMock(queryRunFun);
        var db = new DatastoreDBMock(queryMock: queryMock);
        var repo = new GCloudPackageRepository(db, null);
        var version = await repo.versions(testPackageVersion.package).toList();
        expect(version, isEmpty);
      });

      test('found', () async {
        var completion = new TestDelayCompletion();
        queryRunFun({kind, partition, ancestorKey, filters,
                     filterComparisonObjects, offset, limit, orders}) {
          completion.complete();
          expect(kind, PackageVersion);
          expect(ancestorKey, testPackageKey);
          return new Stream.fromIterable([testPackageVersion]);
        }
        var queryMock = new QueryMock(queryRunFun);
        var db = new DatastoreDBMock(queryMock: queryMock);
        var repo = new GCloudPackageRepository(db, null);
        var version = await repo.versions(testPackageVersion.package).toList();
        expect(version, hasLength(1));
        expect(version.first.packageName, testPackageVersion.package);
        expect(version.first.versionString, testPackageVersion.version);
      });
    });

    group('uploading', () {
      var dateBeforeTest = new DateTime.now().toUtc();

      validateSuccessfullUpdate(List<Model> inserts) {
        expect(inserts, hasLength(2));
        Package package = inserts[0];
        PackageVersion version = inserts[1];

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

      validateSuccessfullSortOrderUpdate(PackageVersion model) {
        expect(model.sortOrder, 0);
      }

      sortOrderUpdateQueryMock({Type kind, Partition partition, Key ancestorKey,
                                List<String> filters,
                                List filterComparisonObjects,
                                int offset, int limit,
                                List<String> orders}) {
          expect(orders, []);
          expect(filters, []);
          expect(offset, isNull);
          expect(limit, isNull);
          expect(kind, PackageVersion);
          expect(ancestorKey, testPackage.key);
          testPackageVersion.sortOrder = 50;
          return new Stream.fromIterable([testPackageVersion]);
      }

      group('GCloudRepository.startAsyncUpload', () {
        final Uri redirectUri = Uri.parse('http://blobstore.com/upload');

        scopedTest('no active user', () async {
          var db = new DatastoreDBMock();
          var repo = new GCloudPackageRepository(db, null);
          registerUploadSigner(new UploadSignerServiceMock(null));
          await repo.startAsyncUpload(redirectUri)
              .catchError(expectAsync((e, _) {
            expect(e is pub_server.UnauthorizedAccessException, isTrue);
          }));
        });

        scopedTest('successful', () async {
          var uri = Uri.parse('http://foobar.com');
          var expectedUploadInfo =
              new pub_server.AsyncUploadInfo(uri, {'a' : 'b'});
          var bucketMock = new BucketMock('mbucket');
          var tarballStorage = new TarballStorageMock(
              tmpObjectNameFun: expectAsync((guid) {
                return 'obj/$guid';
              }), bucketMock: bucketMock);
          var db = new DatastoreDBMock();
          var repo = new GCloudPackageRepository(db, tarballStorage);
          var uploadSignerMock = new UploadSignerServiceMock(
              (bucket, object, lifetime, successRedirectUrl,
               {predefinedAcl, maxUploadSize}) {
            expect(bucket, 'mbucket');
            return expectedUploadInfo;
          });
          registerUploadSigner(uploadSignerMock);
          registerLoggedInUser('hans@juergen.com');
          var uploadInfo = await repo.startAsyncUpload(redirectUri);
          expect(identical(uploadInfo, expectedUploadInfo), isTrue);
        });
      });

      group('GCloudRepository.finishAsyncUpload', () {
        final Uri redirectUri =
            Uri.parse('http://blobstore.com/upload?upload_id=myguid');

        scopedTest('upload-too-big', () async {
          var oneKB = new List.filled(1024, 42);
          var bigTarball = [];
          for (int i = 0;
              i < UploadSignerService.MAX_UPLOAD_SIZE ~/ 1024;
              i++) {
            bigTarball.add(oneKB);
          }
          // Add one more byte than allowed.
          bigTarball.add([1]);

          var tarballStorage = new TarballStorageMock(
              readTempObjectFun: (guid) {
                expect(guid, 'myguid');
                return new Stream.fromIterable(bigTarball);
              },
              removeTempObjectFun: (guid) {
                expect(guid, 'myguid');
              });
          var transactionMock = new TransactionMock();
          var db = new DatastoreDBMock(transactionMock: transactionMock);
          var repo = new GCloudPackageRepository(db, tarballStorage);
          registerLoggedInUser('hans@juergen.com');
          Future result = repo.finishAsyncUpload(redirectUri);
          await result.catchError(expectAsync((error, _) {
            expect(error, contains(
                'Exceeded ${UploadSignerService.MAX_UPLOAD_SIZE} upload size'));
          }));
        });

        scopedTest('successful', () async {
          return withTestPackage((List<int> tarball) async {
            var tarballStorage = new TarballStorageMock(
                readTempObjectFun: (guid) {
                  expect(guid, 'myguid');
                  return new Stream.fromIterable([tarball]);
                },
                uploadViaTempObjectFun : (String guid,
                                          String package,
                                          String version) {
                  expect(guid, 'myguid');
                  expect(package, testPackage.name);
                  expect(version, testPackageVersion.version);
                },
                removeTempObjectFun: (guid) {
                  expect(guid, 'myguid');
                });
            var queryMock = new QueryMock(sortOrderUpdateQueryMock);
            int queueMutationCallNr = 0;
            var transactionMock = new TransactionMock(
                lookupFun: (keys) {
                  expect(keys, hasLength(2));
                  expect(keys.first, testPackageVersion.key);
                  expect(keys.last, testPackage.key);
                  return [null, null];
                },
                queueMutationFun: ({inserts, deletes}) {
                  if (queueMutationCallNr == 0) {
                    validateSuccessfullUpdate(inserts);
                  } else {
                    expect(queueMutationCallNr, 1);
                    expect(inserts, [testPackageVersion]);
                    validateSuccessfullSortOrderUpdate(inserts.first);
                  }
                  queueMutationCallNr++;
                },
                commitFun: expectAsync(() {}, count: 2),
                queryMock: queryMock);
            var db = new DatastoreDBMock(transactionMock: transactionMock);
            var repo = new GCloudPackageRepository(db, tarballStorage);
            registerLoggedInUser('hans@juergen.com');
            var version = await repo.finishAsyncUpload(redirectUri);
            expect(version.packageName, testPackage.name);
            expect(version.versionString, testPackageVersion.version);
          });
        });
      });

      group('GCloudRepository.upload', () {
        scopedTest('not logged in', () async {
          return withTestPackage((List<int> tarball) async {
            var tarballStorage = new TarballStorageMock();
            var transactionMock = new TransactionMock();
            var db = new DatastoreDBMock(transactionMock: transactionMock);
            var repo = new GCloudPackageRepository(db, tarballStorage);
            repo.upload(new Stream.fromIterable([tarball]))
                .catchError(expectAsync((error, _) {
              expect(error is pub_server.UnauthorizedAccessException, isTrue);
            }));
          });
        });

        scopedTest('not authorized', () async {
          return withTestPackage((List<int> tarball) async {
            var tarballStorage = new TarballStorageMock();
            var transactionMock = new TransactionMock(
                lookupFun: expectAsync((keys) {
                  expect(keys, hasLength(2));
                  expect(keys.first, testPackageVersion.key);
                  expect(keys.last, testPackage.key);
                  return [null, testPackage];
                }),
                rollbackFun: expectAsync(() {}));
            var db = new DatastoreDBMock(transactionMock: transactionMock);
            var repo = new GCloudPackageRepository(db, tarballStorage);
            registerLoggedInUser('un@authorized.com');
            repo.upload(new Stream.fromIterable([tarball]))
                .catchError(expectAsync((error, _) {
              expect(error is pub_server.UnauthorizedAccessException, isTrue);
            }));
          });
        });

        scopedTest('versions already exist', () async {
          return withTestPackage((List<int> tarball) async {
            var tarballStorage = new TarballStorageMock();
            var transactionMock = new TransactionMock(
                lookupFun: expectAsync((keys) {
                  expect(keys, hasLength(2));
                  expect(keys.first, testPackageVersion.key);
                  expect(keys.last, testPackage.key);
                  return [testPackageVersion, testPackage];
                }),
                rollbackFun: expectAsync(() {}));
            var db = new DatastoreDBMock(transactionMock: transactionMock);
            var repo = new GCloudPackageRepository(db, tarballStorage);
            registerLoggedInUser('un@authorized.com');
            repo.upload(new Stream.fromIterable([tarball]))
                .catchError(expectAsync((error, _) {
              expect(
                  '$error'.contains(
                      'Version 0.1.1 of package foobar_pkg already exists'),
                  isTrue);
            }));
          });
        });

        scopedTest('bad package names are rejected', () async {
          var tarballStorage = new TarballStorageMock();
          var transactionMock = new TransactionMock();
          var db = new DatastoreDBMock(transactionMock: transactionMock);
          var repo = new GCloudPackageRepository(db, tarballStorage);
          registerLoggedInUser('hans@juergen.com');

          // Returns the error message as String or null if it succeeded.
          fn(String name) async {
            String pubspecContent =
                TestPackagePubspec.replaceAll('foobar_pkg', name);
            try {
              await withTestPackage((List<int> tarball) async {
                await repo.upload(new Stream.fromIterable([tarball]));
              }, pubspecContent: pubspecContent);
            } catch (e) {
              return e.toString();
            }
          };

          expect(await fn('with'),
              'Exception: Package name must not be a reserved word in Dart.');
          expect(await fn('123test'),
              'Exception: Package name must begin with a letter or underscore.');
          expect(await fn('With Space'),
              'Exception: Package name may only contain '
              'letters, numbers, and underscores.');

          expect(await fn('ok_name'), 'no lookupFun');
        });

        scopedTest('upload-too-big', () async {
          var oneKB = new List.filled(1024, 42);
          var bigTarball = [];
          for (int i = 0;
              i < UploadSignerService.MAX_UPLOAD_SIZE ~/ 1024;
              i++) {
            bigTarball.add(oneKB);
          }
          // Add one more byte than allowed.
          bigTarball.add([1]);

          var tarballStorage = new TarballStorageMock();
          var transactionMock = new TransactionMock();
          var db = new DatastoreDBMock(transactionMock: transactionMock);
          var repo = new GCloudPackageRepository(db, tarballStorage);
          registerLoggedInUser('hans@juergen.com');
          Future result = repo.upload(new Stream.fromIterable(bigTarball));
          await result.catchError(expectAsync((error, _) {
            expect(error, contains(
                'Exceeded ${UploadSignerService.MAX_UPLOAD_SIZE} upload size'));
          }));
        });

        scopedTest('successful', () async {
          return withTestPackage((List<int> tarball) async {
            var completion = new TestDelayCompletion(count: 2);
            var tarballStorage = new TarballStorageMock(
                uploadFun : (String package,
                             String version,
                             Stream<List<int>> uploadTarball) async {
                  expect(package, testPackage.name);
                  expect(version, testPackageVersion.version);

                  var bytes =
                      await uploadTarball.fold([], (b, d) => b..addAll(d));

                  expect(bytes, tarball);
                });

            // NOTE: There will be two transactions:
            //  a) for inserting a new Package + PackageVersion
            //  b) for inserting a new PackageVersions sorted by `sort_order`.
            int queueMutationCallNr = 0;
            var queryMock = new QueryMock(sortOrderUpdateQueryMock);
            var transactionMock = new TransactionMock(
                lookupFun: expectAsync((keys) {
                  expect(queueMutationCallNr, 0);

                  expect(keys, hasLength(2));
                  expect(keys.first, testPackageVersion.key);
                  expect(keys.last, testPackage.key);
                  return [null, null];
                }),
                queueMutationFun: ({inserts, deletes}) {
                  if (queueMutationCallNr == 0) {
                    validateSuccessfullUpdate(inserts);
                  } else {
                    expect(queueMutationCallNr, 1);
                    expect(inserts, [testPackageVersion]);
                    validateSuccessfullSortOrderUpdate(inserts.first);
                  }
                  queueMutationCallNr++;
                  completion.complete();
                },
                commitFun: expectAsync(() {}, count: 2),
                queryMock: queryMock);
            var db = new DatastoreDBMock(transactionMock: transactionMock);
            var repo = new GCloudPackageRepository(db, tarballStorage);
            registerLoggedInUser('hans@juergen.com');
            var version = await repo.upload(new Stream.fromIterable([tarball]));
            expect(version.packageName, testPackage.name);
            expect(version.versionString, testPackageVersion.version);
          });
        });
      });
    });
  });
}
