// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';
import 'dart:math' as math;

import 'package:gcloud/db.dart' as db;
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';

import 'package:pub_dartlang_org/dartdoc/backend.dart';
import 'package:pub_dartlang_org/history/backend.dart';
import 'package:pub_dartlang_org/job/backend.dart';
import 'package:pub_dartlang_org/job/job.dart';
import 'package:pub_dartlang_org/scorecard/backend.dart';
import 'package:pub_dartlang_org/shared/configuration.dart';
import 'package:pub_dartlang_org/shared/dartdoc_client.dart';
import 'package:pub_dartlang_org/shared/handler_helpers.dart';
import 'package:pub_dartlang_org/shared/popularity_storage.dart';
import 'package:pub_dartlang_org/shared/scheduler_stats.dart';
import 'package:pub_dartlang_org/shared/service_utils.dart';
import 'package:pub_dartlang_org/shared/storage.dart';
import 'package:pub_dartlang_org/shared/services.dart';

import 'package:pub_dartlang_org/analyzer/handlers.dart';
import 'package:pub_dartlang_org/analyzer/pana_runner.dart';

final Logger logger = Logger('pub.analyzer');
final _random = math.Random.secure();

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
    await _registerServices();
    await runHandler(logger, analyzerServiceHandler);
  });
}

Future _workerMain(WorkerEntryMessage message) async {
  setupServiceIsolate();

  message.protocolSendPort.send(WorkerProtocolMessage());

  await withServices(() async {
    await _registerServices();
    final jobProcessor = AnalyzerJobProcessor();
    final jobMaintenance = JobMaintenance(db.dbService, jobProcessor);

    Timer.periodic(const Duration(minutes: 15), (_) async {
      message.statsSendPort.send(await jobBackend.stats(JobService.analyzer));
    });

    // Run ScoreCard GC in the next 6 hours (randomized wait to reduce race).
    Timer(Duration(minutes: _random.nextInt(360)), () {
      scoreCardBackend.deleteOldEntries();
    });

    jobBackend.scheduleOldDataGC();
    await jobMaintenance.run();
  });
}

Future _registerServices() async {
  final popularityBucket = await getOrCreateBucket(
      storageService, activeConfiguration.popularityDumpBucketName);
  registerPopularityStorage(
      PopularityStorage(storageService, popularityBucket));
  await popularityStorage.init();
  final Bucket dartdocStorageBucket = await getOrCreateBucket(
      storageService, activeConfiguration.dartdocStorageBucketName);
  registerDartdocBackend(DartdocBackend(db.dbService, dartdocStorageBucket));
  registerDartdocClient(DartdocClient());
  registerHistoryBackend(HistoryBackend(db.dbService));
  registerJobBackend(JobBackend(db.dbService));
  registerScoreCardBackend(ScoreCardBackend(db.dbService));
}
