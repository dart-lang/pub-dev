// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:collection';

import 'package:async/async.dart' hide Result;
import 'package:collection/collection.dart';
import 'package:pool/pool.dart';

import '../backend/group.dart';
import '../backend/invoker.dart';
import '../backend/live_test.dart';
import '../backend/live_test_controller.dart';
import '../backend/message.dart';
import '../backend/state.dart';
import '../backend/test.dart';
import '../util/iterable_set.dart';
import 'live_suite.dart';
import 'live_suite_controller.dart';
import 'load_suite.dart';
import 'runner_suite.dart';

/// An [Engine] manages a run that encompasses multiple test suites.
///
/// Test suites are provided by passing them into [suiteSink]. Once all suites
/// have been provided, the user should close [suiteSink] to indicate this.
/// [run] won't terminate until [suiteSink] is closed. Suites will be run in the
/// order they're provided to [suiteSink]. Tests within those suites will
/// likewise be run in the order they're declared.
///
/// The current status of every test is visible via [liveTests]. [onTestStarted]
/// can also be used to be notified when a test is about to be run.
///
/// The engine has some special logic for [LoadSuite]s and the tests they
/// contain, referred to as "load tests". Load tests exist to provide visibility
/// into the process of loading test files, but as long as that process is
/// proceeding normally users usually don't care about it, so the engine only
/// surfaces running load tests (that is, includes them in [liveTests] and other
/// collections) under specific circumstances.
///
/// If only load tests are running, exactly one load test will be in [active]
/// and [liveTests]. If this test passes, it will be removed from both [active]
/// and [liveTests] and *will not* be added to [passed]. If at any point a load
/// test fails, it will be added to [failed] and [liveTests].
///
/// The test suite loaded by a load suite will be automatically be run by the
/// engine; it doesn't need to be added to [suiteSink] manually.
///
/// Load tests will always be emitted through [onTestStarted] so users can watch
/// their event streams once they start running.
class Engine {
  /// Whether [run] has been called yet.
  var _runCalled = false;

  /// Whether [close] has been called.
  var _closed = false;

  /// Whether [close] was called before all the tests finished running.
  ///
  /// This is `null` if close hasn't been called and the tests are still
  /// running, `true` if close was called before the tests finished running, and
  /// `false` if the tests finished running before close was called.
  var _closedBeforeDone;

  /// A pool that limits the number of test suites running concurrently.
  final Pool _runPool;

  /// A pool that limits the number of test suites loaded concurrently.
  ///
  /// Once this reaches its limit, loading any additional test suites will cause
  /// previous suites to be unloaded in the order they completed.
  final Pool _loadPool;

  /// A completer that will complete when [this] is unpaused.
  ///
  /// If [this] isn't paused, [_pauseCompleter] is `null`.
  Completer _pauseCompleter;

  /// A future that completes once [this] is unpaused.
  ///
  /// If [this] isn't paused, this completes immediately.
  Future get _onUnpaused =>
      _pauseCompleter == null ? new Future.value() : _pauseCompleter.future;

  /// Whether all tests passed or were skipped.
  ///
  /// This fires once all tests have completed and [suiteSink] has been closed.
  /// This will be `null` if [close] was called before all the tests finished
  /// running.
  Future<bool> get success async {
    await Future
        .wait(<Future>[_group.future, _loadPool.done], eagerError: true);
    if (_closedBeforeDone) return null;
    return liveTests.every((liveTest) => liveTest.state.result.isPassing);
  }

  /// A group of futures for each test suite.
  final _group = new FutureGroup();

  /// All of the engine's stream subscriptions.
  final _subscriptions = new Set<StreamSubscription>();

  /// A sink used to pass [RunnerSuite]s in to the engine to run.
  ///
  /// Suites may be added as quickly as they're available; the Engine will only
  /// run as many as necessary at a time based on its concurrency settings.
  ///
  /// Suites added to the sink will be closed by the engine based on its
  /// internal logic.
  Sink<RunnerSuite> get suiteSink => new DelegatingSink(_suiteController.sink);
  final _suiteController = new StreamController<RunnerSuite>();

