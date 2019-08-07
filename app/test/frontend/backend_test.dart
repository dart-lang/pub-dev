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
import 'package:pub_dartlang_org/account/models.dart';
import 'package:pub_dartlang_org/frontend/backend.dart';
import 'package:pub_dartlang_org/frontend/email_sender.dart';
import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/name_tracker.dart';
import 'package:pub_dartlang_org/frontend/upload_signer_service.dart';
import 'package:pub_dartlang_org/history/backend.dart';
import 'package:pub_dartlang_org/history/models.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/dartdoc_client.dart';
import 'package:pub_dartlang_org/shared/exceptions.dart';
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
        await dbService.commit(deletes: [
          foobarPackage.key,
          hydrogen.package.key,
          helium.package.key,
          lithium.package.key,
        ]);
        expect(await backend.latestPackages(), []);
      });

      testWithServices('default packages', () async {
        final list = await backend.latestPackages();
        expect(list.map((p) => p.name), [
          'foobar_pkg',
          'lithium',
          'helium',
          'hydrogen',
        ]);
      });

      testWithServices('default packages, extra earlier', () async {
        final p = createFoobarPackage(name: 'other')..updated = DateTime(2010);
        await dbService.commit(inserts: [p]);
        final list = await backend.latestPackages();
        expect(list.map((p) => p.name), [
          'foobar_pkg',
          'lithium',
          'helium',
          'hydrogen',
          'other',
        ]);
      });

      testWithServices('default packages, extra later', () async {
        final p = createFoobarPackage(name: 'other')..updated = DateTime(2018);
        await dbService.commit(inserts: [p]);
        final list = await backend.latestPackages();
        expect(list.map((p) => p.name), [
          'other',
          'foobar_pkg',
          'lithium',
          'helium',
          'hydrogen',
        ]);
      });

      testWithServices('default packages, offset: 2', () async {
        final list = await backend.latestPackages(offset: 2);
        expect(list.map((p) => p.name), ['helium', 'hydrogen']);
      });

      testWithServices('default packages, offset: 1, limit: 1', () async {
        final list = await backend.latestPackages(offset: 1, limit: 1);
        expect(list.map((p) => p.name), ['lithium']);
      });
    });

    group('Backend.latestPackageVersions', () {
      testWithServices('one package', () async {
        final list = await backend.latestPackageVersions(offset: 2, limit: 1);
        expect(list.map((pv) => pv.qualifiedVersionKey.toString()),
            ['helium-2.0.5']);
      });

      testWithServices('empty', () async {
        final list = await backend.latestPackageVersions(offset: 200, limit: 1);
        expect(list, isEmpty);
      });
    });

    group('Backend.lookupPackage', () {
      testWithServices('exists', () async {
        final p = await backend.lookupPackage('hydrogen');
        expect(p, isNotNull);
        expect(p.name, 'hydrogen');
        expect(p.latestVersion, isNotNull);
      });

      testWithServices('does not exists', () async {
        final p = await backend.lookupPackage('not_yet_a_package');
        expect(p, isNull);
      });
    });

    group('Backend.lookupPackageVersion', () {
      testWithServices('exists', () async {
        final p = await backend.lookupPackage('hydrogen');
        final pv =
            await backend.lookupPackageVersion('hydrogen', p.latestVersion);
        expect(pv, isNotNull);
        expect(pv.package, 'hydrogen');
        expect(pv.version, p.latestVersion);
      });

      testWithServices('package does not exists', () async {
        final pv =
            await backend.lookupPackageVersion('not_yet_a_package', '1.0.0');
        expect(pv, isNull);
      });

      testWithServices('version does not exists', () async {
        final pv = await backend.lookupPackageVersion('hydrogen', '0.0.0-dev');
        expect(pv, isNull);
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
      testWithServices('exists', () async {
        final list = await backend.versionsOfPackage('hydrogen');
        final values = list.map((pv) => pv.version).toList();
        values.sort();
        expect(values, hasLength(13));
        expect(values.first, '1.0.0');
        expect(values[5], '1.4.5');
        expect(values.last, '2.0.8');
      });

      testWithServices('package does not exists', () async {
        final list = await backend.versionsOfPackage('not_yet_a_package');
        expect(list, isEmpty);
      });
    });

    testWithServices('Backend.downloadUrl', () async {
      final url = await backend.downloadUrl('hydrogen', '2.0.8');
      expect(url.toString(),
          'http://localhost:0/fake-bucket-pub/packages/hydrogen-2.0.8.tar.gz');
    });
  });

  group('backend.repository', () {
    group('GCloudRepository.addUploader', () {
      testWithServices('not logged in', () async {
        final pkg = foobarPackage.name;
        final rs = backend.repository.addUploader(pkg, 'a@b.com');
        expectLater(rs, throwsA(isA<AuthenticationException>()));
      });

      testWithServices('not authorized', () async {
        final pkg = foobarPackage.name;
        registerAuthenticatedUser(
            AuthenticatedUser('uuid-foo-at-bar-dot-com', 'foo@bar.com'));
        final rs = backend.repository.addUploader(pkg, 'a@b.com');
        expectLater(rs, throwsA(isA<AuthorizationException>()));
      });

      testWithServices('package does not exist', () async {
        registerAuthenticatedUser(hansAuthenticated);
        final rs = backend.repository.addUploader('no_package', 'a@b.com');
        expectLater(rs, throwsA(isA<NotFoundException>()));
      });

      Future testAlreadyExists(
          String pkg, List<User> uploaders, String newUploader) async {
        final bundle = generateBundle(pkg, ['1.0.0'], uploaders: uploaders);
        await dbService.commit(inserts: [
          bundle.package,
          ...bundle.versions,
        ]);
        await backend.repository.addUploader(pkg, newUploader);
        final list = await dbService.lookup<Package>([bundle.package.key]);
        final p = list.single;
        expect(p.uploaders, uploaders.map((u) => u.userId));
      }

      testWithServices('already exists', () async {
        registerAuthenticatedUser(hansAuthenticated);
        final ucEmail = 'Hans@Juergen.Com';
        await testAlreadyExists('p1', [hansUser], hansUser.email);
        await testAlreadyExists('p2', [hansUser], ucEmail);
        await testAlreadyExists('p3', [hansUser, joeUser], ucEmail);
        await testAlreadyExists('p4', [joeUser, hansUser], ucEmail);
      });

      testWithServices('successful', () async {
        registerAuthenticatedUser(hansAuthenticated);

        final newUploader = 'somebody@example.com';
        final rs =
            backend.repository.addUploader(hydrogen.package.name, newUploader);
        await expectLater(
            rs,
            throwsA(isException.having(
                (e) => '$e',
                'text',
                'We have sent an invitation to $newUploader, '
                    'they will be added as uploader after they confirm it.')));

        // uploaders do not change yet
        final list = await dbService.lookup<Package>([hydrogen.package.key]);
        final p = list.single;
        expect(p.uploaders, [hansUser.userId]);

        // TODO: check sent e-mail
        // TODO: check consent (after migrating to consent API)
      });
    });

    group('GCloudRepository.removeUploader', () {
      testWithServices('not logged in', () async {
        final rs =
            backend.repository.removeUploader('hydrogen', hansUser.email);
        expectLater(rs, throwsA(isA<AuthenticationException>()));
      });

      testWithServices('not authorized', () async {
        // replace uploader for the scope of this test
        final pkg =
            (await dbService.lookup<Package>([hydrogen.package.key])).single;
        pkg.addUploader(testUserA.userId);
        pkg.removeUploader(hansUser.userId);
        await dbService.commit(inserts: [pkg]);

        registerAuthenticatedUser(hansAuthenticated);
        final rs =
            backend.repository.removeUploader('hydrogen', hansUser.email);
        expectLater(rs, throwsA(isA<AuthorizationException>()));
      });

      testWithServices('package does not exist', () async {
        registerAuthenticatedUser(hansAuthenticated);
        final rs =
            backend.repository.removeUploader('non_hydrogen', hansUser.email);
        expectLater(rs, throwsA(isA<NotFoundException>()));
      });

      testWithServices('cannot remove last uploader', () async {
        registerAuthenticatedUser(hansAuthenticated);
        final rs =
            backend.repository.removeUploader('hydrogen', hansUser.email);
        await expectLater(
            rs,
            throwsA(isException.having((e) => '$e', 'toString',
                'LastUploaderRemoved: Cannot remove last uploader of a package.')));
      });

      testWithServices('cannot remove non-existent uploader', () async {
        registerAuthenticatedUser(hansAuthenticated);
        final rs =
            backend.repository.removeUploader('hydrogen', 'foo2@bar.com');
        await expectLater(
            rs,
            throwsA(isException.having((e) => '$e', 'toString',
                'The uploader to remove does not exist.')));
      });

      testWithServices('cannot remove self', () async {
        // adding extra uploader for the scope of this test
        final pkg =
            (await dbService.lookup<Package>([hydrogen.package.key])).single;
        pkg.addUploader(testUserA.userId);
        await dbService.commit(inserts: [pkg]);

        registerAuthenticatedUser(hansAuthenticated);
        final rs =
            backend.repository.removeUploader('hydrogen', hansUser.email);
        await expectLater(
            rs,
            throwsA(isException.having((e) => '$e', 'toString',
                'Self-removal is not allowed. Use another account to remove this e-mail address.')));
      });

      testWithServices('successful1', () async {
        // adding extra uploader for the scope of this test
        final key = hydrogen.package.key;
        final pkg1 = (await dbService.lookup<Package>([key])).single;
        pkg1.addUploader(testUserA.userId);
        await dbService.commit(inserts: [pkg1]);

        // verify before change
        final pkg2 = (await dbService.lookup<Package>([key])).single;
        expect(pkg2.uploaders, [hansUser.userId, testUserA.userId]);

        registerAuthenticatedUser(hansAuthenticated);
        await backend.repository.removeUploader('hydrogen', testUserA.email);

        // verify after change
        final pkg3 = (await dbService.lookup<Package>([key])).single;
        expect(pkg3.uploaders, [hansUser.userId]);
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
      testWithServices('package not found', () async {
        final version =
            await backend.repository.lookupVersion('not_hydrogen', '1.0.0');
        expect(version, isNull);
      });

      testWithServices('version not found', () async {
        final version =
            await backend.repository.lookupVersion('hydrogen', '0.3.0');
        expect(version, isNull);
      });

      testWithServices('successful', () async {
        final version =
            await backend.repository.lookupVersion('hydrogen', '1.0.0');
        expect(version, isNotNull);
        expect(version.packageName, 'hydrogen');
        expect(version.versionString, '1.0.0');
      });
    });

    group('GCloudRepository.versions', () {
      testWithServices('not found', () async {
        final versions =
            await backend.repository.versions('non_hydrogen').toList();
        expect(versions, isEmpty);
      });

      testWithServices('found', () async {
        final versions = await backend.repository.versions('hydrogen').toList();
        expect(versions, isNotEmpty);
        expect(versions, hasLength(13));
        expect(versions.first.packageName, 'hydrogen');
        expect(versions.first.versionString, '1.0.0');
        expect(versions.last.packageName, 'hydrogen');
        expect(versions.last.versionString, '2.0.8');
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
