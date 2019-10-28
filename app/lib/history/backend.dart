// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import 'models.dart';

final _logger = Logger('pub.history.backend');

/// Sets the history backend.
void registerHistoryBackend(HistoryBackend backend) =>
    ss.register(#_historyBackend, backend);

/// The active history backend.
HistoryBackend get historyBackend =>
    ss.lookup(#_historyBackend) as HistoryBackend;

/// Stores and queries [History] entries.
class HistoryBackend {
  final DatastoreDB _db;
  final bool _enabled = Platform.environment['HISTORY_ENABLED'] != '0';
  HistoryBackend(this._db);

  /// Whether the storing of the entries is enabled.
  bool get isEnabled => _enabled;

  /// Store a history [event]. When storing is not enabled, this will only log
  /// the method call, and not store the entry in Datastore.
  Future<String> storeEvent(HistoryEvent event) async {
    final history = History.entry(event);
    if (!_enabled) {
      _logger.info('History is not enabled, store aborted: '
          '${history.packageName} ${history.packageVersion} ${history.eventType}');
      return null;
    }
    await _db.withTransaction((tx) async {
      tx.queueMutations(inserts: [history]);
      await tx.commit();
    });
    return history.id as String;
  }

  Stream<History> getAll({
    @required String packageName,
    @required String packageVersion,
    int limit,
  }) {
    final query = _db.query<History>()
      ..filter('packageName =', packageName)
      ..filter('packageVersion =', packageVersion)
      ..order('-timestamp');
    if (limit != null && limit > 0) {
      query.limit(limit);
    }
    return query.run();
  }
}
