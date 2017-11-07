// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:source_gen/source_gen.dart';
import 'package:yaml/yaml.dart';

import 'package:pana/src/annotations.dart';

class PackageVersionGenerator extends GeneratorForAnnotation<PackageVersion> {
  const PackageVersionGenerator();

  @override
  Future<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    var content =
        await buildStep.readAsString(new AssetId.parse('pana|pubspec.yaml'));

    var yaml = loadYaml(content) as Map;

    var versionString = yaml['version'] as String;
    versionString = new Version.parse(versionString).toString();

    return 'final _\$${element.displayName}PubSemverVersion = '
        'new Version.parse("$versionString");';
  }
}
