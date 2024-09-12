// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pub_package_reader/pub_package_reader.dart';

import '../shared/datastore.dart';
import 'models.dart';

final _logger = Logger('pub.name_tracker');

/// The interval to update recent package name list.
const _recentScanInterval = Duration(minutes: 15);

/// The interval to reload the full package name list from scratch.
const _reloadInterval = Duration(days: 1);

/// The timeout for full Datastore scans.
const _reloadTimeout = Duration(minutes: 5);

/// The timeout for recent update scans.
const _pollingTimeout = Duration(seconds: 20);

/// Minimal package information tracked by [NameTracker].
class TrackedPackage {
  final String package;
  final DateTime updated;
  final String latestVersion;
  final DateTime lastPublished;

  /// Derived from `Package.isVisible`, the flag indicates that the
  /// package has not been withdrawn, and can be displayed.
  final bool isVisible;

  TrackedPackage({
    required this.package,
    required this.updated,
    required this.latestVersion,
    required this.lastPublished,
    required this.isVisible,
  });

  factory TrackedPackage.fromPackage(Package p) => TrackedPackage(
        package: p.name!,
        updated: p.updated!,
        latestVersion: p.latestVersion!,
        lastPublished: p.lastVersionPublished!,
        isVisible: p.isVisible,
      );

  @visibleForTesting
  TrackedPackage.simple(this.package)
      : latestVersion = '1.0.0',
        updated = clock.now(),
        lastPublished = clock.now(),
        isVisible = true;

  @override
  late final int hashCode =
      Object.hash(package, updated, latestVersion, lastPublished, isVisible);

  @override
  bool operator ==(Object other) {
    return other is TrackedPackage &&
        package == other.package &&
        updated == other.updated &&
        latestVersion == other.latestVersion &&
        lastPublished == other.lastPublished &&
        isVisible == other.isVisible;
  }
}

