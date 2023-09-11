// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';

import '../services.dart';

/// Wrapper method to replace [withServices] into [withFakeServices] for
/// local tests and development.
typedef ServicesWrapperFn = Future<void> Function(Future Function() fn);

/// Marker class for inter-isolate messages.
sealed class Message {}

/// Initializing message send from the controller isolate to the new one.
class EntryMessage extends Message {
  final SendPort protocolSendPort;

  EntryMessage({
    required this.protocolSendPort,
  });
}

/// Message sent from the isolate to indicate that it is ready with the initialization.
class ReadyMessage extends Message {
  ReadyMessage();
}

/// Message sent from the isolate with arbitrary text.
class DebugMessage extends Message {
  final String text;

  DebugMessage(this.text);
}

/// Starts, monitors, stops or restarts isolates that run the same code.
///
/// Once an isolate starts, it is expected to run indefinitely. When it exits,
/// either by completion or uncaught exception, a new isolate will be started.
class IsolateRunner {
  final Logger logger;
  final String kind;
  final ServicesWrapperFn servicesWrapperFn;
  final Future<void> Function(EntryMessage message) entryPoint;

  int started = 0;
  final _isolates = <_Isolate>[];
  bool _closing = false;

  IsolateRunner({
    required this.logger,
    required this.kind,
    required this.servicesWrapperFn,
    required this.entryPoint,
  });

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
    await Future.delayed(wait);
    for (final i in isolatesToClose) {
      await i.close();
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
      servicesWrapperFn: servicesWrapperFn,
      entryPoint: entryPoint,
    );
    _isolates.add(isolate);
    unawaited(isolate.done.then((_) async {
      _isolates.remove(isolate);
    }));
    await isolate.init();
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
  required Future<void> Function(EntryMessage message) entryPoint,
  ServicesWrapperFn? servicesWrapperFn,
}) async {
  final worker = IsolateRunner(
    logger: logger,
    kind: 'worker',
    servicesWrapperFn: servicesWrapperFn ?? withServices,
    entryPoint: entryPoint,
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
  final ServicesWrapperFn servicesWrapperFn;
  final Future<void> Function(EntryMessage message) entryPoint;

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

  _Isolate({
    required this.group,
    required this.logger,
    required this.id,
    required this.servicesWrapperFn,
    required this.entryPoint,
  });

  Future<void> init() async {
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

    final ready = Completer();
    _protocolSubscription = _protocolReceivePort.listen((e) {
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
