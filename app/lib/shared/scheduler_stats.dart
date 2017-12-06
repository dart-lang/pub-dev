// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

Map _latestSchedulerStats;

void registerSchedulerStatsStream(Stream<Map> stream) {
  stream.listen((stats) {
    _latestSchedulerStats = stats;
  });
}

Map get latestSchedulerStats => _latestSchedulerStats;
