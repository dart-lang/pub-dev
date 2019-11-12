// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:args/command_runner.dart';
import 'package:logging/logging.dart';

import '../../search/backend.dart';
import '../../search/handlers.dart';
import '../../search/updater.dart';
import '../../shared/configuration.dart';
import '../../shared/handler_helpers.dart';
import '../../shared/popularity_storage.dart';
import '../../shared/scheduler_stats.dart';
import '../../shared/task_client.dart';
import '../../shared/task_scheduler.dart';

import '../services.dart';

import '_isolate.dart';

final Logger _logger = Logger('pub.search');

class SearchCommand extends Command {
  @override
  String get name => 'search';

  @override
  String get description => 'The search service entrypoint.';

  @override
  Future<void> run() async {
    // Ensure that we're running in the right environment, or is running locally
    if (envConfig.gaeService != null && envConfig.gaeService != name) {
      throw StateError(
        'Cannot start "$name" in "${envConfig.gaeService}" environment',
      );
    }

    await startIsolates(logger: _logger, frontendEntryPoint: _main);
  }
}

Future _main(FrontendEntryMessage message) async {
  setupServiceIsolate();

  final statsConsumer = ReceivePort();
  registerSchedulerStatsStream(statsConsumer.cast<Map>());
  message.protocolSendPort.send(FrontendProtocolMessage(
    statsConsumerPort: statsConsumer.sendPort,
  ));

  await withServices(() async {
    await popularityStorage.init();

    snapshotStorage.scheduleOldDataGC();

    final ReceivePort taskReceivePort = ReceivePort();
    registerTaskSendPort(taskReceivePort.sendPort);

    indexUpdater.initDartSdkIndex();

    // Don't block on init, we need to serve liveliness and readiness checks.
    scheduleMicrotask(() async {
      try {
        await indexUpdater.init();
      } catch (e, st) {
        _logger.shout('Error initializing search service.', e, st);
        exit(1);
      }

      indexUpdater.runScheduler(
          manualTriggerTasks: taskReceivePort.cast<Task>());
    });

    await runHandler(_logger, searchServiceHandler);
  });
}
