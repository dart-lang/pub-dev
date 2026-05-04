// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:clock/clock.dart';
import 'package:path/path.dart' as path;
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/service/security_advisories/backend.dart';
import 'package:pub_dev/service/security_advisories/sync_security_advisories.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';

import '../../shared/test_services.dart';

void main() {
  testWithProfile(
    'Sync and resync advisories from directory',
    fn: () async {
      final dataDir1 = Directory(
        path.join(
          Directory.current.path,
          'test',
          'service',
          'security_advisory',
          'testdata',
          'adv1',
        ),
      );
      final (osvs, failedFiles) = await loadAdvisoriesFromDir(dataDir1);
      expect(failedFiles, isEmpty);
      expect(osvs.length, 2);

      await updateAdvisories(osvs);
      var list = await securityAdvisoryBackend.listAdvisories();
      expect(list.length, 2);

      var adv = await securityAdvisoryBackend.lookupById('GHSA-4rgh-jx4f-qfcq');
      expect(adv, isNotNull);
      adv = await securityAdvisoryBackend.lookupById('GHSA-1234-1234-1234');
      expect(adv, isNotNull);
      adv = await securityAdvisoryBackend.lookupById('GHSA-5678-5678-5678');
      expect(adv, isNull);

      final dataDir2 = Directory(
        path.join(
          Directory.current.path,
          'test',
          'service',
          'security_advisory',
          'testdata',
          'adv2',
        ),
      );
      final (updatedOsvs, updatedFailedFiles) = await loadAdvisoriesFromDir(
        dataDir2,
      );
      expect(updatedFailedFiles, isEmpty);
      expect(updatedOsvs.length, 2);

      await updateAdvisories(updatedOsvs);

      list = await securityAdvisoryBackend.listAdvisories();
      expect(list.length, 2);

      adv = await securityAdvisoryBackend.lookupById('GHSA-4rgh-jx4f-qfcq');
      expect(adv, isNotNull);
      adv = await securityAdvisoryBackend.lookupById('GHSA-5678-5678-5678');
      expect(adv, isNotNull);
      adv = await securityAdvisoryBackend.lookupById('GHSA-1234-1234-1234');
      expect(adv, isNull);
    },
  );

  testWithProfile(
    'Sync with partial success',
    expectedLogMessages: [
      'SHOUT [advisory-malformed] ID: GHSA-5678-5678-5678: Invalid modified date, cannot be a future date.',
    ],
    fn: () async {
      // This directory contains 4 json files. One is with invalid json.
      // One contains invalid osv. The final two are valid security advisories.
      final dataDir3 = Directory(
        path.join(
          Directory.current.path,
          'test',
          'service',
          'security_advisory',
          'testdata',
          'adv3',
        ),
      );
      final (osvs, failedFiles) = await loadAdvisoriesFromDir(dataDir3);
      expect(failedFiles.length, 1);
      expect(osvs.length, 3);

      await updateAdvisories(osvs);
      final list = await securityAdvisoryBackend.listAdvisories();
      expect(list.length, 2);
    },
  );

  testWithProfile(
    'LatestAdvisory field gets updated on sync',
    expectedLogMessages: [
      'SHOUT [advisory-malformed] ID: GHSA-5678-5678-5678: Invalid modified date, cannot be a future date.',
    ],
    fn: () async {
      var pkg = await packageBackend.lookupPackage('oxygen');
      expect(pkg!.latestAdvisory, isNull);

      final beforeSyncTime = clock.now();
      final dataDir3 = Directory(
        path.join(
          Directory.current.path,
          'test',
          'service',
          'security_advisory',
          'testdata',
          'adv3',
        ),
      );
      final (osvs, _) = await loadAdvisoriesFromDir(dataDir3);
      await updateAdvisories(osvs);
      pkg = await packageBackend.lookupPackage('oxygen');

      expect(pkg!.latestAdvisory, isNotNull);
      expect(pkg.latestAdvisory!.isAfter(beforeSyncTime), isTrue);

      final betweenSyncsTime = clock.now();
      expect(pkg.latestAdvisory!.isBefore(betweenSyncsTime), isTrue);

      final dataDir4 = Directory(
        path.join(
          Directory.current.path,
          'test',
          'service',
          'security_advisory',
          'testdata',
          'adv4',
        ),
      );
      final (osvs1, _) = await loadAdvisoriesFromDir(dataDir4);
      await updateAdvisories(osvs1);
      pkg = await packageBackend.lookupPackage('oxygen');
      expect(pkg!.latestAdvisory!.isAfter(betweenSyncsTime), isTrue);
    },
  );

  testWithProfile(
    'syncSecurityAdvisories in-memory with downloaded live all.zip',
    testProfile: TestProfile(
      defaultUser: 'admin@pub.dev',
      users: [
        TestUser(email: 'admin@pub.dev', likes: []),
        TestUser(email: 'user@pub.dev', likes: []),
      ],
      generatedPackages:
          [
                'oxygen',
                'shared_preferences_android',
                'http',
                'personnummer',
                'pubnub',
                'dio',
                'archive',
                'agent_dart',
                'serverpod_client',
                'serverpod_auth_server',
                'jose',
              ]
              .map(
                (name) => GeneratedTestPackage(
                  name: name,
                  versions: [GeneratedTestVersion(version: '1.0.0')],
                ),
              )
              .toList(),
    ),
    fn: () async {
      final file = File(
        path.join(
          Directory.current.path,
          'test',
          'service',
          'security_advisory',
          'testdata',
          'osv-test.zip',
        ),
      );
      expect(file.existsSync(), isTrue);
      final zipBytes = file.readAsBytesSync();

      // Set up fake storage bucket via our helper methods.
      await createOsvBucketWithretryAsyncForTesting();
      final bucket = getOsvBucketForTesting();
      await bucket.writeBytes('Pub/all.zip', zipBytes);

      // Initially look up should be null for the real IDs.
      var adv = await securityAdvisoryBackend.lookupById('GHSA-4rgh-jx4f-qfcq');
      expect(adv, isNull);
      adv = await securityAdvisoryBackend.lookupById('GHSA-vm9r-h74p-hg97');
      expect(adv, isNull);

      // Execute the in-memory sync.
      await syncSecurityAdvisories();

      // Verify that it creates a good set of advisories in the backend.
      adv = await securityAdvisoryBackend.lookupById('GHSA-4rgh-jx4f-qfcq');
      expect(adv, isNotNull);
      expect(adv!.osv!.id, equals('GHSA-4rgh-jx4f-qfcq'));

      adv = await securityAdvisoryBackend.lookupById('GHSA-vm9r-h74p-hg97');
      expect(adv, isNotNull);
      expect(adv!.osv!.id, equals('GHSA-vm9r-h74p-hg97'));
      expect(adv.affectedPackages, contains('jose'));
    },
  );
}