  /// All the [RunnerSuite]s added to [suiteSink] so far.
  ///
  /// Note that if a [LoadSuite] is added, this will only contain that suite,
  /// not the suite it loads.
  Set<RunnerSuite> get addedSuites => new UnmodifiableSetView(_addedSuites);
  final _addedSuites = new Set<RunnerSuite>();

  /// A broadcast stream that emits each [RunnerSuite] as it's added to the
  /// engine via [suiteSink].
  ///
  /// Note that if a [LoadSuite] is added, this will only return that suite, not
  /// the suite it loads.
  ///
  /// This is guaranteed to fire after the suite is added to [addedSuites].
  Stream<RunnerSuite> get onSuiteAdded => _onSuiteAddedController.stream;
  final _onSuiteAddedController = new StreamController<RunnerSuite>.broadcast();

  /// All the currently-known suites that have run or are running.
  ///
  /// These are [LiveSuite]s, representing the in-progress state of each suite
  /// as its component tests are being run.
  ///
  /// Note that unlike [addedSuites], for suites that are loaded using
  /// [LoadSuite]s, both the [LoadSuite] and the suite it loads will eventually
  /// be in this set.
  Set<LiveSuite> get liveSuites => new UnmodifiableSetView(_liveSuites);
  final _liveSuites = new Set<LiveSuite>();

  /// A broadcast stream that emits each [LiveSuite] as it's loaded.
  ///
  /// Note that unlike [onSuiteAdded], for suites that are loaded using
  /// [LoadSuite]s, both the [LoadSuite] and the suite it loads will eventually
  /// be emitted by this stream.
  Stream<LiveSuite> get onSuiteStarted => _onSuiteStartedController.stream;
  final _onSuiteStartedController = new StreamController<LiveSuite>.broadcast();

  /// All the currently-known tests that have run or are running.
  ///
  /// These are [LiveTest]s, representing the in-progress state of each test.
  /// Tests that have not yet begun running are marked [Status.pending]; tests
  /// that have finished are marked [Status.complete].
  ///
  /// This is guaranteed to contain the same tests as the union of [passed],
  /// [skipped], [failed], and [active].
  ///
  /// [LiveTest.run] must not be called on these tests.
  Set<LiveTest> get liveTests =>
      new UnionSet.from([passed, skipped, failed, new IterableSet(active)],
          disjoint: true);

  /// A stream that emits each [LiveTest] as it's about to start running.
  ///
  /// This is guaranteed to fire before [LiveTest.onStateChange] first fires.
  Stream<LiveTest> get onTestStarted => _onTestStartedGroup.stream;
  final _onTestStartedGroup = new StreamGroup<LiveTest>.broadcast();

  /// The set of tests that have completed and been marked as passing.
  Set<LiveTest> get passed => _passedGroup.set;
  final _passedGroup = new UnionSetController<LiveTest>(disjoint: true);

  /// The set of tests that have completed and been marked as skipped.
  Set<LiveTest> get skipped => _skippedGroup.set;
  final _skippedGroup = new UnionSetController<LiveTest>(disjoint: true);

  /// The set of tests that have completed and been marked as failing or error.
  Set<LiveTest> get failed => _failedGroup.set;
  final _failedGroup = new UnionSetController<LiveTest>(disjoint: true);

  /// The tests that are still running, in the order they begain running.
  List<LiveTest> get active => new UnmodifiableListView(_active);
  final _active = new QueueList<LiveTest>();

  /// The set of tests that have been marked for restarting.
  ///
  /// This is always a subset of [active]. Once a test in here has finished
  /// running, it's run again.
  final _restarted = new Set<LiveTest>();

  /// The tests from [LoadSuite]s that are still running, in the order they
  /// began running.
  ///
  /// This is separate from [active] because load tests aren't always surfaced.
  final _activeLoadTests = new List<LiveTest>();

  /// Whether this engine is idle—that is, not currently executing a test.
  bool get isIdle => _group.isIdle;

