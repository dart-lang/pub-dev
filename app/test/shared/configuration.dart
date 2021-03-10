// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import 'package:pub_dev/shared/configuration.dart';

void main() {
  test('Foo config from yaml file', () async {
    final Configuration config =
        Configuration.fromYaml('test/shared/test_data/foo_config.yaml');
    final expectedValue = 'foo';
    expect(config.projectId == expectedValue, isTrue);
    expect(config.packageBucketName == expectedValue, isTrue);
    expect(config.dartdocStorageBucketName == expectedValue, isTrue);
    expect(config.popularityDumpBucketName == expectedValue, isTrue);
  });

  test('Dev config from yaml file', () async {
    final Configuration config =
        Configuration.fromYaml('test/shared/test_data/dev-config.yaml');
    expect(config.projectId == 'dartlang-pub-dev', isTrue);
  });
}
