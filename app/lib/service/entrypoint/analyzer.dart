// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';
import 'dart:math';

import 'package:args/command_runner.dart';
import 'package:logging/logging.dart';
import 'package:pub_dev/package/deps_graph.dart';

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
  await runHandler(logger, analyzerServiceHandler);
}

Future _jobMain(EntryMessage message) async {
  message.protocolSendPort.send(ReadyMessage());

  await popularityStorage.start();
  final jobProcessor = AnalyzerJobProcessor(
      aliveCallback: () => message.aliveSendPort.send(null));
  final jobMaintenance = JobMaintenance(db.dbService, jobProcessor);
  await jobMaintenance.run();
}

Future _workerMain(EntryMessage message) async {
  message.protocolSendPort.send(ReadyMessage());

  await taskBackend.start();

  setupAnalyzerPeriodicTasks();
  await popularityStorage.start();
  unawaited(_setupDependencyTracker());

  // wait indefinitely
  await Completer().future;
}

Future<void> _setupDependencyTracker() async {
  // Updates job entries for analyzer and dartdoc.
  Future<void> triggerDependentAnalysis(Set<String> affected) async {
    for (final p in affected) {
      await jobBackend.triggerAnalysis(p, null);
    }
    // TODO: re-enable this after we have added some stop-gaps on the frequency
    // await dartdocClient.triggerDartdoc(package, version,
    //    dependentPackages: affected);
  }

  // random delay to reduce race conditions
  final random = Random.secure();
  await Future.delayed(Duration(minutes: random.nextInt(60)));

  final pdb = await PackageDependencyBuilder.loadInitialGraphFromDb(
    db.dbService,
    triggerDependentAnalysis,
    // We don't need to scan for updates frequenty.
    // Furthermore, scanning runs on all analyzer instances, triggering
    // changes more often than the expected value of 6 hours.
    pollingInterval: Duration(hours: 5, minutes: random.nextInt(120)),
  );
  await pdb.monitorInBackground();
}
