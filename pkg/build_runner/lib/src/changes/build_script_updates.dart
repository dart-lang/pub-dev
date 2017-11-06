// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'dart:mirrors';

import 'package:build/build.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;

import '../asset/reader.dart';
import '../generate/options.dart';

class BuildScriptUpdates {
  final RunnerAssetReader _reader;
  final _logger = new Logger('BuildScriptUpdates');

  BuildScriptUpdates(BuildOptions options) : _reader = options.reader;

  /// Checks if the current running program has been updated since [time].
  Future<bool> isNewerThan(DateTime time) async {
    var urisInUse = currentMirrorSystem().libraries.keys;
    var updateTimes = await Future.wait(urisInUse.map(_uriUpdateTime));
    return updateTimes.any((u) => u.isAfter(time));
  }

  Future<DateTime> _uriUpdateTime(Uri uri) async {
    switch (uri.scheme) {
      case 'dart':
        return new DateTime.fromMillisecondsSinceEpoch(0);
      case 'package':
        var parts = uri.pathSegments;
        var id = new AssetId(parts[0],
            path.url.joinAll(['lib']..addAll(parts.getRange(1, parts.length))));
        return _reader.lastModified(id);
      case 'file':

        // TODO(jakemac): Probably shouldn't use dart:io directly, but its
        // definitely the easiest solution and should be fine.
        var file = new File.fromUri(uri);
        return file.lastModified();
      case 'data':

        // Test runner uses a `data` scheme, don't invalidate for those.
        if (uri.path.contains('package:test')) {
          return new DateTime.fromMillisecondsSinceEpoch(0);
        }
    }
    _logger.info('Unsupported uri scheme `${uri.scheme}` found for '
        'library in build script, falling back on full rebuild. '
        '\nThis probably means you are running in an unsupported '
        'context, such as in an isolate or via `pub run`. Instead you '
        'should invoke this script directly like: '
        '`dart path_to_script.dart`.');
    return new DateTime.now();
  }
}
