// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';
import 'dart:math';

import 'package:appengine/appengine.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:stack_trace/stack_trace.dart';

import '../../shared/configuration.dart';
import '../../shared/scheduler_stats.dart';
import '../../shared/utils.dart' show trackEventLoopLatency;

import '../services.dart';

final _random = Random.secure();

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
  final SendPort aliveSendPort;

  WorkerEntryMessage({
    @required this.workerIndex,
    @required this.protocolSendPort,
    @required this.statsSendPort,
    @required this.aliveSendPort,
  });
}

class WorkerProtocolMessage {}

Future startIsolates({
  @required Logger logger,
  Future<void> Function(FrontendEntryMessage message) frontendEntryPoint,
  Future<void> Function() workerSetup,
  Future<void> Function(WorkerEntryMessage message) workerEntryPoint,
  Duration deadWorkerTimeout,
}) async {
  useLoggingPackageAdaptor();
  int frontendStarted = 0;
  int workerStarted = 0;
  final statConsumerPorts = <SendPort>[];

  Future<void> startFrontendIsolate() async {
    frontendStarted++;
    final frontendIndex = frontendStarted;
    logger.info('About to start frontend isolate #$frontendIndex...');
    final ReceivePort errorReceivePort = ReceivePort();
    final ReceivePort protocolReceivePort = ReceivePort();
    await Isolate.spawn(
      _wrapper,
      [
        frontendEntryPoint,
        FrontendEntryMessage(
          frontendIndex: frontendIndex,
          protocolSendPort: protocolReceivePort.sendPort,
        ),
      ],
      onError: errorReceivePort.sendPort,
      onExit: errorReceivePort.sendPort,
      errorsAreFatal: true,
    );
    final protocolMessage = (await protocolReceivePort.take(1).toList()).single
        as FrontendProtocolMessage;
    if (protocolMessage.statsConsumerPort != null) {
      statConsumerPorts.add(protocolMessage.statsConsumerPort);
    }
    logger.info('Frontend isolate #$frontendIndex started.');

    StreamSubscription errorSubscription;

    Future<void> close() async {
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
      await Future.delayed(Duration(seconds: 5));
      await startFrontendIsolate();
    });
  }

  Future<void> startWorkerIsolate() async {
    workerStarted++;
    final workerIndex = workerStarted;
    logger.info('About to start worker isolate #$workerIndex...');
    final errorReceivePort = ReceivePort();
    final protocolReceivePort = ReceivePort();
    final statsReceivePort = ReceivePort();
    final aliveReceivePort = ReceivePort();
    final isolate = await Isolate.spawn(
      _wrapper,
      [
        workerEntryPoint,
        WorkerEntryMessage(
          workerIndex: workerIndex,
          protocolSendPort: protocolReceivePort.sendPort,
          statsSendPort: statsReceivePort.sendPort,
          aliveSendPort: aliveReceivePort.sendPort,
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

    Timer autoKillTimer;
    void resetAutoKillTimer() {
      if (deadWorkerTimeout == null) return;
      autoKillTimer?.cancel();

      /// Randomize TTL so that isolate restarts do not happen at the same time.
      final ttl = deadWorkerTimeout +
          Duration(seconds: _random.nextInt(deadWorkerTimeout.inSeconds));
      autoKillTimer = Timer(ttl, () {
        logger.info('Killing worker isolate #$workerIndex...');
        isolate.kill();
      });
    }

    // We DO NOT initialize [autoKillTimer] at this point, allowing the worker
    // to do arbitrary-length setup. Once the first message comes in, we can
    // start the auto-kill timer.
    final aliveSubscription = aliveReceivePort.listen((_) {
      resetAutoKillTimer();
    });

    StreamSubscription errorSubscription;

    Future<void> close() async {
      await aliveSubscription?.cancel();
      autoKillTimer?.cancel();
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
      await Future.delayed(Duration(minutes: 1));
      await startWorkerIsolate();
    });
  }

  try {
    await withServices(() async {
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

void _wrapper(List fnAndMessage) {
  final fn = fnAndMessage[0] as Function;
  final message = fnAndMessage[1];
  final logger = Logger('isolate.wrapper');
  Chain.capture(() async {
    try {
      return await fn(message);
    } catch (e, st) {
      logger.severe('Uncaught exception in isolate.', e, st);
      rethrow;
    }
  });
}
