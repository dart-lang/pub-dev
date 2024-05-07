// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../admin/backend.dart';
import '../../admin/models.dart';
import '../../package/backend.dart';
import '../../package/models.dart';
import '../../shared/datastore.dart';
import '../../task/backend.dart';
import '../../tool/maintenance/update_public_bucket.dart';
import 'actions.dart';

final moderatePackage = AdminAction(
  name: 'moderate-package',
  summary: 'Set the moderated flag on a package (making it not visible).',
  description: '''
Set the moderated flag on a package (updating the flag and the timestamp).
''',
  options: {
    'case': 'The ModerationCase.caseId that this action is part of.',
    'package': 'The package name to be moderated',
    'state':
        'Set moderated state true / false. Returns current state if omitted.',
    'message': 'Optional message to store and send out.'
  },
  invoke: (options) async {
    final caseId = options['case'];
    InvalidInputException.check(
      caseId != null && caseId.isNotEmpty,
      'case must be given',
    );

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

    final message = options['message'];

    final refCase = await adminBackend.lookupModerationCase(caseId!);
    if (refCase == null) {
      throw NotFoundException.resource(caseId);
    }

    final p = await packageBackend.lookupPackage(package!);
    if (p == null) {
      throw NotFoundException.resource(package);
    }

    Package? p2;
    if (valueToSet != null) {
      p2 = await withRetryTransaction(dbService, (tx) async {
        final pkg = await tx.lookupValue<Package>(p.key);
        pkg.updateIsModerated(isModerated: valueToSet!);
        tx.insert(pkg);

        final mc = await tx.lookupValue<ModerationCase>(refCase.key);
        mc.addActionLogEntry(
          ModerationSubject.package(package).fqn,
          valueToSet ? ModerationAction.apply : ModerationAction.revert,
          message,
        );
        tx.insert(mc);

        return pkg;
      });

      // retract or re-populate public archive files
      await updatePublicArchiveBucket(
        package: package,
        ageCheckThreshold: Duration.zero,
        deleteIfOlder: Duration.zero,
      );

      await taskBackend.trackPackage(package);
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
