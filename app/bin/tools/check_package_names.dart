// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';

import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';
import 'package:pub_dartlang_org/shared/utils.dart';

Future main(List<String> args) async {
  final names = <String>[];

  await withProdServices(() async {
    await for (Package p in dbService.query<Package>().run()) {
      names.add(p.name);
      if (names.length % 100 == 0) {
        print('Scanned: ${names.length} packages [current: ${p.name}].');
      }
    }
  });

  final stripped = <String, List<String>>{};
  for (String name in names) {
    stripped.putIfAbsent(_stripName(name), () => []).add(name);
  }

  print('\nCase sensitive names:\n');
  for (String name in names) {
    final bool isLower = name == name.toLowerCase();
    final bool matchesMixedCase = knownMixedCasePackages
        .any((s) => s.toLowerCase() == name.toLowerCase());
    if (isLower && matchesMixedCase) {
      print('Both mixed and lowercase: $name');
    } else if (!isLower && matchesMixedCase) {
      print('Known mixed case: $name');
    } else if (!isLower && !matchesMixedCase) {
      print('Unknown mixed case: $name');
    } else {
      assert(isLower && !matchesMixedCase);
    }
  }

  print('\nTypo-squatting:\n');
  for (String key in stripped.keys) {
    final values = stripped[key];
    if (values.length > 1) {
      print('Conflicting key ($key) with values: $values');
    }
  }
}

String _stripName(String name) => name
    .toLowerCase()
    .replaceAll('_', '')
    // We don't allow these in package names, but won't hurt here.
    .replaceAll('-', '')
    .replaceAll('.', '');
