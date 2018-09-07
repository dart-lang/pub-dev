// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:pana/pana.dart';

import 'configuration.dart';

const _maxCount = 100;

ToolEnvRef _current;

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

Future<ToolEnvRef> createToolEnvRef() async {
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
