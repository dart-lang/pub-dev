// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:collection';

import '../../backend/test_platform.dart';
import '../../utils.dart';
import 'platform.dart';

/// The functions to use to load [_platformPlugins] in all loaders.
///
/// **Do not access this outside the test package**.
final platformCallbacks =
    new UnmodifiableMapView<TestPlatform, AsyncFunction>(_platformCallbacks);
final _platformCallbacks = <TestPlatform, AsyncFunction>{};

/// **Do not call this function without express permission from the test package
/// authors**.
///
/// Registers a [PlatformPlugin] for [platforms].
///
/// This globally registers a plugin for all [Loader]s. When the runner first
/// requests that a suite be loaded for one of the given platforms, this will
/// call [getPlugin] to load the platform plugin. It may return either a
/// [PlatformPlugin] or a [Future<PlatformPlugin>]. That plugin is then
/// preserved and used to load all suites for all matching platforms.
///
/// This overwrites the default plugins for those platforms.
void registerPlatformPlugin(Iterable<TestPlatform> platforms, getPlugin()) {
  for (var platform in platforms) {
    _platformCallbacks[platform] = getPlugin;
  }
}
