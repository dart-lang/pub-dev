// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/shared/datastore.dart';

import 'actions.dart';

final packageReservationDelete = AdminAction(
  name: 'package-reservation-delete',
  summary: 'Deletes a ReservedPackage entity.',
  description: '''
Deletes a ReservedPackage entity, allowing the package name use by any user.
''',
  options: {
    'package': 'The package reservation to be deleted.',
  },
  invoke: (options) async {
    final package = options['package'];
    InvalidInputException.check(
      package != null && package.isNotEmpty,
      '`package` must be given',
    );

    final rp = await packageBackend.lookupReservedPackage(package!);
    if (rp == null) {
      throw NotFoundException('ReservedPackage `$package` does not exist.');
    }

    await dbService.commit(deletes: [rp.key]);

    return {
      'ReservedPackage': {
        'name': rp.name,
        'emails': rp.emails,
        'deleted': true,
      },
    };
  },
);
