// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:gcloud/service_scope.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:stack_trace/stack_trace.dart';

import '../../shared/env_config.dart';
import '../../shared/logging.dart';

import '../services.dart';
import '_messages.dart';
import 'tools.dart';

export '_messages.dart';

final _random = Random.secure();

/// The main method to run in the new isolate.
typedef EntryPointFn = Future<void> Function(EntryMessage message);

/// Wrapper method to replace [withServices] into [withFakeServices] for
/// local tests and development.
typedef ServicesWrapperFn = Future<void> Function(Future Function() fn);

/// Runs the collection of different isolate groups (where a group of
/// isolate execute the same code).
///
/// TODO: The runner will handle the cross-group communication of the isolates.
@visibleForTesting
class IsolateCollection {
  final Logger logger;
  final ServicesWrapperFn servicesWrapperFn;
  var _closing = false;

  final _groups = <IsolateGroup>[];

  IsolateCollection({
    required this.logger,
    required this.servicesWrapperFn,
  });

  /// Starts a new isolate group with [count] running instances.
  @visibleForTesting
  // TODO: rename *Group to *Kind
  Future<IsolateGroup> startGroup({
    required String kind,
    EntryPointFn? entryPoint,
    Uri? spawnUri,
    required int count,
    required Duration? deadTimeout,
  }) async {
    if (_closing) {
      throw AssertionError('Runner is closed.');
    }
    final group = IsolateGroup(
      runner: this,
      kind: kind,
      entryPoint: entryPoint,
      spawnUri: spawnUri,
      count: count,
      deadTimeout: deadTimeout,
    );
    _groups.add(group);
    await group.start();
    return group;
  }

  Future<void> _closeGroups() async {
    while (_groups.isNotEmpty) {
      await _groups.removeLast().close();
    }
  }

  Future<void> close() async {
    _closing = true;
    await _closeGroups();
  }
}

/// Starts, monitors, stops or restarts isolates that run the same code.
///
/// Once an isolate starts, it is expected to run indefinitely. When it exits,
/// either by completion or uncaught exception, a new isolate will be started.
class IsolateGroup {
  final IsolateCollection runner;
  final String kind;
  final EntryPointFn? entryPoint;
  final Uri? spawnUri;
  final int count;
  final Duration? deadTimeout;
  final bool skipWaitBetweenRestarts;

  int started = 0;
  final _isolates = <_Isolate>[];
  bool get _closing => runner._closing;
  Logger get logger => runner.logger;

  /// The duration while internal errors won't cause isolates to restart.
  var _restartProtectionOffset = Duration.zero;
  var _lastStarted = clock.now();

  IsolateGroup({
    required this.runner,
    required this.kind,
    required this.entryPoint,
    required this.spawnUri,
    required this.count,
    required this.deadTimeout,
    this.skipWaitBetweenRestarts = false,
  });

  /// Starts [count] new isolates.
  Future<void> start() async {
    for (var i = 0; i < count; i++) {
      await _startOne();
    }
  }

  /// Starts [count] new isolates, waits for the pending requests to get processed,
  /// and after a maximum [wait] duration, closes the old ones.
  Future<void> renew({
    required Duration wait,
  }) async {
    final isolatesToClose = [..._isolates];
    // mark the current isolates, so that they don't trigger automatic restart
    for (final i in isolatesToClose) {
      i.markedForReplace = true;
    }
    // start new isolates
    await start();

    await Future.delayed(wait);

    // close the remaining ones
    for (final i in isolatesToClose) {
      await i.close();
    }
  }

  /// Process a request message by delegating it to one if the running isolates,
  /// preferably one that is not under renewal.
  @visibleForTesting
  void processRequestMessage(RequestMessage e) {
    if (_isolates.isEmpty) {
      logger.warning('No isolate to process request.');
      e.replyPort.send(
          ReplyMessage.error('No isolate to process request.').encodeAsJson());
      return;
    }
    final last = _isolates.lastWhereOrNull((i) =>
        i.markedForReplace == false &&
        i._readyMessage?.requestSendPort != null);
    if (last == null) {
      logger.warning('No active isolate to process request.');
      e.replyPort.send(
          ReplyMessage.error('No isolate to process request.').encodeAsJson());
      return;
    }

    last._readyMessage!.requestSendPort!.send(e.encodeAsJson());
  }

