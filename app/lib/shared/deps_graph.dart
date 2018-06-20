// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:logging/logging.dart';

import 'package:pub_dartlang_org/frontend/models.dart';

import 'utils.dart' show StringInternPool;

final Logger _logger = new Logger('pub.package_graph');

// TODO(kustermann): We could incorporate the pubspec constraints to make the
// sets smaller.
class TransitiveDependencyGraph {
  final Map<String, Set<String>> _deps = <String, Set<String>>{};

  void addAll(String node, Set<String> deps) {
    final nodes = _deps.putIfAbsent(node, _newSet);
    final int before = nodes.length;
    nodes.addAll(deps);
    if (before != nodes.length) {
      _fixpointNode(node);
    }
  }

  void add(String node, String dep) {
    if (_deps.putIfAbsent(node, _newSet).add(dep)) {
      _fixpointNode(node);
    }
  }

  Set<String> transitiveNodes(String node) => _deps.putIfAbsent(node, _newSet);

  void _fixpointNode(String node) {
    final Set<String> directs = _deps[node];
    final temp = <Set<String>>[];
    for (;;) {
      final int before = directs.length;
      temp.clear();
      for (final String direct in directs) {
        if (node != direct) {
          final Set<String> transitives = _deps[direct];
          if (transitives?.isNotEmpty == true) {
            temp.add(transitives);
          }
        }
      }
      for (final Set<String> transitives in temp) {
        directs.addAll(transitives);
      }
      if (before == directs.length) break;
    }
  }

  static Set<String> _newSet() => new Set<String>();
}

class PackageDependencyBuilder {
  static const Duration pollingInterval = const Duration(seconds: 10);
  static const String devPrefix = 'dev/';

  final DatastoreDB db;

  final TransitiveDependencyGraph reverseDeps = new TransitiveDependencyGraph();
  final String Function(String) _intern = new StringInternPool().intern;

  DateTime _lastTs;

  static Future<PackageDependencyBuilder> loadInitialGraphFromDb(
      DatastoreDB db) async {
    final sw = new Stopwatch()..start();
    final builder = new PackageDependencyBuilder._(db);
    await builder.scanExistingPackageGraph();
    if (sw.elapsed.inMinutes >= 1) {
      _logger.warning('Scanned initial dependency graph in ${sw.elapsed}.');
    }
    builder.monitorInBackground();
    return builder;
  }

  PackageDependencyBuilder._(this.db);

  Future scanExistingPackageGraph() async {
    final sw = new Stopwatch()..start();
    for (;;) {
      _logger.info('Scanning existing package graph');
      try {
        // We scan from oldest to newest and therefore keep [_lastTs] always
        // increasing.
        final query = dbService.query(PackageVersion)..order('created');
        await for (PackageVersion pv in query.run()) {
          addPackageVersion(pv);
          _lastTs = pv.created;
        }
      } catch (e, s) {
        _logger.severe(e, s);
        continue;
      }
      _logger.info('Scanned package graph in ${sw.elapsed}');
      return;
    }
  }

  // Note, this method never returns.
  Future monitorInBackground() async {
    _logger.info('Monitoring new package uploads.');
    for (;;) {
      try {
        final query = dbService.query(PackageVersion)
          ..filter('created >', _lastTs)
          ..order('created');
        await for (PackageVersion pv in query.run()) {
          addPackageVersion(pv);
          _lastTs = pv.created;
        }
      } catch (e, s) {
        _logger.severe(e, s);
      }
      await new Future.delayed(pollingInterval);
    }
  }

  void addPackageVersion(PackageVersion pv) {
    final Set<String> depsSet = new Set<String>.from(pv.pubspec.dependencies);
    final Set<String> devDepsSet =
        new Set<String>.from(pv.pubspec.devDependencies);

    // First we add the [package] together with the dependencies /
    // dev_dependencies to the graph.  This will update the graph transitively,
    // thereby calculating new users of the [package].
    _add(pv.package, depsSet, devDepsSet);
  }

  Set<String> affectedPackages(String package) {
    // Due to the constraints in the new [pubspec] it might cause a number of
    // packages to get new transitive dependencies during a `pub get` and
    // therefore might cause new analysis results.
    //
    // So we trigger all packages that depend (directly or indirectly) on
    // [package].
    final Set<String> transitiveUsers =
        reverseDeps.transitiveNodes(_intern(package));

    // We filter out all dev package usages and trigger an analysis for them
    // (the dev packages are a superset of the normal packages).
    final Set<String> all = transitiveUsers
        .where((String p) => p.startsWith(devPrefix))
        .map((String p) => p.substring(devPrefix.length))
        .toSet();
    return all;
  }

  void _add(String package, Set<String> deps, Set<String> devDeps) {
    final internedPackage = _intern(package);
    final internedDevPackage = _intern(_devPackage(package));

    for (final String dep in deps) {
      final internedDep = _intern(dep);
      reverseDeps.add(internedDep, internedPackage);
      reverseDeps.add(internedDep, internedDevPackage);
    }

    for (final String dep in devDeps) {
      final internedDep = _intern(dep);
      reverseDeps.add(internedDep, internedDevPackage);
    }
  }

  // We use a synthetic package to handle weak dependencies / dev
  // dependencies (no package is depending on this one).
  String _devPackage(String package) => '$devPrefix$package';
}
