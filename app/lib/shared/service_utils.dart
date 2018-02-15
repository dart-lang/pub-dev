// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';

import 'configuration.dart';
import 'scheduler_stats.dart';
import 'task_client.dart';

Future startIsolates(Logger logger, void entryPoint(message)) async {
  final ReceivePort errorReceivePort = new ReceivePort();

  Future startIsolate() async {
    logger.info('About to start isolate...');
    final ReceivePort mainReceivePort = new ReceivePort();
    final ReceivePort statsReceivePort = new ReceivePort();
    await Isolate.spawn(
      entryPoint,
      [mainReceivePort.sendPort, statsReceivePort.sendPort],
      onError: errorReceivePort.sendPort,
      onExit: errorReceivePort.sendPort,
      errorsAreFatal: true,
    );
    final List<SendPort> sendPorts = await mainReceivePort.take(1).toList();
    registerTaskSendPort(sendPorts[0]);
    registerSchedulerStatsStream(statsReceivePort as Stream<Map>);
    logger.info('Isolate started.');
  }

  errorReceivePort.listen((e) async {
    logger.severe('ERROR from isolate', e);
    // restart isolate after a brief pause
    await new Future.delayed(new Duration(minutes: 1));
    logger.warning('Restarting isolate...');
    await startIsolate();
  });

  for (int i = 0; i < envConfig.isolateCount; i++) {
    await startIsolate();
  }
}

Future initFlutterSdk(Logger logger) async {
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
        logger.shout(
            'Failed to checkout flutter (exited with ${result.exitCode})\n'
            'stdout: ${result.stdout}\nstderr: ${result.stderr}');
      } else {
        logger.info('Flutter checkout completed.');
      }
    }
  }
}

Future<Bucket> getOrCreateBucket(Storage storage, String name) async {
  if (!await storage.bucketExists(name)) {
    await storage.createBucket(name);
  }
  return storage.bucket(name);
}
