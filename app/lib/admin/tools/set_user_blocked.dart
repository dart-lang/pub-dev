// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/shared/email.dart';

Future<String> executeSetUserBlocked(List<String> args) async {
  if (args.isEmpty || args.length > 2) {
    return 'Sets the blocked flag on a User.\n'
        '  <tools-command> <id|email> - get status\n'
        '  <tools-command> <id|email> <true|false> - set status\n';
  }
  final idOrEmail = args[0];
  final valueAsString = args.length == 2 ? args[1] : null;
  final blockedStatus = _parseValue(valueAsString);

  final List<User> users;
  if (isValidEmail(idOrEmail)) {
    users = await accountBackend.lookupUsersByEmail(idOrEmail);
  } else {
    final user = await accountBackend.lookupUserById(idOrEmail);
    users = user == null ? [] : [user];
  }
  if (users.isEmpty) {
    return 'No user found.';
  }
  final output = StringBuffer();
  for (final user in users) {
    if (blockedStatus == null) {
      output.write('userId: ${user.userId}\n'
          'email: ${user.email}\n'
          'isBlocked: ${user.isBlocked}\n');
    } else {
      await accountBackend.updateBlockedFlag(user.userId, blockedStatus);
      output.writeln('Updated: ${user.userId} -> $blockedStatus');
    }
  }
  return output.toString();
}

bool? _parseValue(String? value) {
  if (value == null) return null;
  if (value == 'true') return true;
  if (value == 'false') return false;
  throw ArgumentError('Unknown bool value: $value');
}
