// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:dartdoc/dartdoc.dart';
import 'package:dartdoc/options.dart';

import 'package:pub_dartdoc/pub_data_generator.dart';
import 'package:pub_dartdoc/src/pub_hooks.dart';

Future<void> pubDartDoc(List<String> arguments) async {
  print('[${DateTime.now().toIso8601String()}] Starting...');
  // pub hooks
  final pubResourceProvider =
      PubResourceProvider(pubPackageMetaProvider.resourceProvider);
  final pubMetaProvider =
      PubPackageMetaProvider(pubPackageMetaProvider, pubResourceProvider);

  final config = parseOptions(pubMetaProvider, arguments);
  if (config == null) {
    throw ArgumentError();
  }

  final packageConfigProvider = PhysicalPackageConfigProvider();
  final packageBuilder =
      PubPackageBuilder(config, pubMetaProvider, packageConfigProvider);
  final dartdoc = config.generateDocs
      ? await Dartdoc.fromContext(config, packageBuilder)
      : Dartdoc.withEmptyGenerator(config, packageBuilder);
  final results = await dartdoc.generateDocs();

  final pubDataGenerator =
      PubDataGenerator(config.inputDir, config.resourceProvider);
  pubDataGenerator.generate(results.packageGraph, config.output);

  print(
      '[${DateTime.now().toIso8601String()}] Max memory use: ${ProcessInfo.maxRss}');
}
