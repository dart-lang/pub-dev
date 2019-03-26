// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:logging/logging.dart';

final _statsLogger = Logger('scheduler.stats');

Map _latestSchedulerStats;
DateTime _lastLog;

void registerSchedulerStatsStream(Stream<Map> stream) {
  stream.listen(updateLatestStats);
}

void updateLatestStats(Map stats) {
  _latestSchedulerStats = stats;
  final now = DateTime.now();
  if (_lastLog == null ||
      now.difference(_lastLog) > const Duration(minutes: 10)) {
    _statsLogger.info(const JsonEncoder.withIndent(' ').convert(stats));
    _lastLog = now;
  }
}

Map get latestSchedulerStats => _latestSchedulerStats;
