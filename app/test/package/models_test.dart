// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:pub_dev/package/model_properties.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/scorecard/backend.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

import '../shared/test_services.dart';

void main() {
  group('models', () {
    group('Package', () {
      test('only prerelease version', () {
        final ps = _PublishSequence();
        ps.publish('0.0.1-dev');
        ps.verify('0.0.1-dev');

        // newer prerelease
        ps.publish('0.2.0-dev');
        ps.verify('0.2.0-dev');

        // earlier prerelease
        ps.publish('0.1.0-dev');
        ps.verify('0.2.0-dev');
      });

      test('stable after prerelease', () {
        final ps = _PublishSequence();
        ps.publish('1.0.0-dev');
        ps.verify('1.0.0-dev');

        // stable but earlier
        ps.publish('0.2.0+2');
        ps.verify('0.2.0+2', prerelease: '1.0.0-dev', showPrerelease: true);

        // release 1.0
        ps.publish('1.0.0');
        ps.verify('1.0.0');

        // update old version
        ps.publish('0.2.0+2');
        ps.verify('1.0.0');

        // verify date
        expect(ps._p.lastVersionPublished, isNotNull);
        expect(ps._p.lastVersionPublished!.isAfter(ps._p.created!), isTrue);
      });

      test('preview', () {
        final ps = _PublishSequence();
        // stable
        ps.publish('1.0.0');
        ps.verify('1.0.0');

        // displaying as prerelease
        ps.publish('1.1.0-dev', sdk: 1);
        ps.verify(
          '1.0.0',
          prerelease: '1.1.0-dev',
          preview: '1.0.0',
          showPrerelease: true,
        );

        // stable preview
        ps.publish('1.2.0', sdk: 1);
        ps.verify(
          '1.0.0',
          prerelease: '1.2.0',
          preview: '1.2.0',
          showPreview: true,
        );
      });

      test('prerelease and preview', () {
        final ps = _PublishSequence();
        ps.publish('1.0.0');

        // prerelease
        ps.publish('2.0.0-dev');
        ps.verify('1.0.0', prerelease: '2.0.0-dev', showPrerelease: true);

        // preview
        ps.publish('1.2.0', sdk: 1);
        ps.verify(
          '1.0.0',
          preview: '1.2.0',
          prerelease: '2.0.0-dev',
          showPrerelease: true,
          showPreview: true,
        );
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
      expect(p.canonicalVersion, '1.0.9');
    });

    group('legacy sdk', () {
      Pubspec pubspecWithEnv(Map<String, String> env) {
        return Pubspec.fromJson({
          'name': 'test',
          'environment': env,
        });
      }

      test('no environment', () {
        expect(pubspecWithEnv({}).supportsOnlyLegacySdk, true);
      });

      test('only Flutter', () {
        expect(pubspecWithEnv({'flutter': 'any'}).supportsOnlyLegacySdk, false);
      });

      test('only Dart 1', () {
        expect(pubspecWithEnv({'sdk': '>=1.0.0 <2.0.0'}).supportsOnlyLegacySdk,
            true);
        expect(pubspecWithEnv({'sdk': '>=1.0.0 <2.0.0'}).isDart3Incompatible,
            false);
      });

      test('Dart 1 and 2', () {
        expect(pubspecWithEnv({'sdk': '>=1.0.0 <3.0.0'}).supportsOnlyLegacySdk,
            false);
        expect(pubspecWithEnv({'sdk': '>=1.0.0 <3.0.0'}).isDart3Incompatible,
            true);
      });

      test('Dart pre-2.12', () {
        expect(pubspecWithEnv({'sdk': '>=2.0.0 <3.0.0'}).supportsOnlyLegacySdk,
            false);
        expect(pubspecWithEnv({'sdk': '>=2.0.0 <3.0.0'}).isDart3Incompatible,
            true);
      });

      test('Dart post-2.12', () {
        expect(pubspecWithEnv({'sdk': '>=2.12.0 <3.0.0'}).supportsOnlyLegacySdk,
            false);
        expect(pubspecWithEnv({'sdk': '>=2.12.0 <3.0.0'}).isDart3Incompatible,
            false);
      });

      test('Dart 2 and 3', () {
        expect(pubspecWithEnv({'sdk': '>=2.0.0 <4.0.0'}).supportsOnlyLegacySdk,
            false);
        expect(pubspecWithEnv({'sdk': '>=2.0.0 <4.0.0'}).isDart3Incompatible,
            true);
      });

      test('Dart 3', () {
        expect(pubspecWithEnv({'sdk': '>=3.0.0 <4.0.0'}).supportsOnlyLegacySdk,
            false);
        expect(pubspecWithEnv({'sdk': '>=3.0.0 <4.0.0'}).isDart3Incompatible,
            false);
      });
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

    group('preview analysis SDK', () {
      final nextDartSdk = semanticToolStableDartSdkVersion.nextMinor.toString();
      final nextFlutterSdk =
          semanticToolStableFlutterSdkVersion.nextMinor.toString();

      bool usesPreviewAnalysisSdk(Map<String, String> environment) {
        return Pubspec.fromJson({
          'name': 'test',
          'environment': environment,
        }).usesPreviewAnalysisSdk();
      }

      test('no constraints', () {
        expect(usesPreviewAnalysisSdk({}), isFalse);
      });

      test('stable constraints', () {
        expect(
            usesPreviewAnalysisSdk({
              'sdk': '>=$toolStableDartSdkVersion <400.0.0',
            }),
            isFalse);
        expect(
            usesPreviewAnalysisSdk({
              'flutter': '>=$toolStableFlutterSdkVersion <400.0.0',
            }),
            isFalse);
        expect(
            usesPreviewAnalysisSdk({
              'sdk': '>=$toolStableDartSdkVersion <400.0.0',
              'flutter': '>=$toolStableFlutterSdkVersion <400.0.0',
            }),
            isFalse);
      });

      test('preview Dart', () {
        expect(
          usesPreviewAnalysisSdk({
            'sdk': '>=$nextDartSdk <400.0.0',
          }),
          isTrue,
        );
      });

      test('preview Flutter', () {
        expect(
            usesPreviewAnalysisSdk({
              'flutter': '>=$nextFlutterSdk <400.0.0',
            }),
            isTrue);
        expect(
            usesPreviewAnalysisSdk({
              'sdk': '>=$toolStableDartSdkVersion <400.0.0',
              'flutter': '>=$nextFlutterSdk <400.0.0',
            }),
            isTrue);
        expect(
            usesPreviewAnalysisSdk({
              'sdk': '>=$nextDartSdk <400.0.0',
              'flutter': '>=$nextFlutterSdk <400.0.0',
            }),
            isTrue);
      });
    });
  });

  group('MinSdkVersion', () {
    test('dev only', () {
      final msd = MinSdkVersion.tryParse(
          VersionConstraint.parse('>=2.12.0-0 <2.12.0'))!;
      expect(msd.major, 2);
      expect(msd.minor, 12);
      expect(msd.channel, 'dev');
    });

    test('dev', () {
      final msd = MinSdkVersion.tryParse(
          VersionConstraint.parse('>=2.12.0-29.10.dev <3.0.0'))!;
      expect(msd.major, 2);
      expect(msd.minor, 12);
      expect(msd.channel, 'dev');
    });

    test('beta', () {
      final msd = MinSdkVersion.tryParse(
          VersionConstraint.parse('>=2.12.0-29.10.beta <3.0.0'))!;
      expect(msd.major, 2);
      expect(msd.minor, 12);
      expect(msd.channel, 'beta');
    });

    test('stable', () {
      final msd =
          MinSdkVersion.tryParse(VersionConstraint.parse('>=2.12.0 <3.0.0'))!;
      expect(msd.major, 2);
      expect(msd.minor, 12);
      expect(msd.channel, isNull);
    });
  });

  group('PackageView', () {
    testWithProfile('do not forget to update change method', fn: () async {
      final view = await scoreCardBackend.getPackageView('oxygen');
      final original = json.decode(json.encode(view!.toJson()));
      final updated = json.decode(json.encode(view.change().toJson()));
      expect(updated, original);
    });
  });
}

class _PublishSequence {
  final Version _pastSdk;
  final Version _currentSdk;
  final Version _futureSdk;

  int _counter = 0;

  _PublishSequence({
    String pastSdk = '2.7.0',
    String currentSdk = '2.10.4',
    String nextSdk = '2.12.0',
  })  : _pastSdk = Version.parse(pastSdk),
        _currentSdk = Version.parse(currentSdk),
        _futureSdk = Version.parse(nextSdk);

  final _p = Package()
    ..parentKey = Key.emptyKey(Partition(null))
    ..id = 'pkg'
    ..name = 'pkg'
    ..created = DateTime(2021, 01, 29);

  void publish(String version, {int sdk = 0}) {
    final minSdk = sdk > 0 ? _futureSdk : (sdk < 0 ? _pastSdk : _currentSdk);
    final pv = PackageVersion.init()
      ..parentKey = _p.key
      ..id = version
      ..version = version
      ..created = _p.created!.add(Duration(minutes: _counter++))
      ..pubspec = Pubspec.fromJson({
        'name': 'pkg',
        'version': version,
        'environment': {
          'sdk': '>=$minSdk <3.0.0',
        },
      });
    _p.updateVersion(pv, dartSdkVersion: _currentSdk);
  }

  void verify(
    String stable, {
    String? preview,
    String? prerelease,
    bool showPrerelease = false,
    bool showPreview = false,
  }) {
    preview ??= stable;
    prerelease ??= stable;
    expect(_p.latestVersion, stable);
    expect(_p.latestPreviewVersion, preview);
    expect(_p.latestPrereleaseVersion, prerelease);
    expect(_p.showPrereleaseVersion, showPrerelease);
    expect(_p.showPreviewVersion, showPreview);
  }
}
