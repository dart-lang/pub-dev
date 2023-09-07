// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';

import 'package:args/command_runner.dart';
import 'package:logging/logging.dart';

import '../../dartdoc/handlers.dart';
import '../../shared/env_config.dart';
import '../../shared/handler_helpers.dart';
import '../../shared/scheduler_stats.dart';

import '_isolate.dart';

final Logger logger = Logger('pub.dartdoc');

class DartdocCommand extends Command {
  @override
  String get name => 'dartdoc';

  @override
  String get description => 'The dartdoc service entrypoint.';

  @override
  Future<void> run() async {
    envConfig.checkServiceEnvironment(name);
    await runIsolates(
      logger: logger,
      frontendEntryPoint: _frontendMain,
    );
  }
}

Future _frontendMain(EntryMessage message) async {
  final statsConsumer = ReceivePort();
  registerSchedulerStatsStream(statsConsumer.cast<Map>());
  message.protocolSendPort.send(ReadyMessage());
  await runHandler(logger, dartdocServiceHandler);
}
