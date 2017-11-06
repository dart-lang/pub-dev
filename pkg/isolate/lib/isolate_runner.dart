// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library isolate.isolate_runner;

import "dart:async";
import "dart:isolate";

import 'ports.dart';
import 'runner.dart';
import 'src/lists.dart';

// Command tags. Shared between IsolateRunner and IsolateRunnerRemote.
const int _SHUTDOWN = 0;
const int _RUN = 1;

/// An easier to use interface on top of an [Isolate].
///
/// Wraps an `Isolate` and allows pausing, killing and inspecting
/// the isolate more conveniently than the raw `Isolate` methods.
///
/// Also allows running simple functions in the other isolate, and get back
/// the result.
class IsolateRunner implements Runner {
  /// The underlying [Isolate] object of the isolate being controlled.
  final Isolate isolate;

  /// Command port for the [IsolateRunnerRemote].
  final SendPort _commandPort;

  /// Future returned by [onExit]. Set when [onExit] is first read.
  Future _onExitFuture;

  /// Create an [IsolateRunner] wrapper for [isolate]
  ///
  /// The preferred way to create an `IsolateRunner` is to use [spawn]
  /// to create a new isolate and a runner for it.
  ///
  /// This constructor allows creating a runner for an already existing
  /// isolate.
  /// The [commandPort] must be the [IsolateRunnerRemote.commandPort] of
  /// a remote running in that isolate.
  IsolateRunner(this.isolate, SendPort commandPort)
      : _commandPort = commandPort;

  /// Create a new [Isolate], as by [Isolate.spawn] and wrap that.
  ///
  /// The returned [IsolateRunner] forwards operations to the new isolate,
  /// and keeps a port open in the new isolate that receives commands
  /// from the `IsolateRunner`. Remember to [close] the `IsolateRunner` when
  /// it's no longer needed.
  ///
  /// The created isolate is set to have errors not be fatal.
  static Future<IsolateRunner> spawn() async {
    var channel = new SingleResponseChannel();
    var isolate =
        await Isolate.spawn(IsolateRunnerRemote._create, channel.port);
    // The runner can be used to run multiple independent functions.
    // An accidentally uncaught error shouldn't ruin it for everybody else.
    isolate.setErrorsFatal(false);
    var pingChannel = new SingleResponseChannel();
    isolate.ping(pingChannel.port);
    var commandPort = await channel.result;
    var result = new IsolateRunner(isolate, commandPort);
    // Guarantees that setErrorsFatal has completed.
    await pingChannel.result;
    return result;
  }

  /// Closes the `IsolateRunner` communication down.
  ///
  /// If the isolate isn't running something else to keep it alive,
  /// this will also make the isolate shut down.
  ///
  /// Can be used to create an isolate, use [run] to start a service, and
  /// then drop the connection and let the service control the isolate's
  /// life cycle.
  Future close() {
    var channel = new SingleResponseChannel();
    _commandPort.send(list2(_SHUTDOWN, channel.port));
    return channel.result;
  }

  /// Kills the isolate.
  ///
  /// Starts by calling [close], but if that doesn't cause the isolate to
  /// shut down in a timely manner, as given by [timeout], it follows up
  /// with [Isolate.kill], with increasing urgency if necessary.
  ///
  /// If [timeout] is a zero duration, it goes directly to the most urgent
  /// kill.
  ///
  /// If the isolate is already dead, the returned future will not complete.
  /// If that may be the case, use [Future.timeout] on the returned future
  /// to take extra action after a while. Example:
  ///
  ///     var f = isolate.kill();
  ///     f.then((_) => print('Dead')
  ///      .timeout(new Duration(...), onTimeout: () => print('No response'));
  Future kill({Duration timeout: const Duration(seconds: 1)}) {
    Future onExit = singleResponseFuture(isolate.addOnExitListener);
    if (Duration.ZERO == timeout) {
      isolate.kill(priority: Isolate.IMMEDIATE);
      return onExit;
    } else {
      // Try a more gentle shutdown sequence.
      _commandPort.send(list1(_SHUTDOWN));
      return onExit.timeout(timeout, onTimeout: () {
        isolate.kill(priority: Isolate.IMMEDIATE);
        return onExit;
      });
    }
  }

  /// Queries the isolate on whether it's alive.
  ///
  /// If the isolate is alive and responding to commands, the
  /// returned future completes with `true`.
  ///
  /// If the other isolate is not alive (like after calling [kill]),
  /// or doesn't answer within [timeout] for any other reason,
  /// the returned future completes with `false`.
  ///
  /// Guaranteed to only complete after all previous sent isolate commands
  /// (like pause and resume) have been handled.
  /// Paused isolates do respond to ping requests.
  Future<bool> ping({Duration timeout: const Duration(seconds: 1)}) {
    var channel = new SingleResponseChannel(
        callback: _kTrue, timeout: timeout, timeoutValue: false);
    isolate.ping(channel.port);
    return channel.result;
  }

  static bool _kTrue(_) => true;

