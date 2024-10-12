// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@Timeout(Duration(seconds: 15))
library;

import 'dart:async';

import 'package:_pub_shared/data/package_api.dart';
import 'package:gcloud/db.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/audit/backend.dart';
import 'package:pub_dev/audit/models.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/fake/backend/fake_email_sender.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:test/test.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('backend', () {
    group('Backend.latestPackageVersions', () {
      testWithProfile('all packages', fn: () async {
        final list = await packageBackend.latestPackageVersions(limit: 100);
        expect(list.map((pv) => pv.qualifiedVersionKey.toString()), [
          'oxygen/2.0.0-dev',
          'oxygen/1.2.0',
          'oxygen/1.0.0',
          'flutter_titanium/1.10.0',
          'neon/1.0.0',
          'flutter_titanium/1.9.0',
        ]);
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
        expect(pv.sha256, hasLength(32));
        // making sure that we have at least one non-zero value in it
        expect(pv.sha256, anyElement(greaterThan(0)));
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
        final list = await packageBackend.lookupVersions([
          QualifiedVersionKey(package: 'oxygen', version: '1.2.0'),
          QualifiedVersionKey(package: 'neon', version: '1.0.0'),
        ]);
        expect(list.map((pv) => pv!.qualifiedVersionKey.toString()),
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
            contains('/fake-public-packages/packages/oxygen-2.0.8.tar.gz'));
      });

      testWithProfile('version escape needed', fn: () async {
        final url = await packageBackend.downloadUrl('oxygen', '2.0.8+5');
        expect(url.toString(),
            contains('/fake-public-packages/packages/oxygen-2.0.8%2B5.tar.gz'));
      });
    });
  });

  group('backend.repository', () {
    group('api no longer supported', () {
      testWithProfile('uploader add', fn: () async {
        final rs = createPubApiClient().addUploader('oxygen');
        await expectApiException(
          rs,
          status: 403,
          code: 'OperationForbidden',
          message: 'https://pub.dev/packages/oxygen/admin',
        );
      });

      testWithProfile('uploader remove', fn: () async {
        final rs =
            createPubApiClient().removeUploader('oxygen', 'admin@pub.dev');
        await expectApiException(
          rs,
          status: 403,
          code: 'OperationForbidden',
          message: 'https://pub.dev/packages/oxygen/admin',
        );
      });
    });

    group('invite uploader', () {
      testWithProfile('not logged in', fn: () async {
        final rs = packageBackend.inviteUploader(
            'oxygen', InviteUploaderRequest(email: 'a@b.com'));
        await expectLater(rs, throwsA(isA<AuthenticationException>()));
      });

      testWithProfile('not authorized', fn: () async {
        await withFakeAuthRequestContext('foo@bar.com', () async {
          final rs = packageBackend.inviteUploader(
              'oxygen', InviteUploaderRequest(email: 'a@b.com'));
          await expectLater(rs, throwsA(isA<AuthorizationException>()));
        });
      });

      testWithProfile('blocked user', fn: () async {
        final user = await accountBackend.lookupUserByEmail('admin@pub.dev');
        await dbService.commit(inserts: [user..isBlocked = true]);
        final rs = withFakeAuthRequestContext(
          adminAtPubDevEmail,
          () async {
            return packageBackend.inviteUploader(
                'oxygen', InviteUploaderRequest(email: 'a@b.com'));
          },
        );
        await expectLater(rs, throwsA(isA<AuthenticationException>()));
      });

      testWithProfile('package does not exist', fn: () async {
        await withFakeAuthRequestContext(adminAtPubDevEmail, () async {
          final rs = packageBackend.inviteUploader(
              'no_package', InviteUploaderRequest(email: 'a@b.com'));
          await expectLater(rs, throwsA(isA<NotFoundException>()));
        });
      });

      testWithProfile('already exists', fn: () async {
        await withFakeAuthRequestContext(adminAtPubDevEmail, () async {
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
        await withFakeAuthRequestContext(adminAtPubDevEmail, () async {
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
        await withFakeAuthRequestContext('foo@bar.com', () async {
          final rs = packageBackend.removeUploader('oxygen', 'admin@pub.dev');
          await expectLater(rs, throwsA(isA<AuthorizationException>()));
        });
      });

      testWithProfile('package does not exist', fn: () async {
        await withFakeAuthRequestContext(adminAtPubDevEmail, () async {
          final rs =
              packageBackend.removeUploader('non_hydrogen', 'user@pub.dev');
          await expectLater(rs, throwsA(isA<NotFoundException>()));
        });
      });

      testWithProfile('cannot remove last uploader', fn: () async {
        await withFakeAuthRequestContext(adminAtPubDevEmail, () async {
          final rs = packageBackend.removeUploader('oxygen', 'admin@pub.dev');
          await expectLater(
              rs,
              throwsA(isException.having((e) => '$e', 'toString',
                  'OperationForbidden(403): Cannot remove last uploader of a package.')));
        });
      });

      testWithProfile('cannot remove nonexistent uploader', fn: () async {
        await withFakeAuthRequestContext(adminAtPubDevEmail, () async {
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
        final user = await accountBackend.lookupUserByEmail('user@pub.dev');
        pkg.addUploader(user.userId);
        await dbService.commit(inserts: [pkg]);

        await withFakeAuthRequestContext(adminAtPubDevEmail, () async {
          final rs = packageBackend.removeUploader('oxygen', 'admin@pub.dev');
          await expectLater(
              rs,
              throwsA(isException.having((e) => '$e', 'toString',
                  'OperationForbidden(403): Self-removal is not allowed. Use another account to remove this email address.')));
        });
      });

      testWithProfile('successful', fn: () async {
        // adding extra uploader for the scope of this test
        final pkg = (await packageBackend.lookupPackage('oxygen'))!;
        final user = await accountBackend.lookupUserByEmail('user@pub.dev');
        pkg.addUploader(user.userId);
        await dbService.commit(inserts: [pkg]);

        // verify before change
        final pkg2 = (await packageBackend.lookupPackage('oxygen'))!;
        expect(pkg2.uploaders, contains(user.userId));

        await withFakeAuthRequestContext(adminAtPubDevEmail, () async {
          await packageBackend.removeUploader('oxygen', 'user@pub.dev');
        });

        // verify after change
        final pkg3 = (await packageBackend.lookupPackage('oxygen'))!;
        expect(pkg3.uploaders, isNot(contains(user.userId)));

        // check audit log record
        final page = await auditBackend.listRecordsForPackage('oxygen');
        final r = page.records
            .firstWhere((r) => r.kind == AuditLogRecordKind.uploaderRemoved);
        expect(r.summary,
            '`admin@pub.dev` removed `user@pub.dev` from the uploaders of package `oxygen`.');
      });
    });

    group('GCloudRepository.lookupVersion', () {
      testWithProfile('package not found', fn: () async {
        final rs = packageBackend.lookupVersion('not_hydrogen', '1.0.0');
        await expectLater(rs, throwsA(isA<NotFoundException>()));
      });

      testWithProfile('version not found', fn: () async {
        final rs = packageBackend.lookupVersion('oxygen', '0.3.0');
        await expectLater(rs, throwsA(isA<NotFoundException>()));
      });

      testWithProfile('successful', fn: () async {
        final version = await packageBackend.lookupVersion('oxygen', '1.0.0');
        expect(version, isNotNull);
        expect(version.version, '1.0.0');
        expect(version.archiveSha256, isNotEmpty);
      });
    });

    group('listVersions', () {
      testWithProfile('not found', fn: () async {
        final rs = packageBackend.listVersions('non_hydrogen');
        await expectLater(rs, throwsA(isA<NotFoundException>()));
      });

      testWithProfile('found', fn: () async {
        final pd = await packageBackend.listVersions('oxygen');
        expect(pd.versions, isNotEmpty);
        expect(pd.latest.version, '1.2.0');
        expect(pd.isDiscontinued, isNull);
        // checking versions order
        expect(
            pd.versions.map((v) => v.version), ['1.0.0', '1.2.0', '2.0.0-dev']);
        expect(pd.descendingVersions.map((v) => v.version),
            ['2.0.0-dev', '1.2.0', '1.0.0']);
        // check hash differs
        final hashes = pd.versions.map((e) => e.archiveSha256).toSet();
        expect(hashes, hasLength(pd.versions.length));
        for (final hash in hashes) {
          expect(hash, hasLength(64));
        }
      });

      testWithProfile('isDiscontinued', fn: () async {
        await withFakeAuthRequestContext(
            adminAtPubDevEmail,
            () => packageBackend.updateOptions(
                'oxygen', PkgOptions(isDiscontinued: true)));
        final pd = await packageBackend.listVersions('oxygen');
        expect(pd.isDiscontinued, isTrue);
      });
    });

    group('options', () {
      testWithProfile('discontinued', fn: () async {
        await withFakeAuthRequestContext(adminAtPubDevEmail, () async {
          await packageBackend.updateOptions(
              'oxygen', PkgOptions(isDiscontinued: true));
          final p = (await packageBackend.lookupPackage('oxygen'))!;
          expect(p.isDiscontinued, isTrue);
          expect(p.replacedBy, isNull);
          expect(p.isUnlisted, isFalse);
        });
      });

      testWithProfile('replaced by - without discontinued', fn: () async {
        await withFakeAuthRequestContext(adminAtPubDevEmail, () async {
          final rs = packageBackend.updateOptions(
              'oxygen', PkgOptions(replacedBy: 'neon'));
          await expectLater(
              rs,
              throwsA(isA<InvalidInputException>().having((e) => '$e', 'text',
                  'InvalidInput(400): "replacedBy" must be set only with "isDiscontinued": true.')));
        });
      });

      testWithProfile('replaced by - with discontinued=false', fn: () async {
        await withFakeAuthRequestContext(adminAtPubDevEmail, () async {
          final rs = packageBackend.updateOptions(
              'oxygen', PkgOptions(isDiscontinued: false, replacedBy: 'neon'));
          await expectLater(
              rs,
              throwsA(isA<InvalidInputException>().having((e) => '$e', 'text',
                  'InvalidInput(400): "replacedBy" must be set only with "isDiscontinued": true.')));
        });
      });

      testWithProfile('replaced by - same package', fn: () async {
        await withFakeAuthRequestContext(adminAtPubDevEmail, () async {
          final rs = packageBackend.updateOptions(
              'oxygen', PkgOptions(isDiscontinued: true, replacedBy: 'oxygen'));
          await expectLater(
              rs,
              throwsA(isA<InvalidInputException>().having((e) => '$e', 'text',
                  'InvalidInput(400): "replacedBy" must point to a different package.')));
        });
      });

      testWithProfile('replaced by - with invalid / nonexistent package',
          fn: () async {
        await withFakeAuthRequestContext(adminAtPubDevEmail, () async {
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
        await withFakeAuthRequestContext(adminAtPubDevEmail, () async {
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
        await withFakeAuthRequestContext(adminAtPubDevEmail, () async {
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
          final page = await auditBackend.listRecordsForPackage('oxygen');
          final r = page.records.firstWhere(
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
        await withFakeAuthRequestContext(adminAtPubDevEmail, () async {
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
