// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';

import '../asset/file_based.dart';
import '../asset/reader.dart';
import '../asset/writer.dart';
import '../package_graph/package_graph.dart';
import 'directory_watcher_factory.dart';

/// Manages setting up consistent defaults for all options and build modes.
class BuildOptions {
  // Build mode options.
  StreamSubscription logListener;
  PackageGraph packageGraph;
  RunnerAssetReader reader;
  RunnerAssetWriter writer;
  bool deleteFilesByDefault;

  /// Whether to write to a cache directory rather than the package's source
  /// directory.
  ///
  /// Enabling this option is the only way to allow builders to run against
  /// packages other than the root.
  bool writeToCache;

  // Watch mode options.
  Duration debounceDelay;
  DirectoryWatcherFactory directoryWatcherFactory;

  BuildOptions(
      {this.debounceDelay,
      this.deleteFilesByDefault,
      this.writeToCache,
      this.directoryWatcherFactory,
      Level logLevel,
      onLog(LogRecord record),
      this.packageGraph,
      this.reader,
      this.writer}) {
    /// Set up logging
    logLevel ??= Level.INFO;
    Logger.root.level = logLevel;
    logListener = Logger.root.onRecord.listen(onLog ?? _defaultLogListener);

    /// Set up other defaults.
    debounceDelay ??= const Duration(milliseconds: 250);
    packageGraph ??= new PackageGraph.forThisPackage();
    reader ??= new FileBasedAssetReader(packageGraph);
    writer ??= new FileBasedAssetWriter(packageGraph);
    directoryWatcherFactory ??= defaultDirectoryWatcherFactory;
    deleteFilesByDefault ??= writeToCache ?? false;
    writeToCache ??= false;
  }
}

final _cyan = _isPosixTerminal ? '\u001b[36m' : '';
final _yellow = _isPosixTerminal ? '\u001b[33m' : '';
final _red = _isPosixTerminal ? '\u001b[31m' : '';
final _endColor = _isPosixTerminal ? '\u001b[0m' : '';
final _isPosixTerminal =
    !Platform.isWindows && stdioType(stdout) == StdioType.TERMINAL;

void _defaultLogListener(LogRecord record) {
  var color;
  if (record.level < Level.WARNING) {
    color = _cyan;
  } else if (record.level < Level.SEVERE) {
    color = _yellow;
  } else {
    color = _red;
  }
  var header = '${_isPosixTerminal ? '\x1b[2K\r' : ''}'
      '$color[${record.level}]$_endColor ${record.loggerName}: '
      '${record.message}';
  var lines = <Object>[header];

  if (record.error != null) {
    lines.add(record.error);
  }

  if (record.stackTrace != null) {
    if (record.stackTrace is Trace) {
      lines.add((record.stackTrace as Trace).terse);
    } else {
      lines.add(record.stackTrace);
    }
  }

  var message = lines.join('\n');

  var multiLine = LineSplitter.split(message).length > 1;

  if (record.level > Level.INFO || !_isPosixTerminal || multiLine) {
    // Add an extra line to the output so the last line is written over.
    lines.add('');
    message = lines.join('\n');
  }

  if (record.level >= Level.SEVERE) {
    stderr.write(message);
  } else {
    stdout.write(message);
  }
}
