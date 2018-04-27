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

final _logger = new Logger('pub.history.backend');

/// Sets the history backend.
void registerHistoryBackend(HistoryBackend backend) =>
    ss.register(#_historyBackend, backend);

/// The active history backend.
HistoryBackend get historyBackend => ss.lookup(#_historyBackend);

class HistoryBackend {
  final DatastoreDB _db;
  final bool _enabled = Platform.environment['HISTORY_ENABLED'] == '1';
  HistoryBackend(this._db);

  Future store(History history) async {
    if (!_enabled) {
      _logger.info('History is not enabled, store aborted: '
          '${history.packageName} ${history.packageVersion} ${history.eventType}');
      return;
    }
    await _db.withTransaction((tx) async {
      tx.queueMutations(inserts: [history]);
      await tx.commit();
    });
  }

  Stream<History> getAll({
    @required String scope,
    @required String packageName,
    String packageVersion,
    int limit,
  }) {
    final query = _db.query(History)
      ..filter('scope =', scope)
      ..filter('packageName =', packageName)
      ..order('-timestamp');
    if (limit != null && limit > 0) {
      query.limit(limit);
    }
    if (packageVersion != null) {
      query.filter('packageVersion =', packageVersion);
    }
    return query.run();
  }
}
