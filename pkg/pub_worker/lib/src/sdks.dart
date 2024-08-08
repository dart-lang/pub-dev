// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart' show Version;

@sealed
class InstalledSdk {
  final String kind;
  final String path;
  final Version version;
  final Version? embeddedDartSdkVersion;
  InstalledSdk(this.kind, this.path, this.version, this.embeddedDartSdkVersion);

  @override
  String toString() => 'InstalledSdk($kind, $version, $path)';

  /// List SDKs installed into [path].
  ///
  /// This looks for sub-folders containing `version` files.
  static Future<List<InstalledSdk>> scanDirectory({
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
        // all SDKs have bin/ directory
        final binDir = Directory(p.join(d.path, 'bin'));
        if (!(await binDir.exists())) {
          continue;
        }
        // only Dart SDK has lib/
        // only Flutter SDK has packages/
        if (kind == 'dart') {
          final libDir = Directory(p.join(d.path, 'lib'));
          if (!(await libDir.exists())) {
            continue;
          }
        } else if (kind == 'flutter') {
          final packagesDir = Directory(p.join(d.path, 'packages'));
          if (!(await packagesDir.exists())) {
            continue;
          }
        }

        sdks.add(await fromDirectory(kind: kind, path: d.path));
      } on FormatException {
        continue;
      } on IOException {
        continue;
      }
    }
    sdks.sortByCompare((s) => s.version, Version.prioritize);
    return sdks;
  }

  static Future<InstalledSdk> fromDirectory({
    required String kind,
    required String path,
  }) async {
    final v = await File(p.join(path, 'version')).readAsString();
    Version? embeddedDartSdkVersion;
    if (kind == 'flutter') {
      final embeddedFile =
          File(p.join(path, 'bin', 'cache', 'dart-sdk', 'version'));
      if (await embeddedFile.exists()) {
        final embeddedValue = await embeddedFile.readAsString();
        embeddedDartSdkVersion =
            Version.parse(embeddedValue.split(' ').first.trim());
      }
    }
    return InstalledSdk(
        kind, path, Version.parse(v.trim()), embeddedDartSdkVersion);
  }
}
