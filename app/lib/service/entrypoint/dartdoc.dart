// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';

import 'package:args/command_runner.dart';
import 'package:logging/logging.dart';

import '../../dartdoc/dartdoc_runner.dart';
import '../../dartdoc/handlers.dart';
import '../../job/backend.dart';
import '../../job/job.dart';
import '../../shared/datastore.dart';
import '../../shared/env_config.dart';
import '../../shared/handler_helpers.dart';
import '../../shared/popularity_storage.dart';
import '../../shared/scheduler_stats.dart';
import '../../tool/neat_task/pub_dev_tasks.dart';

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
      jobEntryPoint: _jobMain,
      workerEntryPoint: _workerMain,
      deadWorkerTimeout: Duration(hours: 1),
      frontendCount: 1,
    );
  }
}

Future _frontendMain(EntryMessage message) async {
  final statsConsumer = ReceivePort();
  registerSchedulerStatsStream(statsConsumer.cast<Map>());
  message.protocolSendPort.send(ReadyMessage(
    statsConsumerPort: statsConsumer.sendPort,
  ));
  await runHandler(logger, dartdocServiceHandler);
}

Future _jobMain(EntryMessage message) async {
  message.protocolSendPort.send(ReadyMessage());

  await popularityStorage.start();
  final jobProcessor = DartdocJobProcessor(
    aliveCallback: () => message.aliveSendPort.send(null),
  );
  final jobMaintenance = JobMaintenance(dbService, jobProcessor);

  Timer.periodic(const Duration(minutes: 15), (_) async {
    message.statsSendPort.send({
      'backend': await jobBackend.stats(JobService.dartdoc),
      'processor': jobProcessor.stats(),
    });
  });

  await jobMaintenance.run();
}

Future _workerMain(EntryMessage message) async {
  message.protocolSendPort.send(ReadyMessage());

  setupDartdocPeriodicTasks();
  await popularityStorage.start();

  // wait indefinitely
  await Completer().future;
}
