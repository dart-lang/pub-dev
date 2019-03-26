// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:gcloud/db.dart';

import '../shared/utils.dart';

import 'models.dart';

final _logger = Logger('pub.name_tracker');
const _pollingInterval = Duration(minutes: 1);

final nameTracker = NameTracker();

/// Tracks names of packages that exists, to avoid risks of using similar names
/// or typo-squatting.
///
/// It also provides a quick access to list all of the package names without
/// iterating over Datastore entries.
/// TODO: support remove and re-scan package names every day or so.
class NameTracker {
  final Set<String> _names = Set<String>();
  final Set<String> _reducedNames = Set<String>();
  final _firstScanCompleter = Completer();

  /// Add a package name to the tracker.
  void add(String name) {
    _names.add(name);
    _reducedNames.add(reducePackageName(name));
  }

  /// Whether the package was already added to the tracker.
  bool hasPackage(String name) => _names.contains(name);

  /// Whether the [name] has a conflicting package that already exists.
  bool hasConflict(String name) =>
      _reducedNames.contains(reducePackageName(name));

  /// Whether to accept the upload attempt of a given package [name].
  bool accept(String name) => hasPackage(name) || !hasConflict(name);

  int get length => _names.length;

  /// Get the list of all the packages. If it is called before the first scan
  /// was done, it will wait for it to complete. Afterwards it always returns
  /// the currently cached list of names, without scanning the Datastore.
  Future<List<String>> getPackageNames() async {
    if (!_firstScanCompleter.isCompleted) {
      await _firstScanCompleter.future;
    }
    return _names.toList()..sort();
  }
}

/// Updates [nameTracker] by polling the Datastore periodically.
class NameTrackerUpdater {
  final DatastoreDB _db;
  DateTime _lastTs;

  NameTrackerUpdater(this._db);

  // Note, this method never returns.
  Future startNameTrackerUpdates() async {
    final sw = Stopwatch()..start();
    _logger.info('Scanning existing package names');
    for (;;) {
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
        'Scanned initial package names (${nameTracker.length}) in ${sw.elapsed}.');

    await Future.delayed(_pollingInterval);

    _logger.info('Monitoring new package creation.');
    for (;;) {
      try {
        await _scan();
      } catch (e, st) {
        _logger.severe(e, st);
      }
      await Future.delayed(_pollingInterval);
    }
  }

  Future _scan() async {
    final query = _db.query<Package>()..order('created');
    if (_lastTs != null) {
      query.filter('created >', _lastTs);
    }
    await for (Package p in query.run()) {
      nameTracker.add(p.name);
      _lastTs = p.created;
    }
  }
}
