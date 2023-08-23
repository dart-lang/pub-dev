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

    final dataDir2 = Directory(path.join(Directory.current.path, 'test',
        'service', 'security_advisory', 'testdata', 'adv2'));
    final (updatedOsvs, updatedFailedFiles) =
        await loadAdvisoriesFromDir(dataDir2);
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
  });
}
