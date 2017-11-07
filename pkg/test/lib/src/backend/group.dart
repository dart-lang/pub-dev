// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:stack_trace/stack_trace.dart';

import 'group_entry.dart';
import 'metadata.dart';
import 'operating_system.dart';
import 'test.dart';
import 'test_platform.dart';

/// A group contains one or more tests and subgroups.
///
/// It includes metadata that applies to all contained tests.
class Group implements GroupEntry {
  final String name;

  final Metadata metadata;

  final Trace trace;

  /// The children of this group.
  final List<GroupEntry> entries;

  /// Returns a new root-level group.
  Group.root(Iterable<GroupEntry> entries, {Metadata metadata})
      : this(null, entries, metadata: metadata);

  /// A test to run before all tests in the group.
  ///
  /// This is `null` if no `setUpAll` callbacks were declared.
  final Test setUpAll;

  /// A test to run after all tests in the group.
  ///
  /// This is `null` if no `tearDown` callbacks were declared.
  final Test tearDownAll;

  /// The number of tests (recursively) in this group.
  int get testCount {
    if (_testCount != null) return _testCount;
    _testCount = entries.fold(
        0, (count, entry) => count + (entry is Group ? entry.testCount : 1));
    return _testCount;
  }

  int _testCount;

  Group(this.name, Iterable<GroupEntry> entries,
      {Metadata metadata, this.trace, this.setUpAll, this.tearDownAll})
      : entries = new List<GroupEntry>.unmodifiable(entries),
        metadata = metadata == null ? new Metadata() : metadata;

  Group forPlatform(TestPlatform platform, {OperatingSystem os}) {
    if (!metadata.testOn.evaluate(platform, os: os)) return null;
    var newMetadata = metadata.forPlatform(platform, os: os);
    var filtered = _map((entry) => entry.forPlatform(platform, os: os));
    if (filtered.isEmpty && entries.isNotEmpty) return null;
    return new Group(name, filtered,
        metadata: newMetadata,
        trace: trace,
        setUpAll: setUpAll,
        tearDownAll: tearDownAll);
  }

  Group filter(bool callback(Test test)) {
    var filtered = _map((entry) => entry.filter(callback));
    if (filtered.isEmpty && entries.isNotEmpty) return null;
    return new Group(name, filtered,
        metadata: metadata,
        trace: trace,
        setUpAll: setUpAll,
        tearDownAll: tearDownAll);
  }

  /// Returns the entries of this group mapped using [callback].
  ///
  /// Any `null` values returned by [callback] will be removed.
  List<GroupEntry> _map(GroupEntry callback(GroupEntry entry)) {
    return entries
        .map((entry) => callback(entry))
        .where((entry) => entry != null)
        .toList();
  }
}
