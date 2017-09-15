// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:appengine/appengine.dart';
import 'package:gcloud/db.dart' as db;
import 'package:gcloud/service_scope.dart';
import 'package:gcloud/storage.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/analyzer_memcache.dart';
import 'package:pub_dartlang_org/shared/configuration.dart';
import 'package:pub_dartlang_org/shared/service_utils.dart';
import 'package:pub_dartlang_org/shared/task_client.dart';
import 'package:pub_dartlang_org/shared/task_scheduler.dart';

import 'package:pub_dartlang_org/search/backend.dart';
import 'package:pub_dartlang_org/search/handlers.dart';
import 'package:pub_dartlang_org/search/index_simple.dart';
import 'package:pub_dartlang_org/search/updater.dart';

Future main() async {
  final ReceivePort errorPort = new ReceivePort();
  errorPort.listen((error) {
    print('ERROR from isolate: $error');
  });
  for (int i = 0; i < envConfig.isolateCount; i++) {
    await Isolate.spawn(
      _main,
      i,
      onError: errorPort.sendPort,
      onExit: errorPort.sendPort,
      errorsAreFatal: true,
    );
  }
}

void _main(int isolateId) {
  useLoggingPackageAdaptor();

  withAppEngineServices(() async {
    return withCorrectDatastore(() async {
      registerAnalyzerMemcache(new AnalyzerMemcache(memcacheService));
      final AnalyzerClient analyzerClient =
          new AnalyzerClient(activeConfiguration.analyzerServicePrefix);
      registerAnalyzerClient(analyzerClient);
      registerScopeExitCallback(analyzerClient.close);

      registerSearchBackend(new SearchBackend(db.dbService));

      final Bucket bucket = await _createOrGetBucket(
          storageService, activeConfiguration.searchSnapshotBucketName);
      registerSnapshotStorage(new SnapshotStorage(storageService, bucket));

      registerPackageIndex(new SimplePackageIndex());

      final ReceivePort taskReceivePort = new ReceivePort();
      registerTaskSendPort(taskReceivePort.sendPort);

      final BatchIndexUpdater batchIndexUpdater = new BatchIndexUpdater();
      await batchIndexUpdater.initSnapshot();

      final scheduler = new TaskScheduler(
        batchIndexUpdater,
        [
          new ManualTriggerTaskSource(taskReceivePort),
          new IndexUpdateTaskSource(db.dbService, batchIndexUpdater),
        ],
      );
      scheduler.run();

      await runAppEngine(
        (HttpRequest request) =>
            shelf_io.handleRequest(request, searchServiceHandler),
        shared: true,
      );
    });
  });
}

Future<Bucket> _createOrGetBucket(Storage storage, String name) async {
  if (!await storage.bucketExists(name)) {
    await storage.createBucket(name);
  }
  return storage.bucket(name);
}
