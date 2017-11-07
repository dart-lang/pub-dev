// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';

import 'package:async/async.dart';
import 'package:build/build.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:watcher/watcher.dart';

import '../logging/logging.dart';
import '../package_graph/package_graph.dart';
import 'directory_watcher_factory.dart';

class AssetChange {
  final AssetId id;
  final ChangeType type;
  AssetChange(this.id, this.type);
}

Stream<AssetChange> startFileWatchers(PackageGraph packageGraph, Logger logger,
    DirectoryWatcherFactory directoryWatcherFactory) {
  var completer = new StreamCompleter<AssetChange>();
  logWithTime(
      logger,
      'Setting up file watchers',
      () => _startFileWatchers(packageGraph, logger, directoryWatcherFactory)
          .then((stream) => completer.setSourceStream(stream)));
  return completer.stream;
}

Future<Stream<AssetChange>> _startFileWatchers(PackageGraph packageGraph,
    Logger logger, DirectoryWatcherFactory directoryWatcherFactory) async {
  var controller = new StreamController<AssetChange>();
  final watchers = <DirectoryWatcher>[];

  // Collect absolute file paths for all the packages. This needs to happen
  // before setting up the watchers.
  final absolutePackagePaths = <PackageNode, String>{};
  for (var package in packageGraph.allPackages.values) {
    absolutePackagePaths[package] =
        p.normalize(p.absolute(package.location.toFilePath()));
  }

  var listeners = <StreamSubscription>[];

  // Set up watchers for all the packages
  for (var package in packageGraph.allPackages.values) {
    var absolutePackagePath = absolutePackagePaths[package];
    logger.fine('Setting up watcher at $absolutePackagePath');

    // Ignore all subfolders which are other packages.
    var pathsToIgnore = absolutePackagePaths.values
        .where((path) =>
            path != absolutePackagePath && path.startsWith(absolutePackagePath))
        .toList();

    var watcher = directoryWatcherFactory(absolutePackagePath);
    watchers.add(watcher);
    listeners.add(watcher.events.listen((WatchEvent e) {
      var changePath = _normalizeChangePath(
          e.path, absolutePackagePaths, logger, packageGraph);
      if (changePath == null) return;

      // Check for ignored paths and immediately bail.
      if (pathsToIgnore.any((path) => p.isWithin(path, changePath))) return;

      var relativePath = p.relative(changePath, from: absolutePackagePath);
      logger.finest(
          'Got ${e.type} event for path $relativePath from ${watcher.path}');
      var id = new AssetId(package.name, relativePath);

      controller.add(new AssetChange(id, e.type));
    }));
  }

  await Future.wait(watchers.map((w) => w.ready));
  controller.onCancel = () => Future.wait(listeners.map((l) => l.cancel()));
  return controller.stream;
}

// Convert `packages` paths to absolute paths. Returns null if it finds an
// invalid package path.
String _normalizeChangePath(
    String changePath,
    Map<PackageNode, String> absolutePackagePaths,
    Logger logger,
    PackageGraph packageGraph) {
  var changePathParts = p.split(changePath);
  var packagesIndex = changePathParts.indexOf('packages');
  if (packagesIndex == -1) return changePath;

  if (changePathParts.length < packagesIndex + 2) {
    logger.severe('Invalid change path: $changePath');
    return null;
  }

  var packageName = changePathParts[packagesIndex + 1];
  var packageNode = packageGraph[packageName];
  if (packageNode == null) {
    logger.severe('Got update for invalid package: $packageName');
    return null;
  }
  var packagePath = absolutePackagePaths[packageNode];
  var libPath =
      p.joinAll(['lib']..addAll(changePathParts.skip(packagesIndex + 2)));
  return p.join(packagePath, libPath);
}