  Future<void> _startOne() async {
    if (_closing) return;
    started++;
    final id = '$kind isolate #$started';
    logger.info('About to start $id ...');
    final isolate = _Isolate(
      parent: runner,
      group: this,
      logger: logger,
      id: id,
    );
    _isolates.add(isolate);
    if (entryPoint != null) {
      await isolate.initFunction(
        entryPoint: entryPoint!,
        deadTimeout: deadTimeout,
      );
    } else {
      await isolate.initUri(
        spawnUri: spawnUri!,
        deadTimeout: deadTimeout,
      );
    }
    if (_closing) {
      await isolate.close();
      return;
    }
    logger.info('$id started.');
    _lastStarted = clock.now();

    // automatic restart logic
    unawaited(isolate.done.then((_) async {
      _isolates.remove(isolate);
      if (_closing) {
        return;
      }
      if (isolate.markedForReplace) {
        return;
      }
      if (!skipWaitBetweenRestarts) {
        // Restart the isolate after a wait, increasing the duration with each restart.
        //
        // NOTE: As this wait period increases, the service may miss /liveness_check
        //       requests, and eventually AppEngine may just kill the instance
        //       marking it unreachable (if it is a frontend isolate).
        var waitSeconds = 5 + started;
        while (waitSeconds > 0) {
          if (_closing) {
            return;
          }
          await Future.delayed(Duration(seconds: 1));
          waitSeconds--;
        }
      }
      await _startOne();
    }));
  }

  Future<void> close() async {
    while (_isolates.isNotEmpty) {
      await _isolates.removeLast().close();
    }
  }
}

