// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:logging/logging.dart';

import 'package:pub_dev/package/models.dart';

import '../shared/utils.dart' show StringInternPool;

final Logger _logger = Logger('pub.package_graph');

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

  static Set<String> _newSet() => <String>{};
}

/// Callback function to be called when a new [PackageVersion] should trigger the
/// re-analysis of a package that depends on it.
typedef OnAffected = Future<void> Function(
    String package, String version, Set<String> affected);

class PackageDependencyBuilder {
  static const Duration pollingInterval = Duration(minutes: 1);
  static const String devPrefix = 'dev/';

  final DatastoreDB db;
  final OnAffected _onAffected;

  final TransitiveDependencyGraph reverseDeps = TransitiveDependencyGraph();
  final String Function(String) _intern = StringInternPool().intern;

  DateTime _lastTs;

  /// The future will complete once the initial database has been scanned and a
  /// graph has been built.
  static Future<PackageDependencyBuilder> loadInitialGraphFromDb(
      DatastoreDB db, OnAffected onAffected) async {
    final sw = Stopwatch()..start();
    final builder = PackageDependencyBuilder._(db, onAffected);
    await builder.scanExistingPackageGraph();
    _logger.info('Scanned initial dependency graph in ${sw.elapsed}.');
    return builder;
  }

  PackageDependencyBuilder._(this.db, this._onAffected);

  Future<void> scanExistingPackageGraph() async {
    final sw = Stopwatch()..start();
    for (;;) {
      _logger.info('Scanning existing package graph');
      try {
        // We scan from oldest to newest and therefore keep [_lastTs] always
        // increasing.
        final query = dbService.query<PackageVersionPubspec>()
          ..order('updated');
        await for (PackageVersionPubspec pv in query.run()) {
          addPackageVersion(pv);
          _lastTs = pv.updated;
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
  Future<void> monitorInBackground() async {
    _logger.info('Monitoring new package uploads.');
    for (;;) {
      try {
        final query = dbService.query<PackageVersionPubspec>()
          ..filter('updated >', _lastTs)
          ..order('updated');
        await for (PackageVersionPubspec pv in query.run()) {
          addPackageVersion(pv);

          final affected = affectedPackages(pv.package);
          _logger.info(
              'Found ${affected.length} dependent packages for ${pv.package}.');

          if (affected != null && affected.isNotEmpty) {
            try {
              await _onAffected(pv.package, pv.version, affected);
            } catch (e, st) {
              _logger.warning(
                  'Error triggering action for ${pv.qualifiedVersionKey}',
                  e,
                  st);
            }
          }

          _lastTs = pv.updated;
        }
      } catch (e, s) {
        _logger.severe(e, s);
      }
      await Future.delayed(pollingInterval);
    }
  }

  void addPackageVersion(PackageVersionPubspec pv) {
    final Set<String> depsSet = Set<String>.from(pv.pubspec.dependencies);
    final Set<String> devDepsSet = Set<String>.from(pv.pubspec.devDependencies);

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
