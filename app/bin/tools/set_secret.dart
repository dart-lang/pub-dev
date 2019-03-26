// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';

import 'package:pub_dartlang_org/frontend/models.dart' show Secret, SecretKey;
import 'package:pub_dartlang_org/frontend/service_utils.dart';

void _printHelp() {
  print('Sets the Secret value.');
  print('  dart bin/tools/set_secret.dart [id] [value]');
}

/// Sets the private key value.
Future main(List<String> args) async {
  if (args.isEmpty || args.length != 2) {
    _printHelp();
    return;
  }
  final String id = args[0];
  final String value = args[1];

  if (!SecretKey.values.contains(id) && !id.startsWith(SecretKey.oauthPrefix)) {
    print('ID should be one of [${SecretKey.values}] or prefixed'
        ' ${SecretKey.oauthPrefix}.');
    return;
  }

  await withProdServices(() async {
    await dbService.withTransaction((Transaction t) async {
      final secret =
          (await t.lookup([dbService.emptyKey.append(Secret, id: id)])).single
              as Secret;
      if (secret == null) {
        t.queueMutations(inserts: [
          Secret()
            ..parentKey = dbService.emptyKey
            ..id = id
            ..value = value,
        ]);
      } else {
        t.queueMutations(inserts: [secret..value = value]);
      }
      await t.commit();
    });
  });
}
