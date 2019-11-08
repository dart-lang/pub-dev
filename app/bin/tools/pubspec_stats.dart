// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:appengine/appengine.dart';
import 'package:gcloud/db.dart';

import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';

Future main(List<String> args) async {
  useLoggingPackageAdaptor();
  await withProdServices(() async {
    final counts = <String, int>{};

    int index = 0;
    final query = dbService.query<PackageVersion>();
    await for (PackageVersion pv in query.run()) {
      index++;
      if (index % 100 == 0) {
        print('$index - ${pv.package} ${pv.version}');
      }
      pv.pubspec.asJson.keys.forEach((key) {
        final keyAsString = key.toString();
        counts[keyAsString] = (counts[keyAsString] ?? 0) + 1;
      });
    }

    final sortedKeys = counts.keys.toList()..sort();
    for (String key in sortedKeys) {
      print('$key: ${counts[key]}');
    }
  });
}
