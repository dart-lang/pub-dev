// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pub_package_reader/pub_package_reader.dart';

import '../shared/datastore.dart';
import 'models.dart';

final _logger = Logger('pub.name_tracker');
const _pollingInterval = Duration(minutes: 15);

/// Minimal package information tracked by [NameTracker].
class TrackedPackage {
  final String package;
  final String latestVersion;
  final DateTime lastPublished;
  final bool isVisible;

  TrackedPackage({
    required this.package,
    required this.latestVersion,
    required this.lastPublished,
    required this.isVisible,
  });

  @visibleForTesting
  TrackedPackage.simple(this.package)
      : latestVersion = '1.0.0',
        lastPublished = DateTime.now(),
        isVisible = true;

  @override
  late final int hashCode =
      Object.hash(package, latestVersion, lastPublished, isVisible);

  @override
  bool operator ==(Object other) {
    return other is TrackedPackage &&
        package == other.package &&
        latestVersion == other.latestVersion &&
        lastPublished == other.lastPublished;
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
/// TODO: support remove and re-scan package names every day or so.
class NameTracker {
  final DatastoreDB? _db;
  final Set<String> _names = <String>{};

  final _packages = <String, TrackedPackage>{};
  List<TrackedPackage>? _packagesOrderedByLastPublishedDesc;

  /// Names that are reserved due to moderated packages having these names.
  final _reservedNames = <String>{};
  final _conflictingNames = <String>{};
  final _firstScanCompleter = Completer();
  _NameTrackerUpdater? _updater;

  NameTracker(this._db);

  /// Add a package name to the tracker.
  void add(TrackedPackage pkg) {
    _names.add(pkg.package);
    _conflictingNames.addAll(_generateConflictingNames(pkg.package));
    final current = _packages[pkg.package];
    if (current == null || current.lastPublished.isBefore(pkg.lastPublished)) {
      _packages[pkg.package] = pkg;
      _packagesOrderedByLastPublishedDesc = null;
    }
  }

  void addReservedName(String name) {
    _reservedNames.add(name);
    _conflictingNames.addAll(_generateConflictingNames(name));
    _names.remove(name);
  }

  /// Returns the cached list of packages ordered by descending last published date.
  /// Only the visible packages are present.
  List<TrackedPackage> get packagesOrderedByLastPublishedDesc {
    return _packagesOrderedByLastPublishedDesc ??= _packages.values
        .where((p) => p.isVisible)
        .toList()
      ..sort((a, b) => -a.lastPublished.compareTo(b.lastPublished));
  }

  /// Whether the package was already added to the tracker.
  bool _hasPackage(String name) => _names.contains(name);

  /// Whether the [name] has a conflicting package that already exists or
  /// a conflicting package among the moderated packages.
  bool _hasConflict(String name) =>
      _generateConflictingNames(name).any(_conflictingNames.contains) ||
      _reservedNames.contains(name);

  /// Whether to accept the upload attempt of a given package [name].
  ///
  /// Either the package [name] should exists, or it should be different enough
  /// from already existing active or moderated package names. An example for
  /// the rejection: `long_name` will be rejected, if package `longname` or
  /// `lon_gname` exists.
  Future<bool> accept(String name) async {
    // fast track:
    if (_hasPackage(name)) return true;
    // Trigger a new scan (if updater is active) to get the packages that may
    // have been uploaded recently.
    await _updater?._scan();
    // normal checks:
    return _hasPackage(name) || !_hasConflict(name);
  }

  int get _length => _names.length;

  /// Whether the first scan was already completed.
  bool get isReady => _firstScanCompleter.isCompleted;

  /// Get the list of all the packages. If it is called before the first scan
  /// was done, it will wait for it to complete. Afterwards it always returns
  /// the currently cached list of names, without scanning the Datastore.
  Future<List<String>> getPackageNames() async {
    if (!_firstScanCompleter.isCompleted) {
      await _firstScanCompleter.future;
    }
    return _names.toList()..sort();
  }

  /// Scans the Datastore and populates the tracker.
  @visibleForTesting
  Future<void> scanDatastore() async {
    await for (final p in _db!.query<Package>().run()) {
      add(TrackedPackage(
        package: p.name!,
        latestVersion: p.latestVersion!,
        lastPublished: p.lastVersionPublished!,
        isVisible: p.isVisible,
      ));
    }

    await for (ModeratedPackage p in _db!.query<ModeratedPackage>().run()) {
      addReservedName(p.name!);
    }
    if (!_firstScanCompleter.isCompleted) {
      _firstScanCompleter.complete();
    }
  }

  /// Updates this [NameTracker] by polling the Datastore periodically.
  /// The returned future completes after the `stopTracking` method is called.
  void startTracking() {
    if (_updater != null) {
      throw StateError('Already tracking datastore.');
    }
    _updater = _NameTrackerUpdater(_db!);
    _updater!.startNameTrackerUpdates();
  }

  /// Stops tracking the datastore.
  void stopTracking() {
    _updater?.stop();
    _updater = null;
  }
}

/// Updates [nameTracker] by polling the Datastore periodically.
class _NameTrackerUpdater {
  final DatastoreDB _db;
  DateTime? _lastTs;
  Completer? _sleepCompleter;
  Timer? _sleepTimer;
  bool _stopped = false;

  _NameTrackerUpdater(this._db);

  /// The returned future completes after the `stop` method is called.
  Future<void> startNameTrackerUpdates() async {
    final sw = Stopwatch()..start();
    _logger.info('Scanning existing package names');
    for (;;) {
      if (_stopped) return;
      try {
        await _scan();
      } catch (e, st) {
        _logger.severe(e, st);
        continue;
      }
      break;
    }
    nameTracker._firstScanCompleter.complete();
    _logger.info(
        'Scanned initial package names (${nameTracker._length}) in ${sw.elapsed}.');

    _logger.info('Monitoring new package creation....');

    for (; !_stopped;) {
      await _sleep();
      if (_stopped) break;
      try {
        await _scan();
      } catch (e, st) {
        _logger.severe(e, st);
      }
    }

    _logger.info('Monitoring ended.');
  }

  Future<void> _sleep() async {
    if (_stopped) return;
    _sleepCompleter = Completer();
    _sleepTimer = Timer(_pollingInterval, () {
      if (_sleepCompleter != null && !_sleepCompleter!.isCompleted) {
        _sleepCompleter!.complete();
      }
    });
    await _sleepCompleter!.future;
    _sleepTimer?.cancel();
    _sleepCompleter = null;
    _sleepTimer = null;
  }

  Future<void> _scan() async {
    final now = DateTime.now().toUtc();
    final query = _db.query<Package>()..order('-lastVersionPublished');
    if (_lastTs != null) {
      query.filter('lastVersionPublished >', _lastTs);
    }
    await for (Package p in query.run()) {
      if (_stopped) return;
      nameTracker.add(TrackedPackage(
        package: p.name!,
        latestVersion: p.latestVersion!,
        lastPublished: p.lastVersionPublished!,
        isVisible: p.isVisible,
      ));
    }

    final moderatedPkgQuery = _db.query<ModeratedPackage>()..order('moderated');
    if (_lastTs != null) {
      moderatedPkgQuery.filter('moderated >', _lastTs);
    }

    await for (ModeratedPackage p in moderatedPkgQuery.run()) {
      if (_stopped) return;
      nameTracker.addReservedName(p.name!);
    }

    _lastTs = now.subtract(const Duration(hours: 1));
  }

  void stop() {
    _stopped = true;
    if (_sleepCompleter != null && !_sleepCompleter!.isCompleted) {
      _sleepCompleter!.complete();
    }
    _sleepTimer?.cancel();
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
}
