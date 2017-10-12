// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:appengine/appengine.dart';
import 'package:logging/logging.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'package:pub_dartlang_org/shared/service_utils.dart';
import 'package:pub_dartlang_org/shared/task_scheduler.dart';

import 'package:pub_dartlang_org/dartdoc/dartdoc_runner.dart';
import 'package:pub_dartlang_org/dartdoc/handlers.dart';

final Logger logger = new Logger('pub.dartdoc');

Future main() async {
  useLoggingPackageAdaptor();

  withAppEngineServices(() async {
    await startIsolates(logger, _runScheduler);
    _registerServices();
    await runAppEngine((HttpRequest request) =>
        shelf_io.handleRequest(request, dartdocServiceHandler));
  });
}

void _runScheduler(List<SendPort> sendPorts) {
  useLoggingPackageAdaptor();

  final SendPort mainSendPort = sendPorts[0];
  final SendPort statsSendPort = sendPorts[1];
  final ReceivePort taskReceivePort = new ReceivePort();
  mainSendPort.send(taskReceivePort.sendPort);

  withAppEngineServices(() async {
    _registerServices();
    final runner = new DartdocRunner();
    final scheduler = new TaskScheduler(runner, [
      new ManualTriggerTaskSource(taskReceivePort),
      // TODO: decide how frequently we want to poll the datastore
      // new DatastoreHeadTaskSource(db.dbService),
      // new DatastoreHistoryTaskSource(db.dbService),
    ]);
    new Timer.periodic(const Duration(minutes: 1), (_) {
      statsSendPort.send(scheduler.stats());
    });
    await scheduler.run();
  });
}

void _registerServices() {
  // placeholder
}
