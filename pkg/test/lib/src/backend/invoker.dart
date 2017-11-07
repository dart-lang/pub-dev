// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:stack_trace/stack_trace.dart';

import '../frontend/expect.dart';
import '../runner/load_suite.dart';
import '../utils.dart';
import 'closed_exception.dart';
import 'group.dart';
import 'live_test.dart';
import 'live_test_controller.dart';
import 'message.dart';
import 'metadata.dart';
import 'operating_system.dart';
import 'outstanding_callback_counter.dart';
import 'state.dart';
import 'suite.dart';
import 'test.dart';
import 'test_platform.dart';

/// A test in this isolate.
class LocalTest extends Test {
  final String name;
  final Metadata metadata;
  final Trace trace;

  /// The test body.
  final AsyncFunction _body;

  LocalTest(this.name, this.metadata, body(), {this.trace}) : _body = body;

  /// Loads a single runnable instance of this test.
  LiveTest load(Suite suite, {Iterable<Group> groups}) {
    var invoker = new Invoker._(suite, this, groups: groups);
    return invoker.liveTest;
  }

  Test forPlatform(TestPlatform platform, {OperatingSystem os}) {
    if (!metadata.testOn.evaluate(platform, os: os)) return null;
    return new LocalTest(name, metadata.forPlatform(platform, os: os), _body,
        trace: trace);
  }
}

/// The class responsible for managing the lifecycle of a single local test.
///
/// The current invoker is accessible within the zone scope of the running test
/// using [Invoker.current]. It's used to track asynchronous callbacks and
/// report asynchronous errors.
class Invoker {
  /// The live test being driven by the invoker.
  ///
  /// This provides a view into the state of the test being executed.
  LiveTest get liveTest => _controller.liveTest;
  LiveTestController _controller;

  /// Whether the test can be closed in the current zone.
  bool get _closable => Zone.current[_closableKey];

  /// An opaque object used as a key in the zone value map to identify
  /// [_closable].
  ///
  /// This is an instance variable to ensure that multiple invokers don't step
  /// on one anothers' toes.
  final _closableKey = new Object();

  /// Whether the test has been closed.
  ///
  /// Once the test is closed, [expect] and [expectAsync] will throw
  /// [ClosedException]s whenever accessed to help the test stop executing as
  /// soon as possible.
  bool get closed => _closable && _onCloseCompleter.isCompleted;

  /// A future that completes once the test has been closed.
  Future get onClose => _closable
      ? _onCloseCompleter.future
      // If we're in an unclosable block, return a future that will never
      // complete.
      : new Completer().future;
  final _onCloseCompleter = new Completer();

  /// The test being run.
  LocalTest get _test => liveTest.test as LocalTest;

  /// The outstanding callback counter for the current zone.
  OutstandingCallbackCounter get _outstandingCallbacks {
    var counter = Zone.current[_counterKey];
    if (counter != null) return counter;
    throw new StateError("Can't add or remove outstanding callbacks outside "
        "of a test body.");
  }

  /// All the zones created by [waitForOutstandingCallbacks], in the order they
  /// were created.
  ///
  /// This is used to throw timeout errors in the most recent zone.
  final _outstandingCallbackZones = <Zone>[];

  /// An opaque object used as a key in the zone value map to identify
  /// [_outstandingCallbacks].
  ///
  /// This is an instance variable to ensure that multiple invokers don't step
  /// on one anothers' toes.
  final _counterKey = new Object();

  /// The number of times this [liveTest] has been run.
  int _runCount = 0;

