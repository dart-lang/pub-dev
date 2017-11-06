// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:stack_trace/stack_trace.dart';

import '../../test.dart';
import '../backend/group.dart';
import '../backend/invoker.dart';
import '../backend/metadata.dart';
import '../backend/suite.dart';
import '../backend/test.dart';
import '../backend/test_platform.dart';
import '../utils.dart';
import 'configuration/suite.dart';
import 'load_exception.dart';
import 'plugin/environment.dart';
import 'runner_suite.dart';

/// A [Suite] emitted by a [Loader] that provides a test-like interface for
/// loading a test file.
///
/// This is used to expose the current status of test loading to the user. It's
/// important to provide users visibility into what's taking a long time and
/// where failures occur. And since some tests may be loaded at the same time as
/// others are run, it's useful to provide that visibility in the form of a test
/// suite so that it can integrate well into the existing reporting interface
/// without too much extra logic.
///
/// A suite is constructed with logic necessary to produce a test suite. As with
/// a normal test body, this logic isn't run until [LiveTest.run] is called. The
/// suite itself is returned by [suite] once it's avaialble, but any errors or
/// prints will be emitted through the running [LiveTest].
class LoadSuite extends Suite implements RunnerSuite {
  final environment = const PluginEnvironment();
  final SuiteConfiguration config;
  final isDebugging = false;
  final onDebugging = new StreamController<bool>().stream;

  /// A future that completes to the loaded suite once the suite's test has been
  /// run and completed successfully.
  ///
  /// This will return `null` if the suite is unavailable for some reason (for
  /// example if an error occurred while loading it).
  Future<RunnerSuite> get suite async => (await _suiteAndZone)?.first;

  /// A future that completes to a pair of [suite] and the load test's [Zone].
  ///
  /// This will return `null` if the suite is unavailable for some reason (for
  /// example if an error occurred while loading it).
  final Future<Pair<RunnerSuite, Zone>> _suiteAndZone;

  /// Returns the test that loads the suite.
  ///
  /// Load suites are guaranteed to only contain one test. This is a utility
  /// method for accessing it directly.
  Test get test => this.group.entries.single as Test;

  /// Creates a load suite named [name] on [platform].
  ///
  /// [body] may return either a [RunnerSuite] or a [Future] that completes to a
  /// [RunnerSuite]. Its return value is forwarded through [suite], although if
  /// it throws an error that will be forwarded through the suite's test.
  ///
  /// If the the load test is closed before [body] is complete, it will close
  /// the suite returned by [body] once it completes.
  factory LoadSuite(
      String name, SuiteConfiguration config, FutureOr<RunnerSuite> body(),
      {String path, TestPlatform platform}) {
    var completer = new Completer<Pair<RunnerSuite, Zone>>.sync();
    return new LoadSuite._(name, config, () {
      var invoker = Invoker.current;
      invoker.addOutstandingCallback();

      invoke(() async {
        try {
          var suite = await body();
          if (completer.isCompleted) {
            // If the load test has already been closed, close the suite it
            // generated.
            suite?.close();
            return;
          }

          completer
              .complete(suite == null ? null : new Pair(suite, Zone.current));
          invoker.removeOutstandingCallback();
        } catch (error, stackTrace) {
          registerException(error, stackTrace);
          if (!completer.isCompleted) completer.complete();
        }
      });

      // If the test is forcibly closed, exit immediately. It doesn't have any
      // cleanup to do that won't be handled by Loader.close.
      invoker.onClose.then((_) {
        if (completer.isCompleted) return;
        completer.complete();
        invoker.removeOutstandingCallback();
      });
    }, completer.future, path: path, platform: platform);
  }

  /// A utility constructor for a load suite that just throws [exception].
  ///
  /// The suite's name will be based on [exception]'s path.
  factory LoadSuite.forLoadException(
      LoadException exception, SuiteConfiguration config,
      {StackTrace stackTrace, TestPlatform platform}) {
    if (stackTrace == null) stackTrace = new Trace.current();

    return new LoadSuite(
        "loading ${exception.path}",
        config ?? SuiteConfiguration.empty,
        () => new Future.error(exception, stackTrace),
        path: exception.path,
        platform: platform);
  }

  /// A utility constructor for a load suite that just emits [suite].
  factory LoadSuite.forSuite(RunnerSuite suite) {
    return new LoadSuite("loading ${suite.path}", suite.config, () => suite,
        path: suite.path, platform: suite.platform);
  }

  LoadSuite._(String name, this.config, void body(), this._suiteAndZone,
      {String path, TestPlatform platform})
      : super(
            new Group.root([
              new LocalTest(
                  name,
                  new Metadata(timeout: new Timeout(new Duration(minutes: 5))),
                  body)
            ]),
            path: path,
            platform: platform);

  /// A constructor used by [changeSuite].
  LoadSuite._changeSuite(LoadSuite old, this._suiteAndZone)
      : config = old.config,
        super(old.group, path: old.path, platform: old.platform);

  /// A constructor used by [filter].
  LoadSuite._filtered(LoadSuite old, Group filtered)
      : config = old.config,
        _suiteAndZone = old._suiteAndZone,
        super(old.group, path: old.path, platform: old.platform);

  /// Creates a new [LoadSuite] that's identical to this one, but that
  /// transforms [suite] once it's loaded.
  ///
  /// If [suite] completes to `null`, [change] won't be run. [change] is run
  /// within the load test's zone, so any errors or prints it emits will be
  /// associated with that test.
  LoadSuite changeSuite(RunnerSuite change(RunnerSuite suite)) {
    return new LoadSuite._changeSuite(this, _suiteAndZone.then((pair) {
      if (pair == null) return null;

      var zone = pair.last;
      var newSuite;
      zone.runGuarded(() {
        newSuite = change(pair.first);
      });
      return newSuite == null ? null : new Pair(newSuite, zone);
    }));
  }

  /// Runs the test and returns the suite.
  ///
  /// Rather than emitting errors through a [LiveTest], this just pipes them
  /// through the return value.
  Future<RunnerSuite> getSuite() async {
    var liveTest = test.load(this);
    liveTest.onMessage.listen((message) => print(message.text));
    await liveTest.run();

    if (liveTest.errors.isEmpty) return await suite;

    var error = liveTest.errors.first;
    await new Future.error(error.error, error.stackTrace);
    throw 'unreachable';
  }

  LoadSuite filter(bool callback(Test test)) {
    var filtered = this.group.filter(callback);
    if (filtered == null) filtered = new Group.root([], metadata: metadata);
    return new LoadSuite._filtered(this, filtered);
  }

  Future close() async {}
}
