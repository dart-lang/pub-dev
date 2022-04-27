// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:pub_dev/service/secret/backend.dart';

String _printHelp() {
  return 'Sets the Secret value.\n'
      '  dart bin/tools/set_secret.dart [id] [value]';
}

/// Sets the private Secret value.
Future<String> executeSetSecret(List<String> args) async {
  if (args.isEmpty || args.length != 2) {
    return _printHelp();
  }
  final String id = args[0];
  final String value = args[1];

  if (!SecretKey.isValid(id)) {
    return 'ID should be one of [${SecretKey.values}] or prefixed'
        ' ${SecretKey.oauthPrefix}.';
  }

  await secretBackend.update(id, value);
  return 'Done.';
}
