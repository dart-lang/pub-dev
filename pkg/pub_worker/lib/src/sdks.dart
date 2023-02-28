// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart' show Version, VersionConstraint;

@sealed
class InstalledSdk {
  final String path;
  final Version version;
  final String kind;
  InstalledSdk(this.kind, this.path, this.version);

  @override
  String toString() => 'InstalledSdk($kind, $version, $path)';

  /// List SDKs installed into [path].
  ///
  /// This looks for sub-folders containing `version` files.
  static Future<List<InstalledSdk>> fromDirectory({
    required String kind,
    required Directory path,
  }) async {
    final sdks = <InstalledSdk>[];
    if (!await path.exists()) {
      return sdks;
    }
    await for (final d in path.list()) {
      if (d is! Directory) {
        continue;
      }
      try {
        final v = await File(p.join(d.path, 'version')).readAsString();
        sdks.add(InstalledSdk(kind, d.path, Version.parse(v.trim())));
      } on FormatException {
        continue;
      } on IOException {
        continue;
      }
    }
    sdks.sortByCompare((s) => s.version, Version.prioritize);
    return sdks;
  }

  static InstalledSdk? prioritizedSdk(
    List<InstalledSdk> sdks,
    VersionConstraint? constraint,
  ) {
    constraint ??= VersionConstraint.any;
    sdks = [...sdks]..sortByCompare((s) => s.version, Version.prioritize);
    return sdks.where((s) => constraint!.allows(s.version)).lastOrNull ??
        maxBy(sdks, (s) => s.version);
  }

  static InstalledSdk futureSdk(List<InstalledSdk> sdks) {
    sdks = [...sdks]..sort((a, b) => a.version.compareTo(b.version));
    return sdks.last;
  }
}
