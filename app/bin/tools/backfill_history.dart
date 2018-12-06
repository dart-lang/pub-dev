// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:appengine/appengine.dart';
import 'package:args/args.dart';
import 'package:gcloud/db.dart';

import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';
import 'package:pub_dartlang_org/history/backend.dart';
import 'package:pub_dartlang_org/history/models.dart';

final _argParser = new ArgParser()
  ..addOption('package', abbr: 'p', help: 'The package to backfill.');

Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  final String package = argv['package'];

  useLoggingPackageAdaptor();
  await withProdServices(() async {
    registerHistoryBackend(new HistoryBackend(dbService));

    if (package != null) {
      await _backfillPackage(package);
    } else {
      await for (Package p in dbService.query<Package>().run()) {
        await _backfillPackage(p.name);
      }
    }
  });
}

Future _backfillPackage(String package) async {
  print('Backfill history in: $package');
  final packageKey = dbService.emptyKey.append(Package, id: package);
  final query = dbService.query<PackageVersion>(ancestorKey: packageKey);
  await for (PackageVersion pv in query.run()) {
    bool hasUploaded = false;
    await for (History history in historyBackend.getAll(
        packageName: package, packageVersion: pv.version)) {
      if (history.historyEvent is PackageUploaded) {
        hasUploaded = true;
      }
    }
    if (!hasUploaded) {
      final history = new History.entry(
        source: HistorySource.account,
        event: new PackageUploaded(
          packageName: package,
          packageVersion: pv.version,
          uploaderEmail: pv.uploaderEmail,
          timestamp: pv.created,
        ),
      );
      historyBackend.store(history);
    }
  }
}
