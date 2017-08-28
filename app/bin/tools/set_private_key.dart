// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';

import 'package:pub_dartlang_org/frontend/keys.dart';
import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';

void _printHelp() {
  print('Sets the private key value.');
  print('  dart bin/tools/set_private_key.dart [id] [value]');
}

final List<String> allowedIds = [
  notificationSecretKey,
];

/// Sets the private key value.
Future main(List<String> args) async {
  if (args.isEmpty || args.length != 2) {
    _printHelp();
    return;
  }
  final String id = args[0];
  final String value = args[1];

  if (!allowedIds.contains(id)) {
    print('ID should be one of [$allowedIds].');
    return;
  }

  await withProdServices(() async {
    await dbService.withTransaction((Transaction t) async {
      final PrivateKey pk =
          (await t.lookup([dbService.emptyKey.append(PrivateKey, id: id)]))
              .single;
      if (pk == null) {
        t.queueMutations(inserts: [
          new PrivateKey()
            ..parentKey = dbService.emptyKey
            ..id = id
            ..value = value,
        ]);
      } else {
        t.queueMutations(inserts: [pk..value = value]);
      }
      await t.commit();
    });
  });
}