/// Sets the active [NameTracker].
void registerNameTracker(NameTracker value) =>
    ss.register(#_name_tracker, value);

/// The active [NameTracker].
NameTracker get nameTracker => ss.lookup(#_name_tracker) as NameTracker;

/// Tracks names of packages that exists, to avoid risks of using similar names
/// or typo-squatting.
///
/// It also provides a quick access to list all of the package names without
/// iterating over Datastore entries.
class NameTracker {
  final DatastoreDB? _db;
  var _data = _Data();

  final _firstScanCompleter = Completer();
  Completer? _ongoingRecentScan;
  Timer? _recentScanTimer;
  Timer? _reloadTimer;

  NameTracker(this._db);

  /// Whether to accept the upload attempt of a given package [name].
  ///
  /// Either the package [name] should exists, or it should be different enough
  /// from already existing active or moderated package names. An example for
  /// the rejection: `long_name` will be rejected, if package `longname` or
  /// `lon_gname` exists.
  ///
  /// Returns the package name that caused rejection or null if it is accepted.
  Future<String?> accept(String name) async {
    // fast track:
    if (_data._hasPackage(name)) {
      return null;
    }
    // Trigger a new scan (if updater is active) to get the packages that may
    // have been uploaded recently.
    if (_db != null) {
      await _scanRecentPackages().timeout(_pollingTimeout);
    }
    return _data.accept(name);
  }

  /// Whether the first scan was already completed.
  bool get isReady => _firstScanCompleter.isCompleted;

  /// Get the names of all visible packages.
  ///
  /// Packages that are _withdrawn_ are not listed here.
  /// Packages that are _unlisted_ or _discontinued_ are **included in this list**.
  ///
  /// If it is called before the first scan was done, it will wait for
  /// it to complete. Afterwards it always returns the currently cached
  /// list of names, without scanning the Datastore.
  Future<List<String>> getVisiblePackageNames() async {
    if (!_firstScanCompleter.isCompleted) {
      await _firstScanCompleter.future;
    }
    return _data.visiblePackageNames;
  }

  @visibleForTesting
  void add(TrackedPackage pkg) {
    _data.add(pkg);
  }

  List<TrackedPackage> get visiblePackagesOrderedByLastPublished =>
      _data.visiblePackagesOrderedByLastPublished;

  /// Whether the name tracker has a record of the package.
  bool hasPackage(String name) => _data._hasPackage(name);

  /// Scans the Datastore and populates the tracker.
  @visibleForTesting
  Future<void> reloadFromDatastore() async {
    final sw = Stopwatch()..start();
    _logger.info('Scanning packages...');
    final data = _Data();
    await for (final p in _db!.query<Package>().run()) {
      data.add(TrackedPackage.fromPackage(p));
    }
    await for (final p in _db.query<ModeratedPackage>().run()) {
      data.addModeratedName(p.name!);
    }
    _data = data;
    if (!_firstScanCompleter.isCompleted) {
      _firstScanCompleter.complete();
    }
    _logger.info('Packages scanned in ${sw.elapsed}.');
  }

  Future<void> _scanRecentPackages() async {
    if (_ongoingRecentScan != null) {
      await _ongoingRecentScan!.future;
      return;
    }
    _ongoingRecentScan ??= Completer();
    final start = clock.now().toUtc();
    final ts = _data._lastStartedTs.subtract(const Duration(hours: 1));
    _logger.info('Scanning recent packages starting from "$ts"...');
    try {
      final query = _db!.query<Package>()
        ..order('-lastVersionPublished')
        ..filter('lastVersionPublished >', ts);
      await for (final p in query.run()) {
        _data.add(TrackedPackage.fromPackage(p));
      }

      final moderatedPkgQuery = _db.query<ModeratedPackage>()
        ..order('moderated')
        ..filter('moderated >', ts);

      await for (final p in moderatedPkgQuery.run()) {
        _data.addModeratedName(p.name!);
      }

      _data._lastStartedTs = start;
      _logger
          .info('Recent packages scanned in ${clock.now().difference(start)}.');
    } finally {
      final c = _ongoingRecentScan;
      if (c != null && !c.isCompleted) {
        _ongoingRecentScan = null;
        c.complete();
      }
    }
  }

  /// Updates this [NameTracker] by polling the Datastore periodically.
  Future<void> startTracking() async {
    await reloadFromDatastore().timeout(_reloadTimeout);
    _recentScanTimer ??= Timer.periodic(_recentScanInterval, (_) async {
      try {
        await _scanRecentPackages();
      } catch (e, st) {
        _logger.warning(
            'Failed to update name tracker with recent packages.', e, st);
      }
    });
    _reloadTimer ??= Timer.periodic(_reloadInterval, (_) async {
      try {
        await reloadFromDatastore().timeout(_reloadTimeout);
      } catch (e, st) {
        _logger.warning('Failed to rescan name tracker.', e, st);
      }
    });
  }

  /// Stops tracking the datastore.
  void stopTracking() {
    _recentScanTimer?.cancel();
    _recentScanTimer = null;
    _reloadTimer?.cancel();
    _reloadTimer = null;
  }
}

class _Data {
  var _lastStartedTs = clock.now().toUtc();

  final _names = <String>{};
  final _packages = <String, TrackedPackage>{};

  /// Names that are reserved due to moderated packages having these names.
  final _moderatedNames = <String>{};
  final _conflictingNames = <String, List<String>>{};

  List<TrackedPackage>? _packagesOrderedByLastPublishedDesc;
  List<String>? _visiblePackageNames;

  /// Add a package name to the tracker.
  void add(TrackedPackage pkg) {
    _names.add(pkg.package);
    _addConflictingName(pkg.package);
    final current = _packages[pkg.package];
    if (current == null || current.updated.isBefore(pkg.updated)) {
      _packages[pkg.package] = pkg;
      _resetCache();
    }
  }

  void addModeratedName(String name) {
    _moderatedNames.add(name);
    final existed = _names.remove(name);
    if (existed) {
      _resetCache();
      // remove conflicting name entries for this package
      final names = _generateConflictingNames(name);
      for (final cn in names) {
        final list = _conflictingNames[cn];
        if (list == null) continue;
        list.remove(name);
        if (list.isEmpty) {
          _conflictingNames.remove(cn);
        }
      }
    }
  }

  void _resetCache() {
    _packagesOrderedByLastPublishedDesc = null;
    _visiblePackageNames = null;
  }

  void _addConflictingName(String name) {
    final names = _generateConflictingNames(name);
    for (final cn in names) {
      _conflictingNames.putIfAbsent(cn, () => <String>[]).add(name);
    }
  }

  /// Returns the cached list of packages ordered by descending last published date.
  /// Only the visible packages are present.
  List<TrackedPackage> get visiblePackagesOrderedByLastPublished {
    return _packagesOrderedByLastPublishedDesc ??= _packages.values
        .where((p) => p.isVisible)
        .toList()
      ..sort((a, b) => -a.lastPublished.compareTo(b.lastPublished));
  }

  List<String> get visiblePackageNames {
    return _visiblePackageNames ??= _packages.values
        .where((t) => t.isVisible)
        .map((t) => t.package)
        .toList()
      ..sort();
  }

  /// Whether the package was already added to the tracker.
  bool _hasPackage(String name) => _names.contains(name);

  /// Whether to accept the upload attempt of a given package [name].
  ///
  /// Either the package [name] should exists, or it should be different enough
  /// from already existing active or moderated package names. An example for
  /// the rejection: `long_name` will be rejected, if package `longname` or
  /// `lon_gname` exists.
  ///
  /// Returns the package name that caused rejection or null if it is accepted.
  String? accept(String name) {
    // normal checks:
    if (_hasPackage(name)) return null;
    if (_moderatedNames.contains(name)) {
      return name;
    }
    for (final generated in _generateConflictingNames(name)) {
      final original = _conflictingNames[generated];
      if (original != null) return original.first;
    }
    return null;
  }
}

/// Generates the names that will be used to determine name conflicts:
/// - For each package name, this will generate a String that doesn't contain `_`.
/// - For names that are long enough, this will also try to generate the singular or plural form of the name.
Iterable<String> _generateConflictingNames(String name) sync* {
  // name without underscores
  final reduced = reducePackageName(name);
  yield reduced;
  // singular/plural form parsing
  // This could be improved with some a dictionary or a grammar parser.
  if (!reduced.endsWith('s') && reduced.length >= 3) {
    yield '${reduced}s';
  }
  if (reduced.endsWith('s') && reduced.length >= 4) {
    yield reduced.substring(0, reduced.length - 1);
  }
  for (final pair in _homoglyphPairs) {
    if (reduced.contains(pair[0])) {
      yield reduced.replaceAll(pair[0], pair[1]);
    }
    if (reduced.contains(pair[1])) {
      yield reduced.replaceAll(pair[1], pair[0]);
    }
  }
}

/// Homoglyphs are characters with different meanings, that look similar/identical to each other.
/// These pairs - depending on the font being used - may be rendered similarly.
const _homoglyphPairs = [
  ['1', 'l'],
  ['d', 'cl'],
  ['g', 'cj'],
  ['m', 'rn'],
  ['w', 'vv'],
];
