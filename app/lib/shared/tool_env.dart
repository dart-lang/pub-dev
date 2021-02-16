// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pana/pana.dart';
import 'package:pool/pool.dart';

import 'configuration.dart';

final _logger = Logger('tool_env');

/// Subsequent calls of the analyzer or dartdoc job can use the same [_ToolEnvRef]
/// instance [_maxCount] times.
///
/// Until the limit is reached, the [_ToolEnvRef] will reuse the pub cache
/// directory for its `pub upgrade` calls, but once it is reached, the cache
/// will be deleted and a new [_ToolEnvRef] with a new directory will be created.
const _maxCount = 100;

/// Subsequent calls of the analyzer or dartdoc job can use the same [_ToolEnvRef]
/// instance up until its size reaches [_maxSize].
///
/// Until the limit is reached, the [_ToolEnvRef] will reuse the pub cache
/// directory for its `pub upgrade` calls, but once it is reached, the cache
/// will be deleted and a new [_ToolEnvRef] with a new directory will be created.
const _maxSize = 500 * 1024 * 1024; // 500 MB

/// The id of the next [_ToolEnvRef] to be created.
int _nextId = 0;

/// The base temp directory for tool env.
final _toolEnvTempDir = Directory.systemTemp.createTempSync('tool-env');

/// Forcing callback processing into a single thread.
final _pool = Pool(1);

// The cached values of directory sizes (path -> size in bytes).
Map<String, int> _sizes;

_ToolEnvRef _current;

/// Calls [fn] with the [ToolEnvironment], handling the lifecycle of the local
/// pub cache.
Future<R> withToolEnv<R>({
  @required bool usesPreviewSdk,
  @required Future<R> Function(ToolEnvironment toolEnv) fn,
}) async {
  return await _pool.withResource(() async {
    if (_current != null && !_current._isAvailable) {
      await _current?._cleanup();
      _current = null;
    }
    if (_current == null) {
      final sizes = await _calcSubdirSizes([
        Directory.systemTemp,
        Directory('/tmp'),
        Directory('/var'),
        Directory('/tool'),
      ]);
      _logSpecialDirSizes(sizes);
      _logChanges(_sizes, sizes);
      _sizes = sizes;
    }
    _current ??= await _createToolEnvRef();
    _current._started++;
    try {
      return await fn(usesPreviewSdk ? _current.preview : _current.stable);
    } finally {
      await _current._checkSizeLimit();
    }
  });
}

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
  bool _isAboveSizeLimit = false;

  _ToolEnvRef(this._pubCacheDir, this.stable, this.preview);

  bool get _isAvailable => _started < _maxCount && !_isAboveSizeLimit;

  Future<void> _cleanup() async {
    _logger.info('($_id) Deleting pub cache dir: $_pubCacheDir');
    await _pubCacheDir.delete(recursive: true);
  }

  Future<void> _checkSizeLimit() async {
    if (_isAboveSizeLimit) return;
    final size = await _calcDirectorySize(_pubCacheDir);
    _logger.info('($_id) Current size of pub cache dir: $size');
    _isAboveSizeLimit = size > _maxSize;
  }
}

/// Creates a new [_ToolEnvRef] with a new pub cache dir.
Future<_ToolEnvRef> _createToolEnvRef() async {
  _logger.info('Creating new tool env');
  final cacheDir = await _toolEnvTempDir.createTemp('pub-cache-dir');
  final resolvedDirName = await cacheDir.resolveSymbolicLinks();
  final stableToolEnv = await ToolEnvironment.create(
    dartSdkDir: envConfig.stableDartSdkDir,
    flutterSdkDir: envConfig.stableFlutterSdkDir,
    pubCacheDir: resolvedDirName,
    environment: {
      'CI': 'true',
      'FLUTTER_ROOT': envConfig.stableFlutterSdkDir,
    },
  );
  final previewToolEnv = await ToolEnvironment.create(
    dartSdkDir: envConfig.previewDartSdkDir,
    flutterSdkDir: envConfig.previewFlutterSdkDir,
    pubCacheDir: resolvedDirName,
    environment: {
      'CI': 'true',
      'FLUTTER_ROOT': envConfig.previewFlutterSdkDir,
    },
  );
  await _gitGc(envConfig.stableFlutterSdkDir);
  await _gitGc(envConfig.previewFlutterSdkDir);
  return _ToolEnvRef(cacheDir, stableToolEnv, previewToolEnv);
}

Future<void> _gitGc(String path) async {
  if (path != null &&
      Directory(path).existsSync() &&
      Directory('$path/.git').existsSync()) {
    await runProc('git', ['gc'], workingDirectory: path);
  }
}

Future<int> _calcDirectorySize(Directory dir) async {
  int size = 0;
  if (dir.existsSync()) {
    await for (var fse in dir.list(recursive: true)) {
      if (fse is File) {
        try {
          size += await fse.length();
        } catch (_) {
          // unable to read file size, permission missing
        }
      }
    }
  }
  return size;
}

Future<Map<String, int>> _calcSubdirSizes(Iterable<Directory> dirs) async {
  final results = <String, int>{};
  final sw = Stopwatch()..start();
  for (final dir in dirs) {
    if (dir.existsSync()) {
      // filter duplicate directories
      if (results.containsKey(dir.path)) continue;

      // TODO: optimize this for a single directory scan
      final subdirs = [
        dir,
        ...dir.listSync(recursive: true).whereType<Directory>(),
      ];
      for (final sd in subdirs) {
        results[sd.path] = await _calcDirectorySize(sd);
      }
    } else {
      _logger.info('No $dir directory');
    }
  }
  _logger.info('Directory sizes scanned in ${sw.elapsed}');
  return results;
}

void _logSpecialDirSizes(Map<String, int> sizes) {
  final specials = <String>[
    '/tool/stable/dart-sdk',
    '/tool/stable/flutter',
    '/tool/preview/dart-sdk',
    '/tool/preview/flutter',
  ];
  for (final path in specials) {
    if (sizes.containsKey(path)) {
      _logger.info('Directory size of $path: ${sizes[path]}');
    }
  }
}

void _logChanges(Map<String, int> old, Map<String, int> current) {
  if (old == null) return;
  final paths = (<String>{...old.keys, ...current.keys}).toList()..sort();
  for (final path in paths) {
    final ov = old[path] ?? 0;
    final nv = current[path] ?? 0;

    final diff = nv - ov;
    if (diff == 0) continue;

    _logger.info('Directory size changed: $path $ov -> $nv ($diff)');
  }
}
