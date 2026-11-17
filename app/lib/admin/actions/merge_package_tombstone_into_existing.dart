// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/datastore.dart';

final mergePackageTombstoneIntoExisting = AdminAction(
  name: 'merge-package-tombstone-into-existing',
  summary:
      'Removes a package tombstone and merges it into an existing Package entity.',
  description: '''
This action will remove a package moderation tombstone (PackageTombstone)
row from SQL, and merges its deleted version list into its
already existing Package entity.
The removal will unblock new uploads to the package.

WARNING: Ownership information stored on the tombstone (e.g. publisher
         or uploaders) will be lost.

NOTE: The published versions will be rolled into Package.deletedVersions.

Fails if that package has no package tombstone.
Fails if that package has no existing Package entity.
''',
  options: {
    'package':
        'The name of the tombstoned package to merge into its existing Package.',
  },
  invoke: (args) async {
    final packageName =
        args['package'] ??
        (throw InvalidInputException('Missing --package argument.'));

    // check tombstone existence
    final tombstone = await packageBackend.lookupPackageTombstone(packageName);
    InvalidInputException.check(
      tombstone != null,
      'Package tombstone does not exist.',
    );
    final tombstoneVersions = tombstone!.versions;

    final updated = await withRetryTransaction(dbService, (tx) async {
      // check Package existence
      final pKey = dbService.emptyKey.append(Package, id: packageName);
      final p = await tx.lookupOrNull<Package>(pKey);
      InvalidInputException.check(p != null, 'Package does not exists.');

      // update deleted version list
      final versionList = await tx.query<PackageVersion>(pKey).run().toList();
      final existingVersions = versionList.map((v) => v.version!).toSet();
      final deletedVersions = tombstoneVersions
          .where((v) => !existingVersions.contains(v))
          .toList();
      if (deletedVersions.isNotEmpty) {
        p!.deletedVersions = <String>{
          ...?p.deletedVersions,
          ...deletedVersions,
        }.toList();
      }

      // always bump updated
      p!.updated = clock.now().toUtc();
      tx.insert(p);

      return p;
    });
    await packageBackend.mirrorPackageToSql(updated);
    await packageBackend.deletePackageTombstone(packageName);
    await triggerPackagePostUpdates(packageName).future;

    return {'package': packageName, 'merged': true};
  },
);
