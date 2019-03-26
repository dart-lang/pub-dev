// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:dartdoc/dartdoc.dart';
import 'package:dartdoc/src/html/html_generator.dart';
import 'package:dartdoc/src/logging.dart';

import 'package:pub_dartdoc/pub_data_generator.dart';

void main(List<String> arguments) async {
  final optionSet = await DartdocOptionSet.fromOptionGenerators('pub_dartdoc', [
    createDartdocOptions,
    createLoggingOptions,
    createGeneratorOptions,
  ]);
  optionSet.parseArguments(arguments);

  final optionContext = DartdocProgramOptionContext(optionSet, null);
  startLogging(optionContext);

  final dartdoc = await Dartdoc.withDefaultGenerators(optionContext);
  dartdoc.generators.add(PubDataGenerator(optionContext.inputDir));

  await dartdoc.generateDocs();
}

class DartdocProgramOptionContext extends DartdocGeneratorOptionContext
    with LoggingContext {
  DartdocProgramOptionContext(DartdocOptionSet optionSet, Directory dir)
      : super(optionSet, dir);
}
