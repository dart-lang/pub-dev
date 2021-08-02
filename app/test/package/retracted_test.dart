// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:client_data/package_api.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/package/backend.dart';

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
      expect(origInfo.isRetracted, isNull);

      final u1 = await client.setVersionOptions(
          'oxygen', '1.2.0', VersionOptions(isRetracted: true));
      expect(u1.isRetracted, isTrue);
      final u1Info = await client.packageVersionInfo('oxygen', '1.2.0');
      expect(u1Info.isRetracted, isTrue);
      final v1 = await client.packageVersionInfo('oxygen', '1.0.0');
      expect(v1.isRetracted, isNull);
      await expectVersions(
        retractable: ['1.0.0', '2.0.0-dev'],
        recentlyRetracted: ['1.2.0'],
      );

      final u2 = await client.setVersionOptions(
          'oxygen', '1.2.0', VersionOptions(isRetracted: true));
      expect(u2.toJson(), u1.toJson());
      final u2Info = await client.packageVersionInfo('oxygen', '1.2.0');
      expect(u2Info.isRetracted, isTrue);
      await expectVersions(
        retractable: ['1.0.0', '2.0.0-dev'],
        recentlyRetracted: ['1.2.0'],
      );

      final u3 = await client.setVersionOptions(
          'oxygen', '1.2.0', VersionOptions(isRetracted: false));
      expect(u3.toJson(), orig.toJson());
      final u3Info = await client.packageVersionInfo('oxygen', '1.2.0');
      expect(u3Info.isRetracted, isNull);
      await expectVersions(
        retractable: ['1.0.0', '1.2.0', '2.0.0-dev'],
        recentlyRetracted: [],
      );
    });
  });
}
