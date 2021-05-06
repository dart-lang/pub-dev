// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:dartdoc/dartdoc.dart';
import 'package:dartdoc/options.dart';

import 'package:pub_dartdoc/pub_data_generator.dart';
import 'package:pub_dartdoc/src/pub_hooks.dart';

Future<void> main(List<String> arguments) async {
  // pub hooks
  final pubResourceProvider =
      PubResourceProvider(pubPackageMetaProvider.resourceProvider);
  final pubMetaProvider =
      PubPackageMetaProvider(pubPackageMetaProvider, pubResourceProvider);

  // dartdoc initialization
  final config = await parseOptions(pubMetaProvider, arguments);
  if (config == null) {
    throw ArgumentError();
  }
  pubResourceProvider.setConfig(
    output: config.output,
    isSdkDocs: config.sdkDocs,
  );

  final packageConfigProvider = PhysicalPackageConfigProvider();
  final packageBuilder =
      PubPackageBuilder(config, pubMetaProvider, packageConfigProvider);
  final dartdoc = config.generateDocs
      ? await Dartdoc.fromContext(config, packageBuilder)
      : await Dartdoc.withEmptyGenerator(config, packageBuilder);
  final results = await dartdoc.generateDocs();

  final pubDataGenerator =
      PubDataGenerator(config.inputDir, pubResourceProvider);
  pubDataGenerator.generate(results.packageGraph, config.output);

  pubResourceProvider.writeFilesToDiskSync();
}
