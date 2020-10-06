// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@Timeout(Duration(seconds: 15))
library pub_dartlang_org.backend_test;

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:test/test.dart';

import 'package:client_data/package_api.dart';

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/exceptions.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('backend', () {
    group('Backend.latestPackages', () {
      testWithServices('default packages', () async {
        final list = await packageBackend.latestPackages();
        expect(list.map((p) => p.name), [
          'foobar_pkg',
          'lithium',
          'helium',
          'hydrogen',
        ]);
      });

      testWithServices('default packages with withheld', () async {
        final pkg = await dbService.lookupValue<Package>(foobarPackage.key);
        await dbService.commit(inserts: [pkg..isWithheld = true]);
        final list = await packageBackend.latestPackages();
        expect(list.map((p) => p.name), [
          'lithium',
          'helium',
          'hydrogen',
        ]);
      });

      testWithServices('default packages, extra earlier', () async {
        final h =
            (await dbService.lookup<Package>([helium.package.key])).single;
        h.updated = DateTime(2010);
        await dbService.commit(inserts: [h]);
        final list = await packageBackend.latestPackages();
        expect(list.last.name, 'helium');
      });

      testWithServices('default packages, extra later', () async {
        final h =
            (await dbService.lookup<Package>([helium.package.key])).single;
        h.updated = DateTime(2030);
        await dbService.commit(inserts: [h]);
        final list = await packageBackend.latestPackages();
        expect(list.first.name, 'helium');
      });

      testWithServices('default packages, offset: 2', () async {
        final list = await packageBackend.latestPackages(offset: 2);
        expect(list.map((p) => p.name), ['helium', 'hydrogen']);
      });

      testWithServices('default packages, offset: 1, limit: 1', () async {
        final list = await packageBackend.latestPackages(offset: 1, limit: 1);
        expect(list.map((p) => p.name), ['lithium']);
      });
    });

    group('Backend.latestPackageVersions', () {
      testWithServices('one package', () async {
        final list =
            await packageBackend.latestPackageVersions(offset: 2, limit: 1);
        expect(list.map((pv) => pv.qualifiedVersionKey.toString()),
            ['helium/2.0.5']);
      });

      testWithServices('empty', () async {
        final list =
            await packageBackend.latestPackageVersions(offset: 200, limit: 1);
        expect(list, isEmpty);
      });
    });

    group('Backend.lookupPackage', () {
      testWithServices('exists', () async {
        final p = await packageBackend.lookupPackage('hydrogen');
        expect(p, isNotNull);
        expect(p.name, 'hydrogen');
        expect(p.latestVersion, isNotNull);
      });

      testWithServices('does not exists', () async {
        final p = await packageBackend.lookupPackage('not_yet_a_package');
        expect(p, isNull);
      });
    });

    group('Backend.lookupPackageVersion', () {
      testWithServices('exists', () async {
        final p = await packageBackend.lookupPackage('hydrogen');
        final pv = await packageBackend.lookupPackageVersion(
            'hydrogen', p.latestVersion);
        expect(pv, isNotNull);
        expect(pv.package, 'hydrogen');
        expect(pv.version, p.latestVersion);
      });

      testWithServices('package does not exists', () async {
        final pv = await packageBackend.lookupPackageVersion(
            'not_yet_a_package', '1.0.0');
        expect(pv, isNull);
      });

      testWithServices('version does not exists', () async {
        final pv =
            await packageBackend.lookupPackageVersion('hydrogen', '0.0.0-dev');
        expect(pv, isNull);
      });
    });

    group('Backend.lookupLatestVersions', () {
      testWithServices('two packages', () async {
        final list = await packageBackend
            .lookupLatestVersions([hydrogen.package, helium.package]);
        expect(list.map((pv) => pv.qualifiedVersionKey.toString()),
            ['hydrogen/2.0.8', 'helium/2.0.5']);
      });
    });

    group('Backend.versionsOfPackage', () {
      testWithServices('exists', () async {
        final list = await packageBackend.versionsOfPackage('hydrogen');
        final values = list.map((pv) => pv.version).toList();
        values.sort();
        expect(values, hasLength(13));
        expect(values.first, '1.0.0');
        expect(values[5], '1.4.5');
        expect(values.last, '2.0.8');
      });

      testWithServices('package does not exists', () async {
        final list =
            await packageBackend.versionsOfPackage('not_yet_a_package');
        expect(list, isEmpty);
      });
    });

    group('Backend.downloadUrl', () {
      testWithServices('no escape needed', () async {
        final url = await packageBackend.downloadUrl('hydrogen', '2.0.8');
        expect(url.toString(),
            'http://localhost:0/fake-bucket-pub/packages/hydrogen-2.0.8.tar.gz');
      });

      testWithServices('version escape needed', () async {
        final url = await packageBackend.downloadUrl('hydrogen', '2.0.8+5');
        expect(url.toString(),
            'http://localhost:0/fake-bucket-pub/packages/hydrogen-2.0.8%2B5.tar.gz');
      });
    });
  });

  group('backend.repository', () {
    group('add uploader', () {
      testWithServices('not logged in', () async {
        final pkg = foobarPackage.name;
        final rs = packageBackend.addUploader(pkg, 'a@b.com');
        await expectLater(rs, throwsA(isA<AuthenticationException>()));
      });

      testWithServices('not authorized', () async {
        final pkg = foobarPackage.name;
        registerAuthenticatedUser(User()
          ..id = 'uuid-foo-at-bar-dot-com'
          ..email = 'foo@bar.com'
          ..isDeleted = false
          ..isBlocked = false);
        final rs = packageBackend.addUploader(pkg, 'a@b.com');
        await expectLater(rs, throwsA(isA<AuthorizationException>()));
      });

      testWithServices('blocked user', () async {
        final user = await dbService.lookupValue<User>(hansUser.key);
        await dbService.commit(inserts: [user..isBlocked = true]);
        registerAuthenticatedUser(user);
        final rs = packageBackend.addUploader(foobarPackage.name, 'a@b.com');
        await expectLater(rs, throwsA(isA<AuthorizationException>()));
      });

      testWithServices('package does not exist', () async {
        registerAuthenticatedUser(hansUser);
        final rs = packageBackend.addUploader('no_package', 'a@b.com');
        await expectLater(rs, throwsA(isA<NotFoundException>()));
      });

      Future<void> testAlreadyExists(
          String pkg, List<User> uploaders, String newUploader) async {
        final bundle = generateBundle(pkg, ['1.0.0'], uploaders: uploaders);
        await dbService.commit(inserts: [
          bundle.package,
          ...bundle.versions.map(pvModels).expand((m) => m),
        ]);
        await packageBackend.addUploader(pkg, newUploader);
        final list = await dbService.lookup<Package>([bundle.package.key]);
        final p = list.single;
        expect(p.uploaders, uploaders.map((u) => u.userId));
      }

      testWithServices('already exists', () async {
        registerAuthenticatedUser(hansUser);
        final ucEmail = 'Hans@Juergen.Com';
        await testAlreadyExists('p1', [hansUser], hansUser.email);
        await testAlreadyExists('p2', [hansUser], ucEmail);
        await testAlreadyExists('p3', [hansUser, joeUser], ucEmail);
        await testAlreadyExists('p4', [joeUser, hansUser], ucEmail);
      });

      testWithServices('successful', () async {
        registerAuthenticatedUser(hansUser);

        final newUploader = 'somebody@example.com';
        final rs =
            packageBackend.addUploader(hydrogen.package.name, newUploader);
        await expectLater(
            rs,
            throwsA(isException.having(
                (e) => '$e',
                'text',
                "OperationForbidden(403): We've sent an invitation email to $newUploader.\n"
                    "They'll be added as an uploader after they accept the invitation.")));

        // uploaders do not change yet
        final list = await dbService.lookup<Package>([hydrogen.package.key]);
        final p = list.single;
        expect(p.uploaders, [hansUser.userId]);

        expect(fakeEmailSender.sentMessages, hasLength(1));
        final email = fakeEmailSender.sentMessages.single;
        expect(email.recipients.single.email, 'somebody@example.com');
        expect(
            email.subject, 'You have a new invitation to confirm on pub.dev');
        expect(
            email.bodyText,
            contains(
                'hans@juergen.com has invited you to be an uploader of the package\nhydrogen.\n'));

        // TODO: check consent (after migrating to consent API)
      });
    });

    group('invite uploader', () {
      testWithServices('not logged in', () async {
        final pkg = foobarPackage.name;
        final rs = packageBackend.inviteUploader(
            pkg, InviteUploaderRequest(email: 'a@b.com'));
        await expectLater(rs, throwsA(isA<AuthenticationException>()));
      });

      testWithServices('not authorized', () async {
        final pkg = foobarPackage.name;
        registerAuthenticatedUser(User()
          ..id = 'uuid-foo-at-bar-dot-com'
          ..email = 'foo@bar.com'
          ..isDeleted = false
          ..isBlocked = false);
        final rs = packageBackend.inviteUploader(
            pkg, InviteUploaderRequest(email: 'a@b.com'));
        await expectLater(rs, throwsA(isA<AuthorizationException>()));
      });

      testWithServices('blocked user', () async {
        final user = await dbService.lookupValue<User>(hansUser.key);
        await dbService.commit(inserts: [user..isBlocked = true]);
        registerAuthenticatedUser(user);
        final rs = packageBackend.inviteUploader(
            foobarPackage.name, InviteUploaderRequest(email: 'a@b.com'));
        await expectLater(rs, throwsA(isA<AuthorizationException>()));
      });

      testWithServices('package does not exist', () async {
        registerAuthenticatedUser(hansUser);
        final rs = packageBackend.inviteUploader(
            'no_package', InviteUploaderRequest(email: 'a@b.com'));
        await expectLater(rs, throwsA(isA<NotFoundException>()));
      });

      Future<void> testAlreadyExists(
          String pkg, List<User> uploaders, String newUploader) async {
        final bundle = generateBundle(pkg, ['1.0.0'], uploaders: uploaders);
        await dbService.commit(inserts: [
          bundle.package,
          ...bundle.versions.map(pvModels).expand((m) => m),
        ]);
        final rs = packageBackend.inviteUploader(
            pkg, InviteUploaderRequest(email: newUploader));
        await expectLater(
            rs,
            throwsA(isA<InvalidInputException>().having((e) => '$e', 'text',
                'InvalidInput(400): `hans@juergen.com` is already an uploader.')));
        final list = await dbService.lookup<Package>([bundle.package.key]);
        final p = list.single;
        expect(p.uploaders, uploaders.map((u) => u.userId));
      }

      testWithServices('already exists', () async {
        registerAuthenticatedUser(hansUser);
        final ucEmail = 'Hans@Juergen.Com';
        await testAlreadyExists('p1', [hansUser], hansUser.email);
        await testAlreadyExists('p2', [hansUser], ucEmail);
        await testAlreadyExists('p3', [hansUser, joeUser], ucEmail);
        await testAlreadyExists('p4', [joeUser, hansUser], ucEmail);
      });

      testWithServices('successful', () async {
        registerAuthenticatedUser(hansUser);

        final newUploader = 'somebody@example.com';
        final rs = await packageBackend.inviteUploader(
            hydrogen.package.name, InviteUploaderRequest(email: newUploader));
        expect(rs.emailSent, isTrue);

        // uploaders do not change yet
        final list = await dbService.lookup<Package>([hydrogen.package.key]);
        final p = list.single;
        expect(p.uploaders, [hansUser.userId]);

        expect(fakeEmailSender.sentMessages, hasLength(1));
        final email = fakeEmailSender.sentMessages.single;
        expect(email.recipients.single.email, 'somebody@example.com');
        expect(
            email.subject, 'You have a new invitation to confirm on pub.dev');
        expect(
            email.bodyText,
            contains(
                'hans@juergen.com has invited you to be an uploader of the package\nhydrogen.\n'));

        // TODO: check consent (after migrating to consent API)
      });
    });

    group('GCloudRepository.removeUploader', () {
      testWithServices('not logged in', () async {
        final rs = packageBackend.removeUploader('hydrogen', hansUser.email);
        await expectLater(rs, throwsA(isA<AuthenticationException>()));
      });

      testWithServices('not authorized', () async {
        // replace uploader for the scope of this test
        final pkg =
            (await dbService.lookup<Package>([hydrogen.package.key])).single;
        pkg.addUploader(testUserA.userId);
        pkg.removeUploader(hansUser.userId);
        await dbService.commit(inserts: [pkg]);

        registerAuthenticatedUser(hansUser);
        final rs = packageBackend.removeUploader('hydrogen', hansUser.email);
        await expectLater(rs, throwsA(isA<AuthorizationException>()));
      });

      testWithServices('package does not exist', () async {
        registerAuthenticatedUser(hansUser);
        final rs =
            packageBackend.removeUploader('non_hydrogen', hansUser.email);
        await expectLater(rs, throwsA(isA<NotFoundException>()));
      });

      testWithServices('cannot remove last uploader', () async {
        registerAuthenticatedUser(hansUser);
        final rs = packageBackend.removeUploader('hydrogen', hansUser.email);
        await expectLater(
            rs,
            throwsA(isException.having((e) => '$e', 'toString',
                'OperationForbidden(403): Cannot remove last uploader of a package.')));
      });

      testWithServices('cannot remove non-existent uploader', () async {
        registerAuthenticatedUser(hansUser);
        final rs = packageBackend.removeUploader('hydrogen', 'foo2@bar.com');
        await expectLater(
            rs,
            throwsA(isException.having((e) => '$e', 'toString',
                'NotFound(404): Could not find `uploader: foo2@bar.com`.')));
      });

      testWithServices('cannot remove self', () async {
        // adding extra uploader for the scope of this test
        final pkg =
            (await dbService.lookup<Package>([hydrogen.package.key])).single;
        pkg.addUploader(testUserA.userId);
        await dbService.commit(inserts: [pkg]);

        registerAuthenticatedUser(hansUser);
        final rs = packageBackend.removeUploader('hydrogen', hansUser.email);
        await expectLater(
            rs,
            throwsA(isException.having((e) => '$e', 'toString',
                'OperationForbidden(403): Self-removal is not allowed. Use another account to remove this email address.')));
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

        registerAuthenticatedUser(hansUser);
        await packageBackend.removeUploader('hydrogen', testUserA.email);

        // verify after change
        final pkg3 = (await dbService.lookup<Package>([key])).single;
        expect(pkg3.uploaders, [hansUser.userId]);
      });
    });

    group('GCloudRepository.lookupVersion', () {
      final baseUri = Uri.parse('https://pub.dev');

      testWithServices('package not found', () async {
        final rs =
            packageBackend.lookupVersion(baseUri, 'not_hydrogen', '1.0.0');
        await expectLater(rs, throwsA(isA<NotFoundException>()));
      });

      testWithServices('version not found', () async {
        final rs = packageBackend.lookupVersion(baseUri, 'hydrogen', '0.3.0');
        await expectLater(rs, throwsA(isA<NotFoundException>()));
      });

      testWithServices('successful', () async {
        final version =
            await packageBackend.lookupVersion(baseUri, 'hydrogen', '1.0.0');
        expect(version, isNotNull);
        expect(version.version, '1.0.0');
      });
    });

    group('listVersions', () {
      final baseUri = Uri.parse('https://pub.dev');

      testWithServices('not found', () async {
        final rs = packageBackend.listVersions(baseUri, 'non_hydrogen');
        await expectLater(rs, throwsA(isA<NotFoundException>()));
      });

      testWithServices('found', () async {
        final pd = await packageBackend.listVersions(baseUri, 'hydrogen');
        expect(pd.versions, isNotEmpty);
        expect(pd.versions, hasLength(13));
        expect(pd.versions.first.version, '1.0.0');
        expect(pd.versions.last.version, '2.0.8');
        expect(pd.latest.version, '2.0.8');
        expect(pd.isDiscontinued, isNull);
      });

      testWithServices('isDiscontinued', () async {
        registerAuthenticatedUser(hansUser);
        await packageBackend.updateOptions(
            'hydrogen', PkgOptions(isDiscontinued: true));
        final pd = await packageBackend.listVersions(baseUri, 'hydrogen');
        expect(pd.isDiscontinued, isTrue);
      });
    });

    group('options', () {
      testWithServices('discontinued', () async {
        registerAuthenticatedUser(hansUser);
        await packageBackend.updateOptions(
            'hydrogen', PkgOptions(isDiscontinued: true));
        final p = await packageBackend.lookupPackage('hydrogen');
        expect(p.isDiscontinued, isTrue);
        expect(p.replacedBy, isNull);
        expect(p.isUnlisted, isFalse);
      });

      testWithServices('replaced by - without discontinued', () async {
        registerAuthenticatedUser(hansUser);
        final rs = packageBackend.updateOptions(
            'hydrogen', PkgOptions(replacedBy: 'helium'));
        await expectLater(
            rs,
            throwsA(isA<InvalidInputException>().having((e) => '$e', 'text',
                'InvalidInput(400): "replacedBy" must be set only with "isDiscontinued": true.')));
      });

      testWithServices('replaced by - with discontinued=false', () async {
        registerAuthenticatedUser(hansUser);
        final rs = packageBackend.updateOptions('hydrogen',
            PkgOptions(isDiscontinued: false, replacedBy: 'helium'));
        await expectLater(
            rs,
            throwsA(isA<InvalidInputException>().having((e) => '$e', 'text',
                'InvalidInput(400): "replacedBy" must be set only with "isDiscontinued": true.')));
      });

      testWithServices('replaced by - with invalid / non existing package',
          () async {
        registerAuthenticatedUser(hansUser);
        final rs = packageBackend.updateOptions('hydrogen',
            PkgOptions(isDiscontinued: true, replacedBy: 'no such package'));
        await expectLater(
            rs,
            throwsA(isA<InvalidInputException>().having((e) => '$e', 'text',
                'InvalidInput(400): Package specified by "replaceBy" does not exists.')));
      });

      testWithServices('replaced by - success', () async {
        registerAuthenticatedUser(hansUser);
        await packageBackend.updateOptions(
            'hydrogen', PkgOptions(isDiscontinued: true, replacedBy: 'helium'));
        final p = await packageBackend.lookupPackage('hydrogen');
        expect(p.isDiscontinued, isTrue);
        expect(p.replacedBy, 'helium');
        expect(p.isUnlisted, isFalse);

        await packageBackend.updateOptions(
            'hydrogen', PkgOptions(isDiscontinued: false));
        final p2 = await packageBackend.lookupPackage('hydrogen');
        expect(p2.isDiscontinued, isFalse);
        expect(p2.replacedBy, isNull);
        expect(p2.isUnlisted, isFalse);
      });

      testWithServices('unlisted', () async {
        registerAuthenticatedUser(hansUser);
        await packageBackend.updateOptions(
            'hydrogen', PkgOptions(isUnlisted: true));
        final p = await packageBackend.lookupPackage('hydrogen');
        expect(p.isDiscontinued, isFalse);
        expect(p.replacedBy, isNull);
        expect(p.isUnlisted, isTrue);
      });
    });
  });
}
