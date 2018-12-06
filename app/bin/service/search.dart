// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';

import 'package:gcloud/db.dart' as db;
import 'package:gcloud/service_scope.dart';
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';

import 'package:pub_dartlang_org/dartdoc/backend.dart';
import 'package:pub_dartlang_org/scorecard/backend.dart';
import 'package:pub_dartlang_org/scorecard/scorecard_memcache.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/configuration.dart';
import 'package:pub_dartlang_org/shared/dartdoc_client.dart';
import 'package:pub_dartlang_org/shared/dartdoc_memcache.dart';
import 'package:pub_dartlang_org/shared/handler_helpers.dart';
import 'package:pub_dartlang_org/shared/popularity_storage.dart';
import 'package:pub_dartlang_org/shared/scheduler_stats.dart';
import 'package:pub_dartlang_org/shared/service_utils.dart';
import 'package:pub_dartlang_org/shared/storage.dart';
import 'package:pub_dartlang_org/shared/task_client.dart';
import 'package:pub_dartlang_org/shared/task_scheduler.dart';
import 'package:pub_dartlang_org/shared/task_sources.dart';
import 'package:pub_dartlang_org/shared/versions.dart';
import 'package:pub_dartlang_org/shared/urls.dart';
import 'package:pub_dartlang_org/shared/redis_cache.dart';

import 'package:pub_dartlang_org/search/backend.dart';
import 'package:pub_dartlang_org/search/handlers.dart';
import 'package:pub_dartlang_org/search/index_simple.dart';
import 'package:pub_dartlang_org/search/updater.dart';

final Logger _logger = new Logger('pub.search');

Future main() async {
  await startIsolates(logger: _logger, frontendEntryPoint: _main);
}

Future _main(FrontendEntryMessage message) async {
  setupServiceIsolate();

  final statsConsumer = new ReceivePort();
  registerSchedulerStatsStream(statsConsumer.cast<Map>());
  message.protocolSendPort.send(new FrontendProtocolMessage(
    statsConsumerPort: statsConsumer.sendPort,
  ));

  await withAppEngineAndCache(() async {
    final popularityBucket = await getOrCreateBucket(
        storageService, activeConfiguration.popularityDumpBucketName);
    registerPopularityStorage(
        new PopularityStorage(storageService, popularityBucket));
    await popularityStorage.init();

    final AnalyzerClient analyzerClient = new AnalyzerClient();
    registerAnalyzerClient(analyzerClient);
    registerScopeExitCallback(analyzerClient.close);

    final Bucket dartdocBucket = await getOrCreateBucket(
        storageService, activeConfiguration.dartdocStorageBucketName);
    registerDartdocBackend(new DartdocBackend(db.dbService, dartdocBucket));
    registerDartdocMemcache(new DartdocMemcache());
    final DartdocClient dartdocClient = new DartdocClient();
    registerDartdocClient(dartdocClient);
    registerScopeExitCallback(dartdocClient.close);

    registerScoreCardBackend(new ScoreCardBackend(db.dbService));
    registerScoreCardMemcache(new ScoreCardMemcache());

    registerSearchBackend(new SearchBackend(db.dbService));

    final Bucket snapshotBucket = await getOrCreateBucket(
        storageService, activeConfiguration.searchSnapshotBucketName);
    registerSnapshotStorage(new SnapshotStorage(snapshotBucket));
    snapshotStorage.scheduleOldDataGC();

    final ReceivePort taskReceivePort = new ReceivePort();
    registerDartSdkIndex(new SimplePackageIndex.sdk(
        urlPrefix: dartSdkMainUrl(toolEnvSdkVersion)));
    registerPackageIndex(new SimplePackageIndex());
    registerTaskSendPort(taskReceivePort.sendPort);

    // Don't block on SDK index updates, as it may take several minutes before
    // the dartdoc service produces the required output.
    _updateDartSdkIndex().whenComplete(() {});

    final BatchIndexUpdater batchIndexUpdater = new BatchIndexUpdater();
    await batchIndexUpdater.initSnapshot();

    final scheduler = new TaskScheduler(
      batchIndexUpdater,
      [
        new ManualTriggerTaskSource(taskReceivePort.cast<Task>()),
        new IndexUpdateTaskSource(db.dbService, batchIndexUpdater),
        new DatastoreHeadTaskSource(
          db.dbService,
          TaskSourceModel.scorecard,
          sleep: const Duration(minutes: 10),
          skipHistory: true,
        ),
      ],
    );
    scheduler.run();

    new Timer.periodic(const Duration(minutes: 5), (_) {
      updateLatestStats(scheduler.stats());
    });

    await runHandler(_logger, searchServiceHandler);
  });
}

Future _updateDartSdkIndex() async {
  for (int i = 0;; i++) {
    try {
      _logger.info('Trying to load SDK index.');
      final data = await dartdocBackend.getDartSdkDartdocData();
      if (data != null) {
        final docs =
            splitLibraries(data).map((lib) => createSdkDocument(lib)).toList();
        await dartSdkIndex.addPackages(docs);
        await dartSdkIndex.merge();
        _logger.info('Dart SDK index loaded successfully.');
        return;
      }
    } catch (e, st) {
      _logger.warning('Error loading Dart SDK index.', e, st);
    }
    if (i % 10 == 0) {
      _logger.warning('Unable to load Dart SDK index. Attempt: $i');
    }
    await new Future.delayed(const Duration(minutes: 1));
  }
}
