// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import 'package:pub_dartlang_org/shared/versions.dart';

void main() {
  test('do not forget to update runtimeVersion when any version changes', () {
    final hash = [
      runtimeVersion,
      runtimeSdkVersion,
      toolEnvSdkVersion,
      flutterVersion,
      panaVersion,
      dartdocVersion,
      customizationVersion,
    ].join('//').hashCode;
    expect(hash, 1051343778);
  });

  test('runtime sdk version should match travis and dockerfile', () async {
    final String docker = await new File('../Dockerfile').readAsString();
    expect(
        docker.contains('\nFROM google/dart-runtime-base:$runtimeSdkVersion\n'),
        isTrue);
    final String rootTravis = await new File('.mono_repo.yml').readAsString();
    expect(rootTravis.contains('\n  - $runtimeSdkVersion\n'), isTrue);
    final String appTravis = await new File('.mono_repo.yml').readAsString();
    expect(appTravis.contains('\n  - $runtimeSdkVersion\n'), isTrue);
  });

  test('tool-env sdk version should match dockerfile', () async {
    final String docker = await new File('../Dockerfile').readAsString();
    expect(docker.contains('release/$toolEnvSdkVersion/sdk'), isTrue);
  });

  test('analyzer version should match resolved pana version', () async {
    final String lockContent = await new File('pubspec.lock').readAsString();
    final Map lock = loadYaml(lockContent);
    expect(lock['packages']['pana']['version'], panaVersion);
  });

  test('flutter version should match the tag in setup-flutter.sh', () {
    final flutterSetupContent =
        new File('script/setup-flutter.sh').readAsStringSync();

    expect(
        flutterSetupContent,
        contains('git clone -b \$1 --single-branch '
            'https://github.com/flutter/flutter.git \$FLUTTER_SDK'));
  });

  test('dartdoc version should match pkg/pub_dartdoc', () async {
    final yamlContent =
        await new File('../pkg/pub_dartdoc/pubspec.yaml').readAsString();
    final pubspec = new Pubspec.parse(yamlContent);
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
