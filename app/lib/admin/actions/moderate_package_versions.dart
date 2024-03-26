// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/utils/sdk_version_cache.dart';
import 'package:clock/clock.dart';

import '../../package/backend.dart';
import '../../package/models.dart';
import '../../shared/datastore.dart';
import '../../shared/versions.dart';
import '../../task/backend.dart';
import '../../tool/maintenance/update_public_bucket.dart';

import 'actions.dart';

final moderatePackageVersion = AdminAction(
  name: 'moderate-package-version',
  summary:
      'Set the moderated flag on a package version (making it not visible).',
  description: '''
Set the moderated flag on a package version (updating the flag and the timestamp).
''',
  options: {
    'package': 'The package name to be moderated',
    'version': 'The version to be moderated',
    'state':
        'Set moderated state true / false. Returns current state if omitted.',
  },
  invoke: (options) async {
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
        if (pkg.mayAffectLatestVersions(v.semanticVersion)) {
          final versions =
              await tx.query<PackageVersion>(pkg.key).run().toList();
          pkg.updateLatestVersionReferences(
            versions,
            dartSdkVersion: currentDartSdk.semanticVersion,
            flutterSdkVersion: currentFlutterSdk.semanticVersion,
            replaced: v,
          );
        }
        pkg.updated = clock.now().toUtc();
        tx.insert(pkg);

        return v;
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
