// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../account/backend.dart';
import '../../shared/configuration.dart';
import '../backend.dart';
import 'actions.dart';

final packageVersionDelete = AdminAction(
    name: 'package-version-delete',
    options: {
      'package': 'name of package to delete',
      'version': 'version of package',
    },
    summary: 'Deletes package <package> version <version>.',
    description: '''
Deletes package <package> version <version>.

Deletes all associated resources:

* PackageVersions
* PackageVersionAsset
* archives (might be retrievable from backup)

The package version will be "tombstoned" and same version cannot be published
later.
''',
    invoke: (args) async {
      await requireAuthenticatedAdmin(AdminPermission.removePackage);
      final packageName = args['package'];
      if (packageName == null) {
        throw InvalidInputException('Missing `package` argument');
      }
      final version = args['version'];
      if (version == null) {
        throw InvalidInputException('Missing `version` argument');
      }
      final result =
          await adminBackend.removePackageVersion(packageName, version);

      return {
        'message': 'Package version and all associated resources deleted.',
        'package': packageName,
        'version': version,
        'deletedPackageVersions': result.deletedPackageVersions,
        'deletedPackageVersionInfos': result.deletedPackageVersionInfos,
        'deletedPackageVersionAssets': result.deletedPackageVersionAssets,
      };
    });
