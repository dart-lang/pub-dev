// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:appengine/appengine.dart';
import 'package:args/args.dart';
import 'package:gcloud/db.dart';

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/history/backend.dart';
import 'package:pub_dev/history/models.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';

final _argParser = ArgParser()
  ..addOption('package', abbr: 'p', help: 'The package to backfill.');

Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  final package = argv['package'] as String;

  useLoggingPackageAdaptor();
  await withProdServices(() async {
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
      final uploaderEmail = await accountBackend.getEmailOfUserId(pv.uploader);
      historyBackend.storeEvent(PackageUploaded(
        packageName: package,
        packageVersion: pv.version,
        uploaderId: pv.uploader,
        uploaderEmail: uploaderEmail,
        timestamp: pv.created,
      ));
    }
  }
}