  /// A broadcast stream that fires an event whenever [isIdle] switches from
  /// `false` to `true`.
  Stream get onIdle => _group.onIdle;

  // TODO(nweiz): Use interface libraries to take a Configuration even when
  // dart:io is unavailable.
  /// Creates an [Engine] that will run all tests provided via [suiteSink].
  ///
  /// [concurrency] controls how many suites are run at once, and defaults to 1.
  /// [maxSuites] controls how many suites are *loaded* at once, and defaults to
  /// four times [concurrency].
  Engine({int concurrency, int maxSuites})
      : _runPool = new Pool(concurrency ?? 1),
        _loadPool = new Pool(maxSuites ?? (concurrency ?? 1) * 2) {
    _group.future.then((_) {
      _onTestStartedGroup.close();
      _onSuiteStartedController.close();
      if (_closedBeforeDone == null) _closedBeforeDone = false;
    }).catchError((_) {
      // Don't top-level errors. They'll be thrown via [success] anyway.
    });
  }

  /// Creates an [Engine] that will run all tests in [suites].
  ///
  /// An engine constructed this way will automatically close its [suiteSink],
  /// meaning that no further suites may be provided.
  ///
  /// [concurrency] controls how many suites are run at once. If [runSkipped] is
  /// `true`, skipped tests will be run as though they weren't skipped.
  factory Engine.withSuites(List<RunnerSuite> suites, {int concurrency}) {
    var engine = new Engine(concurrency: concurrency);
    for (var suite in suites) engine.suiteSink.add(suite);
    engine.suiteSink.close();
    return engine;
  }

  /// Runs all tests in all suites defined by this engine.
  ///
  /// This returns `true` if all tests succeed, and `false` otherwise. It will
  /// only return once all tests have finished running and [suiteSink] has been
  /// closed.
  Future<bool> run() {
    if (_runCalled) {
      throw new StateError("Engine.run() may not be called more than once.");
    }
    _runCalled = true;

    StreamSubscription subscription;
    subscription = _suiteController.stream.listen((suite) {
      _addedSuites.add(suite);
      _onSuiteAddedController.add(suite);

      _group.add(new Future.sync(() async {
        var loadResource = await _loadPool.request();

        var controller;
        if (suite is LoadSuite) {
          await _onUnpaused;
          controller = await _addLoadSuite(suite);
          if (controller == null) {
            loadResource.release();
            return;
          }
        } else {
          controller = new LiveSuiteController(suite);
        }

        _addLiveSuite(controller.liveSuite);

        await _runPool.withResource(() async {
          if (_closed) return;
          await _runGroup(controller, controller.liveSuite.suite.group, []);
          controller.noMoreLiveTests();
          loadResource.allowRelease(() => controller.close());
        });
      }));
    }, onDone: () {
      _subscriptions.remove(subscription);
      _onSuiteAddedController.close();
      _group.close();
      _loadPool.close();
    });
    _subscriptions.add(subscription);

    return success;
  }

  /// Runs all the entries in [group] in sequence.
  ///
  /// [suiteController] is the controller fo the suite that contains [group].
  /// [parents] is a list of groups that contain [group]. It may be modified,
  /// but it's guaranteed to be in its original state once this function has
  /// finished.
  Future _runGroup(LiveSuiteController suiteController, Group group,
      List<Group> parents) async {
    parents.add(group);
    try {
      var suiteConfig = suiteController.liveSuite.suite.config;
      var skipGroup = !suiteConfig.runSkipped && group.metadata.skip;
      var setUpAllSucceeded = true;
      if (!skipGroup && group.setUpAll != null) {
        var liveTest = group.setUpAll
            .load(suiteController.liveSuite.suite, groups: parents);
        await _runLiveTest(suiteController, liveTest, countSuccess: false);
        setUpAllSucceeded = liveTest.state.result.isPassing;
      }

      if (!_closed && setUpAllSucceeded) {
        for (var entry in group.entries) {
          if (_closed) return;

          if (entry is Group) {
            await _runGroup(suiteController, entry, parents);
          } else if (!suiteConfig.runSkipped && entry.metadata.skip) {
            await _runSkippedTest(suiteController, entry, parents);
          } else {
            var test = entry as Test;
            await _runLiveTest(suiteController,
                test.load(suiteController.liveSuite.suite, groups: parents));
          }
        }
      }

      // Even if we're closed or setUpAll failed, we want to run all the
      // teardowns to ensure that any state is properly cleaned up.
      if (!skipGroup && group.tearDownAll != null) {
        var liveTest = group.tearDownAll
            .load(suiteController.liveSuite.suite, groups: parents);
        await _runLiveTest(suiteController, liveTest, countSuccess: false);
        if (_closed) await liveTest.close();
      }
    } finally {
      parents.remove(group);
    }
  }

