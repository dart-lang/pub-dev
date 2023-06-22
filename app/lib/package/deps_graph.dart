// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:logging/logging.dart';

import '../package/models.dart';
import '../shared/datastore.dart';

final Logger _logger = Logger('pub.package_graph');

// TODO(kustermann): We could incorporate the pubspec constraints to make the
// sets smaller.
class TransitiveDependencyGraph {
  final _deps = <String, Set<String>>{};
  final _internedKeys = <String, String>{};

  void _logStats() {
    final stats = <String, dynamic>{
      'keys': _deps.length,
      'values': _deps.values.fold<int>(0, (a, b) => a + b.length),
      'interned': _internedKeys.length,
    };
    _logger.info('TransitiveDependencyGraph stats: $stats');
  }

  void addAll(String node, Set<String> deps) {
    final nodes = _deps.putIfAbsent(node, _newSet);
    final int before = nodes.length;
    nodes.addAll(deps);
    if (before != nodes.length) {
      _fixpointNode(node);
    }
  }

  void add(String node, String dep) {
    node = _intern(node);
    if (_deps.putIfAbsent(node, _newSet).add(_intern(dep))) {
      _fixpointNode(node);
    }
  }

  Set<String> transitiveNodes(String node) => _deps.putIfAbsent(node, _newSet);

  String _intern(String s) => _internedKeys.putIfAbsent(s, () => s);

  void _fixpointNode(String node) {
    final directs = _deps[node]!;
    final temp = <Set<String>>[];
    for (;;) {
      final int before = directs.length;
      temp.clear();
      for (final String direct in directs) {
        if (node != direct) {
          final transitives = _deps[direct];
          if (transitives?.isNotEmpty == true) {
            temp.add(transitives!);
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
typedef OnAffected = Future<void> Function(Set<String> affected);

class PackageDependencyBuilder {
  static const String _devPrefix = 'dev/';

  final DatastoreDB _db;
  final OnAffected _onAffected;
  final Duration _pollingInterval;

  final _reverseDeps = TransitiveDependencyGraph();

  DateTime? _lastTs;

  /// The future will complete once the initial database has been scanned and a
  /// graph has been built.
  static Future<PackageDependencyBuilder> loadInitialGraphFromDb(
    DatastoreDB db,
    OnAffected onAffected, {
    required Duration pollingInterval,
  }) async {
    final sw = Stopwatch()..start();
    final builder = PackageDependencyBuilder._(db, onAffected, pollingInterval);
    await builder._scanExistingPackageGraph();
    _logger.info('Scanned initial dependency graph in ${sw.elapsed}.');
    return builder;
  }

  PackageDependencyBuilder._(this._db, this._onAffected, this._pollingInterval);

  Future<void> _scanExistingPackageGraph() async {
    final sw = Stopwatch()..start();
    for (;;) {
      _logger.info('Scanning existing package graph');
      try {
        // We scan from oldest to newest and therefore keep [_lastTs] always
        // increasing.
        final query = _db.query<PackageVersion>()..order('created');
        await for (PackageVersion pv in query.run()) {
          addPackageVersion(pv);
          _lastTs = pv.created;
        }
      } catch (e, s) {
        _logger.severe(e, s);
        continue;
      }
      _logger.info('Scanned package graph in ${sw.elapsed}');
      _reverseDeps._logStats();
      return;
    }
  }

  // Note, this method never returns.
  Future<void> monitorInBackground() async {
    _logger.info('Monitoring new package uploads.');
    for (;;) {
      try {
        final query = _db.query<PackageVersion>()
          ..filter('created >', _lastTs)
          ..order('created');
        var updated = false;
        final affected = <String>{};
        await for (final pv in query.run()) {
          addPackageVersion(pv);
          updated = true;
          affected.addAll(_affectedPackages(pv.package));
          _logger.info(
              'Found ${affected.length} dependent packages for ${pv.package}.');
          _lastTs = pv.created;
        }

        if (affected.isNotEmpty) {
          try {
            await _onAffected(affected);
          } catch (e, st) {
            _logger.warning('Error triggering action', e, st);
          }
        }

        if (updated) {
          _reverseDeps._logStats();
        }
      } catch (e, s) {
        _logger.severe(e, s);
      }
      await Future.delayed(_pollingInterval);
    }
  }

  void addPackageVersion(PackageVersion pv) {
    final Set<String> depsSet = Set<String>.from(pv.pubspec!.dependencyNames);
    final Set<String> devDepsSet =
        Set<String>.from(pv.pubspec!.devDependencies);

    // First we add the [package] together with the dependencies /
    // dev_dependencies to the graph.  This will update the graph transitively,
    // thereby calculating new users of the [package].
    _add(pv.package, depsSet, devDepsSet);
  }

  Set<String> _affectedPackages(String package) {
    // Due to the constraints in the new [pubspec] it might cause a number of
    // packages to get new transitive dependencies during a `dart pub get` and
    // therefore might cause new analysis results.
    //
    // So we trigger all packages that depend (directly or indirectly) on
    // [package].
    final Set<String> transitiveUsers = _reverseDeps.transitiveNodes(package);

    // We filter out all dev package usages and trigger an analysis for them
    // (the dev packages are a superset of the normal packages).
    final Set<String> all = transitiveUsers
        .where((String p) => p.startsWith(_devPrefix))
        .map((String p) => p.substring(_devPrefix.length))
        .toSet();
    return all;
  }

  void _add(String package, Set<String> deps, Set<String> devDeps) {
    final devPackage = _devPackage(package);

    for (final String dep in deps) {
      _reverseDeps.add(dep, package);
      _reverseDeps.add(dep, devPackage);
    }

    for (final String dep in devDeps) {
      _reverseDeps.add(dep, devPackage);
    }
  }

  // We use a synthetic package to handle weak dependencies / dev
  // dependencies (no package is depending on this one).
  String _devPackage(String package) => '$_devPrefix$package';
}
