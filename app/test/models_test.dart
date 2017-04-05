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
        expect(p.latestVersionKey.id, '0.1.1');
        p.updateVersion(testPackageKey.append(PackageVersion, id: '0.2.0'));
        expect(p.latestVersionKey.id, '0.2.0');
        expect(p.latestDevVersionKey.id, '0.2.0');
      });

      test('new dev version', () {
        final Package p = new Package()
          ..latestVersionKey = testPackageVersionKey;
        expect(p.latestVersionKey.id, '0.1.1');
        p.updateVersion(testPackageKey.append(PackageVersion, id: '1.0.0-dev'));
        expect(p.latestVersionKey.id, '0.1.1');
        expect(p.latestDevVersionKey.id, '1.0.0-dev');
      });

      test('new dev version, then a stable patch', () {
        final Package p = new Package()
          ..latestVersionKey = testPackageVersionKey;
        expect(p.latestVersionKey.id, '0.1.1');

        p.updateVersion(testPackageKey.append(PackageVersion, id: '1.0.0-dev'));
        expect(p.latestVersionKey.id, '0.1.1');
        expect(p.latestDevVersionKey.id, '1.0.0-dev');

        p.updateVersion(testPackageKey.append(PackageVersion, id: '0.2.0'));
        expect(p.latestVersionKey.id, '0.2.0');
        expect(p.latestDevVersionKey.id, '1.0.0-dev');
      });
    });
  });
}
