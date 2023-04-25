// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:appengine/appengine.dart';
import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:stack_trace/stack_trace.dart';

import '../../shared/env_config.dart';
import '../../shared/scheduler_stats.dart';

import '../services.dart';
import 'tools.dart';

final _random = Random.secure();

class FrontendEntryMessage {
  final int frontendIndex;
  final SendPort protocolSendPort;

  FrontendEntryMessage({
    required this.frontendIndex,
    required this.protocolSendPort,
  });
}

class FrontendProtocolMessage {
  final SendPort? statsConsumerPort;

  FrontendProtocolMessage({
    this.statsConsumerPort,
  });
}

class WorkerEntryMessage {
  final int workerIndex;
  final SendPort protocolSendPort;
  final SendPort statsSendPort;
  final SendPort aliveSendPort;

  WorkerEntryMessage({
    required this.workerIndex,
    required this.protocolSendPort,
    required this.statsSendPort,
    required this.aliveSendPort,
  });
}

class WorkerProtocolMessage {}

Future startIsolates({
  required Logger logger,
  Future<void> Function(FrontendEntryMessage message)? frontendEntryPoint,
  Future<void> Function(WorkerEntryMessage message)? workerEntryPoint,
  Duration? deadWorkerTimeout,
  required int frontendCount,
  required int workerCount,
}) async {
  await withServices(() async {
    if (!envConfig.isRunningLocally) {
      // The existence of this file may indicate an issue with the service health.
      // Checking it only in AppEngine environment.
      final stampFile =
          File(p.join(Directory.systemTemp.path, 'pub-dev-started.stamp'));
      if (stampFile.existsSync()) {
        stderr.writeln('[warning-service-restarted]: '
            '${stampFile.path} already exists, indicating that this process has been restarted.');
      } else {
        stampFile.createSync(recursive: true);
      }
    }
    _setupServiceIsolate();

    /// The duration while errors won't cause frontend isolates to restart.
    var restartProtectionOffset = Duration.zero;
    var lastStarted = clock.now();
    int frontendStarted = 0;
    int workerStarted = 0;

    var closing = false;
    final isolates = <Isolate>[];
    final statConsumerPorts = <SendPort>[];

    Future<void> startFrontendIsolate() async {
      if (closing) return;
      frontendStarted++;
      final frontendIndex = frontendStarted;
      logger.info('About to start frontend isolate #$frontendIndex...');
      final errorReceivePort = ReceivePort();
      final exitReceivePort = ReceivePort();
      final protocolReceivePort = ReceivePort();
      final isolate = await Isolate.spawn(
        _wrapper,
        [
          frontendEntryPoint,
          FrontendEntryMessage(
            frontendIndex: frontendIndex,
            protocolSendPort: protocolReceivePort.sendPort,
          ),
        ],
        onError: errorReceivePort.sendPort,
        onExit: exitReceivePort.sendPort,
        errorsAreFatal: true,
      );
      isolates.add(isolate);
      final protocolMessage =
          (await protocolReceivePort.first) as FrontendProtocolMessage;
      if (protocolMessage.statsConsumerPort != null) {
        statConsumerPorts.add(protocolMessage.statsConsumerPort!);
      }
      logger.info('Frontend isolate #$frontendIndex started.');
      lastStarted = clock.now();

      StreamSubscription? errorSubscription;
      StreamSubscription? exitSubscription;

      Future<void> close() async {
        if (protocolMessage.statsConsumerPort != null) {
          statConsumerPorts.remove(protocolMessage.statsConsumerPort);
        }
        await errorSubscription?.cancel();
        await exitSubscription?.cancel();
        errorReceivePort.close();
        exitReceivePort.close();
        protocolReceivePort.close();
        isolates.remove(isolate);
      }

      Future<void> restart() async {
        await close();
        // Restart the isolate after a pause, increasing the pause duration at
        // each restart.
        //
        // NOTE: As this wait period increases, the service may miss /liveness_check
        //       requests, and eventually AppEngine may just kill the instance
        //       marking it unreachable.
        await Future.delayed(Duration(seconds: 5 + frontendStarted));
        await startFrontendIsolate();
      }

      errorSubscription = errorReceivePort.listen((e) async {
        stderr.writeln('ERROR from frontend isolate #$frontendIndex: $e');
        logger.severe('ERROR from frontend isolate #$frontendIndex', e);

        final now = clock.now();
        // If the last isolate was started more than an hour ago, we can reset
        // the protection.
        if (now.isAfter(lastStarted.add(Duration(hours: 1)))) {
          restartProtectionOffset = Duration.zero;
        }

        // If we have recently restarted an isolate, let's keep it running.
        if (now.isBefore(lastStarted.add(restartProtectionOffset))) {
          return;
        }

        // Extend restart protection for up to 20 minutes.
        if (restartProtectionOffset.inMinutes < 20) {
          restartProtectionOffset += Duration(minutes: 4);
        }

        await restart();
      });

      exitSubscription = exitReceivePort.listen((e) async {
        stderr.writeln(
            'Frontend isolate #$frontendIndex exited with message: $e');
        logger.warning('Frontend isolate #$frontendIndex exited.', e);
        await restart();
      });
    }

    Future<void> startWorkerIsolate() async {
      if (closing) return;
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
      isolates.add(isolate);
      // read WorkerProtocolMessage
      await protocolReceivePort.first;
      final statsSubscription =
          statsReceivePort.cast<Map>().listen((Map stats) {
        updateLatestStats(stats);
        for (SendPort sp in statConsumerPorts) {
          sp.send(stats);
        }
      });
      logger.info('Worker isolate #$workerIndex started.');

      Timer? autoKillTimer;
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

      StreamSubscription? errorSubscription;

      Future<void> close() async {
        await aliveSubscription.cancel();
        autoKillTimer?.cancel();
        await statsSubscription.cancel();
        await errorSubscription?.cancel();
        errorReceivePort.close();
        protocolReceivePort.close();
        statsReceivePort.close();
        isolates.remove(isolate);
      }

      errorSubscription = errorReceivePort.listen((e) async {
        stderr.writeln('ERROR from worker isolate #$workerIndex: $e');
        logger.severe('ERROR from worker isolate #$workerIndex', e);
        await close();
        // restart isolate after a brief pause
        await Future.delayed(Duration(minutes: 1));
        await startWorkerIsolate();
      });
    }

    Future<void> closeIsolates() async {
      while (isolates.isNotEmpty) {
        final i = isolates.removeLast();
        // TODO: Implement graceful close.
        i.kill();
      }
    }

    try {
      if (frontendEntryPoint != null) {
        for (int i = 0; i < frontendCount; i++) {
          await startFrontendIsolate();
        }
      }
      if (workerEntryPoint != null) {
        for (int i = 0; i < workerCount; i++) {
          await startWorkerIsolate();
        }
      }
      await waitForProcessSignalTermination();

      closing = true;
      await closeIsolates();
      // A small wait to allow already pending isolates to be created.
      await Future.delayed(Duration(seconds: 5));
      await closeIsolates();
    } catch (e, st) {
      logger.shout('Failed to start server.', e, st);
      rethrow;
    }
  });
}

void _setupServiceIsolate() {
  useLoggingPackageAdaptor();
}

void _wrapper(List fnAndMessage) {
  final fn = fnAndMessage[0] as Function;
  final message = fnAndMessage[1];
  final logger = Logger('isolate.wrapper');
  withServices(() async {
    await Chain.capture(() async {
      try {
        _setupServiceIsolate();
        return await fn(message);
      } catch (e, st) {
        logger.severe('Uncaught exception in isolate.', e, st);
        rethrow;
      }
    });
  });
}
