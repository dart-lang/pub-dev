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
    expect(hash, 372734110);
  });

  test('runtime version should be (somewhat) lexicographically ordered', () {
    expect(runtimeVersion.length, greaterThanOrEqualTo(10));
    expect(RegExp(r'\d{4}\.\d{2}\.\d{2}.*').matchAsPrefix(runtimeVersion),
        isNotNull);
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
    // TODO: remove this exception after a stable Flutter SDK is released
    if (flutterVersion == '1.17.0-3.4.pre') return;
    final flutterArchive = await fetchFlutterArchive();
    expect(
        flutterArchive.releases.any(
            (fr) => fr.version == 'v$flutterVersion' && fr.channel == 'stable'),
        isTrue);
  });

  test('dartdoc version should match pkg/pub_dartdoc', () async {
    final yamlContent =
        await File('../pkg/pub_dartdoc/pubspec.yaml').readAsString();
    final pubspec = Pubspec.parse(yamlContent);
    final dependency = pubspec.dependencies['dartdoc'] as HostedDependency;
    expect(dependency.version.toString(), dartdocVersion);
  });

  group('dartdoc serving', () {
    test('old versions are serving', () {
      expect(shouldServeDartdoc(null), isTrue);
      expect(shouldServeDartdoc('2017.1.1'), isTrue);
    });

    test('current version is serving', () {
      expect(shouldServeDartdoc(dartdocServingRuntime.toString()), isTrue);
    });

    test('next version is not serving', () {
      expect(shouldServeDartdoc('2099.12.31'), isFalse);
    });
  });
}
