// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:appengine/appengine.dart';
import 'package:args/args.dart';
import 'package:gcloud/db.dart';
import 'package:pool/pool.dart';

import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';

final _argParser = ArgParser()
  ..addOption('concurrency',
      abbr: 'c', defaultsTo: '1', help: 'Number of concurrent processing.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  if (argv['help'] as bool == true) {
    print('Usage: dart backfill_users.dart');
    print('Ensures User.isDeleted is set to false by default.');
    print(_argParser.usage);
    return;
  }

  final concurrency = int.parse(argv['concurrency'] as String);

  useLoggingPackageAdaptor();
  await withProdServices(() async {
    final pool = Pool(concurrency);
    final futures = <Future>[];

    await for (User u in dbService.query<User>().run()) {
      final f = pool.withResource(() => _backfillUser(u));
      futures.add(f);
    }

    await Future.wait(futures);
    await pool.close();
  });
}

Future _backfillUser(User user) async {
  if (user.isDeletedFlag != null) return;
  print('Backfill User: ${user.userId} / ${user.email}');

  await dbService.withTransaction((tx) async {
    final u = (await dbService.lookup<User>([user.key])).single;
    u.isDeletedFlag ??= false;
    tx.queueMutations(inserts: [u]);
    await tx.commit();
  });
}
