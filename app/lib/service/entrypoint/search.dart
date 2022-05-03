// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';

import 'package:args/command_runner.dart';
import 'package:logging/logging.dart';

import '../../search/dart_sdk_mem_index.dart';
import '../../search/flutter_sdk_mem_index.dart';
import '../../search/handlers.dart';
import '../../search/updater.dart';
import '../../shared/env_config.dart';
import '../../shared/handler_helpers.dart';
import '../../shared/popularity_storage.dart';
import '../../shared/scheduler_stats.dart';
import '../../shared/task_client.dart';
import '../../shared/task_scheduler.dart';
import '../../tool/neat_task/pub_dev_tasks.dart';

import '_isolate.dart';

final Logger _logger = Logger('pub.search');

class SearchCommand extends Command {
  @override
  String get name => 'search';

  @override
  String get description => 'The search service entrypoint.';

  @override
  Future<void> run() async {
    envConfig.checkServiceEnvironment(name);
    await startIsolates(
      logger: _logger,
      frontendEntryPoint: _main,
      frontendCount: 1,
      workerCount: 0,
    );
  }
}

Future _main(FrontendEntryMessage message) async {
  final statsConsumer = ReceivePort();
  registerSchedulerStatsStream(statsConsumer.cast<Map>());
  message.protocolSendPort.send(FrontendProtocolMessage(
    statsConsumerPort: statsConsumer.sendPort,
  ));

  setupSearchPeriodicTasks();
  await popularityStorage.start();

  final ReceivePort taskReceivePort = ReceivePort();
  registerTaskSendPort(taskReceivePort.sendPort);

  // Don't block on init, we need to serve liveliness and readiness checks.
  scheduleMicrotask(() async {
    await dartSdkMemIndex.start();
    await flutterSdkMemIndex.start();
    try {
      await indexUpdater.init();
    } catch (e, st) {
      _logger.shout('Error initializing search service.', e, st);
      rethrow;
    }

    indexUpdater.runScheduler(manualTriggerTasks: taskReceivePort.cast<Task>());
  });

  await runHandler(_logger, searchServiceHandler);
}
