// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import 'package:pub_dev/shared/flutter_archive.dart';
import 'package:pub_dev/shared/versions.dart';

void main() {
  test('runtime pattern', () {
    expect(runtimeVersionPattern.hasMatch(runtimeVersion), isTrue);
    expect(runtimeVersionPattern.hasMatch('2018.09.13'), isTrue);
    expect(runtimeVersionPattern.hasMatch('2018 09 13'), isFalse);
    expect(runtimeVersionPattern.hasMatch('2018.09.13-dev'), isFalse);
    expect(runtimeVersionPattern.hasMatch('2018.09.13+1'), isFalse);
    expect(runtimeVersionPattern.hasMatch('2018'), isFalse);
    expect(runtimeVersionPattern.hasMatch('x.json'), isFalse);
  });

  test('do not forget to update runtimeVersion when any version changes', () {
    final hash = [
      runtimeVersion,
      toolEnvSdkVersion,
      flutterVersion,
      panaVersion,
      dartdocVersion,
    ].join('//').hashCode;
    // This test is a reminder that if pana, the SDK or any of the above
    // versions change, we should also adjust the [runtimeVersion]. Before
    // updating the hash value, double-check if it is being updated.
    expect(hash, 874799229);
  });

  test('accepted runtime versions should be lexicographically ordered', () {
    for (final version in acceptedRuntimeVersions) {
      expect(runtimeVersionPattern.hasMatch(version), isTrue);
    }
    final sorted = [...acceptedRuntimeVersions]
      ..sort((a, b) => -a.compareTo(b));
    expect(acceptedRuntimeVersions, sorted);
  });

  test('No more than 5 accepted runtimeVersions', () {
    expect(acceptedRuntimeVersions, hasLength(lessThan(6)));
  });

  test('runtime sdk version should match travis and dockerfile', () async {
    final String docker = await File('../Dockerfile').readAsString();
    expect(
        docker.contains('\nFROM google/dart-runtime-base:$runtimeSdkVersion\n'),
        isTrue);
    final String monoPkg = await File('mono_pkg.yaml').readAsString();
    expect(monoPkg.contains('$runtimeSdkVersion'), isTrue);
    final String travis = await File('../.travis.yml').readAsString();
    expect(travis.contains('$runtimeSdkVersion'), isTrue);
  });

  test('tool-env sdk version should match dockerfile', () async {
    final String docker = await File('../Dockerfile').readAsString();
    expect(docker.contains('/$toolEnvSdkVersion/sdk/dartsdk-linux-x64-release'),
        isTrue);
  });

  test('analyzer version should match resolved pana version', () async {
    final String lockContent = await File('pubspec.lock').readAsString();
    final lock = loadYaml(lockContent) as Map;
    expect(lock['packages']['pana']['version'], panaVersion);
  });

  test('flutter version should be a dynamic tag in setup-flutter.sh', () {
    final flutterSetupContent =
        File('script/setup-flutter.sh').readAsStringSync();

    expect(
        flutterSetupContent,
        contains('git clone -b \$1 --single-branch '
            'https://github.com/flutter/flutter.git \$FLUTTER_SDK'));
  });

  test('Flutter is using a version from the stable channel.', () async {
    final flutterArchive = await fetchFlutterArchive();
    expect(
        flutterArchive.releases.any(
            (fr) => fr.version == flutterVersion && fr.channel == 'stable'),
        isTrue);
  });

  test(
    'Flutter is using the latest stable',
    () async {
      final flutterArchive = await fetchFlutterArchive();
      final currentStable = flutterArchive.releases.firstWhere(
        (r) => r.hash == flutterArchive.currentRelease.stable,
        orElse: () => null,
      );
      assert(currentStable != null, 'Expected current stable to exist');
      expect(
        flutterVersion,
        equals(currentStable.version),
        reason: '''Expected flutterVersion to be current stable
Please update flutterVersion in app/lib/shared/versions.dart
and do not format to also bump the runtimeVersion.''',
      );
    },
    // TODO: investigate why skip was not working on CI
    skip: false, // Note: this test is easily skipped.
  );

  test('dartdoc version should match pkg/pub_dartdoc', () async {
    final yamlContent =
        await File('../pkg/pub_dartdoc/pubspec.yaml').readAsString();
    final pubspec = Pubspec.parse(yamlContent);
    final dependency = pubspec.dependencies['dartdoc'] as HostedDependency;
    expect(dependency.version.toString(), dartdocVersion);
  });

  test('GC is not deleting currently accepted versions', () {
    for (final version in acceptedRuntimeVersions) {
      expect(shouldGCVersion(version), isFalse);
    }
  });

  test('GC is returning correct values for known versions', () {
    expect(shouldGCVersion('2000.01.01'), isTrue);
    expect(shouldGCVersion('3000.01.01'), isFalse);
  });

  group('dartdoc serving', () {
    test('old versions are no longer serving', () {
      expect(shouldServeDartdoc(null), isFalse);
      expect(shouldServeDartdoc('2017.1.1'), isFalse);
    });

    test('current version is serving', () {
      expect(shouldServeDartdoc(dartdocServingRuntime.toString()), isTrue);
    });

    test('next version is not serving', () {
      expect(shouldServeDartdoc('2099.12.31'), isFalse);
    });
  });
}
