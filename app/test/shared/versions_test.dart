// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import 'package:pub_dartlang_org/shared/versions.dart';

void main() {
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

  test('dartdoc version should match SDK dartdoc', () async {
    final pr = await Process.run('dartdoc', ['--version']);
    final RegExp versionRegExp = new RegExp(r'dartdoc version: (.*)$');
    final match = versionRegExp.firstMatch(pr.stdout.toString().trim());
    if (match == null) {
      throw new Exception('Unable to parse dartdoc version: ${pr.stdout}');
    }
    final version = match.group(1).trim();
    expect(version, dartdocVersion);
  });

  group('dartdoc serving', () {
    test('old versions are serving', () {
      expect(shouldServeDartdoc('0.15.0', '0.1.3', '0.0.0'), isTrue);
    });

    test('max versions are serving', () {
      expect(
          shouldServeDartdoc(
            dartdocVersion,
            flutterVersion,
            customizationVersion,
          ),
          isTrue);
    });

    test('next versions are not serving', () {
      expect(
          shouldServeDartdoc(
            '0.16.1',
            flutterVersion,
            customizationVersion,
          ),
          isFalse);
      expect(
          shouldServeDartdoc(
            dartdocVersion,
            '0.1.5',
            customizationVersion,
          ),
          isFalse);
      expect(
          shouldServeDartdoc(
            dartdocVersion,
            flutterVersion,
            '0.0.2',
          ),
          isFalse);
    });
  });
}