  /// Pauses the isolate.
  ///
  /// While paused, no normal messages are processed, and calls to [run] will
  /// be delayed until the isolate is resumed.
  ///
  /// Commands like [kill] and [ping] are still executed while the isolate is
  /// paused.
  ///
  /// If [resumeCapability] is omitted, it defaults to the [isolate]'s
  /// [Isolate.pauseCapability].
  ///
  /// Calling pause more than once with the same `resumeCapability`
  /// has no further effect. Only a single call to [resume] is needed
  /// to resume the isolate.
  void pause([Capability resumeCapability]) {
    if (resumeCapability == null) resumeCapability = isolate.pauseCapability;
    isolate.pause(resumeCapability);
  }

  /// Resumes after a [pause].
  ///
  /// If [resumeCapability] is omitted, it defaults to the isolate's
  /// [Isolate.pauseCapability].
  ///
  /// Even if `pause` has been called more than once with the same
  /// `resumeCapability`, a single resume call with stop the pause.
  void resume([Capability resumeCapability]) {
    if (resumeCapability == null) resumeCapability = isolate.pauseCapability;
    isolate.resume(resumeCapability);
  }

  /// Execute `function(argument)` in the isolate and return the result.
  ///
  /// Sends [function] and [argument] to the isolate, runs the call, and
  /// returns the result, whether it returned a value or threw.
  /// If the call returns a [Future], the final result of that future
  /// will be returned.
  ///
  /// This works similar to the arguments to [Isolate.spawn], except that
  /// it runs in the existing isolate and the return value is returned to
  /// the caller.
  ///
  /// Example:
  ///
  ///     IsolateRunner iso = await IsolateRunner.spawn();
  ///     try {
  ///       return await iso.run(heavyComputation, argument);
  ///     } finally {
  ///       await iso.close();
  ///     }
  Future<R> run<R, P>(R function(P argument), P argument,
      {Duration timeout, onTimeout()}) {
    return singleResultFuture((SendPort port) {
      _commandPort.send(list4(_RUN, function, argument, port));
    }, timeout: timeout, onTimeout: onTimeout);
  }

  /// A broadcast stream of uncaught errors from the isolate.
  ///
  /// When listening on the stream, errors from the isolate will be reported
  /// as errors in the stream. Be ready to handle the errors.
  ///
  /// The stream closes when the isolate shuts down.
  Stream get errors {
    StreamController controller;
    RawReceivePort port;
    void handleError(message) {
      if (message == null) {
        // Isolate shutdown.
        port.close();
        controller.close();
      } else {
        // Uncaught error.
        String errorDescription = message[0];
        String stackDescription = message[1];
        var error = new RemoteError(errorDescription, stackDescription);
        controller.addError(error, error.stackTrace);
      }
    }

    controller = new StreamController.broadcast(
        sync: true,
        onListen: () {
          port = new RawReceivePort(handleError);
          isolate.addErrorListener(port.sendPort);
          isolate.addOnExitListener(port.sendPort);
        },
        onCancel: () {
          isolate.removeErrorListener(port.sendPort);
          isolate.removeOnExitListener(port.sendPort);
          port.close();
          port = null;
        });
    return controller.stream;
  }

  /// Waits for the [isolate] to terminate.
  ///
  /// Completes the returned future when the isolate terminates.
  ///
  /// If the isolate has already stopped responding to commands,
  /// the returned future will be completed after one second,
  /// using [ping] to check if the isolate is still alive.
  Future get onExit {
    // TODO(lrn): Is there a way to see if an isolate is dead
    // so we can close the receive port for this future?
    if (_onExitFuture == null) {
      var channel = new SingleResponseChannel();
      isolate.addOnExitListener(channel.port);
      _onExitFuture = channel.result;
      ping().then((bool alive) {
        if (!alive) {
          channel.interrupt();
          _onExitFuture = null;
        }
      });
    }
    return _onExitFuture;
  }
}

/// The remote part of an [IsolateRunner].
///
/// The `IsolateRunner` sends commands to the controlled isolate through
/// the `IsolateRunnerRemote` [commandPort].
///
/// Only use this class if you need to set up the isolate manually
/// instead of relying on [IsolateRunner.spawn].
class IsolateRunnerRemote {
  final RawReceivePort _commandPort = new RawReceivePort();
  IsolateRunnerRemote() {
    _commandPort.handler = _handleCommand;
  }

  /// The command port that can be used to send commands to this remote.
  ///
  /// Use this as argument to [new IsolateRunner] if creating the link
  /// manually, otherwise it's handled by [IsolateRunner.spawn].
  SendPort get commandPort => _commandPort.sendPort;

  static void _create(SendPort initPort) {
    var remote = new IsolateRunnerRemote();
    initPort.send(remote.commandPort);
  }

  void _handleCommand(List command) {
    switch (command[0]) {
      case _SHUTDOWN:
        SendPort responsePort = command[1];
        _commandPort.close();
        responsePort.send(null);
        return;
      case _RUN:
        Function function = command[1];
        var argument = command[2];
        SendPort responsePort = command[3];
        sendFutureResult(
            new Future.sync(() => function(argument)), responsePort);
        return;
    }
  }
}
