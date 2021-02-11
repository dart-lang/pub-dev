// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pana/pana.dart';

import 'configuration.dart';

final _logger = Logger('tool_env');

/// Subsequent calls of the analyzer or dartdoc job can use the same [_ToolEnvRef]
/// instance [_maxCount] times.
///
/// Until the limit is reached, the [_ToolEnvRef] will reuse the pub cache
/// directory for its `pub upgrade` calls, but once it is reached, the cache
/// will be deleted and a new [_ToolEnvRef] with a new directory will be created.
const _maxCount = 50;

/// Subsequent calls of the analyzer or dartdoc job can use the same [_ToolEnvRef]
/// instance up until its size reaches [_maxSize].
///
/// Until the limit is reached, the [_ToolEnvRef] will reuse the pub cache
/// directory for its `pub upgrade` calls, but once it is reached, the cache
/// will be deleted and a new [_ToolEnvRef] with a new directory will be created.
const _maxSize = 500 * 1024 * 1024; // 500 MB

/// Calls [fn] with the [ToolEnvironment], handling the lifecycle of the local
/// pub cache.
Future<R> withToolEnv<R>({
  @required bool usesPreviewSdk,
  @required Future<R> Function(ToolEnvironment toolEnv) fn,
}) async {
  _ToolEnvRef ref;
  try {
    ref = await _getOrCreateToolEnvRef();
    return await fn(usesPreviewSdk ? ref.preview : ref.stable);
  } finally {
    await ref?._release();
  }
}

/// The id of the next [_ToolEnvRef] to be created.
int _nextId = 0;

_ToolEnvRef _current;
Completer _ongoing;

/// Tracks the temporary directory of the downloaded package cache with the
/// [ToolEnvironment] (that was initialized with that directory), along with its
/// use stats.
///
/// The pub cache will be reused between `pub upgrade` calls, until the
/// [_maxCount] threshold is reached. The directory will be deleted once all of
/// the associated jobs complete.
class _ToolEnvRef {
  final Directory _pubCacheDir;
  final ToolEnvironment stable;
  final ToolEnvironment preview;
  final _id = _nextId++;
  int _started = 0;
  int _active = 0;
  bool _isAboveSizeLimit = false;

  _ToolEnvRef(this._pubCacheDir, this.stable, this.preview);

  bool get _isAvailable => _started < _maxCount && !_isAboveSizeLimit;

  void _acquire() {
    _started++;
    _active++;
    _logger
        .info('($_id) Tool env acquired. started: $_started, active: $_active');
  }

  Future<void> _release() async {
    _logger
        .info('($_id) Tool env released. started: $_started, active: $_active');
    await _checkSizeLimit();
    _active--;
    if (_active == 0) {
      // Delete directory if the instance is no longer active or it reached the
      // maximum threshold.
      if (_started >= _maxCount || _current != this) {
        _logger.info('($_id) Deleting pub cache dir: $_pubCacheDir');
        await _pubCacheDir.delete(recursive: true);
      }
    }
  }

  Future<void> _checkSizeLimit() async {
    if (_isAboveSizeLimit) return;
    int size = 0;
    await for (var fse in _pubCacheDir.list(recursive: true)) {
      if (fse is File) {
        size += await fse.length();
      }
    }
    _logger.info('($_id) Current size of pub cache dir: $size');
    _isAboveSizeLimit = size > _maxSize;
  }
}

/// Gets a currently available [_ToolEnvRef] if it is used less than the
/// configured threshold ([_maxCount]). If it it has already
/// reached the amount, a new cache dir and environment will be created.
Future<_ToolEnvRef> _getOrCreateToolEnvRef() async {
  _ToolEnvRef result;
  while (result == null) {
    if (_current != null && _current._isAvailable) {
      result = _current;
      result._acquire();
      break;
    }

    if (_ongoing != null) {
      await _ongoing.future;
      continue;
    }

    _ongoing = Completer();

    final cacheDir = await Directory.systemTemp.createTemp('pub-cache-dir');
    final resolvedDirName = await cacheDir.resolveSymbolicLinks();
    final stableToolEnv = await ToolEnvironment.create(
      dartSdkDir: envConfig.stableDartSdkDir,
      flutterSdkDir: envConfig.stableFlutterSdkDir,
      pubCacheDir: resolvedDirName,
      environment: {
        'FLUTTER_ROOT': envConfig.stableFlutterSdkDir,
      },
    );
    final previewToolEnv = await ToolEnvironment.create(
      dartSdkDir: envConfig.previewDartSdkDir,
      flutterSdkDir: envConfig.previewFlutterSdkDir,
      pubCacheDir: resolvedDirName,
      environment: {
        'FLUTTER_ROOT': envConfig.previewFlutterSdkDir,
      },
    );
    _current = _ToolEnvRef(cacheDir, stableToolEnv, previewToolEnv);
    result = _current;
    result._acquire();
    _ongoing.complete();
    _ongoing = null;
    break;
  }
  return result;
}
