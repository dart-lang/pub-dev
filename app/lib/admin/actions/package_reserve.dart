// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/datastore.dart';

import 'actions.dart';

final packageReserve = AdminAction(
  name: 'package-reserve',
  summary: 'Creates a ReservedPackage entity.',
  description: '''
Reserves a package name that can be claimed by @google.com accounts or
the allowed list of email addresses.

The action can be re-run with the same package name. In such cases the provided
email list will be added to the existing ReservedPackage entity.
''',
  options: {
    'package': 'The package name to be reserved.',
    'emails': 'The list of email addresses, separated by comma.'
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
    final mp = await packageBackend.lookupModeratedPackage(package);
    if (mp != null) {
      throw InvalidInputException('ModeratedPackage `$package` exists.');
    }

    final entry = await withRetryTransaction(dbService, (tx) async {
      final existing = await tx.lookupOrNull<ReservedPackage>(
          dbService.emptyKey.append(ReservedPackage, id: package));
      final entry = existing ?? ReservedPackage.init(package);
      if (emails != null) {
        entry.emails = <String>{...entry.emails, ...emails}.toList();
      }
      tx.insert(entry);
      return entry;
    });

    return {
      'ReservedPackage': {
        'name': entry.name,
        'created': entry.created.toIso8601String(),
        'emails': entry.emails,
      },
    };
  },
);
