// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';

import 'package:appengine/appengine.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';

import 'package:pub_dartlang_org/job/backend.dart';
import 'package:pub_dartlang_org/job/job.dart';
import 'package:pub_dartlang_org/shared/configuration.dart';
import 'package:pub_dartlang_org/shared/dartdoc_memcache.dart';
import 'package:pub_dartlang_org/shared/handler_helpers.dart';
import 'package:pub_dartlang_org/shared/service_utils.dart';

import 'package:pub_dartlang_org/dartdoc/backend.dart';
import 'package:pub_dartlang_org/dartdoc/dartdoc_runner.dart';
import 'package:pub_dartlang_org/dartdoc/handlers.dart';

final Logger logger = new Logger('pub.dartdoc');

Future main() async {
  useLoggingPackageAdaptor();

  await withAppEngineServices(() async {
    await initDartdoc(logger);
    initFlutterSdk(logger).then(
        (_) => startIsolates(logger: logger, workerEntryPoint: _workerMain));
    await _registerServices();
    await runHandler(logger, dartdocServiceHandler);
  });
}

void _workerMain(WorkerEntryMessage message) {
  useLoggingPackageAdaptor();

  final ReceivePort taskReceivePort = new ReceivePort();
  message.protocolSendPort
      .send(new WorkerProtocolMessage(taskSendPort: taskReceivePort.sendPort));

  withAppEngineServices(() async {
    await _registerServices();

    Future<bool> shouldUpdate(
        String package, String version, DateTime updated) async {
      final status = await dartdocBackend.checkTargetStatus(
          package, version, updated, true);
      return !status.shouldSkip;
    }

    final jobProcessor =
        new DartdocJobProcessor(lockDuration: const Duration(minutes: 30));

    final jobMaintenance =
        new JobMaintenance(dbService, JobService.dartdoc, shouldUpdate);

    new Timer.periodic(const Duration(minutes: 15), (_) async {
      message.statsSendPort.send(await jobBackend.stats(JobService.dartdoc));
    });

    await Future.wait([
      jobMaintenance.syncNotifications(taskReceivePort),
      jobMaintenance.syncDatastoreHead(),
      jobMaintenance.syncDatastoreHistory(),
      jobMaintenance.updateStates(),
      jobProcessor.run(),
      jobProcessor.run(), // a second processing, to better saturate the CPU
    ]);
  });
}

Future _registerServices() async {
  registerDartdocMemcache(new DartdocMemcache(memcacheService));

  final Bucket storageBucket = await getOrCreateBucket(
      storageService, activeConfiguration.dartdocStorageBucketName);
  registerDartdocBackend(new DartdocBackend(dbService, storageBucket));
  registerJobBackend(new JobBackend(dbService));
}
