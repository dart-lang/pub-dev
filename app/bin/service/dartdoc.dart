// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';

import 'package:appengine/appengine.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';

import 'package:pub_dartlang_org/shared/configuration.dart';
import 'package:pub_dartlang_org/shared/dartdoc_memcache.dart';
import 'package:pub_dartlang_org/shared/handler_helpers.dart';
import 'package:pub_dartlang_org/shared/service_utils.dart';
import 'package:pub_dartlang_org/shared/task_scheduler.dart';

import 'package:pub_dartlang_org/dartdoc/backend.dart';
import 'package:pub_dartlang_org/dartdoc/dartdoc_runner.dart';
import 'package:pub_dartlang_org/dartdoc/handlers.dart';
import 'package:pub_dartlang_org/dartdoc/task_sources.dart';

final Logger logger = new Logger('pub.dartdoc');

Future main() async {
  useLoggingPackageAdaptor();

  withAppEngineServices(() async {
    await initDartdoc(logger);
    initFlutterSdk(logger)
        .then((_) => startIsolates(logger, _runSchedulerWrapper));
    await _registerServices();
    await runHandler(logger, dartdocServiceHandler);
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
    await _registerServices();
    final runner = new DartdocRunner();
    final scheduler = new TaskScheduler(runner, [
      new ManualTriggerTaskSource(taskReceivePort),
      new DartdocDatastoreHeadTaskSource(dbService),
      new DartdocDatastoreHistoryTaskSource(dbService),
    ]);
    new Timer.periodic(const Duration(minutes: 1), (_) {
      statsSendPort.send(scheduler.stats());
    });
    await scheduler.run();
  });
}

Future _registerServices() async {
  registerDartdocMemcache(new DartdocMemcache(memcacheService));

  final Bucket storageBucket = await getOrCreateBucket(
      storageService, activeConfiguration.dartdocStorageBucketName);
  registerDartdocBackend(new DartdocBackend(dbService, storageBucket));
}
