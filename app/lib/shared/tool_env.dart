// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:pana/pana.dart';

import 'configuration.dart';

const _maxCount = 100;

ToolEnvRef _current;

/// Tracks the temporary directory of the downloaded package cache with the
/// [ToolEnvironment] (that was initialized with that directory), along with its
/// use stats.
class ToolEnvRef {
  final Directory _pubCacheDir;
  final ToolEnvironment toolEnv;
  int _started = 0;
  int _active = 0;

  ToolEnvRef(this._pubCacheDir, this.toolEnv);

  void _aquire() {
    _started++;
    _active++;
  }

  Future release() async {
    _active--;
    if (_started >= _maxCount && _active == 0) {
      await _pubCacheDir.delete(recursive: true);
    }
  }
}

/// Gets a currently available [ToolEnvRef] if it is used less than the
/// configured threshold (_maxCount, currently 100). If it it has already
/// reached the amount, a new cache dir and environment will be created.
Future<ToolEnvRef> getOrCreateToolEnvRef() async {
  if (_current != null && _current._started < _maxCount) {
    _current._aquire();
    return _current;
  }
  final cacheDir = await Directory.systemTemp.createTemp('pub-cache-dir');
  final resolvedDirName = await cacheDir.resolveSymbolicLinks();
  final toolEnv = await ToolEnvironment.create(
    dartSdkDir: envConfig.toolEnvDartSdkDir,
    flutterSdkDir: envConfig.flutterSdkDir,
    pubCacheDir: resolvedDirName,
  );
  _current = new ToolEnvRef(cacheDir, toolEnv);
  _current._aquire();
  return _current;
}
