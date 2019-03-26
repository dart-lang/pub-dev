// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:http/http.dart';
import 'package:pool/pool.dart';

import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/pub_client.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';

void main() async {
  await withProdServices(() async {
    final pubClient = PubClient(Client());

    int processIdx = 0;
    int missingPackages = 0;
    int missingVersions = 0;
    final pool = Pool(4);
    final futures = <Future>[];

    final packages = await pubClient.listPackages();
    for (String package in packages) {
      final data = await pubClient.getPackageData(package);

      final f = pool.withResource(() async {
        final pkgKey = dbService.emptyKey.append(Package, id: package);
        final versions = await dbService
            .query<PackageVersion>(ancestorKey: pkgKey)
            .run()
            .toList();
        final versionsExisting = versions.map((pv) => pv.version).toSet();
        final versionsToCreate =
            data.versions.where((v) => !versionsExisting.contains(v));

        final idx = processIdx++;
        final status = versionsToCreate.isEmpty
            ? 'OK'
            : 'missing ${versionsToCreate.length} versions';
        print('Package [$idx/${packages.length}] $package: $status');

        missingVersions += versionsToCreate.length;
        if (versionsToCreate.isNotEmpty) {
          final p = (await dbService.lookup([pkgKey])).single as Package;
          if (p == null) {
            missingPackages++;
          }
          // TODO: update staging Datastore
        }
      });
      futures.add(f);
    }
    await Future.wait(futures);
    await pool.close();

    print(
        'Total missing: $missingPackages packages $missingVersions versions.');
    await pubClient.close();
  });
}
