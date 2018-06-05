// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import 'package:pub_dartlang_org/shared/versions.dart';

void main() {
  test('do not forget to update runtimeVersion when any version changes', () {
    final hash = [
      runtimeVersion,
      sdkVersion,
      flutterVersion,
      panaVersion,
      dartdocVersion,
      customizationVersion,
    ].join('//').hashCode;
    expect(hash, 535416774);
  });

  test('sdk version should match travis and dockerfile', () async {
    final String docker = await new File('../Dockerfile').readAsString();
    expect(docker.contains('\nFROM google/dart-runtime-base:$sdkVersion\n'),
        isTrue);
    final String rootTravis = await new File('.mono_repo.yml').readAsString();
    expect(rootTravis.contains('\n  - $sdkVersion\n'), isTrue);
    final String appTravis = await new File('.mono_repo.yml').readAsString();
    expect(appTravis.contains('\n  - $sdkVersion\n'), isTrue);
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
        contains("git clone -b v$flutterVersion --single-branch "
            "https://github.com/flutter/flutter.git \$FLUTTER_SDK"));
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
