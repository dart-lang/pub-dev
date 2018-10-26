// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:pana/pana.dart';
import 'package:path/path.dart' as p;

import 'configuration.dart';

/// Subsequent calls of the analyzer or dartdoc job can use the same [ToolEnvRef]
/// instance [_maxCount] times.
///
/// Until the limit is reached, the [ToolEnvRef] will reuse the pub cache
/// directory for its `pub upgrade` calls, but once it is reached, the cache
/// will be deleted and a new [ToolEnvRef] with a new directory will be created.
const _maxCount = 100;

ToolEnvRef _current;
Completer _ongoing;

/// Tracks the temporary directory of the downloaded package cache with the
/// [ToolEnvironment] (that was initialized with that directory), along with its
/// use stats.
///
/// The pub cache will be reused between `pub upgrade` calls, until the
/// [_maxCount] threshold is reached. The directory will be deleted once all of
/// the associated jobs complete.
class ToolEnvRef {
  final Directory _pubCacheDir;
  final ToolEnvironment toolEnv;
  final ToolEnvironment flutterEnv;
  int _started = 0;
  int _active = 0;

  ToolEnvRef(this._pubCacheDir, this.toolEnv, this.flutterEnv);

  void _aquire() {
    _started++;
    _active++;
  }

  Future release() async {
    _active--;
    if (_active == 0) {
      // Delete directory if the instance is no longer active or it reached the
      // maximum threshold.
      if (_started >= _maxCount || _current != this) {
        await _pubCacheDir.delete(recursive: true);
      }
    }
  }
}

/// Gets a currently available [ToolEnvRef] if it is used less than the
/// configured threshold ([_maxCount]). If it it has already
/// reached the amount, a new cache dir and environment will be created.
Future<ToolEnvRef> getOrCreateToolEnvRef() async {
  ToolEnvRef result;
  while (result == null) {
    if (_current != null && _current._started < _maxCount) {
      result = _current;
      result._aquire();
      break;
    }

    if (_ongoing != null) {
      await _ongoing.future;
      continue;
    }

    _ongoing = new Completer();

    final cacheDir = await Directory.systemTemp.createTemp('pub-cache-dir');
    final resolvedDirName = await cacheDir.resolveSymbolicLinks();
    final toolEnv = await ToolEnvironment.create(
      dartSdkDir: envConfig.toolEnvDartSdkDir,
      flutterSdkDir: envConfig.flutterSdkDir,
      pubCacheDir: resolvedDirName,
    );
    ToolEnvironment flutterEnv = toolEnv;
    if (envConfig.flutterSdkDir != null) {
      flutterEnv = await ToolEnvironment.create(
        dartSdkDir: p.join(envConfig.flutterSdkDir, 'bin', 'cache', 'dart-sdk'),
        flutterSdkDir: envConfig.flutterSdkDir,
        pubCacheDir: resolvedDirName,
      );
    }
    _current = new ToolEnvRef(cacheDir, toolEnv, flutterEnv);
    result = _current;
    result._aquire();
    _ongoing.complete();
    _ongoing = null;
    break;
  }
  return result;
}
