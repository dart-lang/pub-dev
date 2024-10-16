// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/datastore.dart';

import 'actions.dart';

final packageDiscontinue = AdminAction(
  name: 'package-discontinue',
  summary: 'Sets the package discontinued.',
  description: '''
Sets the `Package.isDiscontinued` and `Package.replacedBy` properties.
''',
  options: {
    'package': 'The package to be discontinued.',
    'value': 'The value to set (defaults to true).',
    'replaced-by':
        'The Package.replacedBy field (if not set will be set to `null`).',
  },
  invoke: (options) async {
    final package = options['package'];
    InvalidInputException.check(
      package != null && package.isNotEmpty,
      '`package` must be given',
    );
    final value = options['value'] ?? 'true';
    InvalidInputException.checkAnyOf(value, 'value', ['true', 'false']);
    final valueToSet = value == 'true';

    final p = await packageBackend.lookupPackage(package!);
    if (p == null) {
      throw NotFoundException.resource(package);
    }

    final replacedBy = options['replaced-by'];
    if (replacedBy != null) {
      final rp = await packageBackend.lookupPackage(replacedBy);
      if (rp == null) {
        throw NotFoundException('Replacing package "$replacedBy" not found.');
      }
    }

    final info = await withRetryTransaction(dbService, (tx) async {
      final pkg = await tx.lookupOrNull<Package>(p.key);
      if (pkg == null) {
        throw NotFoundException.resource(package);
      }
      pkg.isDiscontinued = valueToSet;
      pkg.replacedBy = valueToSet ? replacedBy : null;
      pkg.updated = clock.now().toUtc();
      tx.insert(pkg);
      return pkg;
    });

    return {
      'package': {
        'name': info.name,
        'isDiscontinued': info.isDiscontinued,
        'replacedBy': info.replacedBy,
      },
    };
  },
);
