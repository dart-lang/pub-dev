// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';

import 'package:appengine/appengine.dart';
import 'package:gcloud/db.dart' as db;
import 'package:logging/logging.dart';

import 'package:pub_dartlang_org/shared/analyzer_memcache.dart';
import 'package:pub_dartlang_org/shared/service_utils.dart';
import 'package:pub_dartlang_org/shared/task_scheduler.dart';
import 'package:pub_dartlang_org/shared/handler_helpers.dart';

import 'package:pub_dartlang_org/analyzer/backend.dart';
import 'package:pub_dartlang_org/analyzer/handlers.dart';
import 'package:pub_dartlang_org/analyzer/pana_runner.dart';
import 'package:pub_dartlang_org/analyzer/task_sources.dart';

final Logger logger = new Logger('pub.analyzer');

Future main() async {
  useLoggingPackageAdaptor();

  withAppEngineServices(() async {
    initFlutterSdk(logger)
        .then((_) => startIsolates(logger, _runSchedulerWrapper));
    _registerServices();
    await runHandler(logger, analyzerServiceHandler);
  });
}

// Remove after https://github.com/dart-lang/sdk/issues/30755 lands.
void _runSchedulerWrapper(message) => _runScheduler(message);

void _runScheduler(List<SendPort> sendPorts) {
  useLoggingPackageAdaptor();

  final SendPort mainSendPort = sendPorts[0];
  final SendPort statsSendPort = sendPorts[1];
  final ReceivePort taskReceivePort = new ReceivePort();
  mainSendPort.send(taskReceivePort.sendPort);

  withAppEngineServices(() async {
    _registerServices();
    final PanaRunner runner = new PanaRunner(analysisBackend);
    final scheduler = new TaskScheduler(runner, [
      new ManualTriggerTaskSource(taskReceivePort),
      new DatastoreHeadTaskSource(db.dbService),
      new DatastoreHistoryTaskSource(db.dbService),
    ]);
    new Timer.periodic(const Duration(minutes: 1), (_) {
      statsSendPort.send(scheduler.stats());
    });
    await scheduler.run();
  });
}

void _registerServices() {
  registerAnalysisBackend(new AnalysisBackend(db.dbService));
  registerAnalyzerMemcache(new AnalyzerMemcache(memcacheService));
}
