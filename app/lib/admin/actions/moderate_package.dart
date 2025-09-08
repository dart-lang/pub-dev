// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../admin/backend.dart';
import '../../admin/models.dart';
import '../../package/backend.dart';
import '../../package/models.dart';
import '../../scorecard/backend.dart';
import '../../shared/datastore.dart';
import 'actions.dart';

final moderatePackage = AdminAction(
  name: 'moderate-package',
  summary: 'Set the moderated flag on a package (making it not visible).',
  description: '''
Set the moderated flag on a package (updating the flag and the timestamp).

Note: the action may take a longer time to complete as the public archive bucket
      will be updated: on moderation the files will be deleted, on restore the
      archive files will be copied over from the (private) canonical archive bucket.
''',
  options: {
    'case':
        'The ModerationCase.caseId that this action is part of (or `none`).',
    'package': 'The package name to be moderated',
    'state':
        'Set moderated state true / false. Returns current state if omitted.',
    'note': 'Optional note to store (internal).',
  },
  invoke: (options) async {
    final caseId = options['case'];

    final package = options['package'];
    final state = options['state'];
    final note = options['note'];

    final refCase = await adminBackend
        .loadAndVerifyModerationCaseForAdminAction(caseId);

    return await adminMarkPackageVisibility(
      package,
      state: state,
      whenUpdating: (tx, p, valueToSet) async {
        p.updateIsModerated(isModerated: valueToSet);

        if (refCase != null) {
          final mc = await tx.lookupValue<ModerationCase>(refCase.key);
          mc.addActionLogEntry(
            ModerationSubject.package(package!).fqn,
            valueToSet ? ModerationAction.apply : ModerationAction.revert,
            note,
          );
          tx.insert(mc);
        }
      },
      valueFn: (p) => {
        'isModerated': p.isModerated,
        'moderatedAt': p.moderatedAt?.toIso8601String(),
      },
    );
  },
);

/// Changes the moderated or the admin-deleted flag and timestamp on a [package].
Future<Map<String, dynamic>> adminMarkPackageVisibility(
  String? package, {

  /// `true`, `false` or `null`
  required String? state,

  /// The updates to apply during the transaction.
  required Future<void> Function(
    TransactionWrapper tx,
    Package v,
    bool valueToSet,
  )
  whenUpdating,

  /// The debug information to return.
  required Map Function(Package v) valueFn,
}) async {
  InvalidInputException.check(
    package != null && package.isNotEmpty,
    'package must be given',
  );

  bool? valueToSet;
  switch (state) {
    case 'true':
      valueToSet = true;
      break;
    case 'false':
      valueToSet = false;
      break;
  }

  final p = await packageBackend.lookupPackage(package!);
  if (p == null) {
    throw NotFoundException.resource(package);
  }

  Package? p2;
  if (valueToSet != null) {
    p2 = await withRetryTransaction(dbService, (tx) async {
      final pkg = await tx.lookupValue<Package>(p.key);
      await whenUpdating(tx, pkg, valueToSet!);
      tx.insert(pkg);
      return pkg;
    });

    await triggerPackagePostUpdates(package, exportForceDelete: true).future;

    // retract or re-populate public archive files
    await packageBackend.tarballStorage.updatePublicArchiveBucket(
      package: package,
      ageCheckThreshold: Duration.zero,
      deleteIfOlder: Duration.zero,
    );

    await purgeScorecardData(package, p2!.latestVersion!, isLatest: true);
  }

  return {
    'package': p.name,
    'before': valueFn(p),
    if (p2 != null) 'after': valueFn(p2),
  };
}
