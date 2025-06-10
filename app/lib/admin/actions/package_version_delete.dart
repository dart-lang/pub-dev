// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../account/backend.dart';
import '../../shared/configuration.dart';
import 'actions.dart';
import 'moderate_package_versions.dart';

final packageVersionDelete = AdminAction(
  name: 'package-version-delete',
  summary:
      'Set the admin-deleted flag on a package version (making it not visible).',
  description: '''
Set the admin-deleted flag on a package version (updating the flag and the timestamp).

A package version in this state will appear deleted from the public. But its archive file will still exist in the canonical bucket, and the metadata will still be present.

After 2 months it will be fully purged.

To undo a deletion run the same command with `state: false`.
''',
  options: {
    'package': 'The package name to be deleted',
    'version': 'The version to be deleted',
    'state':
        'Set admin-deleted state true / false. Returns current state if omitted.',
  },
  invoke: (args) async {
    await requireAuthenticatedAdmin(AdminPermission.removePackage);
    final package = args['package'];
    final version = args['version'];
    final state = args['state'];
    return await adminMarkPackageVersionVisibility(
      package,
      version,
      state: state,
      whenUpdating: (tx, v, valueToSet) async {
        v.updateIsAdminDeleted(isAdminDeleted: valueToSet);
      },
      valueFn: (v) => {
        'isAdminDeleted': v.isAdminDeleted,
        'adminDeletedAt': v.adminDeletedAt?.toIso8601String(),
      },
    );
  },
);
