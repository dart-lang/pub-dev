// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/datastore.dart';

final mergeModeratedPackageIntoExisting = AdminAction(
  name: 'merge-moderated-package-into-existing',
  summary:
      'Removes a ModeratedPackage tombstone and merges it into an existing Package entity.',
  description: '''
This action will remove a package moderation tombstone (ModeratedPackage)
entity from the Datastore, and merges its deleted version list into its
already existing Package entity.
The removal will unblock new uploads to the package.

WARNING: Ownership information stored on the ModeratedPackage (e.g. publisher
         or uploaders) will be lost.

NOTE: The published versions will be rolled into Package.deletedVersions.

Fails if that package has no ModeratedPackage tombstone.
Fails if that package has no existing Package entity.
''',
  options: {
    'package':
        'The name of ModeratedPackage to merge into its existing Package.',
  },
  invoke: (args) async {
    final packageName = args['package'] as String;

    await withRetryTransaction(dbService, (tx) async {
      // check ModeratedPackage existence
      final mpKey =
          dbService.emptyKey.append(ModeratedPackage, id: packageName);
      final mp = await tx.lookupOrNull<ModeratedPackage>(mpKey);
      InvalidInputException.check(
          mp != null, 'ModeratedPackage does not exists.');

      // check Package existence
      final pKey = dbService.emptyKey.append(Package, id: packageName);
      final p = await tx.lookupOrNull<Package>(pKey);
      InvalidInputException.check(p != null, 'Package does not exists.');

      // update deleted version list
      final versionList = await tx.query<PackageVersion>(pKey).run().toList();
      final existingVersions = versionList.map((v) => v.version!).toSet();
      final deletedVersions = (mp!.versions ?? <String>[])
          .where((v) => !existingVersions.contains(v))
          .toList();
      if (deletedVersions.isNotEmpty) {
        p!.deletedVersions = <String>{
          ...?p.deletedVersions,
          ...deletedVersions,
        }.toList();
      }

      tx.insert(p!);
      tx.delete(mpKey);
    });
    await purgePackageCache(packageName);

    return {
      'package': packageName,
      'merged': true,
    };
  },
);
