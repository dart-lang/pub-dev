// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartlang_org/models.dart';

import 'utils.dart';

void main() {
  group('models', () {
    group('Package', () {
      test('new stable version', () {
        final Package p = new Package()
          ..latestVersionKey = testPackageVersionKey;
        expect(p.latestVersion, '0.1.1');
        p.updateVersion(new PackageVersion()
          ..parentKey = testPackageKey
          ..id = '0.2.0'
          ..version = '0.2.0');
        expect(p.latestVersion, '0.2.0');
        expect(p.latestDevVersion, '0.2.0');
      });

      test('new dev version', () {
        final Package p = new Package()
          ..latestVersionKey = testPackageVersionKey;
        expect(p.latestVersion, '0.1.1');
        p.updateVersion(new PackageVersion()
          ..parentKey = testPackageKey
          ..id = '1.0.0-dev'
          ..version = '1.0.0-dev');
        expect(p.latestVersion, '0.1.1');
        expect(p.latestDevVersion, '1.0.0-dev');
      });

      test('new dev version, then a stable patch', () {
        final Package p = new Package()
          ..latestVersionKey = testPackageVersionKey;
        expect(p.latestVersion, '0.1.1');

        p.updateVersion(new PackageVersion()
          ..parentKey = testPackageKey
          ..id = '1.0.0-dev'
          ..version = '1.0.0-dev');
        expect(p.latestVersion, '0.1.1');
        expect(p.latestDevVersion, '1.0.0-dev');

        p.updateVersion(new PackageVersion()
          ..parentKey = testPackageKey
          ..id = '0.2.0'
          ..version = '0.2.0');
        expect(p.latestVersion, '0.2.0');
        expect(p.latestDevVersion, '1.0.0-dev');
      });
    });
  });
}