/// Starts an [IsolateCollection] with the default isolate configuration
/// (when specified).
///
/// After starting the isolates, the method waits for terminating
/// process signals (e.g. SIGTERM), and when recieved, closes the
/// isolates and returns.
Future runIsolates({
  required Logger logger,
  EntryPointFn? frontendEntryPoint,
  EntryPointFn? workerEntryPoint,
  EntryPointFn? jobEntryPoint,
  Uri? indexSpawnUri,
  Stream? indexRenewTrigger,
  Duration? indexRenewTimeout,
  Duration? deadWorkerTimeout,
  required int frontendCount,
  ServicesWrapperFn? servicesWrapperFn,
}) async {
  final runner = IsolateCollection(
    logger: logger,
    servicesWrapperFn: servicesWrapperFn ?? withServices,
  );
  await runner.servicesWrapperFn(() async {
    _verifyStampFile();
    try {
      if (frontendEntryPoint != null) {
        await runner.startGroup(
          kind: 'frontend',
          entryPoint: frontendEntryPoint,
          count: frontendCount,
          deadTimeout: Duration(minutes: 1),
        );
      }
      if (workerEntryPoint != null) {
        await runner.startGroup(
          kind: 'worker',
          entryPoint: workerEntryPoint,
          count: 1,
          deadTimeout: deadWorkerTimeout,
        );
      }
      if (jobEntryPoint != null) {
        await runner.startGroup(
          kind: 'job',
          entryPoint: jobEntryPoint,
          count: 1,
          deadTimeout: deadWorkerTimeout,
        );
      }
      StreamSubscription? indexRenewSubscription;
      if (indexSpawnUri != null) {
        final indexGroup = await runner.startGroup(
          kind: 'index',
          spawnUri: indexSpawnUri,
          count: 1,
          deadTimeout: null,
        );
        indexRenewSubscription = indexRenewTrigger?.listen((_) {
          indexGroup.renew(wait: indexRenewTimeout ?? Duration(minutes: 5));
        });
      }

      await waitForProcessSignalTermination();

      await indexRenewSubscription?.cancel();
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

/// Represents a running isolate, with its current status, subscriptions and
/// autokill timer.
class _Isolate {
  /// Parent runner that owns this group
  final IsolateCollection parent;
  final IsolateGroup group;
  final Logger logger;
  final String id;

  late Isolate _isolate;

  final _aliveReceivePort = ReceivePort();
  final _errorReceivePort = ReceivePort();
  final _exitReceivePort = ReceivePort();
  final _protocolReceivePort = ReceivePort();

  ReadyMessage? _readyMessage;

  StreamSubscription? _protocolSubscription;
  StreamSubscription? _errorSubscription;
  StreamSubscription? _exitSubscription;
  StreamSubscription? _aliveSubscription;
  Timer? _autokillTimer;

  final _doneCompleter = Completer();
  late final done = _doneCompleter.future;
  var markedForReplace = false;

  _Isolate({
    required this.parent,
    required this.group,
    required this.logger,
    required this.id,
  });

  Future<void> initFunction({
    required EntryPointFn entryPoint,
    required Duration? deadTimeout,
  }) async {
    _isolate = await Isolate.spawn(
      _wrapper,
      [
        parent.servicesWrapperFn,
        entryPoint,
        EntryMessage(
          protocolSendPort: _protocolReceivePort.sendPort,
          aliveSendPort: _aliveReceivePort.sendPort,
        ),
      ],
      onError: _errorReceivePort.sendPort,
      onExit: _exitReceivePort.sendPort,
      errorsAreFatal: true,
      debugName: id,
    );
    await _init(deadTimeout: deadTimeout);
  }

  Future<void> initUri({
    required Uri spawnUri,
    required Duration? deadTimeout,
  }) async {
    _isolate = await Isolate.spawnUri(
      spawnUri,
      [],
      EntryMessage(
        protocolSendPort: _protocolReceivePort.sendPort,
        aliveSendPort: _aliveReceivePort.sendPort,
      ).encodeAsJson(),
      onError: _errorReceivePort.sendPort,
      onExit: _exitReceivePort.sendPort,
      errorsAreFatal: true,
      debugName: id,
    );
    await _init(deadTimeout: deadTimeout);
  }

  Future<void> _init({
    required Duration? deadTimeout,
  }) async {
    final ready = Completer();
    _protocolSubscription = _protocolReceivePort.listen((event) {
      final e = Message.decode(event);
      if (e is ReadyMessage && !ready.isCompleted) {
        _readyMessage = e;
        ready.complete();
      } else if (e is RequestMessage) {
        final group = parent._groups.firstWhereOrNull((g) => g.kind == e.kind);
        if (group == null) {
          logger.warning('Isolate group "${e.kind}" does not exist.');
          e.replyPort.send(
              ReplyMessage.error('Isolate group "${e.kind}" does not exist.')
                  .encodeAsJson());
          return;
        } else {
          group.processRequestMessage(e);
        }
      } else if (e is DebugMessage) {
        logger.info('Debug message from $id: ${e.text}');
      }
    });

    _errorSubscription = _errorReceivePort.listen((e) async {
      stderr.writeln('ERROR from $id: $e');
      logger.severe('ERROR from $id', e);

      final now = clock.now();
      // If the last isolate was started more than an hour ago, we can reset
      // the protection.
      if (now.isAfter(group._lastStarted.add(Duration(hours: 1)))) {
        group._restartProtectionOffset = Duration.zero;
      }

      // If we have recently restarted an isolate, let's keep it running.
      if (now
          .isBefore(group._lastStarted.add(group._restartProtectionOffset))) {
        return;
      }

      // Extend restart protection for up to 20 minutes.
      if (group._restartProtectionOffset.inMinutes < 20) {
        group._restartProtectionOffset += Duration(minutes: 4);
      }

      await close();
    });

    _exitSubscription = _exitReceivePort.listen((e) async {
      stderr.writeln('$id exited with message: $e');
      logger.warning('$id exited.', e);
      await close();
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

Future<void> _wrapper(List args) async {
  final serviceFn = args[0] as ServicesWrapperFn;
  final fn = args[1] as Function;
  final message = args[2];
  final logger = Logger('isolate.wrapper');
  // NOTE: This timer triggers active "work" and prevents the VM to run compaction GC.
  //       https://github.com/dart-lang/sdk/issues/52513
  final timer = Timer.periodic(Duration(milliseconds: 250), (_) {});

  try {
    return await Chain.capture(
      () => serviceFn(() async => await fn(message)),
      onError: (e, st) {
        // TODO: Enable, if we undo the hack for logging:
        // print('Uncaught exception in isolate. $e $st');
        logger.severe('Uncaught exception in isolate.', e, st.terse);
        throw Exception('Crashing isolate due to uncaught exception: $e');
      },
    );
  } finally {
    timer.cancel();
  }
}

/// Exposes [withFakeServices] as [ServicesWrapperFn].
Future<void> fakeServicesWrapper(Future Function() fn) async {
  setupDebugEnvBasedLogging();
  await fork(() => withFakeServices(fn: fn));
}
