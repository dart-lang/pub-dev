// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:appengine/appengine.dart';
import 'package:logging/logging.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'package:pub_dartlang_org/shared/configuration.dart';
import 'package:pub_dartlang_org/shared/service_utils.dart';

import 'package:pub_dartlang_org/analyzer/handlers.dart';

final Logger logger = new Logger('pub.analyzer');

Future main() async {
  useLoggingPackageAdaptor();

  withAppEngineServices(() async {
    _initFlutterSdk().then((_) {
      // TODO: flutter SDK initialized, start analyzer background task
    });
    return withCorrectDatastore(() async {
      await runAppEngine((HttpRequest request) =>
          shelf_io.handleRequest(request, analyzerServiceHandler));
    });
  });
}

Future _initFlutterSdk() async {
  if (envConfig.flutterSdkDir == null) {
    logger.warning('FLUTTER_SDK is not set, assuming flutter is in PATH.');
  } else {
    // If the script exists, it is very likely that we are inside the appengine.
    // In local development environment the setup should happen only once, and
    // running the setup script multiple times should be safe (no-op if
    // FLUTTER_SDK directory exists).
    if (FileSystemEntity.isFileSync('/project/app/script/setup-flutter.sh')) {
      logger.warning('Setting up flutter checkout. This may take some time.');
      final ProcessResult result =
          await Process.run('/project/app/script/setup-flutter.sh', []);
      if (result.exitCode != 0) {
        logger.severe(
            'Failed to checkout flutter (exited with ${result.exitCode})\n'
            'stdout: ${result.stdout}\nstderr: ${result.stderr}');
      } else {
        logger.info('Flutter checkout completed.');
      }
    }
  }
}
