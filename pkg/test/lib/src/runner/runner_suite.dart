// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:async/async.dart';

import '../backend/group.dart';
import '../backend/operating_system.dart';
import '../backend/suite.dart';
import '../backend/test.dart';
import '../backend/test_platform.dart';
import '../utils.dart';
import 'configuration/suite.dart';
import 'environment.dart';

/// A suite produced and consumed by the test runner that has runner-specific
/// logic and lifecycle management.
///
/// This is separated from [Suite] because the backend library (which will
/// eventually become its own package) is primarily for test code itself to use,
/// for which the [RunnerSuite] APIs don't make sense.
///
/// A [RunnerSuite] can be produced and controlled using a
/// [RunnerSuiteController].
class RunnerSuite extends Suite {
  final RunnerSuiteController _controller;

  /// The environment in which this suite runs.
  Environment get environment => _controller._environment;

  /// The configuration for this suite.
  SuiteConfiguration get config => _controller._config;

  /// Whether the suite is paused for debugging.
  ///
  /// When using a dev inspector, this may also mean that the entire browser is
  /// paused.
  bool get isDebugging => _controller._isDebugging;

  /// A broadcast stream that emits an event whenever the suite is paused for
  /// debugging or resumed afterwards.
  ///
  /// The event is `true` when debugging starts and `false` when it ends.
  Stream<bool> get onDebugging => _controller._onDebuggingController.stream;

  /// A shortcut constructor for creating a [RunnerSuite] that never goes into
  /// debugging mode.
  factory RunnerSuite(
      Environment environment, SuiteConfiguration config, Group group,
      {String path,
      TestPlatform platform,
      OperatingSystem os,
      AsyncFunction onClose}) {
    var controller = new RunnerSuiteController(environment, config, group,
        path: path, platform: platform, os: os, onClose: onClose);
    return controller.suite;
  }

  RunnerSuite._(this._controller, Group group, String path,
      TestPlatform platform, OperatingSystem os)
      : super(group, path: path, platform: platform, os: os);

  RunnerSuite filter(bool callback(Test test)) {
    var filtered = group.filter(callback);
    filtered ??= new Group.root([], metadata: metadata);
    return new RunnerSuite._(_controller, filtered, path, platform, os);
  }

  /// Closes the suite and releases any resources associated with it.
  Future close() => _controller._close();
}

/// A class that exposes and controls a [RunnerSuite].
class RunnerSuiteController {
  /// The suite controlled by this controller.
  RunnerSuite get suite => _suite;
  RunnerSuite _suite;

  /// The backing value for [suite.environment].
  final Environment _environment;

  /// The configuration for this suite.
  final SuiteConfiguration _config;

  /// The function to call when the suite is closed.
  final AsyncFunction _onClose;

  /// The backing value for [suite.isDebugging].
  bool _isDebugging = false;

  /// The controller for [suite.onDebugging].
  final _onDebuggingController = new StreamController<bool>.broadcast();

  RunnerSuiteController(this._environment, this._config, Group group,
      {String path,
      TestPlatform platform,
      OperatingSystem os,
      AsyncFunction onClose})
      : _onClose = onClose {
    _suite = new RunnerSuite._(this, group, path, platform, os);
  }

  /// Sets whether the suite is paused for debugging.
  ///
  /// If this is different than [suite.isDebugging], this will automatically
  /// send out an event along [suite.onDebugging].
  void setDebugging(bool debugging) {
    if (debugging == _isDebugging) return;
    _isDebugging = debugging;
    _onDebuggingController.add(debugging);
  }

  /// The backing function for [suite.close].
  Future _close() => _closeMemo.runOnce(() async {
        _onDebuggingController.close();
        if (_onClose != null) await _onClose();
      });
  final _closeMemo = new AsyncMemoizer();
}
