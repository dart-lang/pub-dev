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
import 'package:pub_dev/audit/backend.dart';
import 'package:pub_dev/audit/models.dart';
import 'package:pub_dev/fake/backend/fake_email_sender.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/shared/exceptions.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('backend', () {
    group('Backend.latestPackages', () {
      testWithProfile('default packages', fn: () async {
        final page = await packageBackend.latestPackages();
        expect(page.packages.map((p) => p.name), [
          'oxygen',
          'flutter_titanium',
          'neon',
        ]);
      });

      testWithProfile('default packages with withheld', fn: () async {
        final pkg = (await packageBackend.lookupPackage('oxygen'))!;
        await dbService.commit(inserts: [pkg..isWithheld = true]);
        final page = await packageBackend.latestPackages();
        expect(page.packages.map((p) => p.name), [
          'flutter_titanium',
          'neon',
        ]);
      });

      testWithProfile('default packages, extra earlier', fn: () async {
        final h = (await packageBackend.lookupPackage('oxygen'))!;
        h.updated = DateTime(2010);
        h.lastVersionPublished = DateTime(2010);
        await dbService.commit(inserts: [h]);
        final page = await packageBackend.latestPackages();
        expect(page.packages.last.name, 'oxygen');
      });

      testWithProfile('default packages, extra later', fn: () async {
        final h = (await packageBackend.lookupPackage('neon'))!;
        h.updated = DateTime(2030);
        h.lastVersionPublished = DateTime(2030);
        await dbService.commit(inserts: [h]);
        final page = await packageBackend.latestPackages();
        expect(page.packages.first.name, 'neon');
      });

      testWithProfile('default packages, offset: 2', fn: () async {
        final page = await packageBackend.latestPackages(offset: 2);
        expect(page.packages.map((p) => p.name), ['neon']);
      });

      testWithProfile('default packages, offset: 1, limit: 1', fn: () async {
        final page = await packageBackend.latestPackages(offset: 1, limit: 1);
        expect(page.packages.map((p) => p.name), ['flutter_titanium']);
      });
    });

    group('Backend.latestPackageVersions', () {
      testWithProfile('one package', fn: () async {
        final list =
            await packageBackend.latestPackageVersions(offset: 2, limit: 1);
        expect(list.map((pv) => pv.qualifiedVersionKey.toString()),
            ['neon/1.0.0']);
      });

      testWithProfile('empty', fn: () async {
        final list =
            await packageBackend.latestPackageVersions(offset: 200, limit: 1);
        expect(list, isEmpty);
      });
    });

    group('Backend.lookupPackage', () {
      testWithProfile('exists', fn: () async {
        final p = (await packageBackend.lookupPackage('oxygen'))!;
        expect(p, isNotNull);
        expect(p.name, 'oxygen');
        expect(p.latestVersion, isNotNull);
      });

      testWithProfile('does not exists', fn: () async {
        final p = await packageBackend.lookupPackage('not_yet_a_package');
        expect(p, isNull);
      });
    });

    group('Backend.lookupPackageVersion', () {
      testWithProfile('exists', fn: () async {
        final p = (await packageBackend.lookupPackage('oxygen'))!;
        final pv = (await packageBackend.lookupPackageVersion(
            'oxygen', p.latestVersion!))!;
        expect(pv, isNotNull);
        expect(pv.package, 'oxygen');
        expect(pv.version, p.latestVersion);
      });

      testWithProfile('package does not exists', fn: () async {
        final pv = await packageBackend.lookupPackageVersion(
            'not_yet_a_package', '1.0.0');
        expect(pv, isNull);
      });

      testWithProfile('version does not exists', fn: () async {
        final pv =
            await packageBackend.lookupPackageVersion('oxygen', '0.0.0-dev');
        expect(pv, isNull);
      });
    });

    group('Backend.lookupLatestVersions', () {
      testWithProfile('two packages', fn: () async {
        final list = await packageBackend.lookupLatestVersions([
          (await packageBackend.lookupPackage('oxygen'))!,
          (await packageBackend.lookupPackage('neon'))!,
        ]);
        expect(list.map((pv) => pv.qualifiedVersionKey.toString()),
            ['oxygen/1.2.0', 'neon/1.0.0']);
      });
    });

    group('Backend.versionsOfPackage', () {
      testWithProfile('exists', fn: () async {
        final list = await packageBackend.versionsOfPackage('oxygen');
        final values = list.map((pv) => pv.version).toList();
        values.sort();
        expect(values, ['1.0.0', '1.2.0', '2.0.0-dev']);
      });

      testWithProfile('package does not exists', fn: () async {
        final list =
            await packageBackend.versionsOfPackage('not_yet_a_package');
        expect(list, isEmpty);
      });
    });

    group('Backend.downloadUrl', () {
      testWithProfile('no escape needed', fn: () async {
        final url = await packageBackend.downloadUrl('oxygen', '2.0.8');
        expect(url.toString(),
            contains('/fake-bucket-pub/packages/oxygen-2.0.8.tar.gz'));
      });

      testWithProfile('version escape needed', fn: () async {
        final url = await packageBackend.downloadUrl('oxygen', '2.0.8+5');
        expect(url.toString(),
            contains('/fake-bucket-pub/packages/oxygen-2.0.8%2B5.tar.gz'));
      });
    });
  });

  group('backend.repository', () {
    group('add uploader', () {
      testWithProfile('not logged in', fn: () async {
        final rs = packageBackend.addUploader('oxygen', 'a@b.com');
        await expectLater(rs, throwsA(isA<AuthenticationException>()));
      });

      testWithProfile('not authorized', fn: () async {
        await accountBackend.withBearerToken('foo-at-bar-dot-com', () async {
          final rs = packageBackend.addUploader('oxygen', 'a@b.com');
          await expectLater(rs, throwsA(isA<AuthorizationException>()));
        });
      });

      testWithProfile('blocked user', fn: () async {
        final user =
            await accountBackend.lookupOrCreateUserByEmail('admin@pub.dev');
        await dbService.commit(inserts: [user..isBlocked = true]);
        registerAuthenticatedUser(user);
        final rs = packageBackend.addUploader('oxygen', 'a@b.com');
        await expectLater(rs, throwsA(isA<AuthorizationException>()));
      });

      testWithProfile('package does not exist', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final rs = packageBackend.addUploader('no_package', 'a@b.com');
          await expectLater(rs, throwsA(isA<NotFoundException>()));
        });
      });

      testWithProfile('already exists', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          Future<void> verify(String email) async {
            await packageBackend.addUploader('oxygen', email);
            final p = (await packageBackend.lookupPackage('oxygen'))!;
            final emails =
                await accountBackend.getEmailsOfUserIds(p.uploaders!);
            expect(emails.toSet(), {'admin@pub.dev'});
          }

          await verify('admin@pub.dev');
          await verify('Admin@Pub.Dev');
        });
      });

      testWithProfile('successful', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final newUploader = 'somebody@example.com';
          final rs = packageBackend.addUploader('oxygen', newUploader);
          await expectLater(
              rs,
              throwsA(isException.having(
                  (e) => '$e',
                  'text',
                  "OperationForbidden(403): We've sent an invitation email to $newUploader.\n"
                      "They'll be added as an uploader after they accept the invitation.")));

          // uploaders do not change yet
          final p = (await packageBackend.lookupPackage('oxygen'))!;
          expect(p.uploaders, hasLength(1));

          expect(fakeEmailSender.sentMessages, hasLength(1));
          final email = fakeEmailSender.sentMessages.single;
          expect(email.recipients.single.email, 'somebody@example.com');
          expect(
              email.subject, 'You have a new invitation to confirm on pub.dev');
          expect(
              email.bodyText,
              contains(
                  'admin@pub.dev has invited you to be an uploader of the package oxygen.\n'));
        });
      });
    });

    group('invite uploader', () {
      testWithProfile('not logged in', fn: () async {
        final rs = packageBackend.inviteUploader(
            'oxygen', InviteUploaderRequest(email: 'a@b.com'));
        await expectLater(rs, throwsA(isA<AuthenticationException>()));
      });

      testWithProfile('not authorized', fn: () async {
        await accountBackend.withBearerToken('foo-at-bar-dot-com', () async {
          final rs = packageBackend.inviteUploader(
              'oxygen', InviteUploaderRequest(email: 'a@b.com'));
          await expectLater(rs, throwsA(isA<AuthorizationException>()));
        });
      });

      testWithProfile('blocked user', fn: () async {
        final user =
            await accountBackend.lookupOrCreateUserByEmail('admin@pub.dev');
        await dbService.commit(inserts: [user..isBlocked = true]);
        registerAuthenticatedUser(user);
        final rs = packageBackend.inviteUploader(
            'oxygen', InviteUploaderRequest(email: 'a@b.com'));
        await expectLater(rs, throwsA(isA<AuthorizationException>()));
      });

      testWithProfile('package does not exist', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final rs = packageBackend.inviteUploader(
              'no_package', InviteUploaderRequest(email: 'a@b.com'));
          await expectLater(rs, throwsA(isA<NotFoundException>()));
        });
      });

      testWithProfile('already exists', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          Future<void> verify(String email) async {
            final rs = packageBackend.inviteUploader(
                'oxygen', InviteUploaderRequest(email: email));
            await expectLater(
                rs,
                throwsA(isA<InvalidInputException>().having((e) => '$e', 'text',
                    'InvalidInput(400): `${email.toLowerCase()}` is already an uploader.')));
            final p = (await packageBackend.lookupPackage('oxygen'))!;
            final emails =
                await accountBackend.getEmailsOfUserIds(p.uploaders!);
            expect(emails.toSet(), {'admin@pub.dev'});
          }

          await verify('admin@pub.dev');
          await verify('Admin@Pub.Dev');
        });
      });

      testWithProfile('successful', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final newUploader = 'somebody@example.com';
          final rs = await packageBackend.inviteUploader(
              'oxygen', InviteUploaderRequest(email: newUploader));
          expect(rs.emailSent, isTrue);

          // uploaders do not change yet
          final p = (await packageBackend.lookupPackage('oxygen'))!;
          expect(p.uploaders, hasLength(1));

          expect(fakeEmailSender.sentMessages, hasLength(1));
          final email = fakeEmailSender.sentMessages.single;
          expect(email.recipients.single.email, 'somebody@example.com');
          expect(
              email.subject, 'You have a new invitation to confirm on pub.dev');
          expect(
              email.bodyText,
              contains(
                  'admin@pub.dev has invited you to be an uploader of the package oxygen.\n'));
        });
      });
    });

    group('GCloudRepository.removeUploader', () {
      testWithProfile('not logged in', fn: () async {
        final rs = packageBackend.removeUploader('oxygen', 'admin@pub.dev');
        await expectLater(rs, throwsA(isA<AuthenticationException>()));
      });

      testWithProfile('not authorized', fn: () async {
        await accountBackend.withBearerToken('foo-at-bar-dot-com', () async {
          final rs = packageBackend.removeUploader('oxygen', 'admin@pub.dev');
          await expectLater(rs, throwsA(isA<AuthorizationException>()));
        });
      });

      testWithProfile('package does not exist', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final rs =
              packageBackend.removeUploader('non_hydrogen', 'user@pub.dev');
          await expectLater(rs, throwsA(isA<NotFoundException>()));
        });
      });

      testWithProfile('cannot remove last uploader', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final rs = packageBackend.removeUploader('oxygen', 'admin@pub.dev');
          await expectLater(
              rs,
              throwsA(isException.having((e) => '$e', 'toString',
                  'OperationForbidden(403): Cannot remove last uploader of a package.')));
        });
      });

      testWithProfile('cannot remove non-existent uploader', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final rs = packageBackend.removeUploader('oxygen', 'foo2@bar.com');
          await expectLater(
              rs,
              throwsA(isException.having((e) => '$e', 'toString',
                  'NotFound(404): Could not find `uploader: foo2@bar.com`.')));
        });
      });

      testWithProfile('cannot remove self', fn: () async {
        // adding extra uploader for the scope of this test
        final pkg = (await packageBackend.lookupPackage('oxygen'))!;
        final user =
            await accountBackend.lookupOrCreateUserByEmail('user@pub.dev');
        pkg.addUploader(user.userId);
        await dbService.commit(inserts: [pkg]);

        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final rs = packageBackend.removeUploader('oxygen', 'admin@pub.dev');
          await expectLater(
              rs,
              throwsA(isException.having((e) => '$e', 'toString',
                  'OperationForbidden(403): Self-removal is not allowed. Use another account to remove this email address.')));
        });
      });

      testWithProfile('successful1', fn: () async {
        // adding extra uploader for the scope of this test
        final pkg = (await packageBackend.lookupPackage('oxygen'))!;
        final user =
            await accountBackend.lookupOrCreateUserByEmail('user@pub.dev');
        pkg.addUploader(user.userId);
        await dbService.commit(inserts: [pkg]);

        // verify before change
        final pkg2 = (await packageBackend.lookupPackage('oxygen'))!;
        expect(pkg2.uploaders, contains(user.userId));

        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          await packageBackend.removeUploader('oxygen', 'user@pub.dev');
        });

        // verify after change
        final pkg3 = (await packageBackend.lookupPackage('oxygen'))!;
        expect(pkg3.uploaders, isNot(contains(user.userId)));

        // check audit log record
        final records = await auditBackend.listRecordsForPackage('oxygen');
        final r = records
            .firstWhere((r) => r.kind == AuditLogRecordKind.uploaderRemoved);
        expect(r.summary,
            '`admin@pub.dev` removed `user@pub.dev` from the uploaders of package `oxygen`.');
      });
    });

    group('GCloudRepository.lookupVersion', () {
      final baseUri = Uri.parse('https://pub.dev');

      testWithProfile('package not found', fn: () async {
        final rs =
            packageBackend.lookupVersion(baseUri, 'not_hydrogen', '1.0.0');
        await expectLater(rs, throwsA(isA<NotFoundException>()));
      });

      testWithProfile('version not found', fn: () async {
        final rs = packageBackend.lookupVersion(baseUri, 'oxygen', '0.3.0');
        await expectLater(rs, throwsA(isA<NotFoundException>()));
      });

      testWithProfile('successful', fn: () async {
        final version =
            await packageBackend.lookupVersion(baseUri, 'oxygen', '1.0.0');
        expect(version, isNotNull);
        expect(version.version, '1.0.0');
      });
    });

    group('listVersions', () {
      final baseUri = Uri.parse('https://pub.dev');

      testWithProfile('not found', fn: () async {
        final rs = packageBackend.listVersions(baseUri, 'non_hydrogen');
        await expectLater(rs, throwsA(isA<NotFoundException>()));
      });

      testWithProfile('found', fn: () async {
        final pd = await packageBackend.listVersions(baseUri, 'oxygen');
        expect(pd.versions, isNotEmpty);
        expect(pd.versions, hasLength(3));
        expect(pd.versions.first.version, '1.0.0');
        expect(pd.versions.last.version, '2.0.0-dev');
        expect(pd.latest.version, '1.2.0');
        expect(pd.isDiscontinued, isNull);
      });

      testWithProfile('isDiscontinued', fn: () async {
        await accountBackend.withBearerToken(
            adminAtPubDevAuthToken,
            () => packageBackend.updateOptions(
                'oxygen', PkgOptions(isDiscontinued: true)));
        final pd = await packageBackend.listVersions(baseUri, 'oxygen');
        expect(pd.isDiscontinued, isTrue);
      });
    });

    group('options', () {
      testWithProfile('discontinued', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          await packageBackend.updateOptions(
              'oxygen', PkgOptions(isDiscontinued: true));
          final p = (await packageBackend.lookupPackage('oxygen'))!;
          expect(p.isDiscontinued, isTrue);
          expect(p.replacedBy, isNull);
          expect(p.isUnlisted, isFalse);
        });
      });

      testWithProfile('replaced by - without discontinued', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final rs = packageBackend.updateOptions(
              'oxygen', PkgOptions(replacedBy: 'neon'));
          await expectLater(
              rs,
              throwsA(isA<InvalidInputException>().having((e) => '$e', 'text',
                  'InvalidInput(400): "replacedBy" must be set only with "isDiscontinued": true.')));
        });
      });

      testWithProfile('replaced by - with discontinued=false', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final rs = packageBackend.updateOptions(
              'oxygen', PkgOptions(isDiscontinued: false, replacedBy: 'neon'));
          await expectLater(
              rs,
              throwsA(isA<InvalidInputException>().having((e) => '$e', 'text',
                  'InvalidInput(400): "replacedBy" must be set only with "isDiscontinued": true.')));
        });
      });

      testWithProfile('replaced by - same package', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final rs = packageBackend.updateOptions(
              'oxygen', PkgOptions(isDiscontinued: true, replacedBy: 'oxygen'));
          await expectLater(
              rs,
              throwsA(isA<InvalidInputException>().having((e) => '$e', 'text',
                  'InvalidInput(400): "replacedBy" must point to a different package.')));
        });
      });

      testWithProfile('replaced by - with invalid / non existing package',
          fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          final rs = packageBackend.updateOptions('oxygen',
              PkgOptions(isDiscontinued: true, replacedBy: 'no such package'));
          await expectLater(
              rs,
              throwsA(isA<InvalidInputException>().having((e) => '$e', 'text',
                  'InvalidInput(400): Package specified by "replaceBy" does not exists.')));
        });
      });

      testWithProfile('replaced by - other package is discontinued too',
          fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          await packageBackend.updateOptions(
              'oxygen', PkgOptions(isDiscontinued: true, replacedBy: 'neon'));
          final rs = packageBackend.updateOptions('flutter_titanium',
              PkgOptions(isDiscontinued: true, replacedBy: 'oxygen'));
          await expectLater(
              rs,
              throwsA(isA<InvalidInputException>().having((e) => '$e', 'text',
                  'InvalidInput(400): Package specified by "replaceBy" must not be discontinued.')));
        });
      });

      testWithProfile('replaced by - success', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          await packageBackend.updateOptions(
              'oxygen', PkgOptions(isDiscontinued: true, replacedBy: 'neon'));
          final p = (await packageBackend.lookupPackage('oxygen'))!;
          expect(p.isDiscontinued, isTrue);
          expect(p.replacedBy, 'neon');
          expect(p.isUnlisted, isFalse);

          await packageBackend.updateOptions(
              'oxygen', PkgOptions(isDiscontinued: true));
          final p1 = (await packageBackend.lookupPackage('oxygen'))!;
          expect(p1.isDiscontinued, isTrue);
          expect(p1.replacedBy, isNull);
          expect(p1.isUnlisted, isFalse);

          // check audit log record
          final records = await auditBackend.listRecordsForPackage('oxygen');
          final r = records.firstWhere(
              (r) => r.kind == AuditLogRecordKind.packageOptionsUpdated);
          expect(r.summary,
              '`admin@pub.dev` updated `replacedBy` of package `oxygen`.');

          await packageBackend.updateOptions(
              'oxygen', PkgOptions(isDiscontinued: false));
          final p2 = (await packageBackend.lookupPackage('oxygen'))!;
          expect(p2.isDiscontinued, isFalse);
          expect(p2.replacedBy, isNull);
          expect(p2.isUnlisted, isFalse);
        });
      });

      testWithProfile('unlisted', fn: () async {
        await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
          await packageBackend.updateOptions(
              'oxygen', PkgOptions(isUnlisted: true));
          final p = (await packageBackend.lookupPackage('oxygen'))!;
          expect(p.isDiscontinued, isFalse);
          expect(p.replacedBy, isNull);
          expect(p.isUnlisted, isTrue);
        });
      });
    });
  });
}