  /// Runs [liveTest] using [suiteController].
  ///
  /// If [countSuccess] is `true` (the default), the test is put into [passed]
  /// if it succeeds. Otherwise, it's removed from [liveTests] entirely.
  Future _runLiveTest(LiveSuiteController suiteController, LiveTest liveTest,
      {bool countSuccess: true}) async {
    await _onUnpaused;
    _active.add(liveTest);

    // If there were no active non-load tests, the current active test would
    // have been a load test. In that case, remove it, since now we have a
    // non-load test to add.
    if (_active.first.suite is LoadSuite) _active.removeFirst();

    StreamSubscription subscription;
    subscription = liveTest.onStateChange.listen((state) {
      if (state.status != Status.complete) return;
      _active.remove(liveTest);

      // If we're out of non-load tests, surface a load test.
      if (_active.isEmpty && _activeLoadTests.isNotEmpty) {
        _active.add(_activeLoadTests.first);
      }
    }, onDone: () {
      _subscriptions.remove(subscription);
    });
    _subscriptions.add(subscription);

    suiteController.reportLiveTest(liveTest, countSuccess: countSuccess);

    // Schedule a microtask to ensure that [onTestStarted] fires before the
    // first [LiveTest.onStateChange] event.
    await new Future.microtask(liveTest.run);

    // Once the test finishes, use [new Future] to do a coarse-grained event
    // loop pump to avoid starving non-microtask events.
    await new Future(() {});

    if (!_restarted.contains(liveTest)) return;
    await _runLiveTest(suiteController, liveTest.copy(),
        countSuccess: countSuccess);
    _restarted.remove(liveTest);
  }

  /// Runs a dummy [LiveTest] for a test marked as "skip".
  ///
  /// [suiteController] is the controller for the suite that contains [test].
  /// [parents] is a list of groups that contain [test].
  Future _runSkippedTest(LiveSuiteController suiteController, Test test,
      List<Group> parents) async {
    await _onUnpaused;
    var skipped =
        new LocalTest(test.name, test.metadata, () {}, trace: test.trace);

    var controller;
    controller =
        new LiveTestController(suiteController.liveSuite.suite, skipped, () {
      controller.setState(const State(Status.running, Result.success));
      controller.setState(const State(Status.running, Result.skipped));

      if (skipped.metadata.skipReason != null) {
        controller
            .message(new Message.skip("Skip: ${skipped.metadata.skipReason}"));
      }

      controller.setState(const State(Status.complete, Result.skipped));
      controller.completer.complete();
    }, () {}, groups: parents);

    return await _runLiveTest(suiteController, controller.liveTest);
  }

  /// Closes [liveTest] and tells the engine to re-run it once it's done
  /// running.
  ///
  /// Returns the same future as [LiveTest.close].
  Future restartTest(LiveTest liveTest) async {
    if (_activeLoadTests.contains(liveTest)) {
      throw new ArgumentError("Can't restart a load test.");
    }

    if (!_active.contains(liveTest)) {
      throw new StateError("Can't restart inactive test "
          "\"${liveTest.test.name}\".");
    }

    _restarted.add(liveTest);
    _active.remove(liveTest);
    await liveTest.close();
  }

