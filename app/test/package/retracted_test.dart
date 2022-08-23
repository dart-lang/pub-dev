// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/data/package_api.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('Retractions', () {
    Future<void> expectVersions({
      String package = 'oxygen',
      dynamic retractable,
      dynamic recentlyRetracted,
    }) async {
      if (retractable != null) {
        final r1 = await packageBackend.listRetractableVersions(package);
        expect(r1.map((pv) => pv.version).toList(), retractable);
      }
      if (recentlyRetracted != null) {
        final u1 = await packageBackend.listRecentlyRetractedVersions('oxygen');
        expect(u1.map((pv) => pv.version).toList(), recentlyRetracted);
      }
    }

    testWithProfile('unauthenticated', fn: () async {
      final client = createPubApiClient();
      await expectApiException(
        client.setVersionOptions('oxygen', '1.2.0', VersionOptions()),
        status: 401,
        code: 'MissingAuthentication',
      );
    });

    testWithProfile('unauthorized', fn: () async {
      final client = createPubApiClient(authToken: userAtPubDevAuthToken);
      await expectApiException(
        client.setVersionOptions('oxygen', '1.2.0', VersionOptions()),
        status: 403,
        code: 'InsufficientPermissions',
      );
    });

    testWithProfile('bad package', fn: () async {
      final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
      await expectApiException(
        client.setVersionOptions('no_package', '1.2.0', VersionOptions()),
        status: 404,
        code: 'NotFound',
      );
    });

    testWithProfile('bad version', fn: () async {
      final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
      await expectApiException(
        client.setVersionOptions('oxygen', '10.0.0', VersionOptions()),
        status: 404,
        code: 'NotFound',
      );
    });

    testWithProfile('wait too long before retraction', fn: () async {
      await expectVersions(
        retractable: ['1.0.0', '1.2.0', '2.0.0-dev'],
        recentlyRetracted: [],
      );

      final pv = await packageBackend.lookupPackageVersion('oxygen', '1.0.0');
      pv!.created = pv.created!.subtract(Duration(days: 7));
      await dbService.commit(inserts: [pv]);
      await expectVersions(
        retractable: ['1.2.0', '2.0.0-dev'],
        recentlyRetracted: [],
      );

      final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
      await expectApiException(
        client.setVersionOptions(
            'oxygen', '1.0.0', VersionOptions(isRetracted: true)),
        status: 400,
        code: 'InvalidInput',
        message: 'Can\'t retract package "oxygen" version "1.0.0".',
      );
    });

    testWithProfile('wait too long after retraction', fn: () async {
      await expectVersions(
        retractable: ['1.0.0', '1.2.0', '2.0.0-dev'],
        recentlyRetracted: [],
      );
      final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
      await client.setVersionOptions(
          'oxygen', '1.2.0', VersionOptions(isRetracted: true));
      await expectVersions(
        retractable: ['1.0.0', '2.0.0-dev'],
        recentlyRetracted: ['1.2.0'],
      );

      final pv2 = await packageBackend.lookupPackageVersion('oxygen', '1.2.0');
      pv2!.retracted = pv2.created!.subtract(Duration(days: 8));
      await dbService.commit(inserts: [pv2]);
      await expectVersions(
        retractable: ['1.0.0', '2.0.0-dev'],
        recentlyRetracted: [],
      );

      await expectApiException(
        client.setVersionOptions(
            'oxygen', '1.2.0', VersionOptions(isRetracted: false)),
        status: 400,
        code: 'InvalidInput',
        message: 'Can\'t undo retraction of package "oxygen" version "1.2.0".',
      );
    });

    testWithProfile('Successful', fn: () async {
      await expectVersions(
        retractable: ['1.0.0', '1.2.0', '2.0.0-dev'],
        recentlyRetracted: [],
      );
      final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
      final orig = await client.getVersionOptions('oxygen', '1.2.0');
      expect(orig.isRetracted, isFalse);
      final origInfo = await client.packageVersionInfo('oxygen', '1.2.0');
      expect(origInfo.retracted, isNull);
      final p0Info = PackageData.fromJson(
          json.decode(utf8.decode(await client.listVersions('oxygen')))
              as Map<String, dynamic>);
      expect(p0Info.latest.version, '1.2.0');

      final u1 = await client.setVersionOptions(
          'oxygen', '1.2.0', VersionOptions(isRetracted: true));
      expect(u1.isRetracted, isTrue);
      final u1Info = await client.packageVersionInfo('oxygen', '1.2.0');
      expect(u1Info.retracted, isTrue);
      final v1 = await client.packageVersionInfo('oxygen', '1.0.0');
      expect(v1.retracted, isNull);
      await expectVersions(
        retractable: ['1.0.0', '2.0.0-dev'],
        recentlyRetracted: ['1.2.0'],
      );
      final p1Info = PackageData.fromJson(
          json.decode(utf8.decode(await client.listVersions('oxygen')))
              as Map<String, dynamic>);
      expect(p1Info.latest.version, '1.0.0');

      final u2 = await client.setVersionOptions(
          'oxygen', '1.2.0', VersionOptions(isRetracted: true));
      expect(u2.toJson(), u1.toJson());
      final u2Info = await client.packageVersionInfo('oxygen', '1.2.0');
      expect(u2Info.retracted, isTrue);
      await expectVersions(
        retractable: ['1.0.0', '2.0.0-dev'],
        recentlyRetracted: ['1.2.0'],
      );

      final u3 = await client.setVersionOptions(
          'oxygen', '1.2.0', VersionOptions(isRetracted: false));
      expect(u3.toJson(), orig.toJson());
      final u3Info = await client.packageVersionInfo('oxygen', '1.2.0');
      expect(u3Info.retracted, isNull);
      await expectVersions(
        retractable: ['1.0.0', '1.2.0', '2.0.0-dev'],
        recentlyRetracted: [],
      );
      final p3Info = PackageData.fromJson(
          json.decode(utf8.decode(await client.listVersions('oxygen')))
              as Map<String, dynamic>);
      expect(p3Info.latest.version, '1.2.0');
    });

    testWithProfile('Updates latest version references',
        testProfile: TestProfile(
          defaultUser: 'admin@pub.dev',
          packages: [
            TestPackage(name: 'oxygen', versions: [
              TestVersion(version: '1.0.0'),
              TestVersion(version: '1.2.0'),
              TestVersion(version: '2.0.0-dev'),
              TestVersion(version: '2.1.0-dev'),
            ]),
          ],
        ), fn: () async {
      await expectVersions(
        retractable: ['1.0.0', '1.2.0', '2.0.0-dev', '2.1.0-dev'],
        recentlyRetracted: [],
      );
      final pkg = (await packageBackend.lookupPackage('oxygen'))!;
      expect(pkg.latestVersion, '1.2.0');

      final origLastVersionPublished = pkg.lastVersionPublished;
      final origLatestPublished = pkg.latestPublished;
      final origLatestPrereleasePublished = pkg.latestPrereleasePublished;

      final client = createPubApiClient(authToken: adminAtPubDevAuthToken);
      final orig = await client.getVersionOptions('oxygen', '1.2.0');
      expect(orig.isRetracted, isFalse);
      final origInfo = await client.packageVersionInfo('oxygen', '1.2.0');
      expect(origInfo.retracted, isNull);

      // Retract latest
      final u1 = await client.setVersionOptions(
          'oxygen', '1.2.0', VersionOptions(isRetracted: true));
      expect(u1.isRetracted, isTrue);
      final u1Info = await client.packageVersionInfo('oxygen', '1.2.0');
      expect(u1Info.retracted, isTrue);

      final pkg1 = (await packageBackend.lookupPackage('oxygen'))!;
      expect(pkg1.latestVersion, '1.0.0');
      expect(pkg1.latestPublished, isNot(origLatestPublished));
      expect(pkg1.lastVersionPublished, origLastVersionPublished);

      // Restore latest
      final u2 = await client.setVersionOptions(
          'oxygen', '1.2.0', VersionOptions(isRetracted: false));
      expect(u2.isRetracted, isFalse);
      final u2Info = await client.packageVersionInfo('oxygen', '1.2.0');
      expect(u2Info.retracted, isNull);

      final pkg2 = (await packageBackend.lookupPackage('oxygen'))!;
      expect(pkg2.latestVersion, '1.2.0');
      expect(pkg2.latestPublished, origLatestPublished);
      expect(pkg2.lastVersionPublished, origLastVersionPublished);

      // Retract latest dev
      final u3 = await client.setVersionOptions(
          'oxygen', '2.1.0-dev', VersionOptions(isRetracted: true));
      expect(u3.isRetracted, isTrue);
      final u3Info = await client.packageVersionInfo('oxygen', '2.1.0-dev');
      expect(u3Info.retracted, isTrue);

      final pkg3 = (await packageBackend.lookupPackage('oxygen'))!;
      expect(pkg3.latestPrereleaseVersion, '2.0.0-dev');
      expect(
          pkg3.latestPrereleasePublished, isNot(origLatestPrereleasePublished));
      expect(pkg3.lastVersionPublished, origLastVersionPublished);

      // Retract all dev
      final u4 = await client.setVersionOptions(
          'oxygen', '2.0.0-dev', VersionOptions(isRetracted: true));
      expect(u4.isRetracted, isTrue);
      final u4Info = await client.packageVersionInfo('oxygen', '2.0.0-dev');
      expect(u4Info.retracted, isTrue);

      final pkg4 = (await packageBackend.lookupPackage('oxygen'))!;
      expect(pkg4.latestPrereleaseVersion, '1.2.0');
      expect(pkg4.latestPrereleasePublished, origLatestPublished);
      expect(pkg4.lastVersionPublished, origLastVersionPublished);

      // Restore latest dev
      final u5 = await client.setVersionOptions(
          'oxygen', '2.1.0-dev', VersionOptions(isRetracted: false));
      expect(u5.isRetracted, isFalse);
      final u5Info = await client.packageVersionInfo('oxygen', '2.1.0-dev');
      expect(u5Info.retracted, isNull);

      final pkg5 = (await packageBackend.lookupPackage('oxygen'))!;
      expect(pkg5.latestPrereleaseVersion, '2.1.0-dev');
      expect(pkg5.latestPrereleasePublished, origLatestPrereleasePublished);
      expect(pkg5.lastVersionPublished, origLastVersionPublished);

      // Retract all
      final u6 = await client.setVersionOptions(
          'oxygen', '1.2.0', VersionOptions(isRetracted: true));
      expect(u6.isRetracted, isTrue);
      final u7 = await client.setVersionOptions(
          'oxygen', '1.0.0', VersionOptions(isRetracted: true));
      expect(u7.isRetracted, isTrue);
      final u9 = await client.setVersionOptions(
          'oxygen', '2.1.0-dev', VersionOptions(isRetracted: true));
      expect(u9.isRetracted, isTrue);
      final u6Info = await client.packageVersionInfo('oxygen', '1.0.0');
      final u7Info = await client.packageVersionInfo('oxygen', '1.2.0');
      final u8Info = await client.packageVersionInfo('oxygen', '2.0.0-dev');
      final u9Info = await client.packageVersionInfo('oxygen', '2.1.0-dev');
      expect(u6Info.retracted, isTrue);
      expect(u7Info.retracted, isTrue);
      expect(u8Info.retracted, isTrue);
      expect(u9Info.retracted, isTrue);

      final pkg6 = (await packageBackend.lookupPackage('oxygen'))!;
      expect(pkg6.latestVersion, '1.2.0');
      expect(pkg6.latestPrereleaseVersion, '2.1.0-dev');
      expect(pkg6.lastVersionPublished, origLastVersionPublished);
      expect(pkg6.latestPrereleasePublished, origLatestPrereleasePublished);
      expect(pkg6.lastVersionPublished, origLastVersionPublished);
    });
  });
}
