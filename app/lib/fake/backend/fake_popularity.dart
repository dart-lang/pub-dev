// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' as math;

import 'package:clock/clock.dart';

import '../../package/models.dart';
import '../../service/download_counts/backend.dart';
import '../../shared/datastore.dart';

/// Scans the datastore for packages and generates download count values with a
/// deterministic random seed.
Future<void> generateFakeDownloadCounts() async {
  final query = dbService.query<Package>();
  await for (final p in query.run()) {
    final r = math.Random(p.name.hashCode.abs());
    final count = (math.min(p.likes * p.likes, 50) + r.nextInt(50));
    await downloadCountsBackend.updateDownloadCounts(
      p.name!,
      {
        p.latestVersion!: count,
      },
      clock.now(),
    );
  }
}
