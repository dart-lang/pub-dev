// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';

import 'package:pub_dartlang_org/analyzer/models.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';

Future main(List<String> arguments) async {
  await withProdServices(() async {
    await _deleteWithQuery('Analysis', dbService.query<Analysis>());
    await _deleteWithQuery(
        'PackageVersionAnalysis', dbService.query<PackageVersionAnalysis>());
    await _deleteWithQuery(
        'PackageAnalysis', dbService.query<PackageAnalysis>());
  });
}

Future _deleteWithQuery<T>(String name, Query query) async {
  final deletes = <Key>[];
  int total = 0;
  await for (Model m in query.run()) {
    deletes.add(m.key);
    total++;
    if (deletes.length >= 100) {
      print('Deleting ${deletes.length} $name (total: $total)...');
      await dbService.commit(deletes: deletes);
      deletes.clear();
    }
  }
  if (deletes.isNotEmpty) {
    print('Deleting ${deletes.length} $name (total: $total)...');
    await dbService.commit(deletes: deletes);
    deletes.clear();
  }
}
