// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:appengine/appengine.dart';
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:stack_trace/stack_trace.dart';

import 'configuration.dart';
import 'scheduler_stats.dart';
import 'task_client.dart';
import 'utils.dart' show trackEventLoopLatency;
import 'versions.dart';

class FrontendEntryMessage {
  final int frontendIndex;
  final SendPort protocolSendPort;

  FrontendEntryMessage({
    @required this.frontendIndex,
    @required this.protocolSendPort,
  });
}

class FrontendProtocolMessage {
  final SendPort statsConsumerPort;

  FrontendProtocolMessage({
    @required this.statsConsumerPort,
  });
}

class WorkerEntryMessage {
  final int workerIndex;
  final SendPort protocolSendPort;
  final SendPort statsSendPort;

  WorkerEntryMessage({
    @required this.workerIndex,
    @required this.protocolSendPort,
    @required this.statsSendPort,
  });
}

class WorkerProtocolMessage {
  final SendPort taskSendPort;

  WorkerProtocolMessage({@required this.taskSendPort});
}

Future startIsolates({
  @required Logger logger,
  void frontendEntryPoint(FrontendEntryMessage message),
  Future workerSetup(),
  void workerEntryPoint(WorkerEntryMessage message),
}) async {
  useLoggingPackageAdaptor();
  int frontendStarted = 0;
  int workerStarted = 0;
  final statConsumerPorts = <SendPort>[];

  Future startFrontendIsolate() async {
    frontendStarted++;
    final frontendIndex = frontendStarted;
    logger.info('About to start frontend isolate #$frontendIndex...');
    final ReceivePort errorReceivePort = new ReceivePort();
    final ReceivePort protocolReceivePort = new ReceivePort();
    await Isolate.spawn(
      _wrapper,
      [
        frontendEntryPoint,
        new FrontendEntryMessage(
          frontendIndex: frontendIndex,
          protocolSendPort: protocolReceivePort.sendPort,
        ),
      ],
      onError: errorReceivePort.sendPort,
      onExit: errorReceivePort.sendPort,
      errorsAreFatal: true,
    );
    final FrontendProtocolMessage protocolMessage =
        (await protocolReceivePort.take(1).toList()).single;
    if (protocolMessage.statsConsumerPort != null) {
      statConsumerPorts.add(protocolMessage.statsConsumerPort);
    }
    logger.info('Frontend isolate #$frontendIndex started.');

    StreamSubscription errorSubscription;

    Future close() async {
      if (protocolMessage.statsConsumerPort != null) {
        statConsumerPorts.remove(protocolMessage.statsConsumerPort);
      }
      await errorSubscription?.cancel();
      errorReceivePort.close();
      protocolReceivePort.close();
    }

    errorSubscription = errorReceivePort.listen((e) async {
      logger.severe('ERROR from frontend isolate #$frontendIndex', e);
      await close();
      // restart isolate after a brief pause
      await new Future.delayed(new Duration(seconds: 5));
      await startFrontendIsolate();
    });
  }

  Future startWorkerIsolate() async {
    workerStarted++;
    final workerIndex = workerStarted;
    logger.info('About to start worker isolate #$workerIndex...');
    final ReceivePort errorReceivePort = new ReceivePort();
    final ReceivePort protocolReceivePort = new ReceivePort();
    final ReceivePort statsReceivePort = new ReceivePort();
    await Isolate.spawn(
      _wrapper,
      [
        workerEntryPoint,
        new WorkerEntryMessage(
          workerIndex: workerIndex,
          protocolSendPort: protocolReceivePort.sendPort,
          statsSendPort: statsReceivePort.sendPort,
        ),
      ],
      onError: errorReceivePort.sendPort,
      onExit: errorReceivePort.sendPort,
      errorsAreFatal: true,
    );
    final WorkerProtocolMessage protocolMessage =
        (await protocolReceivePort.take(1).toList()).single;
    registerTaskSendPort(protocolMessage.taskSendPort);
    final statsSubscription =
        statsReceivePort?.cast<Map>()?.listen((Map stats) {
      updateLatestStats(stats);
      for (SendPort sp in statConsumerPorts) {
        sp.send(stats);
      }
    });
    logger.info('Worker isolate #$workerIndex started.');

    StreamSubscription errorSubscription;

    Future close() async {
      await statsSubscription?.cancel();
      unregisterTaskSendPort(protocolMessage.taskSendPort);
      await errorSubscription?.cancel();
      errorReceivePort.close();
      protocolReceivePort.close();
      statsReceivePort.close();
    }

    errorSubscription = errorReceivePort.listen((e) async {
      logger.severe('ERROR from worker isolate #$workerIndex', e);
      await close();
      // restart isolate after a brief pause
      await new Future.delayed(new Duration(minutes: 1));
      await startWorkerIsolate();
    });
  }

  await withAppEngineServices(() async {
    if (frontendEntryPoint != null) {
      for (int i = 0; i < envConfig.frontendCount; i++) {
        await startFrontendIsolate();
      }
    }
    if (workerEntryPoint != null) {
      if (workerSetup != null) {
        await workerSetup();
      }
      for (int i = 0; i < envConfig.workerCount; i++) {
        await startWorkerIsolate();
      }
    }
  });
}

void setupServiceIsolate() {
  useLoggingPackageAdaptor();
  trackEventLoopLatency();
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

void _wrapper(List fnAndMessage) {
  final fn = fnAndMessage[0];
  final message = fnAndMessage[1];
  Chain.capture(() => fn(message));
}

Future initDartdoc(Logger logger) async {
  Future<bool> checkVersion() async {
    final pr = await Process.run('pub', ['global', 'list']);
    if (pr.exitCode == 0) {
      final lines = pr.stdout
          .toString()
          .split('\n')
          .where((line) => line.startsWith('dartdoc '))
          .toList();
      if (lines.isEmpty) {
        return false;
      }
      final version = lines.single.split(' ').last;
      return version == dartdocVersion;
    } else {
      return false;
    }
  }

  final exists = await checkVersion();
  if (exists) return;

  final pr = await Process
      .run('pub', ['global', 'activate', 'dartdoc', dartdocVersion]);
  if (pr.exitCode != 0) {
    final message = 'Failed to activate dartdoc (exited with ${pr.exitCode})\n'
        'stdout: ${pr.stdout}\nstderr: ${pr.stderr}';
    logger.shout(message);
    throw new Exception(message);
  }

  final matches = await checkVersion();
  if (!matches) {
    final message = 'Failed to setup dartdoc.';
    logger.shout(message);
    throw new Exception(message);
  }
}

Future<Bucket> getOrCreateBucket(Storage storage, String name) async {
  if (!await storage.bucketExists(name)) {
    await storage.createBucket(name);
  }
  return storage.bucket(name);
}
