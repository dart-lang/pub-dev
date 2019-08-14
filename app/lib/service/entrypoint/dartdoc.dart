// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';

import 'package:gcloud/db.dart';
import 'package:logging/logging.dart';

import '../../dartdoc/backend.dart';
import '../../dartdoc/dartdoc_runner.dart';
import '../../dartdoc/handlers.dart';
import '../../job/backend.dart';
import '../../job/job.dart';
import '../../shared/handler_helpers.dart';
import '../../shared/popularity_storage.dart';
import '../../shared/scheduler_stats.dart';

import '../services.dart';

import '_gae_setup.dart';
import '_isolate.dart';

final Logger logger = Logger('pub.dartdoc');

Future main() async {
  Future workerSetup() async {
    await initFlutterSdk(logger);
  }

  await startIsolates(
    logger: logger,
    frontendEntryPoint: _frontendMain,
    workerSetup: workerSetup,
    workerEntryPoint: _workerMain,
  );
}

Future _frontendMain(FrontendEntryMessage message) async {
  setupServiceIsolate();

  final statsConsumer = ReceivePort();
  registerSchedulerStatsStream(statsConsumer.cast<Map>());
  message.protocolSendPort.send(FrontendProtocolMessage(
    statsConsumerPort: statsConsumer.sendPort,
  ));

  await withServices(() async {
    await runHandler(logger, dartdocServiceHandler);
  });
}

Future _workerMain(WorkerEntryMessage message) async {
  setupServiceIsolate();

  message.protocolSendPort.send(WorkerProtocolMessage());

  await withServices(() async {
    await popularityStorage.init();

    final jobProcessor =
        DartdocJobProcessor(lockDuration: const Duration(minutes: 30));
    await jobProcessor.generateDocsForSdk();

    final jobMaintenance = JobMaintenance(dbService, jobProcessor);

    Timer.periodic(const Duration(minutes: 15), (_) async {
      message.statsSendPort.send(await jobBackend.stats(JobService.dartdoc));
    });

    dartdocBackend.scheduleOldDataGC();
    jobBackend.scheduleOldDataGC();
    await jobMaintenance.run();
  });
}
