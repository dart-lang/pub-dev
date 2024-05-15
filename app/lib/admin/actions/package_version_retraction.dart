// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/account/agent.dart';
import 'package:pub_dev/admin/actions/actions.dart';
import '../../package/backend.dart';
import '../../package/models.dart';
import '../../shared/datastore.dart';

final packageVersionRetraction = AdminAction(
    name: 'package-version-retraction',
    options: {
      'package': 'name of the package',
      'version': 'version to update',
      'set-retracted': 'true/false, whether to retract the package version',
    },
    summary: 'Update retraction status for a package version',
    description: '''
This action will view/update retraction status for a package version.
The `package` option specifies which package, and the `version` option specifies
which version.

If the `set-retracted` option is not specified, this will return current status.
Otherwise, it will set the package version as retracted depending on the
value of `set-retracted`, which should either be `true` or `false`.
''',
    invoke: (args) async {
      final packageName = args['package'];
      if (packageName == null) {
        throw InvalidInputException('Missing --package argument.');
      }
      final version = args['version'];
      if (version == null) {
        throw InvalidInputException('Missing --version argument.');
      }
      final isRetracted = switch (args['set-retracted']) {
        'true' => true,
        'false' => false,
        null => null,
        _ => throw InvalidInputException('Invalid --set-retracted'),
      };

      final pkg = await packageBackend.lookupPackage(packageName);
      if (pkg == null) {
        throw NotFoundException.resource(packageName);
      }

      final packageVersion =
          await packageBackend.lookupPackageVersion(packageName, version);
      if (packageVersion == null) {
        throw NotFoundException.resource(version);
      }
      final before = {
        'package': packageVersion.package,
        'version': packageVersion.version,
        'isRetracted': packageVersion.isRetracted,
      };
      if (isRetracted == null) {
        return {
          'before': before,
        };
      }

      final versionKey = pkg.key.append(PackageVersion, id: version);
      final after = await withRetryTransaction(dbService, (tx) async {
        final p = await tx.lookupValue<Package>(pkg.key);
        final pv = await tx.lookupOrNull<PackageVersion>(versionKey);
        if (pv == null) {
          throw NotFoundException.resource(version);
        }
        if (pv.isModerated) {
          throw ModeratedException.packageVersion(packageName, version);
        }

        if (isRetracted != pv.isRetracted) {
          await packageBackend.doUpdateRetractedStatus(
            SupportAgent(),
            tx,
            p,
            pv,
            isRetracted,
          );
        }
        return {
          'package': pv.package,
          'version': pv.version,
          'isRetracted': pv.isRetracted,
        };
      });
      await purgePackageCache(packageName);

      return {
        'before': before,
        'after': after,
      };
    });
