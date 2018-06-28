// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';

import 'package:appengine/appengine.dart';
import 'package:gcloud/db.dart' as db;
import 'package:logging/logging.dart';

import 'package:pub_dartlang_org/history/backend.dart';
import 'package:pub_dartlang_org/job/backend.dart';
import 'package:pub_dartlang_org/job/job.dart';
import 'package:pub_dartlang_org/shared/analyzer_memcache.dart';
import 'package:pub_dartlang_org/shared/dartdoc_client.dart';
import 'package:pub_dartlang_org/shared/dartdoc_memcache.dart';
import 'package:pub_dartlang_org/shared/handler_helpers.dart';
import 'package:pub_dartlang_org/shared/scheduler_stats.dart';
import 'package:pub_dartlang_org/shared/service_utils.dart';

import 'package:pub_dartlang_org/analyzer/backend.dart';
import 'package:pub_dartlang_org/analyzer/handlers.dart';
import 'package:pub_dartlang_org/analyzer/pana_runner.dart';

final Logger logger = new Logger('pub.analyzer');

Future main() async {
  Future workerSetup() async {
    await initDartdoc(logger);
    await initFlutterSdk(logger);
  }

  await startIsolates(
    logger: logger,
    frontendEntryPoint: _frontendMain,
    workerSetup: workerSetup,
    workerEntryPoint: _workerMain,
  );
}

void _frontendMain(FrontendEntryMessage message) {
  setupServiceIsolate();

  final statsConsumer = new ReceivePort();
  registerSchedulerStatsStream(statsConsumer as Stream<Map>);
  message.protocolSendPort.send(new FrontendProtocolMessage(
    statsConsumerPort: statsConsumer.sendPort,
  ));

  withAppEngineServices(() async {
    _registerServices();
    await runHandler(logger, analyzerServiceHandler);
  });
}

void _workerMain(WorkerEntryMessage message) {
  setupServiceIsolate();

  message.protocolSendPort.send(new WorkerProtocolMessage());

  withAppEngineServices(() async {
    _registerServices();
    final jobProcessor = new AnalyzerJobProcessor();
    final jobMaintenance = new JobMaintenance(db.dbService, jobProcessor);

    new Timer.periodic(const Duration(minutes: 15), (_) async {
      message.statsSendPort.send(await jobBackend.stats(JobService.analyzer));
    });

    await jobMaintenance.run();
  });
}

void _registerServices() {
  registerAnalysisBackend(new AnalysisBackend(db.dbService));
  registerAnalyzerMemcache(new AnalyzerMemcache(memcacheService));
  registerDartdocMemcache(new DartdocMemcache(memcacheService));
  registerDartdocClient(new DartdocClient());
  registerHistoryBackend(new HistoryBackend(db.dbService));
  registerJobBackend(new JobBackend(db.dbService));
}
