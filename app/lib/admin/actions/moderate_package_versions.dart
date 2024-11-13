// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/utils/sdk_version_cache.dart';
import 'package:clock/clock.dart';

import '../../package/api_export/api_exporter.dart';
import '../../package/backend.dart';
import '../../package/models.dart';
import '../../scorecard/backend.dart';
import '../../shared/datastore.dart';
import '../../shared/versions.dart';
import '../../task/backend.dart';

import '../backend.dart';
import '../models.dart';

import 'actions.dart';

final moderatePackageVersion = AdminAction(
  name: 'moderate-package-version',
  summary:
      'Set the moderated flag on a package version (making it not visible).',
  description: '''
Set the moderated flag on a package version (updating the flag and the timestamp).
''',
  options: {
    'case':
        'The ModerationCase.caseId that this action is part of (or `none`).',
    'package': 'The package name to be moderated',
    'version': 'The version to be moderated',
    'state':
        'Set moderated state true / false. Returns current state if omitted.',
    'note': 'Optional note to store (internal).'
  },
  invoke: (options) async {
    final caseId = options['case'];

    final package = options['package'];
    InvalidInputException.check(
      package != null && package.isNotEmpty,
      'package must be given',
    );
    final version = options['version'];
    InvalidInputException.check(
      version != null && version.isNotEmpty,
      'version must be given',
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

    final note = options['note'];

    final refCase =
        await adminBackend.loadAndVerifyModerationCaseForAdminAction(
      caseId,
      status: ModerationStatus.pending,
    );

    final p = await packageBackend.lookupPackage(package!);
    if (p == null) {
      throw NotFoundException.resource(package);
    }
    final pv = await packageBackend.lookupPackageVersion(package, version!);
    if (pv == null) {
      throw NotFoundException.resource('$package $version');
    }

    PackageVersion? pv2;
    if (valueToSet != null) {
      final currentDartSdk = await getCachedDartSdkVersion(
          lastKnownStable: toolStableDartSdkVersion);
      final currentFlutterSdk = await getCachedFlutterSdkVersion(
          lastKnownStable: toolStableFlutterSdkVersion);
      pv2 = await withRetryTransaction(dbService, (tx) async {
        final v = await tx.lookupValue<PackageVersion>(pv.key);
        v.updateIsModerated(isModerated: valueToSet!);
        tx.insert(v);

        // Update references to latest versions.
        final pkg = await tx.lookupValue<Package>(p.key);
        final versions = await tx.query<PackageVersion>(pkg.key).run().toList();
        pkg.updateVersions(
          versions,
          dartSdkVersion: currentDartSdk.semanticVersion,
          flutterSdkVersion: currentFlutterSdk.semanticVersion,
          replaced: v,
        );
        if (pkg.latestVersionKey == null) {
          throw InvalidInputException('xx');
        }
        pkg.updated = clock.now().toUtc();
        tx.insert(pkg);

        if (refCase != null) {
          final mc = await tx.lookupValue<ModerationCase>(refCase.key);
          mc.addActionLogEntry(
            ModerationSubject.package(package, version).fqn,
            valueToSet ? ModerationAction.apply : ModerationAction.revert,
            note,
          );
          tx.insert(mc);
        }

        return v;
      });

      // sync exported API(s)
      await apiExporter?.synchronizePackage(package);

      // retract or re-populate public archive files
      await packageBackend.tarballStorage.updatePublicArchiveBucket(
        package: package,
        ageCheckThreshold: Duration.zero,
        deleteIfOlder: Duration.zero,
      );

      await taskBackend.trackPackage(package);
      await purgePackageCache(package);
      await purgeScorecardData(package, version, isLatest: true);
    }

    return {
      'package': p.name,
      'version': pv.version,
      'before': {
        'isModerated': pv.isModerated,
        'moderatedAt': pv.moderatedAt?.toIso8601String(),
      },
      if (pv2 != null)
        'after': {
          'isModerated': pv2.isModerated,
          'moderatedAt': pv2.moderatedAt?.toIso8601String(),
        },
    };
  },
);
