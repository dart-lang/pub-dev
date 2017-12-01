// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import 'package:pub_dartlang_org/analyzer/versions.dart';

void main() {
  test('analyzer version should match resolved pana version', () async {
    final String lockContent = await new File('pubspec.lock').readAsString();
    final Map lock = loadYaml(lockContent);
    expect(lock['packages']['pana']['version'], panaVersion);
  });

  test('flutter version should match the tag in ../docker/Dockerfile', () {
    final flutterSetupContent =
        new File('../docker/Dockerfile').readAsStringSync();

    expect(
        flutterSetupContent,
        contains("git clone -b $flutterVersion --single-branch "
            "https://github.com/flutter/flutter.git /flutter"));
  });
}
