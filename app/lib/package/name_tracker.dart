// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:meta/meta.dart';
import 'package:pub_package_reader/pub_package_reader.dart';

import 'models.dart';

final _logger = Logger('pub.name_tracker');
const _pollingInterval = Duration(minutes: 15);

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
  final DatastoreDB _db;
  final Set<String> _names = Set<String>();
  final Set<String> _reducedNames = Set<String>();
  final _firstScanCompleter = Completer();
  _NameTrackerUpdater _updater;

  NameTracker(this._db);

  /// Add a package name to the tracker.
  void add(String name) {
    _names.add(name);
    _reducedNames.add(reducePackageName(name));
  }

  /// Whether the package was already added to the tracker.
  bool _hasPackage(String name) => _names.contains(name);

  /// Whether the [name] has a conflicting package that already exists.
  bool _hasConflict(String name) =>
      _reducedNames.contains(reducePackageName(name));

  /// Whether to accept the upload attempt of a given package [name].
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
  Future scanDatastore() async {
    await for (final p in _db.query<Package>().run()) {
      add(p.name);
    }
    if (!_firstScanCompleter.isCompleted) {
      _firstScanCompleter.complete();
    }
  }

  /// Updates this [NameTracker] by polling the Datastore periodically.
  /// The returned future completes after the `stopTracking` method is called.
  Future startTracking() async {
    if (_updater != null) {
      throw StateError('Already tracking datastore.');
    }
    _updater = _NameTrackerUpdater(_db);
    return _updater.startNameTrackerUpdates();
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
  DateTime _lastTs;
  Completer _sleepCompleter;
  Timer _sleepTimer;
  bool _stopped = false;

  _NameTrackerUpdater(this._db);

  /// The returned future completes after the `stop` method is called.
  Future startNameTrackerUpdates() async {
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

    await _sleep();

    _logger.info('Monitoring new package creation.');
    for (;;) {
      if (_stopped) return;
      try {
        await _scan();
      } catch (e, st) {
        _logger.severe(e, st);
      }
      await _sleep();
    }
  }

  Future _sleep() async {
    _sleepCompleter = Completer();
    _sleepTimer = Timer(_pollingInterval, () {
      if (_sleepCompleter != null && !_sleepCompleter.isCompleted) {
        _sleepCompleter.complete();
      }
    });
    await _sleepCompleter.future;
    _sleepTimer.cancel();
    _sleepCompleter = null;
    _sleepTimer = null;
  }

  Future _scan() async {
    final now = DateTime.now().toUtc();
    final query = _db.query<Package>()..order('created');
    if (_lastTs != null) {
      query.filter('created >', _lastTs);
    }
    await for (Package p in query.run()) {
      if (_stopped) return;
      nameTracker.add(p.name);
    }
    _lastTs = now.subtract(const Duration(hours: 1));
  }

  void stop() {
    _stopped = true;
    if (_sleepCompleter != null && !_sleepCompleter.isCompleted) {
      _sleepCompleter.complete();
    }
  }
}
