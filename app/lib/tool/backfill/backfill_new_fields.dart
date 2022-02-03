// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:pub_package_reader/pub_package_reader.dart';
import 'package:retry/retry.dart';

import '../../package/backend.dart';
import '../../package/models.dart';
import '../../shared/datastore.dart';
import '../../shared/utils.dart';
import 'backfill_packageversions.dart';

final _logger = Logger('backfill_new_fields');

/// Backfills new fields that are introduced in a release.
///
/// Fields should be added here as they are added to the models.
/// CHANGELOG.md must be updated with the new fields, and the next
/// release could remove the backfill from here.
Future<void> backfillNewFields() async {
  _logger.info('Backfill package versions with known version issues...');
  final query = dbService.query<PackageVersion>();
  await for (final pv in query.run()) {
    if (pv.pubspec!.hasBadVersionFormat) {
      _logger.info(
          'Starting to backfill package version "${pv.qualifiedVersionKey}"...');
      await retry(() async {
        await withTempDirectory((d) async {
          final archivePath = p.join(d.path, 'archive.tar.gz');
          await tarballStorage
              .download(pv.package, pv.version!)
              .pipe(File(archivePath).openWrite());
          final archive =
              await summarizePackageArchive(archivePath, created: pv.created!);
          final stats = await backfillPackageVersion(
            package: pv.package,
            version: pv.version!,
            archive: archive,
            versionCreated: pv.created!,
          );
          _logger.info(
              'Backfilled package version "${pv.qualifiedVersionKey}": $stats');
        });
      });
    }
  }
}
