// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert' show json;
import 'dart:io' show exit, File, Platform;

import 'package:logging/logging.dart' show Logger, Level, LogRecord;
import 'package:pana/pana.dart';
import 'package:path/path.dart' as p;

final _log = Logger('pana_wrapper');

/// Program to be used as subprocess for running pana, ensuring that we capture
/// all the output, and only run analysis in a subprocess that can timeout and
/// be killed.
Future<void> main(List<String> args) async {
  if (args.length != 3) {
    print('Usage: pana_wrapper.dart <output-folder> <package> <version>');
    exit(1);
  }

  final outputFolder = args[0];
  final package = args[1];
  final version = args[2];

  // Setup logging
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
    if (rec.error != null) {
      print('ERROR: ${rec.error}, ${rec.stackTrace}');
    }
  });

  final toolEnv = await ToolEnvironment.create(
    dartSdkDir: Platform.environment['DART_ANALYSIS_SDK'],
    flutterSdkDir: Platform.environment['FLUTTER_ANALYSIS_SDK'],
  );
  final pana = PackageAnalyzer(toolEnv);
  final summary = await pana.inspectPackage(
    package,
    version: version,
    options: InspectOptions(
      dartdocOutputDir: p.join(outputFolder, 'dartdoc'),
      dartdocRetry: 2,
      dartdocTimeout: Duration(minutes: 15),
    ),
  );

  _log.info('Writing pana-summary.json');
  await File(
    p.join(outputFolder, 'pana-summary.json'),
  ).writeAsString(json.encode(summary));
}
