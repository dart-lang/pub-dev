// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:pub_dev/service/secret/backend.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';

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
    await secretBackend.update(id, value);
  });
}
