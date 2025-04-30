// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/package/api_export/api_exporter.dart';
import '../../package/backend.dart';
import '../../package/models.dart';
import '../../shared/datastore.dart';

final packageVersionFixSha256 = AdminAction(
  name: 'package-version-fix-sha256',
  options: {
    'package': 'name of the package',
    'version': 'version',
  },
  summary: 'Update the sha256 field for a package version',
  description: '''
This action will recalculate and update sha256 field for a package version.
The `package` option specifies which package, and the `version` option specifies
which version.
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
      'sha256': hex.encode(packageVersion.sha256 ?? []),
    };

    final archive = await packageBackend.tarballStorage
        .getCanonicalArchiveBytes(
            packageVersion.package, packageVersion.version!);
    final hash = sha256.convert(archive).bytes;

    final after = await withRetryTransaction(dbService, (tx) async {
      final p = await tx.lookupValue<Package>(pkg.key);
      p.updated = clock.now().toUtc();

      final pv = await tx.lookupOrNull<PackageVersion>(packageVersion.key);
      if (pv == null) {
        throw NotFoundException.resource(version);
      }

      pv.sha256 = hash;
      tx.insert(p);
      tx.insert(pv);

      return {
        'sha256': hex.encode(pv.sha256!),
      };
    });
    await purgePackageCache(packageName);
    await apiExporter!.synchronizePackage(packageName);

    return {
      'package': packageVersion.package,
      'version': packageVersion.version,
      'before': before,
      'after': after,
    };
  },
);
