// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/service/security_advisories/backend.dart';
import 'package:pub_dev/service/security_advisories/models.dart';
import 'package:test/test.dart';

import '../shared/test_services.dart';

void main() {
  testWithProfile('Insert, lookup and update advisory', fn: () async {
    final firstTime = DateTime(2022).toIso8601String();
    final affectedA = Affected(
      package: Package(ecosystem: 'pub', name: 'a'),
      versions: ['1'],
    );

    final affectedB = Affected(
      package: Package(ecosystem: 'pub', name: 'b'),
      versions: ['1'],
    );

    final affectedC = Affected(
      package: Package(ecosystem: 'pub', name: 'c'),
      versions: ['1'],
    );

    final id = '123';

    final osv = OSV(
      schemaVersion: '1.2.3',
      id: id,
      modified: firstTime,
      published: firstTime,
      affected: [affectedA, affectedB],
    );

    await securityAdvisoryBackend.ingestSecurityAdvisory(osv);

    final advisory = await securityAdvisoryBackend.lookupById(id);
    expect(advisory, isNotNull);
    expect(advisory!.id, id);
    expect(advisory.aliases, [id]);
    expect(advisory.affectedPackages!.length, 2);
    expect(advisory.affectedPackages!.first, affectedA.package.name);
    expect(advisory.affectedPackages!.last, affectedB.package.name);

    final list = await securityAdvisoryBackend.lookupSecurityAdvisories('a');
    expect(list, isNotNull);
    expect(list.length, 1);
    expect(list.first.id, id);

    final updateTime = DateTime(2023).toIso8601String();

    final updatedOsv = OSV(
      schemaVersion: '1.2.3',
      id: id,
      modified: updateTime,
      published: updateTime,
      affected: [affectedA, affectedC],
    );

    await securityAdvisoryBackend.ingestSecurityAdvisory(updatedOsv);

    final updatedAdvisory = await securityAdvisoryBackend.lookupById(id);
    expect(updatedAdvisory, isNotNull);
    expect(updatedAdvisory!.id, id);
    expect(updatedAdvisory.aliases, [id]);
    expect(updatedAdvisory.affectedPackages!.length, 2);
    expect(updatedAdvisory.affectedPackages!.first, affectedA.package.name);
    expect(updatedAdvisory.affectedPackages!.last, affectedC.package.name);

    final list2 = await securityAdvisoryBackend.lookupSecurityAdvisories('b');
    expect(list2, isEmpty);

    final list3 = await securityAdvisoryBackend.lookupSecurityAdvisories('c');
    expect(list3, isNotNull);
    expect(list3.length, 1);
    expect(list3.first.id, id);
  });
}
