// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';

import 'package:args/command_runner.dart';
import 'package:logging/logging.dart';

import '../../analyzer/handlers.dart';
import '../../analyzer/pana_runner.dart';
import '../../job/backend.dart';
import '../../job/job.dart';
import '../../shared/datastore.dart' as db;
import '../../shared/env_config.dart';
import '../../shared/handler_helpers.dart';
import '../../shared/popularity_storage.dart';
import '../../shared/scheduler_stats.dart';
import '../../task/backend.dart';
import '../../tool/neat_task/pub_dev_tasks.dart';

import '_isolate.dart';

final Logger logger = Logger('pub.analyzer');

class AnalyzerCommand extends Command {
  @override
  String get name => 'analyzer';

  @override
  String get description => 'The analyzer service entrypoint.';

  @override
  Future<void> run() async {
    envConfig.checkServiceEnvironment(name);
    await startIsolates(
      logger: logger,
      frontendEntryPoint: _frontendMain,
      workerEntryPoint: _workerMain,
      deadWorkerTimeout: Duration(hours: 1),
      frontendCount: 1,
      workerCount: 1,
    );
  }
}

Future _frontendMain(FrontendEntryMessage message) async {
  final statsConsumer = ReceivePort();
  registerSchedulerStatsStream(statsConsumer.cast<Map>());
  message.protocolSendPort.send(FrontendProtocolMessage(
    statsConsumerPort: statsConsumer.sendPort,
  ));
  await runHandler(logger, analyzerServiceHandler);
}

Future _workerMain(WorkerEntryMessage message) async {
  message.protocolSendPort.send(WorkerProtocolMessage());

  await taskBackend.start();

  setupAnalyzerPeriodicTasks();
  await popularityStorage.start();
  final jobProcessor = AnalyzerJobProcessor(
      aliveCallback: () => message.aliveSendPort.send(null));
  final jobMaintenance = JobMaintenance(db.dbService, jobProcessor);

  Timer.periodic(const Duration(minutes: 15), (_) async {
    message.statsSendPort.send(await jobBackend.stats(JobService.analyzer));
  });

  await jobMaintenance.run();
}
