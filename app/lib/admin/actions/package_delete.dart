// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../account/backend.dart';
import '../../shared/configuration.dart';
import 'actions.dart';
import 'moderate_package.dart';

final packageDelete = AdminAction(
  name: 'package-delete',
  summary: 'Set the admin-deleted flag on a package (making it not visible).',
  description: '''
Set the admin-deleted flag on a package (updating the flag and the timestamp).

A package in this state will appear deleted from the public. But its archive file will still exist in the canonical bucket, and the metadata will still be present.

After 2 months it will be fully purged.

To undo a deletion <insert action here>
''',
  options: {
    'package': 'The package name to be deleted',
    'state':
        'Set admin-deleted state true / false. Returns current state if omitted.',
  },
  invoke: (args) async {
    await requireAuthenticatedAdmin(AdminPermission.removePackage);
    final package = args['package'];
    final state = args['state'];
    return await adminMarkPackageVisibility(
      package,
      state: state,
      whenUpdating: (tx, p, valueToSet) async {
        p.updateIsAdminDeleted(isAdminDeleted: valueToSet);
      },
      valueFn: (p) => {
        'isAdminDeleted': p.isAdminDeleted,
        'adminDeletedAt': p.adminDeletedAt?.toIso8601String(),
      },
    );
  },
);
