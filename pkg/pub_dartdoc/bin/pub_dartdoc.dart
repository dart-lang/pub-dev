// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:dartdoc/dartdoc.dart';
import 'package:dartdoc/options.dart';

import 'package:pub_dartdoc/pub_data_generator.dart';
import 'package:pub_dartdoc/src/pub_hooks.dart';
import 'package:pub_dartdoc_data/pub_dartdoc_config.dart';

Future<void> main(List<String> arguments) async {
// pub hooks
  final pubResourceProvider =
      PubResourceProvider(pubPackageMetaProvider.resourceProvider);
  final pubMetaProvider =
      PubPackageMetaProvider(pubPackageMetaProvider, pubResourceProvider);

  final config = await parseOptions(pubMetaProvider, arguments);
  if (config == null) {
    throw ArgumentError();
  }

  final customizerConfig =
      DartdocCustomizerConfig.tryReadFromDirectorySync(config.inputDir);
  // placeholder for customizer processing
  print(customizerConfig?.toJson());

  final packageConfigProvider = PhysicalPackageConfigProvider();
  final packageBuilder =
      PubPackageBuilder(config, pubMetaProvider, packageConfigProvider);
  final dartdoc = config.generateDocs
      ? await Dartdoc.fromContext(config, packageBuilder)
      : await Dartdoc.withEmptyGenerator(config, packageBuilder);
  final results = await dartdoc.generateDocs();

  final pubDataGenerator =
      PubDataGenerator(config.inputDir, config.resourceProvider);
  pubDataGenerator.generate(results.packageGraph, config.output);

  print('Max memory use: ${ProcessInfo.maxRss}');
}
