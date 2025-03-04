// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../account/backend.dart';
import '../../shared/configuration.dart';
import '../backend.dart';
import 'actions.dart';

final packageDelete = AdminAction(
    name: 'package-delete',
    options: {
      'package': 'name of package to delete',
    },
    summary: 'Deletes package <package>.',
    description: '''
Deletes package <package>.

Deletes all associated resources:

* PackageVersions
* Likes
* AuditLogRecords
* PackageVersionAsset
* replacedBy references
* archives (might be retrievable from backup)

The package will be "tombstoned" and no package with the same name can be 
published later.
''',
    invoke: (args) async {
      final packageName = args['package'];
      if (packageName == null) {
        throw InvalidInputException('Missing `package` argument');
      }

      await requireAuthenticatedAdmin(AdminPermission.removePackage);
      final result = await adminBackend.removePackage(packageName);

      return {
        'message': '''
Package and all associated resources deleted.

A tombstone has been created

'NOTICE: Redis caches referencing the package will expire given time.'
''',
        'package': packageName,
        'deletedPackages': result.deletedPackages,
        'deletedPackageVersions': result.deletedPackageVersions,
        'deletedPackageVersionInfos': result.deletedPackageVersionInfos,
        'deletedPackageVersionAssets': result.deletedPackageVersionAssets,
        'deletedLikes': result.deletedLikes,
        'deletedAuditLogs': result.deletedAuditLogs,
        'replacedByFixes': result.replacedByFixes,
      };
    });
