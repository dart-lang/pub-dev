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

class EntryMessage {
  final SendPort protocolSendPort;
  final SendPort aliveSendPort;
  final SendPort statsSendPort;

  EntryMessage({
    required this.protocolSendPort,
    required this.aliveSendPort,
    required this.statsSendPort,
  });
}

/// Message sent from the isolate to indicate that it is ready with the initialization.
class ReadyMessage {
  final SendPort? statsConsumerPort;

  ReadyMessage({
    this.statsConsumerPort,
  });
}

/// Message sent from the isolate with arbitrary text.
class DebugMessage {
  final String text;

  DebugMessage(this.text);
}

class IsolateRunner {
  final Logger logger;
  var _closing = false;

  /// The duration while errors won't cause frontend isolates to restart.
  var _restartProtectionOffset = Duration.zero;
  var _lastStarted = clock.now();
  final _isolates = <_Isolate>[];

  IsolateRunner({
    required this.logger,
  });

  Future<void> startIsolates({
    required String kind,
    required Future<void> Function(EntryMessage message) entryPoint,
    required int count,
    required Duration? deadTimeout,
  }) async {
    int started = 0;

    Future<void> start() async {
      if (_closing) return;
      started++;
      final id = '$kind isolate #$started';
      logger.info('About to start $id ...');
      final isolate = _Isolate(
        runner: this,
        logger: logger,
        id: id,
        entryPoint: entryPoint,
      );
      _isolates.add(isolate);
      await isolate.init(deadTimeout: deadTimeout);
      logger.info('$id started.');
      _lastStarted = clock.now();

      // automatic restart logic
      unawaited(isolate.done.then((_) async {
        _isolates.remove(isolate);
        if (_closing) return;
        // Restart the isolate after a pause, increasing the pause duration at
        // each restart.
        //
        // NOTE: As this wait period increases, the service may miss /liveness_check
        //       requests, and eventually AppEngine may just kill the instance
        //       marking it unreachable.
        var waitSeconds = 5 + started;
        while (waitSeconds > 0) {
          if (_closing) return;
          await Future.delayed(Duration(seconds: 1));
          waitSeconds--;
        }
        await start();
      }));
    }

    for (int i = 0; i < count; i++) {
      await start();
    }
  }

  Future<void> _closeIsolates() async {
    while (_isolates.isNotEmpty) {
      await _isolates.last.close();
    }
  }

  Future<void> close() async {
    _closing = true;
    await _closeIsolates();
    // A small wait to allow already pending isolates to be created.
    await Future.delayed(Duration(seconds: 5));
    await _closeIsolates();
  }
}

Future runIsolates({
  required Logger logger,
  Future<void> Function(EntryMessage message)? frontendEntryPoint,
  Future<void> Function(EntryMessage message)? workerEntryPoint,
  Duration? deadWorkerTimeout,
  required int frontendCount,
  required int workerCount,
}) async {
  await withServices(() async {
    _setupServiceIsolate();
    _verifyStampFile();
    try {
      final runner = IsolateRunner(logger: logger);
      if (frontendEntryPoint != null) {
        await runner.startIsolates(
          kind: 'frontend',
          entryPoint: frontendEntryPoint,
          count: frontendCount,
          deadTimeout: Duration(minutes: 1),
        );
      }
      if (workerEntryPoint != null) {
        await runner.startIsolates(
          kind: 'worker',
          entryPoint: workerEntryPoint,
          count: workerCount,
          deadTimeout: deadWorkerTimeout,
        );
      }

      await waitForProcessSignalTermination();

      await runner.close();
    } catch (e, st) {
      logger.shout('Failed to start server.', e, st);
      rethrow;
    }
  });
}

void _verifyStampFile() {
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
}

class _Isolate {
  final IsolateRunner runner;
  final Logger logger;
  final String id;
  final Future<void> Function(EntryMessage message) entryPoint;

  late Isolate _isolate;

  final _aliveReceivePort = ReceivePort();
  final _statsReceivePort = ReceivePort();
  final _errorReceivePort = ReceivePort();
  final _exitReceivePort = ReceivePort();
  final _protocolReceivePort = ReceivePort();

  ReadyMessage? _readyMessage;
  bool get isReady => _readyMessage != null;
  SendPort? get statsConsumerPort => _readyMessage?.statsConsumerPort;

  StreamSubscription? _protocolSubscription;
  StreamSubscription? _errorSubscription;
  StreamSubscription? _exitSubscription;
  StreamSubscription? _aliveSubscription;
  StreamSubscription? _statsSubscription;
  Timer? _autokillTimer;

  final _doneCompleter = Completer();
  late final done = _doneCompleter.future;

  _Isolate({
    required this.runner,
    required this.logger,
    required this.id,
    required this.entryPoint,
  });

