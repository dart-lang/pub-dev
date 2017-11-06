// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:stream_channel/stream_channel.dart';

import '../../backend/test_platform.dart';
import '../configuration/suite.dart';
import '../environment.dart';
import '../runner_suite.dart';
import 'environment.dart';
import 'platform_helpers.dart';

/// A class that defines a platform for which test suites can be loaded.
///
/// A minimal plugin must define [platforms], which indicates the platforms it
/// supports, and [loadChannel], which connects to a client in which the tests
/// are defined. This is enough to support most of the test runner's
/// functionality.
///
/// In order to support interactive debugging, a plugin must override [load] as
/// well, which returns a [RunnerSuite] that can contain a custom [Environment]
/// and control debugging metadata such as [RunnerSuite.isDebugging] and
/// [RunnerSuite.onDebugging]. The plugin must create this suite by calling the
/// [deserializeSuite] helper function.
///
/// A platform plugin can be registered with [Loader.registerPlatformPlugin].
abstract class PlatformPlugin {
  /// Loads and establishes a connection with the test file at [path] using
  /// [platform].
  ///
  /// This returns a channel that's connected to a remote client. The client
  /// must connect it to a channel returned by [serializeGroup]. The default
  /// implementation of [load] will take care of wrapping it up in a
  /// [RunnerSuite] and running the tests when necessary.
  ///
  /// The returned channel may emit exceptions, indicating that the suite failed
  /// to load or crashed later on. If the channel is closed by the caller, that
  /// indicates that the suite is no longer needed and its resources may be
  /// released.
  ///
  /// The [platform] is guaranteed to be a member of [platforms].
  StreamChannel loadChannel(String path, TestPlatform platform);

  /// Loads the runner suite for the test file at [path] using [platform], with
  /// [suiteConfig] encoding the suite-specific configuration.
  ///
  /// By default, this just calls [loadChannel] and passes its result to
  /// [deserializeSuite]. However, it can be overridden to provide more
  /// fine-grained control over the [RunnerSuite], including providing a custom
  /// implementation of [Environment].
  ///
  /// Subclasses overriding this method must call [deserializeSuite] in
  /// `platform_helpers.dart` to obtain a [RunnerSuiteController]. They must
  /// pass the opaque [message] parameter to the [deserializeSuite] call.
  Future<RunnerSuite> load(String path, TestPlatform platform,
      SuiteConfiguration suiteConfig, Object message) async {
    // loadChannel may throw an exception. That's fine; it will cause the
    // LoadSuite to emit an error, which will be presented to the user.
    var channel = loadChannel(path, platform);
    var controller = await deserializeSuite(
        path, platform, suiteConfig, new PluginEnvironment(), channel, message);
    return controller.suite;
  }

  Future closeEphemeral() async {}

  Future close() async {}
}
