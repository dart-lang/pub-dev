// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:logging/logging.dart';

import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/shared/task_scheduler.dart';

final Logger _logger = new Logger('pub.package_graph');

// To avoid having the same package names many times in memory we canonicalize them.
class StringCanonicalization {
  final Map<String, String> _map = <String, String>{};

  String canonicalize(String value) {
    // Fast case is when [value] is already in the map.
    final canonicalized = _map[value];
    if (canonicalized != null) return canonicalized;

    return _map[value] = value;
  }
}

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

  // The forward (transitive) dependencies could be easily calculated, but
  // right now we have no need for them.
  //final TransitiveDependencyGraph normalDeps = new TransitiveDependencyGraph();

  final TransitiveDependencyGraph reverseDeps = new TransitiveDependencyGraph();
  final String Function(String) canonicalize = new StringCanonicalization().canonicalize;

  DateTime _lastTs;

  PackageDependencyBuilder(this.db);

  Future scanExistingPackageGraph() async {
    final sw = new Stopwatch()..start();
    for (;;) {
      _logger.info('Scanning existing package graph');
      try {
        // We scan from oldest to newest and therefore keep [_lastTs] always
        // increasing.
        final query = dbService.query(PackageVersion)..order('created');
        await for (PackageVersion pv in query.run()) {
          _addPackageVersion(pv);
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

  Stream<Set<String>> run() async* {
    _logger.info('Monitoring new package uploads & trigger analysis');
    for (;;) {
      try {
        final query = dbService.query(PackageVersion)
          ..filter('created >', _lastTs)
          ..order('created');
        await for (PackageVersion pv in query.run()) {
          // Emit a set of packages depending on this one.
          _addPackageVersion(pv);
          yield _affectedPackages(pv.package);

          _lastTs = pv.created;
        }
      } catch (e, s) {
        _logger.severe(e, s);
      }
      await new Future.delayed(pollingInterval);
    }
  }

  void _addPackageVersion(PackageVersion pv) {
    final String package = pv.package;
    final Map pubspec = pv.pubspec.asJson;

    final Set<String> depsSet = new Set<String>();
    final normalDeps = pubspec['dependencies'];
    if (normalDeps is Map) {
      depsSet.addAll(normalDeps.keys);
    }

    final Set<String> devDepsSet = new Set<String>();
    final devDeps = pubspec['dev_dependencies'];
    if (devDeps is Map) {
      devDepsSet.addAll(devDeps.keys);
    }

    // First we add the [package] together with the dependencies /
    // dev_dependencies to the graph.  This will update the graph transitively,
    // thereby calculating new users of the [package].
    _add(package, depsSet, devDepsSet);
  }

  Set<String> _affectedPackages(String package) {
    // Due to the constraints in the new [pubspec] it might cause a number of
    // packages to get new transitive dependencies during a `pub get` and
    // therefore might cause new analysis results.
    //
    // So we trigger all packages that depend (directly or indirectly) on
    // [package].
    final Set<String> transitiveUsers =
        reverseDeps.transitiveNodes(canonicalize(package));

    // We filter out all dev package usages and trigger an analysis for them
    // (the dev packages are a superset of the normal packages).
    final Set<String> all = transitiveUsers
        .where((String p) => p.startsWith(devPrefix))
        .map((String p) => p.substring(devPrefix.length)).toSet();
    return all;
  }

  void _add(String package, Set<String> deps, Set<String> devDeps) {
    final canonicalizedPackage = canonicalize(package);
    final canonicalizedDevPackage = canonicalize(_devPackage(package));

    final canonicalizedDeps = deps.map(canonicalize).toSet();
    final canonicalizedDevDeps = devDeps.map(canonicalize).toSet();

    //normalDeps.addAll(canonicalizedPackage, canonicalizedDeps);
    //normalDeps.addAll(canonicalizedDevPackage, canonicalizedDeps);
    for (final String dep in canonicalizedDeps) {
      reverseDeps.add(dep, canonicalizedPackage);
      reverseDeps.add(dep, canonicalizedDevPackage);
    }

    //normalDeps.addAll(canonicalizedDevPackage, canonicalizedDevDeps);
    for (final String dep in canonicalizedDevDeps) {
      reverseDeps.add(dep, canonicalizedDevPackage);
    }
  }

  // We use a synthetic package to handle weak dependencies / dev
  // dependencies (no package is depending on this one).
  String _devPackage(String package) => '$devPrefix$package';
}

class DepsGraphBasedAnalysisTaskSource implements TaskSource {
  final DatastoreDB db;
  final PackageDependencyBuilder builder;

  DepsGraphBasedAnalysisTaskSource(this.db, this.builder);

  @override
  Stream<Task> startStreaming() async* {
    await for (final Set<String> packages in builder.run()) {
      for (final String packageName in packages) {
        final Key packageKey = db.emptyKey.append(Package, id: packageName);
        final Package package = (await db.lookup([packageKey]))[0];
        if (package != null) {
          yield new Task(package.name, package.latestVersion);
        } else {
          _logger.warning('Package "$packageName" was not found. Maybe it got deleted?');
        }
      }
    }
  }
}
