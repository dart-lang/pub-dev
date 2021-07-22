// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../package/models.dart';
import '../../shared/datastore.dart';

/// Backfills new fields that are introduced in a release.
///
/// Fields should be added here as they are added to the models.
/// CHANGELOG.md must be updated with the new fields, and the next
/// release could remove the backfill from here.
Future<void> backfillNewFields() async {
  final query = dbService.query<PackageVersion>();
  await for (final pv in query.run()) {
    await _backfillPackageVersion(pv);
  }
}

Future<void> _backfillPackageVersion(PackageVersion pv) async {
  if (pv.isRetracted != null) return;
  await withRetryTransaction(dbService, (tx) async {
    final v = await tx.lookupValue<PackageVersion>(pv.key);
    v.isRetracted ??= false;
    tx.insert(v);
  });
}
