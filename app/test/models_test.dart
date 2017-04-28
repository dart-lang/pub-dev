// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartlang_org/models.dart';

import 'utils.dart';

void main() {
  group('models', () {
    group('Package', () {
      test('only dev version', () {
        final devVersion =
            testPackageKey.append(PackageVersion, id: '0.0.1-dev');
        final Package p = new Package()
          ..latestVersionKey = devVersion
          ..latestDevVersionKey = devVersion;
        p.updateVersion(new PackageVersion()
          ..parentKey = testPackageKey
          ..id = '0.2.0-dev'
          ..version = '0.2.0-dev');
        expect(p.latestVersion, '0.2.0-dev');
        expect(p.latestDevVersion, '0.2.0-dev');
      });

      test('update old with only dev version', () {
        final devVersion =
            testPackageKey.append(PackageVersion, id: '1.0.0-dev');
        final Package p = new Package()
          ..latestVersionKey = devVersion
          ..latestDevVersionKey = devVersion;
        p.updateVersion(new PackageVersion()
          ..parentKey = testPackageKey
          ..id = '0.2.1-dev'
          ..version = '0.2.1-dev');
        expect(p.latestVersion, '1.0.0-dev');
        expect(p.latestDevVersion, '1.0.0-dev');
      });

      test('stable after dev', () {
        final devVersion =
            testPackageKey.append(PackageVersion, id: '1.0.0-dev');
        final Package p = new Package()
          ..latestVersionKey = devVersion
          ..latestDevVersionKey = devVersion;
        p.updateVersion(new PackageVersion()
          ..parentKey = testPackageKey
          ..id = '0.2.0'
          ..version = '0.2.0');
        expect(p.latestVersion, '0.2.0');
        expect(p.latestDevVersion, '1.0.0-dev');
      });

      test('new stable version', () {
        final Package p = new Package()
          ..latestVersionKey = testPackageVersionKey
          ..latestDevVersionKey = testPackageVersionKey;
        expect(p.latestVersion, '0.1.1');
        p.updateVersion(new PackageVersion()
          ..parentKey = testPackageKey
          ..id = '0.2.0'
          ..version = '0.2.0');
        expect(p.latestVersion, '0.2.0');
        expect(p.latestDevVersion, '0.2.0');
      });

      test('update old stable version', () {
        final Package p = new Package()
          ..latestVersionKey = testPackageVersionKey
          ..latestDevVersionKey = testPackageVersionKey;
        expect(p.latestVersion, '0.1.1');
        p.updateVersion(new PackageVersion()
          ..parentKey = testPackageKey
          ..id = '0.1.0'
          ..version = '0.1.0');
        expect(p.latestVersion, '0.1.1');
        expect(p.latestDevVersion, '0.1.1');
      });

      test('new dev version', () {
        final Package p = new Package()
          ..latestVersionKey = testPackageVersionKey
          ..latestDevVersionKey = testPackageVersionKey;
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
          ..latestVersionKey = testPackageVersionKey
          ..latestDevVersionKey = testPackageVersionKey;
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
