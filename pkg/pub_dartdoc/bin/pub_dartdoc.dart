// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:dartdoc/dartdoc.dart';
import 'package:dartdoc/options.dart';

import 'package:pub_dartdoc/pub_data_generator.dart';

Future<void> main(List<String> arguments) async {
  final config = await parseOptions(pubPackageMetaProvider, arguments);
  if (config == null) {
    throw ArgumentError();
  }

  final packageConfigProvider = PhysicalPackageConfigProvider();
  final packageBuilder =
      PubPackageBuilder(config, pubPackageMetaProvider, packageConfigProvider);
  final dartdoc = config.generateDocs
      ? await Dartdoc.fromContext(config, packageBuilder)
      : await Dartdoc.withEmptyGenerator(config, packageBuilder);
  final results = await dartdoc.generateDocs();

  final pubDataGenerator =
      PubDataGenerator(config.inputDir, config.resourceProvider);
  pubDataGenerator.generate(results.packageGraph, config.output);
}
