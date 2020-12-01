// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';

void _printHelp() {
  print('Sets the blocked flag on a User.');
  print('  dart bin/tools/set_user_blocked.dart <id|email> - get status');
  print(
      '  dart bin/tools/set_user_blocked.dart <id|email> <true|false> - set status');
}

/// Sets the private key value.
Future main(List<String> args) async {
  if (args.isEmpty || args.length > 2) {
    _printHelp();
    return;
  }
  final idOrEmail = args[0];
  final valueAsString = args.length == 2 ? args[1] : null;
  final blockedStatus = _parseValue(valueAsString);

  await withToolRuntime(() async {
    final user = await accountBackend.lookupUserById(idOrEmail) ??
        await accountBackend.lookupUserByEmail(idOrEmail);
    if (user == null) {
      print('No user found.');
      return;
    }
    if (blockedStatus == null) {
      print('userId: ${user.userId}');
      print('email: ${user.email}');
      print('isBlocked: ${user.isBlocked}');
      return;
    }
    await accountBackend.updateBlockedFlag(user.userId, blockedStatus);
  });
}

bool _parseValue(String value) {
  if (value == null) return null;
  if (value == 'true') return true;
  if (value == 'false') return false;
  throw ArgumentError('Unknown bool value: $value');
}