  Future<void> init({
    required Duration? deadTimeout,
  }) async {
    _isolate = await Isolate.spawn(
      _wrapper,
      [
        entryPoint,
        EntryMessage(
          protocolSendPort: _protocolReceivePort.sendPort,
          aliveSendPort: _aliveReceivePort.sendPort,
          statsSendPort: _statsReceivePort.sendPort,
        ),
      ],
      onError: _errorReceivePort.sendPort,
      onExit: _exitReceivePort.sendPort,
      errorsAreFatal: true,
      debugName: id,
    );

    final ready = Completer();
    _protocolSubscription = _protocolReceivePort.listen((e) {
      if (e is ReadyMessage && !ready.isCompleted) {
        _readyMessage = e;
        ready.complete();
      }
      if (e is DebugMessage) {
        logger.info('Debug message from $id: ${e.text}');
      }
    });

    _errorSubscription = _errorReceivePort.listen((e) async {
      stderr.writeln('ERROR from $id: $e');
      logger.severe('ERROR from $id', e);

      final now = clock.now();
      // If the last isolate was started more than an hour ago, we can reset
      // the protection.
      if (now.isAfter(runner._lastStarted.add(Duration(hours: 1)))) {
        runner._restartProtectionOffset = Duration.zero;
      }

      // If we have recently restarted an isolate, let's keep it running.
      if (now
          .isBefore(runner._lastStarted.add(runner._restartProtectionOffset))) {
        return;
      }

      // Extend restart protection for up to 20 minutes.
      if (runner._restartProtectionOffset.inMinutes < 20) {
        runner._restartProtectionOffset += Duration(minutes: 4);
      }

      await close();
    });

    _exitSubscription = _exitReceivePort.listen((e) async {
      stderr.writeln('$id exited with message: $e');
      logger.warning('$id exited.', e);
      await close();
    });

    _statsSubscription = _statsReceivePort.cast<Map>().listen((Map stats) {
      updateLatestStats(stats);
      for (final i in runner._isolates) {
        i.statsConsumerPort?.send(stats);
      }
    });

    _setupAutokillTimer(deadTimeout);

    await ready.future;
  }

  /// Resets (and starts) autokill timer on alive messages.
  /// Returns the [Function] that should be called on isolate closing,
  /// cancelling the stream listener and the timer that may be active.
  ///
  /// NOTE: The timer will NOT be initialized when [timeout] is not specified or negative.
  void _setupAutokillTimer(Duration? timeout) {
    void resetAutokillTimer() {
      if (timeout == null || timeout <= Duration.zero) {
        return;
      }
      _autokillTimer?.cancel();

      /// Randomize TTL so that isolate restarts do not happen at the same time.
      final ttl = timeout + Duration(seconds: _random.nextInt(30));
      _autokillTimer = Timer(ttl, () {
        logger.shout('Killing "$id", because it is not sending alive pings');
        close();
      });
    }

    // We DO NOT initialize `autokillTimer` at this point, allowing the isolate
    // to do arbitrary-length setup. Once the first message comes in, we can
    // start the auto-kill timer.
    _aliveSubscription = _aliveReceivePort.listen((_) {
      resetAutokillTimer();
    });
  }

  Future<void> close() async {
    try {
      if (_doneCompleter.isCompleted) return;
      logger.info('About to close $id ...');
      _autokillTimer?.cancel();
      await _protocolSubscription?.cancel();
      await _statsSubscription?.cancel();
      await _aliveSubscription?.cancel();
      await _errorSubscription?.cancel();
      await _exitSubscription?.cancel();
      _aliveReceivePort.close();
      _errorReceivePort.close();
      _exitReceivePort.close();
      _protocolReceivePort.close();
      _isolate.kill();
      logger.info('$id closed.');
    } finally {
      if (!_doneCompleter.isCompleted) {
        _doneCompleter.complete();
      }
    }
  }
}

void _setupServiceIsolate() {
  if (envConfig.isRunningInAppengine) {
    useLoggingPackageAdaptor();
  }
}

Future<void> _wrapper(List fnAndMessage) async {
  final fn = fnAndMessage[0] as Function;
  final message = fnAndMessage[1];
  final logger = Logger('isolate.wrapper');
  // NOTE: This timer triggers active "work" and prevents the VM to run compaction GC.
  //       https://github.com/dart-lang/sdk/issues/52513
  final timer = Timer.periodic(Duration(milliseconds: 250), (_) {});

  Future run() async {
    return await Chain.capture(
      () async {
        try {
          _setupServiceIsolate();
          return await fn(message);
        } catch (e, st) {
          print('Uncaught exception in isolate. $e $st');
          logger.severe('Uncaught exception in isolate.', e, st);
          rethrow;
        }
      },
      onError: (e, st) {
        print('Uncaught exception in isolate. $e $st');
        logger.severe('Uncaught exception in isolate.', e, st);
        if (e is Exception) {
          throw e;
        }
        if (e is Error) {
          throw e;
        }
        throw Exception('Uncaught exception: $e $st');
      },
    );
  }

  try {
    if (envConfig.isRunningInAppengine) {
      return await withServices(() async {
        return await run();
      });
    } else {
      return await run();
    }
  } finally {
    timer.cancel();
  }
}
