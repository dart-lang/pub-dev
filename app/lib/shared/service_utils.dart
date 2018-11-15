// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:appengine/appengine.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pana/pana.dart' show runProc;
import 'package:stack_trace/stack_trace.dart';

import 'configuration.dart';
import 'scheduler_stats.dart';
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

class WorkerProtocolMessage {}

Future startIsolates({
  @required Logger logger,
  Future frontendEntryPoint(FrontendEntryMessage message),
  Future workerSetup(),
  Future workerEntryPoint(WorkerEntryMessage message),
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
      print('ERROR from frontend isolate #$frontendIndex: $e');
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
    // read WorkerProtocolMessage
    (await protocolReceivePort.take(1).toList()).single;
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
      await errorSubscription?.cancel();
      errorReceivePort.close();
      protocolReceivePort.close();
      statsReceivePort.close();
    }

    errorSubscription = errorReceivePort.listen((e) async {
      print('ERROR from worker isolate #$workerIndex: $e');
      logger.severe('ERROR from worker isolate #$workerIndex', e);
      await close();
      // restart isolate after a brief pause
      await new Future.delayed(new Duration(minutes: 1));
      await startWorkerIsolate();
    });
  }

  try {
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
  } catch (e, st) {
    logger.shout('Failed to start server.', e, st);
    rethrow;
  }
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
      final sw = new Stopwatch()..start();
      logger.info('Setting up flutter checkout. This may take some time.');
      final ProcessResult result = await runProc(
          '/project/app/script/setup-flutter.sh', ['v$flutterVersion'],
          timeout: const Duration(minutes: 5));
      if (result.exitCode != 0) {
        throw new Exception(
            'Failed to checkout flutter (exited with ${result.exitCode})\n'
            'stdout: ${result.stdout}\nstderr: ${result.stderr}');
      }
      final flutterBin = new File('${envConfig.flutterSdkDir}/bin/flutter');
      if (!(await flutterBin.exists())) {
        throw new Exception(
            'Flutter binary is missing after running setup-flutter.sh');
      }
      sw.stop();
      logger.info('Flutter checkout completed in ${sw.elapsed}.');
    }
  }
}

void _wrapper(List fnAndMessage) {
  final Function fn = fnAndMessage[0];
  final message = fnAndMessage[1];
  final logger = new Logger('isolate.wrapper');
  Chain.capture(() async {
    try {
      return await fn(message);
    } catch (e, st) {
      logger.severe('Uncaught exception in isolate.', e, st);
      rethrow;
    }
  });
}

Future initDartdoc(Logger logger) async {
  logger.info('Initializing pkg/pub_dartdoc');
  final dir = Platform.script.resolve('../../pkg/pub_dartdoc').toFilePath();
  final pr = await runProc('pub', ['get'],
      workingDirectory: dir, timeout: const Duration(minutes: 5));
  if (pr.exitCode != 0) {
    final message = 'Failed to initialize pkg/pub_dartdoc: exit code: '
        '${pr.exitCode}\n\nSTDOUT:\n${pr.stdout}\n\nSTDERR:\n${pr.stderr}';
    logger.shout(message);
    throw new Exception(message);
  }
}
