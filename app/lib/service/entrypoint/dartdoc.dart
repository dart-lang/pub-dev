// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:logging/logging.dart';

import '../../service/services.dart';
import '../../shared/env_config.dart';
import '../../shared/handler_helpers.dart';
import '../../shared/handlers.dart';

final Logger logger = Logger('pub.dartdoc');

class DartdocCommand extends Command {
  @override
  String get name => 'dartdoc';

  @override
  String get description => 'The dartdoc service entrypoint.';

  @override
  Future<void> run() async {
    envConfig.checkServiceEnvironment(name);
    await withServices(() async {
      await runHandler(logger, notFoundHandler);
    });
  }
}
