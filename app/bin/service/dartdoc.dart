// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';
import 'dart:math' as math;

import 'package:appengine/appengine.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';

import 'package:pub_dartlang_org/analyzer/backend.dart';
import 'package:pub_dartlang_org/history/backend.dart';
import 'package:pub_dartlang_org/job/backend.dart';
import 'package:pub_dartlang_org/job/job.dart';
import 'package:pub_dartlang_org/scorecard/backend.dart';
import 'package:pub_dartlang_org/scorecard/scorecard_memcache.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/configuration.dart';
import 'package:pub_dartlang_org/shared/dartdoc_memcache.dart';
import 'package:pub_dartlang_org/shared/handler_helpers.dart';
import 'package:pub_dartlang_org/shared/popularity_storage.dart';
import 'package:pub_dartlang_org/shared/scheduler_stats.dart';
import 'package:pub_dartlang_org/shared/service_utils.dart';

import 'package:pub_dartlang_org/dartdoc/backend.dart';
import 'package:pub_dartlang_org/dartdoc/dartdoc_runner.dart';
import 'package:pub_dartlang_org/dartdoc/handlers.dart';

final Logger logger = new Logger('pub.dartdoc');
final _random = new math.Random.secure();

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

Future _frontendMain(FrontendEntryMessage message) async {
  setupServiceIsolate();

  final statsConsumer = new ReceivePort();
  registerSchedulerStatsStream(statsConsumer.cast<Map>());
  message.protocolSendPort.send(new FrontendProtocolMessage(
    statsConsumerPort: statsConsumer.sendPort,
  ));

  await withAppEngineServices(() async {
    await _registerServices();
    await runHandler(logger, dartdocServiceHandler);
  });
}

Future _workerMain(WorkerEntryMessage message) async {
  setupServiceIsolate();

  message.protocolSendPort.send(new WorkerProtocolMessage());

  await withAppEngineServices(() async {
    await _registerServices();

    final jobProcessor =
        new DartdocJobProcessor(lockDuration: const Duration(minutes: 30));
    await jobProcessor.generateDocsForSdk();

    final jobMaintenance = new JobMaintenance(dbService, jobProcessor);

    new Timer.periodic(const Duration(minutes: 15), (_) async {
      message.statsSendPort.send(await jobBackend.stats(JobService.dartdoc));
    });

    // Run GC in the next 6 hours (randomized wait to reduce race).
    new Timer(new Duration(minutes: _random.nextInt(360)), () {
      dartdocBackend.deleteOldSdkData();
    });

    await jobMaintenance.run();
  });
}

Future _registerServices() async {
  final Bucket popularityBucket =
      storageService.bucket(activeConfiguration.popularityDumpBucketName);
  registerPopularityStorage(
      new PopularityStorage(storageService, popularityBucket));
  await popularityStorage.init();

  registerDartdocMemcache(new DartdocMemcache(memcacheService));

  registerAnalysisBackend(new AnalysisBackend(dbService));
  registerAnalyzerClient(new AnalyzerClient());
  final Bucket storageBucket = await getOrCreateBucket(
      storageService, activeConfiguration.dartdocStorageBucketName);
  registerDartdocBackend(new DartdocBackend(dbService, storageBucket));
  registerHistoryBackend(new HistoryBackend(dbService));
  registerJobBackend(new JobBackend(dbService));
  registerScoreCardMemcache(new ScoreCardMemcache(memcacheService));
  registerScoreCardBackend(new ScoreCardBackend(dbService));
}
