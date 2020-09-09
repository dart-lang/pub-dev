// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:gcloud/db.dart';
import 'package:pana/pana.dart';
import 'package:path/path.dart' as p;
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/service/secret/backend.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/package/name_tracker.dart';
import 'package:pub_dev/package/upload_signer_service.dart';
import 'package:pub_dev/shared/exceptions.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';

import 'backend_test_utils.dart';

void main() {
  group('uploading', () {
    group('packageBackend.startUpload', () {
      testWithServices('no active user', () async {
        final rs = packageBackend.startUpload(Uri.parse('http://example.com/'));
        await expectLater(rs, throwsA(isA<AuthenticationException>()));
      });

      testWithServices('successful', () async {
        final Uri redirectUri = Uri.parse('http://blobstore.com/upload');
        registerAuthenticatedUser(hansUser);
        final info = await packageBackend.startUpload(redirectUri);
        expect(
            info.url, startsWith('https://storage.url/fake-bucket-pub/tmp/'));
        expect(info.fields, {
          'key': startsWith('fake-bucket-pub/tmp/'),
          'success_action_redirect': startsWith('$redirectUri?upload_id='),
        });
      });
    });

    group('packageBackend.publishUploadedBlob', () {
      final Uri redirectUri =
          Uri.parse('http://blobstore.com/upload?upload_id=my-uuid');

      testWithServices('uploaded zero-length file', () async {
        registerAuthenticatedUser(hansUser);

        // create empty file
        await tarballStorage.bucket.write('tmp/my-uuid').close();

        final rs = packageBackend.publishUploadedBlob(redirectUri);
        await expectLater(
          rs,
          throwsA(
            isA<PackageRejectedException>().having(
                (e) => '$e', 'text', contains('Package archive is empty')),
          ),
        );
      });

      testWithServices('upload-too-big', () async {
        registerAuthenticatedUser(hansUser);

        final chunk = List.filled(1024 * 1024, 42);
        final chunkCount = UploadSignerService.maxUploadSize ~/ chunk.length;
        final bigTarball = <List<int>>[];
        for (int i = 0; i < chunkCount; i++) {
          bigTarball.add(chunk);
        }
        // Add one more byte than allowed.
        bigTarball.add([1]);

        final sink = tarballStorage.bucket.write('tmp/my-uuid');
        bigTarball.forEach(sink.add);
        await sink.close();

        final rs = packageBackend.publishUploadedBlob(redirectUri);
        await expectLater(
          rs,
          throwsA(
            isA<PackageRejectedException>().having(
                (e) => '$e', 'text', contains('Package archive exceeded ')),
          ),
        );
      });

      testWithServices('successful', () async {
        registerAuthenticatedUser(hansUser);

        final dateBeforeTest = DateTime.now().toUtc();
        final pubspecContent = generatePubspecYaml('new_package', '1.2.3');
        await tarballStorage.bucket.writeBytes('tmp/my-uuid',
            await packageArchiveBytes(pubspecContent: pubspecContent));

        final version = await packageBackend.publishUploadedBlob(redirectUri);
        expect(version.package, 'new_package');
        expect(version.version, '1.2.3');

        final pkgKey = dbService.emptyKey.append(Package, id: version.package);
        final package = (await dbService.lookup<Package>([pkgKey])).single;
        expect(package.name, 'new_package');
        expect(package.latestVersion, '1.2.3');
        expect(package.uploaders, ['hans-at-juergen-dot-com']);
        expect(package.publisherId, isNull);
        expect(package.created.compareTo(dateBeforeTest) >= 0, isTrue);
        expect(package.updated.compareTo(dateBeforeTest) >= 0, isTrue);

        final pvKey = package.latestVersionKey;
        final pv = (await dbService.lookup<PackageVersion>([pvKey])).single;
        expect(pv.packageKey, package.key);
        expect(pv.created.compareTo(dateBeforeTest) >= 0, isTrue);
        expect(pv.readmeFilename, 'README.md');
        expect(pv.readmeContent, foobarReadmeContent);
        expect(pv.changelogFilename, 'CHANGELOG.md');
        expect(pv.changelogContent, foobarChangelogContent);
        expect(pv.pubspec.asJson, loadYaml(pubspecContent));
        expect(pv.libraries, ['test_library.dart']);
        expect(pv.uploader, 'hans-at-juergen-dot-com');
        expect(pv.publisherId, isNull);
        expect(pv.downloads, 0);

        expect(fakeEmailSender.sentMessages, hasLength(1));
        final email = fakeEmailSender.sentMessages.single;
        expect(email.recipients.single.email, hansUser.email);
        expect(email.subject, 'Package uploaded: new_package 1.2.3');
        expect(email.bodyText,
            contains('https://pub.dev/packages/new_package/versions/1.2.3\n'));

        // TODO: check history
        // TODO: check assets
      });

      testWithServices('package under publisher', () async {
        registerAuthenticatedUser(hansUser);

        final dateBeforeTest = DateTime.now().toUtc();
        final pubspecContent = generatePubspecYaml('lithium', '7.0.0');
        await tarballStorage.bucket.writeBytes('tmp/my-uuid',
            await packageArchiveBytes(pubspecContent: pubspecContent));

        final version = await packageBackend.publishUploadedBlob(redirectUri);
        expect(version.package, 'lithium');
        expect(version.version, '7.0.0');

        final pkgKey = dbService.emptyKey.append(Package, id: version.package);
        final package = (await dbService.lookup<Package>([pkgKey])).single;
        expect(package.name, 'lithium');
        expect(package.latestVersion, '7.0.0');
        expect(package.publisherId, 'example.com');
        expect(package.uploaders, []);
        expect(package.created.compareTo(dateBeforeTest) < 0, isTrue);
        expect(package.updated.compareTo(dateBeforeTest) >= 0, isTrue);

        final pvKey = package.latestVersionKey;
        final pv = (await dbService.lookup<PackageVersion>([pvKey])).single;
        expect(pv.packageKey, package.key);
        expect(pv.created.compareTo(dateBeforeTest) >= 0, isTrue);
        expect(pv.readmeFilename, 'README.md');
        expect(pv.readmeContent, foobarReadmeContent);
        expect(pv.changelogFilename, 'CHANGELOG.md');
        expect(pv.changelogContent, foobarChangelogContent);
        expect(pv.pubspec.asJson, loadYaml(pubspecContent));
        expect(pv.libraries, ['test_library.dart']);
        expect(pv.uploader, 'hans-at-juergen-dot-com');
        expect(pv.publisherId, 'example.com');
        expect(pv.downloads, 0);

        expect(fakeEmailSender.sentMessages, hasLength(1));
        final email = fakeEmailSender.sentMessages.single;
        expect(email.recipients.single.email, hansUser.email);
        expect(email.subject, 'Package uploaded: lithium 7.0.0');
        expect(email.bodyText,
            contains('https://pub.dev/packages/lithium/versions/7.0.0\n'));

        // TODO: check history
        // TODO: check assets
      });
    });

    group('packageBackend.upload', () {
      testWithServices('not logged in', () async {
        final tarball = await packageArchiveBytes();
        final rs = packageBackend.upload(Stream.fromIterable([tarball]));
        await expectLater(rs, throwsA(isA<AuthenticationException>()));
      });

      testWithServices('not authorized', () async {
        registerAuthenticatedUser(joeUser);
        final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml(foobarPackage.name, '0.2.0'));
        final rs = packageBackend.upload(Stream.fromIterable([tarball]));
        await expectLater(rs, throwsA(isA<AuthorizationException>()));
      });

      testWithServices('user is blocked', () async {
        final user = await dbService.lookupValue<User>(hansUser.key);
        await dbService.commit(inserts: [user..isBlocked = true]);
        registerAuthenticatedUser(user);
        final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml(foobarPackage.name, '1.2.3'));
        final rs = packageBackend.upload(Stream.fromIterable([tarball]));
        await expectLater(rs, throwsA(isA<AuthorizationException>()));
      });

      testWithServices('upload restriction - no uploads', () async {
        await secretBackend.update(SecretKey.uploadRestriction, 'no-uploads');
        registerAuthenticatedUser(hansUser);
        final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml(foobarPackage.name, '1.2.3'));
        final rs = packageBackend.upload(Stream.fromIterable([tarball]));
        await expectLater(
            rs,
            throwsA(isA<PackageRejectedException>().having(
              (e) => '$e',
              'text',
              contains('Uploads are restricted. Please try again later.'),
            )));
      });

      testWithServices('upload restriction - no new packages', () async {
        await secretBackend.update(SecretKey.uploadRestriction, 'only-updates');
        registerAuthenticatedUser(hansUser);
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

      testWithServices('upload restriction - update is accepted', () async {
        await secretBackend.update(SecretKey.uploadRestriction, 'only-updates');
        registerAuthenticatedUser(hansUser);
        final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml(foobarPackage.name, '1.2.3'));
        final rs = await packageBackend.upload(Stream.fromIterable([tarball]));
        expect(rs.package, foobarPackage.name);
      });

      testWithServices('versions already exist', () async {
        registerAuthenticatedUser(joeUser);
        final tarball = await packageArchiveBytes();
        final rs = packageBackend.upload(Stream.fromIterable([tarball]));
        await expectLater(
            rs,
            throwsA(isA<Exception>().having(
              (e) => '$e',
              'text',
              contains('Version 0.1.1+5 of package foobar_pkg already exists'),
            )));
      });

      // Returns the error message as String or null if it succeeded.
      Future<String> fn(String name) async {
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

      testWithServices('bad package names are rejected', () async {
        await nameTracker.scanDatastore();
        registerAuthenticatedUser(hansUser);

        expect(await fn('with'),
            'PackageRejected(400): Package name must not be a reserved word in Dart.');
        expect(await fn('123test'),
            'PackageRejected(400): Package name must begin with a letter or underscore.');
        expect(await fn('With Space'),
            'PackageRejected(400): Package name may only contain letters, numbers, and underscores.');

        expect(await fn('ok_name'), isNull);
      });

      testWithServices('conflicting package names are rejected', () async {
        await nameTracker.scanDatastore();
        registerAuthenticatedUser(hansUser);

        expect(await fn('hy_drogen'),
            'PackageRejected(400): Package name is too similar to another active or moderated package.');

        expect(await fn('mo_derate'),
            'PackageRejected(400): Package name is too similar to another active or moderated package.');
      });

      testWithServices('bad yaml file: duplicate key', () async {
        registerAuthenticatedUser(joeUser);
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

      testWithServices('bad pubspec content: bad version', () async {
        registerAuthenticatedUser(joeUser);
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

      testWithServices('has git dependency', () async {
        registerAuthenticatedUser(joeUser);
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

      testWithServices('upload-too-big', () async {
        registerAuthenticatedUser(hansUser);

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

      testWithServices('successful upload + download', () async {
        registerAuthenticatedUser(hansUser);
        final tarball = await packageArchiveBytes(
            pubspecContent: generatePubspecYaml(foobarPackage.name, '1.2.3'));
        final version =
            await packageBackend.upload(Stream.fromIterable([tarball]));
        expect(version.package, foobarPackage.name);
        expect(version.version, '1.2.3');

        expect(fakeEmailSender.sentMessages, hasLength(1));
        final email = fakeEmailSender.sentMessages.single;
        expect(email.recipients.single.email, hansUser.email);
        expect(email.subject, 'Package uploaded: foobar_pkg 1.2.3');
        expect(email.bodyText,
            contains('https://pub.dev/packages/foobar_pkg/versions/1.2.3\n'));

        final packages = await packageBackend.latestPackages();
        expect(packages.first.name, foobarPackage.name);
        expect(packages.first.latestVersion, '1.2.3');

        final stream =
            await packageBackend.download(foobarPackage.name, '1.2.3');
        final chunks = await stream.toList();
        final bytes = chunks
            .fold<List<int>>(<int>[], (buffer, chunk) => buffer..addAll(chunk));
        expect(bytes, tarball);
      });
    });
  });

  group('.tar.gz verification', () {
    test('invalid file content', () async {
      await withTempDirectory((tempDir) async {
        final file = File(p.join(tempDir, 'bad.tar.gz'));
        await file.writeAsBytes([0, 1, 2]);
        final rs = verifyTarGzSymlinks(file.path);
        await expectLater(
            rs,
            throwsA(isA<PackageRejectedException>().having(
              (e) => '$e',
              'text',
              contains('is not a valid'),
            )));
      });
    });

    Future<void> runArchiveVerification({
      Future<void> Function(String pkgDirPath) setupDir,
      String expectedErrorMessage,
    }) async {
      return await withTempDirectory((tempDir) async {
        final archiveFile = File(p.join(tempDir, 'with-symlink.tar.gz'));
        final pkgDir = Directory(p.join(tempDir, 'pkg'));
        await pkgDir.create(recursive: true);
        await setupDir(pkgDir.path);
        final pr = await runProc('tar', ['-czvf', archiveFile.path, 'pkg'],
            workingDirectory: tempDir);
        expect(pr.exitCode, 0);
        final rs = verifyTarGzSymlinks(archiveFile.path);
        if (expectedErrorMessage != null) {
          await expectLater(
              rs,
              throwsA(isA<PackageRejectedException>().having(
                (e) => '$e',
                'text',
                contains(expectedErrorMessage),
              )));
        } else {
          await rs;
        }
      });
    }

    test('has a relative symlink outside of archive', () async {
      await runArchiveVerification(
        setupDir: (pkgDir) async {
          await Link(p.join(pkgDir, 'README.md')).create('../../README.md');
        },
        expectedErrorMessage:
            'Package archive contains a broken symlink: `pkg/README.md` -> `../../README.md`.',
      );
    });

    test('has an absolute symlink', () async {
      await runArchiveVerification(
        setupDir: (pkgDir) async {
          await Link(p.join(pkgDir, 'README.md')).create('/README.md');
        },
        expectedErrorMessage:
            'Package archive contains a broken symlink: `pkg/README.md` -> `/README.md`.',
      );
    });

    // This test-case should fail, but it for simplicity it is accepted by pub.
    // TODO: fix verification to detect circular links
    test('has symlink(s) with circular links', () async {
      // TODO: this use case should fail instead
      await runArchiveVerification(
        setupDir: (pkgDir) async {
          await Link(p.join(pkgDir, 'README.md')).create('./README.md');
        },
      );
    });

    test('valid symlink to another file', () async {
      await runArchiveVerification(
        setupDir: (pkgDir) async {
          await Directory(p.join(pkgDir, 'a')).create();
          await Directory(p.join(pkgDir, 'b')).create();
          await File(p.join(pkgDir, 'a', 'existing.txt')).writeAsString('');
          await Link(p.join(pkgDir, 'b', 'link.txt'))
              .create('../a/existing.txt');
        },
      );
    });
  });
}
