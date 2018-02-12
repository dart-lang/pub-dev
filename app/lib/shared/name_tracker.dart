// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:gcloud/db.dart';

import 'package:pub_dartlang_org/frontend/models.dart';

final Logger _logger = new Logger('pub.name_tracker');
const Duration _pollingInterval = const Duration(seconds: 10);

final NameTracker nameTracker = new NameTracker();

class NameTracker {
  final Set<String> _names = new Set<String>();
  final Set<String> _reducedNames = new Set<String>();

  void add(String name) {
    _names.add(name);
    _reducedNames.add(_reduce(name));
  }

  bool hasPackage(String name) => _names.contains(name);

  bool hasConflict(String name) => _reducedNames.contains(_reduce(name));

  bool accept(String name) => hasPackage(name) || !hasConflict(name);

  String _reduce(String name) =>
      // we allow only `_` as part of the name.
      name.replaceAll('_', '').toLowerCase();

  int get length => _names.length;
}

class NameTrackerUpdater {
  final DatastoreDB _db;
  DateTime _lastTs;

  NameTrackerUpdater(this._db);

  // Note, this method never returns.
  Future startNameTrackerUpdates() async {
    final sw = new Stopwatch()..start();
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
    _logger.info(
        'Scanned initial package names (${nameTracker.length}) in ${sw.elapsed}.');

    await new Future.delayed(_pollingInterval);

    _logger.info('Monitoring new package creation.');
    for (;;) {
      try {
        await _scan();
      } catch (e, st) {
        _logger.severe(e, st);
      }
      await new Future.delayed(_pollingInterval);
    }
  }

  Future _scan() async {
    final query = _db.query(Package)..order('created');
    if (_lastTs != null) {
      query.filter('created >', _lastTs);
    }
    await for (Package p in query.run()) {
      nameTracker.add(p.name);
      _lastTs = p.created;
    }
  }
}
