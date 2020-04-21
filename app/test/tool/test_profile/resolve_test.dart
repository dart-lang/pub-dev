// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:pub_dev/tool/test_profile/resolver.dart';

void main() {
  Future<List<String>> _resolve(List<TestPackage> packages) async {
    final profile = TestProfile(
      publishers: [],
      packages: packages,
      users: [],
      defaultUser: 'dev@example.com',
    );
    profile.normalize();
    return await resolveVersions(profile);
  }

  group('resolver tests', () {
    test('latest version', () async {
      final pvs = await _resolve([TestPackage(name: 'retry')]);
      expect(pvs, hasLength(1));
      expect(pvs.first, startsWith('retry:'));
    });

    test('dependencies', () async {
      final pvs = await _resolve([
        TestPackage(
          name: 'safe_url_check',
          versions: ['1.0.0'],
        )
      ]);
      expect(pvs, hasLength(2));
      expect(pvs[0], startsWith('retry:'));
      expect(pvs[1], 'safe_url_check:1.0.0');
    });
  });
}
