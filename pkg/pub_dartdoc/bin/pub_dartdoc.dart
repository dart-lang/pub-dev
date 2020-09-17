// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:dartdoc/dartdoc.dart';
import 'package:dartdoc/src/dartdoc_options.dart';
import 'package:dartdoc/src/logging.dart';
import 'package:dartdoc/src/package_meta.dart';

import 'package:pub_dartdoc/pub_data_generator.dart';

void main(List<String> arguments) async {
  final optionSet = await DartdocOptionSet.fromOptionGenerators(
    'pub_dartdoc',
    [
      createDartdocOptions,
      createLoggingOptions,
      createGeneratorOptions,
    ],
    pubPackageMetaProvider,
  );
  optionSet.parseArguments(arguments);

  final optionContext = DartdocProgramOptionContext(optionSet);
  startLogging(optionContext);

  final packageConfigProvider = PhysicalPackageConfigProvider();
  final dartdoc = await Dartdoc.fromContext(
      optionContext,
      PubPackageBuilder(
          optionContext, pubPackageMetaProvider, packageConfigProvider));
  final results = await dartdoc.generateDocs();

  final pubDataGenerator = PubDataGenerator(optionContext.inputDir);
  await pubDataGenerator.generate(results.packageGraph, optionContext.output);
}

class DartdocProgramOptionContext extends DartdocGeneratorOptionContext
    with LoggingContext {
  DartdocProgramOptionContext(DartdocOptionSet optionSet)
      : super(optionSet, null, pubPackageMetaProvider.resourceProvider);
}
