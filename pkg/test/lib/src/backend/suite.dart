// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'group.dart';
import 'metadata.dart';
import 'operating_system.dart';
import 'test.dart';
import 'test_platform.dart';

/// A test suite.
///
/// A test suite is a set of tests that are intended to be run together and that
/// share default configuration.
class Suite {
  /// The platform on which the suite is running, or `null` if that platform is
  /// unknown.
  final TestPlatform platform;

  /// The operating system on which the suite is running, or `null` if that
  /// operating system is unknown.
  ///
  /// This will always be `null` if [platform] is `null`.
  final OperatingSystem os;

  /// The path to the Dart test suite, or `null` if that path is unknown.
  final String path;

  /// The metadata associated with this test suite.
  ///
  /// This is a shortcut for [group.metadata].
  Metadata get metadata => group.metadata;

  /// The top-level group for this test suite.
  final Group group;

  /// Creates a new suite containing [entires].
  ///
  /// If [platform] and/or [os] are passed, [group] is filtered to match that
  /// platform information.
  ///
  /// If [os] is passed without [platform], throws an [ArgumentError].
  Suite(Group group, {this.path, TestPlatform platform, OperatingSystem os})
      : platform = platform,
        os = os,
        group = _filterGroup(group, platform, os);

  /// Returns [entries] filtered according to [platform] and [os].
  ///
  /// Gracefully handles [platform] being null.
  static Group _filterGroup(
      Group group, TestPlatform platform, OperatingSystem os) {
    if (platform == null && os != null) {
      throw new ArgumentError.value(
          null, "os", "If os is passed, platform must be passed as well");
    }

    if (platform == null) return group;
    var filtered = group.forPlatform(platform, os: os);
    if (filtered != null) return filtered;
    return new Group.root([], metadata: group.metadata);
  }

  /// Returns a new suite with all tests matching [test] removed.
  ///
  /// Unlike [GroupEntry.filter], this never returns `null`. If all entries are
  /// filtered out, it returns an empty suite.
  Suite filter(bool callback(Test test)) {
    var filtered = group.filter(callback);
    if (filtered == null) filtered = new Group.root([], metadata: metadata);
    return new Suite(filtered, platform: platform, os: os, path: path);
  }
}
