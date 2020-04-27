// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:pana/pana.dart' show runProc;

import '../../shared/configuration.dart';
import '../../shared/versions.dart';

/// Runs the setup-flutter.sh script in a GAE machine.
Future initFlutterSdk(Logger logger) async {
  if (envConfig.flutterSdkDir == null) {
    logger.warning('FLUTTER_SDK is not set, assuming flutter is in PATH.');
  } else {
    // If the script exists, it is very likely that we are inside the appengine.
    // In local development environment the setup should happen only once, and
    // running the setup script multiple times should be safe (no-op if
    // FLUTTER_SDK directory exists).
    if (FileSystemEntity.isFileSync('/project/app/script/setup-flutter.sh')) {
      final sw = Stopwatch()..start();
      logger.info('Setting up flutter checkout. This may take some time.');
      final ProcessResult result = await runProc(
          '/project/app/script/setup-flutter.sh', [flutterVersion],
          timeout: const Duration(minutes: 5));
      if (result.exitCode != 0) {
        throw Exception(
            'Failed to checkout flutter (exited with ${result.exitCode})\n'
            'stdout: ${result.stdout}\nstderr: ${result.stderr}');
      }
      final flutterBin = File('${envConfig.flutterSdkDir}/bin/flutter');
      if (!(await flutterBin.exists())) {
        throw Exception(
            'Flutter binary is missing after running setup-flutter.sh');
      }
      sw.stop();
      logger.info('Flutter checkout completed in ${sw.elapsed}.');
    }
  }
}
