// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';

import '../services.dart';
import '_messages.dart';
export '_messages.dart';

/// Wrapper method to replace [withServices] into [withFakeServices] for
/// local tests and development.
typedef ServicesWrapperFn = Future<void> Function(Future Function() fn);

/// The main method to run in the new isolate.
typedef EntryPointFn = Future<void> Function(EntryMessage message);

/// Starts, monitors, stops or restarts isolates that run the same code.
///
/// Once an isolate starts, it is expected to run indefinitely. When it exits,
/// either by completion or uncaught exception, a new isolate will be started.
class IsolateRunner {
  final Logger logger;
  final String kind;
  final ServicesWrapperFn? servicesWrapperFn;
  final EntryPointFn? entryPoint;
  final Uri? spawnUri;

  int started = 0;
  final _isolates = <_Isolate>[];
  bool _closing = false;

  IsolateRunner.fn({
    required this.logger,
    required this.kind,
    required ServicesWrapperFn this.servicesWrapperFn,
    required EntryPointFn this.entryPoint,
  }) : spawnUri = null;

  IsolateRunner.uri({
    required this.logger,
    required this.kind,
    required Uri this.spawnUri,
  })  : entryPoint = null,
        servicesWrapperFn = null;

  /// Starts [count] new isolates.
  Future<void> start(int count) async {
    for (var i = 0; i < count; i++) {
      await _startOne();
    }
  }

  /// Starts [count] new isolates, and after a [wait] duration,
  /// closes the old ones.
  Future<void> renew({
    required int count,
    required Duration wait,
  }) async {
    final isolatesToClose = [..._isolates];

    await start(count);
    // prevent traffic to hit the old instances
    for (final i in isolatesToClose) {
      i.markedForRenew = true;
    }

    await Future.delayed(wait);
    for (final i in isolatesToClose) {
      await i.close();
    }
  }

  /// Send [RequestMessage] and wait for [ReplyMessage] returning
  /// [ReplyMessage.result], or throws [IsolateRequestException]
  Future<Object?> sendRequest(
    Object payload, {
    required Duration timeout,
  }) async {
    final last = _isolates.lastWhereOrNull((i) =>
        i.markedForRenew == false && i._readyMessage?.requestSendPort != null);
    if (last == null) {
      throw IsolateRequestException('No isolate to process request.');
    }

    final replyRecievePort = ReceivePort();
    try {
      final firstFuture = replyRecievePort.first;
      final targetSendPort = last._readyMessage!.requestSendPort!;
      final requestMessage = RequestMessage(payload, replyRecievePort.sendPort);
      targetSendPort.send(requestMessage.encodeAsJson());
      final first = await firstFuture.timeout(timeout) as Map<String, dynamic>;
      final reply = Message.fromObject(first) as ReplyMessage;
      if (reply.isError) {
        throw IsolateRequestException(reply.error!);
      }
      return reply.result;
    } finally {
      replyRecievePort.close();
    }
  }

  Future<void> _startOne() async {
    if (_closing) return;
    started++;
    final id = '$kind isolate #$started';
    logger.info('About to start $id ...');
    final isolate = _Isolate(
      group: this,
      logger: logger,
      id: id,
    );
    _isolates.add(isolate);
    unawaited(isolate.done.then((_) async {
      _isolates.remove(isolate);
    }));
    if (entryPoint != null) {
      await isolate.spawnFn(
        servicesWrapperFn: servicesWrapperFn!,
        entryPoint: entryPoint!,
      );
    } else {
      await isolate.spawnUri(spawnUri: spawnUri!);
    }
    if (_closing) {
      await isolate.close();
      return;
    }
    logger.info('$id started.');
  }

  Future<void> close() async {
    _closing = true;
    while (_isolates.isNotEmpty) {
      await _isolates.removeLast().close();
    }
  }
}

/// Starts a worker isolate and returns its runner to control it.
Future<IsolateRunner> startWorkerIsolate({
  required Logger logger,
  required EntryPointFn entryPoint,
  ServicesWrapperFn? servicesWrapperFn,
}) async {
  final worker = IsolateRunner.fn(
    logger: logger,
    kind: 'worker',
    servicesWrapperFn: servicesWrapperFn ?? withServices,
    entryPoint: entryPoint,
  );
  await worker.start(1);
  return worker;
}

/// Starts an index isolate and returns its runner to control it.
Future<IsolateRunner> startQueryIsolate({
  required Logger logger,
  required Uri spawnUri,
}) async {
  final worker = IsolateRunner.uri(
    logger: logger,
    kind: 'query',
    spawnUri: spawnUri,
  );
  await worker.start(1);
  return worker;
}

/// Represents a running isolate, with its current status and subscriptions.
class _Isolate {
  /// Parent runner that owns this group
  final IsolateRunner group;
  final Logger logger;
  final String id;

  late Isolate _isolate;

  final _errorReceivePort = ReceivePort();
  final _exitReceivePort = ReceivePort();
  final _protocolReceivePort = ReceivePort();

  ReadyMessage? _readyMessage;
  bool get isReady => _readyMessage != null;

  StreamSubscription? _protocolSubscription;
  StreamSubscription? _errorSubscription;
  StreamSubscription? _exitSubscription;
  StreamSubscription? _aliveSubscription;

  final _doneCompleter = Completer();
  late final done = _doneCompleter.future;
  bool markedForRenew = false;

  _Isolate({
    required this.group,
    required this.logger,
    required this.id,
  });

  Future<void> spawnFn({
    required ServicesWrapperFn servicesWrapperFn,
    required Future<void> Function(EntryMessage message) entryPoint,
  }) async {
    _isolate = await Isolate.spawn(
      _wrapper,
      [
        servicesWrapperFn,
        entryPoint,
        EntryMessage(
          protocolSendPort: _protocolReceivePort.sendPort,
        ),
      ],
      onError: _errorReceivePort.sendPort,
      onExit: _exitReceivePort.sendPort,
      errorsAreFatal: true,
      debugName: id,
    );

    await _init();
  }

  Future<void> spawnUri({
    required Uri spawnUri,
  }) async {
    _isolate = await Isolate.spawnUri(
      spawnUri,
      [],
      EntryMessage(
        protocolSendPort: _protocolReceivePort.sendPort,
      ).encodeAsJson(),
      onError: _errorReceivePort.sendPort,
      onExit: _exitReceivePort.sendPort,
      errorsAreFatal: true,
      debugName: id,
    );
    await _init();
  }

  Future<void> _init() async {
    final ready = Completer();
    _protocolSubscription = _protocolReceivePort.listen((event) {
      final e = Message.fromObject(event);
      if (e is ReadyMessage && !ready.isCompleted) {
        _readyMessage = e;
        ready.complete();
      } else if (e is DebugMessage) {
        logger.info('Debug message from $id: ${e.text}');
      }
    });

    _errorSubscription = _errorReceivePort.listen((e) async {
      stderr.writeln('ERROR from $id: $e');
      logger.severe('ERROR from $id', e);
      await close();
    });

    _exitSubscription = _exitReceivePort.listen((e) async {
      stderr.writeln('$id exited with message: $e');
      logger.warning('$id exited.', e);
      await close();
    });

    await ready.future;
  }

  Future<void> close() async {
    try {
      if (_doneCompleter.isCompleted) return;
      logger.info('About to close $id ...');
      await _protocolSubscription?.cancel();
      await _aliveSubscription?.cancel();
      await _errorSubscription?.cancel();
      await _exitSubscription?.cancel();
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
