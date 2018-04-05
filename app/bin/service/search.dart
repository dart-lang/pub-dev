// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';

import 'package:appengine/appengine.dart';
import 'package:gcloud/db.dart' as db;
import 'package:gcloud/service_scope.dart';
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';

import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/analyzer_memcache.dart';
import 'package:pub_dartlang_org/shared/configuration.dart';
import 'package:pub_dartlang_org/shared/handler_helpers.dart';
import 'package:pub_dartlang_org/shared/popularity_storage.dart';
import 'package:pub_dartlang_org/shared/task_client.dart';
import 'package:pub_dartlang_org/shared/task_scheduler.dart';
import 'package:pub_dartlang_org/shared/task_sources.dart';
import 'package:pub_dartlang_org/shared/service_utils.dart';

import 'package:pub_dartlang_org/search/backend.dart';
import 'package:pub_dartlang_org/search/handlers.dart';
import 'package:pub_dartlang_org/search/index_simple.dart';
import 'package:pub_dartlang_org/search/updater.dart';

final Logger _logger = new Logger('pub.search');

Future main() async {
  await startIsolates(logger: _logger, frontendEntryPoint: _main);
}

void _main(FrontendEntryMessage message) {
  useLoggingPackageAdaptor();

  message.protocolSendPort.send(new FrontendProtocolMessage());

  withAppEngineServices(() async {
    final Bucket popularityBucket = await getOrCreateBucket(
        storageService, activeConfiguration.popularityDumpBucketName);
    registerPopularityStorage(
        new PopularityStorage(storageService, popularityBucket));
    await popularityStorage.init();

    registerAnalyzerMemcache(new AnalyzerMemcache(memcacheService));
    final AnalyzerClient analyzerClient = new AnalyzerClient();
    registerAnalyzerClient(analyzerClient);
    registerScopeExitCallback(analyzerClient.close);

    registerSearchBackend(new SearchBackend(db.dbService));

    final Bucket snapshotBucket = await getOrCreateBucket(
        storageService, activeConfiguration.searchSnapshotBucketName);
    registerSnapshotStorage(
        new SnapshotStorage(storageService, snapshotBucket));

    final ReceivePort taskReceivePort = new ReceivePort();
    registerPackageIndex(new SimplePackageIndex());
    registerTaskSendPort(taskReceivePort.sendPort);

    final BatchIndexUpdater batchIndexUpdater = new BatchIndexUpdater();
    await batchIndexUpdater.initSnapshot();

    final scheduler = new TaskScheduler(
      batchIndexUpdater,
      [
        new ManualTriggerTaskSource(taskReceivePort),
        new IndexUpdateTaskSource(db.dbService, batchIndexUpdater),
        new DatastoreHeadTaskSource(
          db.dbService,
          TaskSourceModel.analysis,
          sleep: const Duration(minutes: 10),
          skipHistory: true,
        ),
      ],
    );
    scheduler.run();
    await runHandler(_logger, searchServiceHandler, shared: true);
  });
}
