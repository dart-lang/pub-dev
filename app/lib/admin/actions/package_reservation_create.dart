// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/shared/redis_cache.dart';

import 'actions.dart';

final packageReservationCreate = AdminAction(
  name: 'package-reservation-create',
  summary: 'Creates a ReservedPackage entity.',
  description: '''
Reserves a package name that can be claimed by the specified list of email addresses.

The action can be re-run with the same package name. In such cases the previous
email list will be discarded, and the specified email list will be updated to the
existing ReservedPackage entity.

When no emails are specified, the package will be reserved, but no user may be
able to claim it.
''',
  options: {
    'package': 'The package name to be reserved.',
    'emails': 'The list of email addresses, separated by comma.',
  },
  invoke: (options) async {
    final package = options['package'];
    InvalidInputException.check(
      package != null && package.isNotEmpty,
      '`package` must be given',
    );
    final emails = options['emails']?.split(',');

    final p = await packageBackend.lookupPackage(package!);
    if (p != null) {
      throw InvalidInputException('Package `$package` exists.');
    }
    await packageBackend.mirrorPackageTombstoneToSqlByName(package);
    final mp = await packageBackend.lookupModeratedPackage(package);
    if (mp != null) {
      throw InvalidInputException('ModeratedPackage `$package` exists.');
    }

    await packageBackend.upsertReservedPackage(
      package,
      <String>{...?emails}.toList(),
    );
    await cache.reservedPackagePrefixes().purge();
    final entry = (await packageBackend.lookupReservedPackage(package))!;

    return {
      'ReservedPackage': {
        'name': entry.name,
        'created': entry.createdAt.toIso8601String(),
        'emails': entry.emails,
      },
    };
  },
);
