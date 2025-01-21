// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:_pub_shared/data/advisories_api.dart';
import 'package:_pub_shared/data/package_api.dart';
import 'package:clock/clock.dart';
import 'package:path/path.dart' as path;
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/service/security_advisories/backend.dart';
import 'package:pub_dev/shared/utils.dart';
import 'package:test/test.dart';

import '../../shared/test_models.dart';
import '../../shared/test_services.dart';

void main() {
  test('Parse advisory', () async {
    try {
      final file = File(path.join(Directory.current.path, 'test', 'service',
              'security_advisory', 'testdata', 'example_advisory.json'))
          .readAsBytesSync();
      final osv =
          OSV.fromJson(utf8JsonDecoder.convert(file) as Map<String, dynamic>);

      expect(osv.id, 'GHSA-4rgh-jx4f-qfcq');
      expect(osv.summary, contains('vulnerable to header injection'));
      expect(osv.details, contains('issue was discovered in the http package'));
      expect(osv.aliases, contains('CVE-2020-35669'));
      expect(osv.modified, '2023-04-11T01:46:51.549596Z');
      expect(osv.published, '2022-05-24T17:37:16Z');
      expect(osv.schemaVersion, '1.4.0');

      expect(osv.databaseSpecific, isNotNull);
      expect(osv.databaseSpecific!.length, 5);
      expect(osv.databaseSpecific!.keys.first, 'nvd_published_at');
      expect(osv.databaseSpecific!['github_reviewed'], isTrue);
      expect(osv.databaseSpecific!.keys.last, 'cwe_ids');
      expect(osv.databaseSpecific!['cwe_ids'].first, 'CWE-74');

      expect(osv.references!.length, 7);
      expect(osv.references![4].type, 'PACKAGE');
      expect(osv.references![4].url, 'https://github.com/dart-lang/http');

      expect(osv.affected!.length, 1);
      expect(osv.affected!.first.package.name, 'http');
      expect(osv.affected!.first.package.ecosystem, 'Pub');
      expect(osv.affected!.first.package.purl, 'pkg:pub/http');
      expect(osv.affected!.first.ranges!.length, 1);
      expect(osv.affected!.first.ranges!.first.type, 'ECOSYSTEM');
      expect(osv.affected!.first.ranges!.first.events!.length, 2);
      expect(osv.affected!.first.ranges!.first.events!.first.introduced, '0');
      expect(osv.affected!.first.ranges!.first.events!.first.fixed, isNull);
      expect(osv.affected!.first.ranges!.first.events!.last.introduced, isNull);
      expect(osv.affected!.first.ranges!.first.events!.last.fixed, '0.13.3');
      expect(osv.affected!.first.versions!.length, 113);
      expect(osv.affected!.first.versions![100], '0.8.2');
      expect(osv.affected!.first.databaseSpecific!['source'],
          'https://github.com/github/advisory-database/blob/main/advisories/github-reviewed/2022/05/GHSA-4rgh-jx4f-qfcq/GHSA-4rgh-jx4f-qfcq.json');

      expect(osv.severity!.length, 1);
      expect(osv.severity!.first.type, 'CVSS_V3');
      expect(osv.severity!.first.score,
          'CVSS:3.1/AV:N/AC:L/PR:N/UI:R/S:C/C:L/I:L/A:N');
    } catch (e, st) {
      fail('Parsing advisory failed with \n$e\n$st');
    }
  });

  testWithProfile('Ingest invalid advisory', expectedLogMessages: [
    'SHOUT Package a not found, while ingesting advisory 123.',
    'SHOUT [advisory-malformed] ID: 456: Invalid modified date, cannot be a future date.',
  ], fn: () async {
    final firstTime = DateTime(2022).toIso8601String();
    final futureTime = clock.now().add(Duration(days: 1)).toIso8601String();
    final affectedA = Affected(
      package: Package(ecosystem: 'pub', name: 'a'),
      versions: ['1.0.0'],
    );
    final id = '123';
    final id2 = '456';

    final osv = OSV(
      schemaVersion: '1.2.3',
      id: id,
      modified: firstTime,
      published: firstTime,
      affected: [affectedA],
    );

    final osv2 = OSV(
      schemaVersion: '1.2.3',
      id: id2,
      modified: futureTime,
      published: firstTime,
      affected: [affectedA],
    );

    final syncTime = clock.now();
    final adv =
        await securityAdvisoryBackend.ingestSecurityAdvisory(osv, syncTime);
    expect(adv, isNotNull);

    final adv2 =
        await securityAdvisoryBackend.ingestSecurityAdvisory(osv2, syncTime);
    expect(adv2, isNull);
  });

  testWithProfile('List all advisories and delete advisory',
      expectedLogMessages: [
        'SHOUT Package a not found, while ingesting advisory 123.',
        'SHOUT Package a not found, while ingesting advisory 456.',
      ], fn: () async {
    final firstTime = DateTime(2022).toIso8601String();
    final affectedA = Affected(
      package: Package(ecosystem: 'pub', name: 'a'),
      versions: ['1.0.0'],
    );
    final id = '123';
    final id2 = '456';

    final osv = OSV(
      schemaVersion: '1.2.3',
      id: id,
      modified: firstTime,
      published: firstTime,
      affected: [affectedA],
    );

    final osv2 = OSV(
      schemaVersion: '1.2.3',
      id: id2,
      modified: firstTime,
      published: firstTime,
      affected: [affectedA],
    );

    final syncTime = clock.now();
    final adv =
        await securityAdvisoryBackend.ingestSecurityAdvisory(osv, syncTime);
    expect(adv, isNotNull);

    final adv2 =
        await securityAdvisoryBackend.ingestSecurityAdvisory(osv2, syncTime);
    expect(adv2, isNotNull);

    final all = await securityAdvisoryBackend.listAdvisories();
    expect(all, isNotNull);
    expect(all.length, 2);
    expect(all.first.id, id);
    expect(all.last.id, id2);

    await securityAdvisoryBackend.deleteAdvisory(adv!, syncTime);

    final reduced = await securityAdvisoryBackend.listAdvisories();
    expect(reduced, isNotNull);
    expect(reduced.length, 1);
    expect(reduced.first.id, id2);

    final advisory = await securityAdvisoryBackend.lookupById(id);
    expect(advisory, isNull);
  });

  testWithProfile('Insert, lookup and update advisory', expectedLogMessages: [
    'SHOUT Package a not found, while ingesting advisory 123.',
    'SHOUT Package b not found, while ingesting advisory 123.',
    'SHOUT Package c not found, while ingesting advisory 123.',
  ], fn: () async {
    final firstTime = DateTime(2022).toIso8601String();
    final affectedA = Affected(
      package: Package(ecosystem: 'pub', name: 'a'),
      versions: ['1.0.0'],
    );

    final affectedB = Affected(
      package: Package(ecosystem: 'pub', name: 'b'),
      versions: ['1.0.0'],
    );

    final affectedC = Affected(
      package: Package(ecosystem: 'pub', name: 'c'),
      versions: ['1.0.0'],
    );

    final id = '123';

    final osv = OSV(
      schemaVersion: '1.2.3',
      id: id,
      modified: firstTime,
      published: firstTime,
      affected: [affectedA, affectedB],
    );

    final ingestTime = clock.now();
    await securityAdvisoryBackend.ingestSecurityAdvisory(osv, ingestTime);
    final afterIngestTime = clock.now();

    final advisory = await securityAdvisoryBackend.lookupById(id);
    expect(advisory, isNotNull);
    final syncTime = advisory!.syncTime!;
    expect(advisory.id, id);
    expect(advisory.aliases, [id]);
    expect(advisory.affectedPackages!.length, 2);
    expect(advisory.affectedPackages!.first, affectedA.package.name);
    expect(advisory.affectedPackages!.last, affectedB.package.name);
    expect(advisory.syncTime!, ingestTime);
    expect(advisory.syncTime!.isBefore(afterIngestTime), isTrue);

    final list = await securityAdvisoryBackend.lookupSecurityAdvisories(
      'a',
      skipCache: true,
    );
    expect(list, isNotNull);
    expect(list.length, 1);
    expect(list.first.advisory.id, id);

    final updateTime = DateTime(2023).toIso8601String();
    final updatedOsv = OSV(
      schemaVersion: '1.2.3',
      id: id,
      modified: updateTime,
      published: updateTime,
      affected: [affectedA, affectedC],
    );

    final updateIngestTime = clock.now();
    await securityAdvisoryBackend.ingestSecurityAdvisory(
        updatedOsv, updateIngestTime);

    final updatedAdvisory = await securityAdvisoryBackend.lookupById(id);
    final updatedSyncTime = updatedAdvisory!.syncTime!;

    expect(updatedAdvisory, isNotNull);
    expect(updatedAdvisory.id, id);
    expect(updatedSyncTime.isAfter(syncTime), isTrue);
    expect(updatedAdvisory.aliases, [id]);
    expect(updatedAdvisory.affectedPackages!.length, 2);
    expect(updatedAdvisory.affectedPackages!.first, affectedA.package.name);
    expect(updatedAdvisory.affectedPackages!.last, affectedC.package.name);

    final list2 = await securityAdvisoryBackend.lookupSecurityAdvisories(
      'b',
      skipCache: true,
    );
    expect(list2, isEmpty);

    final list3 = await securityAdvisoryBackend.lookupSecurityAdvisories(
      'c',
      skipCache: true,
    );
    expect(list3, isNotNull);
    expect(list3.length, 1);
    expect(list3.first.advisory.id, id);
  });

  testWithProfile(
      'Only include affected packages with "Pub" as specified ecosystem.',
      expectedLogMessages: [
        'SHOUT Package a not found, while ingesting advisory GHSA-0123-4567-8910.',
      ], fn: () async {
    final firstTime = DateTime(2022).toIso8601String();
    final id = 'GHSA-0123-4567-8910';

    final affectedA = Affected(
      package: Package(ecosystem: 'Pub', name: 'a'),
      versions: ['1.0.0'],
    );
    final affectedNotPub = Affected(
      package: Package(ecosystem: 'NotPub', name: 'b'),
      versions: ['1.0.0'],
    );

    final osv = OSV(
      schemaVersion: '1.2.3',
      id: id,
      modified: firstTime,
      published: firstTime,
      affected: [affectedA, affectedNotPub],
    );

    await securityAdvisoryBackend.ingestSecurityAdvisory(osv, clock.now());

    final advisory = await securityAdvisoryBackend.lookupById(id);
    expect(advisory, isNotNull);
    expect(advisory!.id, id);
    expect(advisory.affectedPackages!.length, 1);
    expect(advisory.affectedPackages!.first, affectedA.package.name);

    final list = await securityAdvisoryBackend.lookupSecurityAdvisories(
      'a',
      skipCache: true,
    );
    expect(list, isNotNull);
    expect(list.length, 1);
    expect(list.first.advisory.id, id);

    final list2 = await securityAdvisoryBackend.lookupSecurityAdvisories(
      'b',
      skipCache: true,
    );
    expect(list2, isNotNull);
    expect(list2, isEmpty);
  });

  group('Validate osv', () {
    test('Modified date should not be in the future', () async {
      final firstTime = DateTime(2022).toIso8601String();
      final futureTime = clock.now().add(Duration(days: 1)).toIso8601String();
      final id = '123';
      final osv = OSV(
        schemaVersion: '1.2.3',
        id: id,
        modified: futureTime,
        published: firstTime,
        affected: [
          Affected(
            package: Package(ecosystem: 'pub', name: 'oxygen'),
            versions: ['1.0.0'],
          )
        ],
      );

      final errors = sanityCheckOSV(osv);
      expect(errors, isNotEmpty);
      expect(errors.first, contains('Invalid modified date'));
    });

    test('Affected packages should be non-empty', () async {
      final firstTime = DateTime(2022).toIso8601String();
      final id = '123';
      final osv = OSV(
        schemaVersion: '1.2.3',
        id: id,
        modified: firstTime,
        published: firstTime,
        affected: [],
      );

      final errors = sanityCheckOSV(osv);
      expect(errors, isNotEmpty);
      expect(errors.first, contains('No affected packages'));
    });

    test(
        'At least one affected package should contain a non-empty versions list',
        () async {
      final firstTime = DateTime(2022).toIso8601String();
      final id = '123';
      final osv = OSV(
        schemaVersion: '1.2.3',
        id: id,
        modified: firstTime,
        published: firstTime,
        affected: [
          Affected(
            package: Package(ecosystem: 'pub', name: 'oxygen'),
            versions: [],
          )
        ],
      );

      final errors = sanityCheckOSV(osv);
      expect(errors, isNotEmpty);
      expect(errors.first, contains('specified affected versions'));
    });

    test('Id should be less than 255 characters', () async {
      final firstTime = DateTime(2022).toIso8601String();
      final longid =
          '0123456789012345678901234567890123456789012345678901234567890123456789'
          '0123456789012345678901234567890123456789012345678901234567890123456789'
          '0123456789012345678901234567890123456789012345678901234567890123456789'
          '01234567890123456789012345678901234567890123456789';
      final osv2 = OSV(
        schemaVersion: '1.2.3',
        id: longid,
        modified: firstTime,
        published: firstTime,
        affected: [
          Affected(
            package: Package(ecosystem: 'pub', name: 'oxygen'),
            versions: ['1.0.0'],
          )
        ],
      );
      final errors = sanityCheckOSV(osv2);
      expect(errors, isNotEmpty);
      expect(errors.first, contains('Invalid id'));
    });

    test('Id should be printable ASCII', () async {
      final firstTime = DateTime(2022).toIso8601String();
      final invalidId = '\n';
      final osv3 = OSV(
        schemaVersion: '1.2.3',
        id: invalidId,
        modified: firstTime,
        published: firstTime,
        affected: [
          Affected(
            package: Package(ecosystem: 'pub', name: 'oxygen'),
            versions: ['1.0.0'],
          )
        ],
      );
      final errors = sanityCheckOSV(osv3);
      expect(errors, isNotEmpty);
      expect(errors.first, contains('Invalid id'));
    });

    test('OSV size should be less than 500 kB', () async {
      final firstTime = DateTime(2022).toIso8601String();
      final id = '123';
      final largeMap = <String, String>{};
      for (int i = 0; i < 35000; i++) {
        largeMap['$i'] = '$i';
      }
      final osv4 = OSV(
        schemaVersion: '1.2.3',
        id: id,
        modified: firstTime,
        published: firstTime,
        affected: [
          Affected(
            package: Package(ecosystem: 'pub', name: 'oxygen'),
            versions: ['1.0.0'],
          )
        ],
        databaseSpecific: largeMap,
      );

      final errors = sanityCheckOSV(osv4);
      expect(errors, isNotEmpty);
      expect(errors.first, contains('OSV too large'));
    });
  });

  testWithProfile('api test for advisories', fn: () async {
    var oxygenPkg = await packageBackend.lookupPackage('oxygen');
    var neonPkg = await packageBackend.lookupPackage('neon');

    expect(oxygenPkg!.latestAdvisory, isNull);
    expect(neonPkg!.latestAdvisory, isNull);

    final syncTime = clock.now();
    final osv = OSV(
      schemaVersion: '1.2.3',
      id: '123',
      modified: DateTime(2022).toIso8601String(),
      published: DateTime(2022).toIso8601String(),
      affected: [
        Affected(
          package: Package(ecosystem: 'pub', name: 'oxygen'),
          versions: ['1.0.0'],
        )
      ],
    );
    await securityAdvisoryBackend.ingestSecurityAdvisory(osv, syncTime);

    oxygenPkg = await packageBackend.lookupPackage('oxygen');
    neonPkg = await packageBackend.lookupPackage('neon');

    expect(oxygenPkg!.latestAdvisory, syncTime);
    expect(neonPkg!.latestAdvisory, isNull);

    final client = await createFakeAuthPubApiClient(email: adminAtPubDevEmail);

    final oxygenPkgInfo = PackageData.fromJson(
        json.decode(utf8.decode(await client.listVersions('oxygen')))
            as Map<String, dynamic>);
    expect(oxygenPkgInfo.advisoriesUpdated, syncTime);

    final neonPkgInfo = PackageData.fromJson(
        json.decode(utf8.decode(await client.listVersions('neon')))
            as Map<String, dynamic>);
    expect(neonPkgInfo.advisoriesUpdated, isNull);

    final oxygenRes = await client.getPackageAdvisories('oxygen');
    expect(oxygenRes.advisories.length, 1);
    expect(oxygenRes.advisories.first.id, '123');
    expect(oxygenRes.advisoriesUpdated, syncTime);

    final neonRes = await client.getPackageAdvisories('neon');
    expect(neonRes.advisories, isEmpty);
    expect(neonRes.advisoriesUpdated, isNull);
  });

  testWithProfile('display url', expectedLogMessages: [
    'SHOUT Package a not found, while ingesting advisory GHSA-0123-4567-8910.',
    'SHOUT Package a not found, while ingesting advisory CVE-0123-4567-8910.',
    'SHOUT Package a not found, while ingesting advisory ABCD-EFGH-IJKL-1234.',
    'SHOUT Package a not found, while ingesting advisory ABCD-EFGH-IJKL-1235.',
    'SHOUT Package a not found, while ingesting advisory ABCD-EFGH-IJKL-1236.',
  ], fn: () async {
    final firstTime = DateTime(2022).toIso8601String();
    final affectedA = Affected(
      package: Package(ecosystem: 'pub', name: 'a'),
      versions: ['1.0.0'],
    );
    final ghsaId = 'GHSA-0123-4567-8910';
    final cveId = 'CVE-0123-4567-8910';
    final id = 'ABCD-EFGH-IJKL-1234';
    final id1 = 'ABCD-EFGH-IJKL-1235';
    final id2 = 'ABCD-EFGH-IJKL-1236';

    final osv = OSV(
      schemaVersion: '1.2.3',
      id: ghsaId,
      modified: firstTime,
      published: firstTime,
      affected: [affectedA],
    );

    final osv1 = OSV(
      schemaVersion: '1.2.3',
      id: cveId,
      modified: firstTime,
      published: firstTime,
      affected: [affectedA],
    );

    final osv2 = OSV(
      schemaVersion: '1.2.3',
      id: id,
      modified: firstTime,
      published: firstTime,
      affected: [affectedA],
    );

    final osv3 = OSV(
        schemaVersion: '1.2.3',
        id: id1,
        modified: firstTime,
        published: firstTime,
        affected: [affectedA],
        aliases: [ghsaId]);

    final osv4 = OSV(
        schemaVersion: '1.2.3',
        id: id2,
        modified: firstTime,
        published: firstTime,
        affected: [affectedA],
        aliases: [cveId]);

    final syncTime = clock.now();
    await securityAdvisoryBackend.ingestSecurityAdvisory(osv, syncTime);
    await securityAdvisoryBackend.ingestSecurityAdvisory(osv1, syncTime);
    await securityAdvisoryBackend.ingestSecurityAdvisory(osv2, syncTime);
    await securityAdvisoryBackend.ingestSecurityAdvisory(osv3, syncTime);
    await securityAdvisoryBackend.ingestSecurityAdvisory(osv4, syncTime);

    final all = await securityAdvisoryBackend.listAdvisories();
    expect(all, isNotNull);
    expect(all.length, 5);
    expect(all[0].id, ghsaId);
    expect(all[1].id, cveId);
    expect(all[2].id, id);
    expect(all[3].id, id1);
    expect(all[4].id, id2);
    expect(all[0].aliases, contains(ghsaId));
    expect(all[1].aliases, contains(cveId));

    expect(all[0].osv!.databaseSpecific!['pub_display_url'],
        'https://github.com/advisories/$ghsaId');

    expect(all[1].osv!.databaseSpecific!['pub_display_url'],
        'https://osv.dev/vulnerability/$cveId');

    expect(all[2].osv!.databaseSpecific!['pub_display_url'],
        'https://osv.dev/vulnerability/$id');

    expect(all[3].osv!.databaseSpecific!['pub_display_url'],
        'https://github.com/advisories/$ghsaId');

    expect(all[4].osv!.databaseSpecific!['pub_display_url'],
        'https://osv.dev/vulnerability/$cveId');
  });
}