  /// Runs [suite] and returns the [LiveSuiteController] for the suite it loads.
  ///
  /// Returns `null` if the suite fails to load.
  Future<LiveSuiteController> _addLoadSuite(LoadSuite suite) async {
    var controller = new LiveSuiteController(suite);
    _addLiveSuite(controller.liveSuite);

    var liveTest = suite.test.load(suite);
    _activeLoadTests.add(liveTest);

    // Only surface the load test if there are no other tests currently running.
    if (_active.isEmpty) _active.add(liveTest);

    StreamSubscription subscription;
    subscription = liveTest.onStateChange.listen((state) {
      if (state.status != Status.complete) return;
      _activeLoadTests.remove(liveTest);

      // Only one load test will be active at any given time, and it will always
      // be the only active test. Remove it and, if possible, surface another
      // load test.
      if (_active.isNotEmpty && _active.first.suite == suite) {
        _active.remove(liveTest);
        if (_activeLoadTests.isNotEmpty) _active.add(_activeLoadTests.last);
      }
    }, onDone: () {
      _subscriptions.remove(subscription);
    });
    _subscriptions.add(subscription);

    controller.reportLiveTest(liveTest, countSuccess: false);
    controller.noMoreLiveTests();

    // Schedule a microtask to ensure that [onTestStarted] fires before the
    // first [LiveTest.onStateChange] event.
    new Future.microtask(liveTest.run);

    var innerSuite = await suite.suite;
    if (innerSuite == null) return null;

    var innerController = new LiveSuiteController(innerSuite);
    innerController.liveSuite.onClose.then((_) {
      // When the main suite is closed, close the load suite and its test as
      // well. This doesn't release any resources, but it does close streams
      // which indicates that the load test won't experience an error in the
      // future.
      liveTest.close();
      controller.close();
    });

    return innerController;
  }

  /// Add [liveSuite] and the information it exposes to the engine's
  /// informational streams and collections.
  void _addLiveSuite(LiveSuite liveSuite) {
    _liveSuites.add(liveSuite);
    _onSuiteStartedController.add(liveSuite);

    _onTestStartedGroup.add(liveSuite.onTestStarted);
    _passedGroup.add(liveSuite.passed);
    _skippedGroup.add(liveSuite.skipped);
    _failedGroup.add(liveSuite.failed);
  }

  /// Pauses the engine.
  ///
  /// This pauses all streams and keeps any new suites from being loaded or
  /// tests from being run until [resume] is called.
  ///
  /// This does nothing if the engine is already paused. Pauses are *not*
  /// cumulative.
  void pause() {
    if (_pauseCompleter != null) return;
    _pauseCompleter = new Completer();
    for (var subscription in _subscriptions) {
      subscription.pause();
    }
  }

  void resume() {
    if (_pauseCompleter == null) return;
    _pauseCompleter.complete();
    _pauseCompleter = null;
    for (var subscription in _subscriptions) {
      subscription.resume();
    }
  }

  /// Signals that the caller is done paying attention to test results and the
  /// engine should release any resources it has allocated.
  ///
  /// Any actively-running tests are also closed. VM tests are allowed to finish
  /// running so that any modifications they've made to the filesystem can be
  /// cleaned up.
  ///
  /// **Note that closing the engine is not the same as closing [suiteSink].**
  /// Closing [suiteSink] indicates that no more input will be provided, closing
  /// the engine indicates that no more output should be emitted.
  Future close() async {
    _closed = true;
    if (_closedBeforeDone != null) _closedBeforeDone = true;
    _onSuiteAddedController.close();
    _suiteController.close();

    // Close the running tests first so that we're sure to wait for them to
    // finish before we close their suites and cause them to become unloaded.
    var allLiveTests = liveTests.toSet()..addAll(_activeLoadTests);
    var futures = allLiveTests.map((liveTest) => liveTest.close()).toList();

    // Closing the load pool will close the test suites as soon as their tests
    // are done. For browser suites this is effectively immediate since their
    // tests shut down as soon as they're closed, but for VM suites we may need
    // to wait for tearDowns or tearDownAlls to run.
    futures.add(_loadPool.close());
    await Future.wait(futures, eagerError: true);
  }
}
