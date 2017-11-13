// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:appengine/appengine.dart';
import 'package:gcloud/db.dart' as db;
import 'package:gcloud/service_scope.dart';
import 'package:logging/logging.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'package:pub_dartlang_org/shared/analyzer_memcache.dart';
import 'package:pub_dartlang_org/shared/configuration.dart';
import 'package:pub_dartlang_org/shared/notification.dart';
import 'package:pub_dartlang_org/shared/service_utils.dart';
import 'package:pub_dartlang_org/shared/task_scheduler.dart';

import 'package:pub_dartlang_org/analyzer/backend.dart';
import 'package:pub_dartlang_org/analyzer/handlers.dart';
import 'package:pub_dartlang_org/analyzer/pana_runner.dart';
import 'package:pub_dartlang_org/analyzer/task_sources.dart';

final Logger logger = new Logger('pub.analyzer');

Future main() async {
  useLoggingPackageAdaptor();

  withAppEngineServices(() async {
    _initFlutterSdk().then((_) async {
      startIsolates(logger, _runSchedulerWrapper);
    });
    _registerServices();
    await runAppEngine((HttpRequest request) =>
        shelf_io.handleRequest(request, analyzerServiceHandler));
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

Future _initFlutterSdk() async {
  if (envConfig.flutterSdkDir == null) {
    logger.warning('FLUTTER_SDK is not set, assuming flutter is in PATH.');
  } else {
    // If the script exists, it is very likely that we are inside the appengine.
    // In local development environment the setup should happen only once, and
    // running the setup script multiple times should be safe (no-op if
    // FLUTTER_SDK directory exists).
    if (FileSystemEntity.isFileSync('/project/app/script/setup-flutter.sh')) {
      logger.warning('Setting up flutter checkout. This may take some time.');
      final ProcessResult result =
          await Process.run('/project/app/script/setup-flutter.sh', []);
      if (result.exitCode != 0) {
        logger.severe(
            'Failed to checkout flutter (exited with ${result.exitCode})\n'
            'stdout: ${result.stdout}\nstderr: ${result.stderr}');
      } else {
        logger.info('Flutter checkout completed.');
      }
    }
  }
}

void _registerServices() {
  final NotificationClient notificationClient = new NotificationClient();
  registerNotificationClient(notificationClient);
  registerScopeExitCallback(notificationClient.close);
  registerAnalysisBackend(new AnalysisBackend(db.dbService));
  registerAnalyzerMemcache(new AnalyzerMemcache(memcacheService));
}
