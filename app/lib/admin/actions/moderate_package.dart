// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/tool/maintenance/update_public_bucket.dart';

final moderatePackage = AdminAction(
  name: 'moderate-package',
  summary: 'Set the moderated flag on a package (making it not visible).',
  description: '''
Set the moderated flag on a package (updating the flag and the timestamp).
''',
  options: {
    'package': 'The package name to be moderated',
    'state':
        'Set moderated state true / false. Returns current state if omitted.',
  },
  invoke: (options) async {
    final package = options['package'];
    InvalidInputException.check(
      package != null && package.isNotEmpty,
      'package must be given',
    );

    final state = options['state'];
    bool? valueToSet;
    switch (state) {
      case 'true':
        valueToSet = true;
        break;
      case 'false':
        valueToSet = false;
        break;
    }

    var p = await packageBackend.lookupPackage(package!);
    if (p == null) {
      throw NotFoundException.resource(package);
    }

    Package? p2;
    if (valueToSet != null) {
      p2 = await withRetryTransaction(dbService, (tx) async {
        final pkg = await tx.lookupValue<Package>(p!.key);
        pkg.updateIsModerated(isModerated: valueToSet!);
        tx.insert(pkg);
        return pkg;
      });

      // retract public archive files
      await updatePublicArchiveBucket(
        package: package,
        ageCheckThreshold: Duration.zero,
        deleteIfOlder: Duration.zero,
      );

      await purgePackageCache(package);
    }

    return {
      'package': p.name,
      'before': {
        'isModerated': p.isModerated,
        'moderatedAt': p.moderatedAt?.toIso8601String(),
      },
      if (p2 != null)
        'after': {
          'isModerated': p2.isModerated,
          'moderatedAt': p2.moderatedAt?.toIso8601String(),
        },
    };
  },
);
