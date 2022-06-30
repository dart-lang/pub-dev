// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:crypto/crypto.dart';
import 'package:logging/logging.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/datastore.dart';

final _logger = Logger('backfill_new_fields');

/// Backfills new fields that are introduced in a release.
///
/// Fields should be added here as they are added to the models.
/// CHANGELOG.md must be updated with the new fields, and the next
/// release could remove the backfill from here.
Future<void> backfillNewFields() async {
  _logger.info('Backfill PackageVersion.sha256');
  await _backfillPackageVersionSha256();
}

Future<void> _backfillPackageVersionSha256() async {
  var skipped = 0;
  var updated = 0;
  await for (final pv in dbService.query<PackageVersion>().run()) {
    if (pv.sha256 != null && pv.sha256!.isNotEmpty) {
      skipped++;
      continue;
    }
    final bytes =
        await packageBackend.readArchiveBytes(pv.package, pv.version!);
    final hash = sha256.convert(bytes).bytes;
    await withRetryTransaction(dbService, (tx) async {
      final v = await tx.lookupValue<PackageVersion>(pv.key);
      if (v.sha256 != null && pv.sha256!.isNotEmpty) {
        skipped++;
        return;
      }
      v.sha256 = hash;
      tx.insert(v);
    });
    updated++;
  }
  _logger.info(
      'Backfilled PackageVersion.sha256: $skipped skipped, $updated updated.');
}
