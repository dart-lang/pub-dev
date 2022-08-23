// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:pub_dev/publisher/backend.dart';

Future<String> executePublisherMember(List<String> args) async {
  if (args.length != 1) {
    return 'Tool to check publisher member info.\n'
        '  <tools-command> <publisherId> - list current members\n';
  }
  final publisherId = args.single;

  final members = await publisherBackend.listPublisherMembers(publisherId);
  return members.map((e) => '${e.userId} ${e.email} ${e.role}\n').join();
}
