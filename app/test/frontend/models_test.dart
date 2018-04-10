// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/model_properties.dart';

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
        expect(p.latestVersion, '0.1.1+5');
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
        expect(p.latestVersion, '0.1.1+5');
        p.updateVersion(new PackageVersion()
          ..parentKey = testPackageKey
          ..id = '0.1.0'
          ..version = '0.1.0');
        expect(p.latestVersion, '0.1.1+5');
        expect(p.latestDevVersion, '0.1.1+5');
      });

      test('new dev version', () {
        final Package p = new Package()
          ..latestVersionKey = testPackageVersionKey
          ..latestDevVersionKey = testPackageVersionKey;
        expect(p.latestVersion, '0.1.1+5');
        p.updateVersion(new PackageVersion()
          ..parentKey = testPackageKey
          ..id = '1.0.0-dev'
          ..version = '1.0.0-dev');
        expect(p.latestVersion, '0.1.1+5');
        expect(p.latestDevVersion, '1.0.0-dev');
      });

      test('new dev version, then a stable patch', () {
        final Package p = new Package()
          ..latestVersionKey = testPackageVersionKey
          ..latestDevVersionKey = testPackageVersionKey;
        expect(p.latestVersion, '0.1.1+5');

        p.updateVersion(new PackageVersion()
          ..parentKey = testPackageKey
          ..id = '1.0.0-dev'
          ..version = '1.0.0-dev');
        expect(p.latestVersion, '0.1.1+5');
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

  group('Pubspec', () {
    const String pubspecBase = '''
name: test_package
description: 'Test package'
version: 1.0.9
''';

    test('properties', () {
      final Pubspec p = new Pubspec(pubspecBase);
      expect(p.name, 'test_package');
      expect(p.description, 'Test package');
      expect(p.version, '1.0.9');
    });

    group('Flutter', () {
      test('basic package', () {
        final Pubspec p = new Pubspec(pubspecBase);
        expect(p.hasFlutterPlugin, isFalse);
        expect(p.dependsOnFlutterSdk, isFalse);
      });
      test('Depends on Flutter SDK', () {
        final Pubspec p = new Pubspec(pubspecBase +
            'dependencies:\n'
            '  flutter:\n'
            '    sdk: flutter\n');
        expect(p.hasFlutterPlugin, isFalse);
        expect(p.dependsOnFlutterSdk, isTrue);
      });
      test('Has flutter plugin', () {
        final Pubspec p = new Pubspec(pubspecBase +
            'flutter:\n'
            '  plugin:\n'
            '    androidPackage: com.example.EntryPoint\n');
        expect(p.hasFlutterPlugin, isTrue);
        expect(p.dependsOnFlutterSdk, isFalse);
      });
    });
  });

  group('Author', () {
    test('empty', () {
      final author = new Author.parse('');
      expect(author.name, '');
      expect(author.email, isNull);
    });

    test('John Doe', () {
      final author = new Author.parse('John Doe');
      expect(author.name, 'John Doe');
      expect(author.email, isNull);
    });

    test('John Doe <email>', () {
      final author = new Author.parse('John Doe <john.doe@example.com>');
      expect(author.name, 'John Doe');
      expect(author.email, 'john.doe@example.com');
    });

    test('John Doe inline email', () {
      final author = new Author.parse('John Doe john.doe@example.com');
      expect(author.name, 'John Doe');
      expect(author.email, 'john.doe@example.com');
    });

    test('John Doe inline email v2', () {
      final author = new Author.parse('John john.doe@example.com Doe');
      expect(author.name, 'John Doe');
      expect(author.email, 'john.doe@example.com');
    });

    test('email only', () {
      final author = new Author.parse('john.doe@example.com');
      expect(author.name, 'john.doe@example.com');
      expect(author.email, 'john.doe@example.com');
    });
  });
}
