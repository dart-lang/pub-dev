// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:pub_dev/service/security_advisories/backend.dart';
import 'package:pub_dev/service/security_advisories/sync_security_advisories.dart';
import 'package:test/test.dart';

import '../../shared/test_services.dart';

void main() {
  testWithProfile('Sync and resync advisories from dircetory', fn: () async {
    final dataDir1 = Directory(path.join(Directory.current.path, 'test',
        'service', 'security_advisory', 'testdata', 'adv1'));
    final (osvs, failedFiles) = await loadAdvisoriesFromDir(dataDir1);
    expect(failedFiles, isEmpty);
    expect(osvs.length, 4);

    await updateAdvisories(osvs);
    var list = await securityAdvisoryBackend.listAdvisories();
    expect(list.length, 4);

    var adv = await securityAdvisoryBackend.lookupById('GHSA-4xh4-v2pq-jvhm');
    expect(adv, isNotNull);
    adv = await securityAdvisoryBackend.lookupById('GHSA-9324-jv53-9cc8');
    expect(adv, isNotNull);
    adv = await securityAdvisoryBackend.lookupById('GHSA-4xh4-v2pq-jvhm');
    expect(adv, isNotNull);
    adv = await securityAdvisoryBackend.lookupById('GHSA-9f2c-xxfm-32mj');
    expect(adv, isNotNull);
    adv = await securityAdvisoryBackend.lookupById('GHSA-jwpw-q68h-r678');
    expect(adv, isNull);

    final dataDir2 = Directory(path.join(Directory.current.path, 'test',
        'service', 'security_advisory', 'testdata', 'adv2'));
    final (updatedOsvs, updatedFailedFiles) =
        await loadAdvisoriesFromDir(dataDir2);
    expect(updatedFailedFiles, isEmpty);
    expect(updatedOsvs.length, 4);

    await updateAdvisories(updatedOsvs);

    list = await securityAdvisoryBackend.listAdvisories();
    expect(list.length, 4);

    adv = await securityAdvisoryBackend.lookupById('GHSA-4xh4-v2pq-jvhm');
    expect(adv, isNotNull);
    adv = await securityAdvisoryBackend.lookupById('GHSA-9324-jv53-9cc8');
    expect(adv, isNotNull);
    adv = await securityAdvisoryBackend.lookupById('GHSA-4xh4-v2pq-jvhm');
    expect(adv, isNotNull);
    adv = await securityAdvisoryBackend.lookupById('GHSA-9f2c-xxfm-32mj');
    expect(adv, isNull);
    adv = await securityAdvisoryBackend.lookupById('GHSA-jwpw-q68h-r678');
    expect(adv, isNotNull);
  });
}
