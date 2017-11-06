// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';
import 'dart:mirrors';

import 'package:build/build.dart';
import 'package:build_runner/build_runner.dart';
import 'package:build_test/build_test.dart';
import 'package:glob/glob.dart';

class InMemoryRunnerAssetReader extends InMemoryAssetReader
    implements RunnerAssetReader {
  InMemoryRunnerAssetReader(
      [Map<AssetId, DatedValue> sourceAssets, String rootPackage])
      : super(sourceAssets: sourceAssets, rootPackage: rootPackage);

  @override
  Iterable<AssetId> findAssets(Glob glob, {String packageName}) {
    packageName ??= rootPackage;
    return assets.keys
        .where((id) => id.package == packageName && glob.matches(id.path));
  }

  final Map<Uri, LibraryMirror> _allLibraries = currentMirrorSystem().libraries;

  @override
  Future<DateTime> lastModified(AssetId id) async {
    if (!assets.containsKey(id)) {
      /// Support reading files imported by the test script as well. Also
      /// pretend like they are very old so that builds don't get invalidated.
      ///
      /// Overridden values in [assets] will take precedence.
      var uri = new Uri(
          scheme: 'package',
          path: '${id.package}/${id.path.replaceFirst("lib/", "")}');
      if (_allLibraries[uri] != null) {
        return new DateTime.fromMillisecondsSinceEpoch(0);
      }

      throw new AssetNotFoundException(id);
    }

    return assets[id].date;
  }
}