  /// The current invoker, or `null` if none is defined.
  ///
  /// An invoker is only set within the zone scope of a running test.
  static Invoker get current {
    // TODO(nweiz): Use a private symbol when dart2js supports it (issue 17526).
    return Zone.current[#test.invoker];
  }

  /// The zone that the top level of [_test.body] is running in.
  ///
  /// Tracking this ensures that [_timeoutTimer] isn't created in a
  /// timer-mocking zone created by the test.
  Zone _invokerZone;

  /// The timer for tracking timeouts.
  ///
  /// This will be `null` until the test starts running.
  Timer _timeoutTimer;

  /// The tear-down functions to run when this test finishes.
  final _tearDowns = <AsyncFunction>[];

  /// Messages to print if and when this test fails.
  final _printsOnFailure = <String>[];

  Invoker._(Suite suite, LocalTest test, {Iterable<Group> groups}) {
    _controller = new LiveTestController(
        suite, test, _onRun, _onCloseCompleter.complete,
        groups: groups);
  }

  /// Runs [callback] after this test completes.
  ///
  /// The [callback] may return a [Future]. Like all tear-downs, callbacks are
  /// run in the reverse of the order they're declared.
  void addTearDown(callback()) {
    if (closed) throw new ClosedException();
    _tearDowns.add(callback);
  }

  /// Tells the invoker that there's a callback running that it should wait for
  /// before considering the test successful.
  ///
  /// Each call to [addOutstandingCallback] should be followed by a call to
  /// [removeOutstandingCallback] once the callbak is no longer running. Note
  /// that only successful tests wait for outstanding callbacks; as soon as a
  /// test experiences an error, any further calls to [addOutstandingCallback]
  /// or [removeOutstandingCallback] will do nothing.
  ///
  /// Throws a [ClosedException] if this test has been closed.
  void addOutstandingCallback() {
    if (closed) throw new ClosedException();
    _outstandingCallbacks.addOutstandingCallback();
  }

  /// Tells the invoker that a callback declared with [addOutstandingCallback]
  /// is no longer running.
  void removeOutstandingCallback() {
    heartbeat();
    _outstandingCallbacks.removeOutstandingCallback();
  }

  /// Removes all outstanding callbacks, for example when an error occurs.
  ///
  /// Future calls to [addOutstandingCallback] and [removeOutstandingCallback]
  /// will be ignored.
  void removeAllOutstandingCallbacks() =>
      _outstandingCallbacks.removeAllOutstandingCallbacks();

  /// Runs [fn] and returns once all (registered) outstanding callbacks it
  /// transitively invokes have completed.
  ///
  /// If [fn] itself returns a future, this will automatically wait until that
  /// future completes as well. Note that outstanding callbacks registered
  /// within [fn] will *not* be registered as outstanding callback outside of
  /// [fn].
  ///
  /// If [fn] produces an unhandled error, this marks the current test as
  /// failed, removes all outstanding callbacks registered within [fn], and
  /// completes the returned future. It does not remove any outstanding
  /// callbacks registered outside of [fn].
  ///
  /// If the test times out, the *most recent* call to
  /// [waitForOutstandingCallbacks] will treat that error as occurring within
  /// [fn]—that is, it will complete immediately.
  Future waitForOutstandingCallbacks(fn()) {
    heartbeat();

    var zone;
    var counter = new OutstandingCallbackCounter();
    runZoned(() async {
      zone = Zone.current;
      _outstandingCallbackZones.add(zone);
      await fn();
      counter.removeOutstandingCallback();
    }, zoneValues: {_counterKey: counter});

    return counter.noOutstandingCallbacks.whenComplete(() {
      _outstandingCallbackZones.remove(zone);
    });
  }

  /// Runs [fn] in a zone where [closed] is always `false`.
  ///
  /// This is useful for running code that should be able to register callbacks
  /// and interact with the test framework normally even when the invoker is
  /// closed, for example cleanup code.
  unclosable(fn()) {
    heartbeat();

    return runZoned(fn, zoneValues: {_closableKey: false});
  }

  /// Notifies the invoker that progress is being made.
  ///
  /// Each heartbeat resets the timeout timer. This helps ensure that
  /// long-running tests that still make progress don't time out.
  void heartbeat() {
    if (liveTest.isComplete) return;
    if (_timeoutTimer != null) _timeoutTimer.cancel();

    var timeout =
        liveTest.test.metadata.timeout.apply(new Duration(seconds: 30));
    if (timeout == null) return;
    _timeoutTimer = _invokerZone.createTimer(timeout, () {
      _outstandingCallbackZones.last.run(() {
        if (liveTest.isComplete) return;
        _handleError(
            Zone.current,
            new TimeoutException(
                "Test timed out after ${niceDuration(timeout)}.", timeout));
      });
    });
  }

  /// Marks the current test as skipped.
  ///
  /// If passed, [message] is emitted as a skip message.
  ///
  /// Note that this *does not* mark the test as complete. That is, it sets
  /// the result to [Result.skipped], but doesn't change the state.
  void skip([String message]) {
    if (liveTest.state.shouldBeDone) {
      // Set the state explicitly so we don't get an extra error about the test
      // failing after being complete.
      _controller.setState(const State(Status.complete, Result.error));
      throw "This test was marked as skipped after it had already completed. "
          "Make sure to use\n"
          "[expectAsync] or the [completes] matcher when testing async code.";
    }

    if (message != null) _controller.message(new Message.skip(message));
    // TODO: error if the test is already complete.
    _controller.setState(const State(Status.pending, Result.skipped));
  }

  /// Prints [message] if and when this test fails.
  void printOnFailure(String message) {
    message = message.trim();
    if (liveTest.state.result.isFailing) {
      print("\n$message");
    } else {
      _printsOnFailure.add(message);
    }
  }

  /// Notifies the invoker of an asynchronous error.
  ///
  /// The [zone] is the zone in which the error was thrown.
  void _handleError(Zone zone, error, [StackTrace stackTrace]) {
    // Ignore errors propagated from previous test runs
    if (_runCount != zone[#runCount]) return;
    if (stackTrace == null) stackTrace = new Chain.current();

    // Store these here because they'll change when we set the state below.
    var shouldBeDone = liveTest.state.shouldBeDone;

    if (error is! TestFailure) {
      _controller.setState(const State(Status.complete, Result.error));
    } else if (liveTest.state.result != Result.error) {
      _controller.setState(const State(Status.complete, Result.failure));
    }

    _controller.addError(error, stackTrace);
    zone.run(removeAllOutstandingCallbacks);

    if (!liveTest.test.metadata.chainStackTraces) {
      _printsOnFailure.add("Consider enabling the flag chain-stack-traces to "
          "receive more detailed exceptions.\n"
          "For example, 'pub run test --chain-stack-traces'.");
    }

    if (_printsOnFailure.isNotEmpty) {
      print(_printsOnFailure.join("\n\n"));
      _printsOnFailure.clear();
    }

    // If a test was supposed to be done but then had an error, that indicates
    // that it was poorly-written and could be flaky.
    if (!shouldBeDone) return;

    // However, users don't think of load tests as "tests", so the error isn't
    // helpful for them.
    //
    // TODO(nweiz): Find a way of avoiding this error that doesn't require
    // Invoker to refer to a class from the runner.
    if (liveTest.suite is LoadSuite) return;

    _handleError(
        zone,
        "This test failed after it had already completed. Make sure to use "
        "[expectAsync]\n"
        "or the [completes] matcher when testing async code.",
        stackTrace);
  }

  /// The method that's run when the test is started.
  void _onRun() {
    _controller.setState(const State(Status.running, Result.success));

    var outstandingCallbacksForBody = new OutstandingCallbackCounter();

    _runCount++;
    Chain.capture(() {
      runZoned(() async {
        _invokerZone = Zone.current;
        _outstandingCallbackZones.add(Zone.current);

        // Run the test asynchronously so that the "running" state change has
        // a chance to hit its event handler(s) before the test produces an
        // error. If an error is emitted before the first state change is
        // handled, we can end up with [onError] callbacks firing before the
        // corresponding [onStateChkange], which violates the timing
        // guarantees.
        //
        // Using [new Future] also avoids starving the DOM or other
        // microtask-level events.
        new Future(() async {
          await _test._body();
          await unclosable(_runTearDowns);
          removeOutstandingCallback();
        });

        await _outstandingCallbacks.noOutstandingCallbacks;
        if (_timeoutTimer != null) _timeoutTimer.cancel();

        if (liveTest.state.result != Result.success &&
            _runCount < liveTest.test.metadata.retry + 1) {
          _controller
              .message(new Message.print("Retry: ${liveTest.test.name}"));
          _onRun();
          return;
        }

        _controller.setState(new State(Status.complete, liveTest.state.result));

        _controller.completer.complete();
      },
          zoneValues: {
            #test.invoker: this,
            // Use the invoker as a key so that multiple invokers can have different
            // outstanding callback counters at once.
            _counterKey: outstandingCallbacksForBody,
            _closableKey: true,
            #runCount: _runCount
          },
          zoneSpecification: new ZoneSpecification(
              print: (self, parent, zone, line) =>
                  _controller.message(new Message.print(line)),
              // Use [handleUncaughtError] rather than [onError] so we can
              // capture [zone] and with it the outstanding callback counter for
              // the zone in which [error] was thrown.
              handleUncaughtError: (self, _, zone, error, stackTrace) => self
                  .parent
                  .run(() => _handleError(zone, error, stackTrace))));
    }, when: liveTest.test.metadata.chainStackTraces);
  }

  /// Run [_tearDowns] in reverse order.
  Future _runTearDowns() async {
    while (_tearDowns.isNotEmpty) {
      await errorsDontStopTest(_tearDowns.removeLast());
    }
  }
}
