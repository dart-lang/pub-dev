// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' as math;

import '../../package/models.dart';
import '../../shared/datastore.dart';
import '../../shared/popularity_storage.dart';

/// Scans the datastore for packages and generates popularity values with a
/// deterministic random seed.
///
/// TODO: generate similar values for download counts.
Future<void> generateFakePopularityValues() async {
  final values = <String, double>{};
  final query = dbService.query<Package>();
  await for (final p in query.run()) {
    final r = math.Random(p.name.hashCode.abs());
    final value = (math.min(p.likes * p.likes, 50) + r.nextInt(50)) / 100;
    values[p.name!] = value;
  }
  // ignore: invalid_use_of_visible_for_testing_member
  popularityStorage.updateValues(values, invalid: false);
}
