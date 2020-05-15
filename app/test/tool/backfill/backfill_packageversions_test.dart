// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:pub_dev/package/models.dart';
import 'package:test/test.dart';

import 'package:pub_dev/tool/backfill/backfill_packageversions.dart';

import '../../shared/test_models.dart';
import '../../shared/test_services.dart';

void main() {
  group('normalization tests', () {
    testWithServices('no update', () async {
      final stats = await backfillAllVersionsOfPackage('hydrogen');
      expect(stats.versionCount, 13);
      expect(stats.pvInfoCount, 0);
      expect(stats.pvPubspecCount, 0);
    });

    testWithServices('info missing', () async {
      final lastId =
          hydrogen.versions.last.qualifiedVersionKey.qualifiedVersion;
      await dbService.commit(deletes: [
        dbService.emptyKey.append(PackageVersionInfo, id: lastId),
      ]);
      final stats = await backfillAllVersionsOfPackage('hydrogen');
      expect(stats.versionCount, 13);
      expect(stats.pvInfoCount, 1);
      expect(stats.pvPubspecCount, 0);
    });

    testWithServices('pubspec missing', () async {
      final lastId =
          hydrogen.versions.last.qualifiedVersionKey.qualifiedVersion;
      await dbService.commit(deletes: [
        dbService.emptyKey.append(PackageVersionPubspec, id: lastId)
      ]);
      final stats = await backfillAllVersionsOfPackage('hydrogen');
      expect(stats.versionCount, 13);
      expect(stats.pvInfoCount, 0);
      expect(stats.pvPubspecCount, 1);
    });
  });
}
