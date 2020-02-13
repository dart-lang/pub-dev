// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';

import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';

/// Checks whether the User entries are all-lowercase, or some of them have
/// uppercase characters too.
Future main(List<String> args) async {
  int count = 0;
  await withProdServices(() async {
    final bad = <String>{};
    final good = <String>{};
    final query = dbService.query<User>();
    await for (User user in query.run()) {
      count++;
      if (count % 100 == 0) {
        print(count);
      }
      if (user.email != user.email.toLowerCase()) {
        bad.add(user.email);
        print('BAD: ${user.userId} ${user.email}');
      } else {
        good.add(user.email);
      }
    }

    final intersect = bad.where((s) => good.contains(s.toLowerCase())).length;
    print('$count User entity checked.');
    print('${bad.length} bad, ${good.length} good, $intersect intersect');
  });
}
