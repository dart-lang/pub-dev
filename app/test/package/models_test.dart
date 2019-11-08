// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/package/model_properties.dart';

import '../shared/test_models.dart';

void main() {
  group('models', () {
    group('Package', () {
      test('only dev version', () {
        final devVersion = foobarPkgKey.append(PackageVersion, id: '0.0.1-dev');
        final Package p = Package()
          ..latestVersionKey = devVersion
          ..latestDevVersionKey = devVersion;
        p.updateVersion(PackageVersion()
          ..parentKey = foobarPkgKey
          ..id = '0.2.0-dev'
          ..version = '0.2.0-dev');
        expect(p.latestVersion, '0.2.0-dev');
        expect(p.latestDevVersion, '0.2.0-dev');
      });

      test('update old with only dev version', () {
        final devVersion = foobarPkgKey.append(PackageVersion, id: '1.0.0-dev');
        final Package p = Package()
          ..latestVersionKey = devVersion
          ..latestDevVersionKey = devVersion;
        p.updateVersion(PackageVersion()
          ..parentKey = foobarPkgKey
          ..id = '0.2.1-dev'
          ..version = '0.2.1-dev');
        expect(p.latestVersion, '1.0.0-dev');
        expect(p.latestDevVersion, '1.0.0-dev');
      });

      test('stable after dev', () {
        final devVersion = foobarPkgKey.append(PackageVersion, id: '1.0.0-dev');
        final Package p = Package()
          ..latestVersionKey = devVersion
          ..latestDevVersionKey = devVersion;
        p.updateVersion(PackageVersion()
          ..parentKey = foobarPkgKey
          ..id = '0.2.0'
          ..version = '0.2.0');
        expect(p.latestVersion, '0.2.0');
        expect(p.latestDevVersion, '1.0.0-dev');
      });

      test('new stable version', () {
        final Package p = Package()
          ..latestVersionKey = foobarStablePVKey
          ..latestDevVersionKey = foobarStablePVKey;
        expect(p.latestVersion, '0.1.1+5');
        p.updateVersion(PackageVersion()
          ..parentKey = foobarPkgKey
          ..id = '0.2.0'
          ..version = '0.2.0');
        expect(p.latestVersion, '0.2.0');
        expect(p.latestDevVersion, '0.2.0');
      });

      test('update old stable version', () {
        final Package p = Package()
          ..latestVersionKey = foobarStablePVKey
          ..latestDevVersionKey = foobarStablePVKey;
        expect(p.latestVersion, '0.1.1+5');
        p.updateVersion(PackageVersion()
          ..parentKey = foobarPkgKey
          ..id = '0.1.0'
          ..version = '0.1.0');
        expect(p.latestVersion, '0.1.1+5');
        expect(p.latestDevVersion, '0.1.1+5');
      });

      test('new dev version', () {
        final Package p = Package()
          ..latestVersionKey = foobarStablePVKey
          ..latestDevVersionKey = foobarStablePVKey;
        expect(p.latestVersion, '0.1.1+5');
        p.updateVersion(PackageVersion()
          ..parentKey = foobarPkgKey
          ..id = '1.0.0-dev'
          ..version = '1.0.0-dev');
        expect(p.latestVersion, '0.1.1+5');
        expect(p.latestDevVersion, '1.0.0-dev');
      });

      test('new dev version, then a stable patch', () {
        final Package p = Package()
          ..latestVersionKey = foobarStablePVKey
          ..latestDevVersionKey = foobarStablePVKey;
        expect(p.latestVersion, '0.1.1+5');

        p.updateVersion(PackageVersion()
          ..parentKey = foobarPkgKey
          ..id = '1.0.0-dev'
          ..version = '1.0.0-dev');
        expect(p.latestVersion, '0.1.1+5');
        expect(p.latestDevVersion, '1.0.0-dev');

        p.updateVersion(PackageVersion()
          ..parentKey = foobarPkgKey
          ..id = '0.2.0'
          ..version = '0.2.0');
        expect(p.latestVersion, '0.2.0');
        expect(p.latestDevVersion, '1.0.0-dev');
      });
    });
  });

  group('Pubspec', () {
    const String pubspecBase = '''
name: test_package
description: 'Test package'
version: 1.0.9
''';

    test('properties', () {
      final Pubspec p = Pubspec(pubspecBase);
      expect(p.name, 'test_package');
      expect(p.description, 'Test package');
      expect(p.version, '1.0.9');
    });

    group('Flutter', () {
      test('basic package', () {
        final Pubspec p = Pubspec(pubspecBase);
        expect(p.hasFlutterPlugin, isFalse);
        expect(p.dependsOnFlutterSdk, isFalse);
      });
      test('Depends on Flutter SDK', () {
        final Pubspec p = Pubspec(pubspecBase +
            'dependencies:\n'
                '  flutter:\n'
                '    sdk: flutter\n');
        expect(p.hasFlutterPlugin, isFalse);
        expect(p.dependsOnFlutterSdk, isTrue);
      });
      test('Has flutter plugin', () {
        final Pubspec p = Pubspec(pubspecBase +
            'flutter:\n'
                '  plugin:\n'
                '    androidPackage: com.example.EntryPoint\n');
        expect(p.hasFlutterPlugin, isTrue);
        expect(p.dependsOnFlutterSdk, isFalse);
      });
    });
  });
}
