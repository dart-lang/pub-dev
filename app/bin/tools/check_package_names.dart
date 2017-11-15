// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';

import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';
import 'package:pub_dartlang_org/shared/utils.dart';

Future main(List<String> args) async {
  await withProdServices(() async {
    await for (Package p in dbService.query(Package).run()) {
      final bool isLower = p.name == p.name.toLowerCase();
      final bool matchesMixedCase = knownMixedCasePackages
          .any((s) => s.toLowerCase() == p.name.toLowerCase());
      if (isLower && matchesMixedCase) {
        print('Both mixed and lowercase: ${p.name}');
      } else if (!isLower && matchesMixedCase) {
        print('Known mixed case: ${p.name}');
      } else if (!isLower && !matchesMixedCase) {
        print('Unknown mixed case: ${p.name}');
      } else {
        assert(isLower && !matchesMixedCase);
      }
    }
  });
}
