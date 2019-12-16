// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:appengine/appengine.dart';
import 'package:args/args.dart';
import 'package:gcloud/db.dart';
import 'package:pool/pool.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';

final _argParser = ArgParser()
  ..addOption('concurrency',
      abbr: 'c', defaultsTo: '10', help: 'Number of concurrent processing.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  if (argv['help'] as bool == true) {
    print('Usage: dart backfill_likes.dart');
    print('Ensures Like.packageName is set to a string.');
    print(_argParser.usage);
    return;
  }

  final concurrency = int.parse(argv['concurrency'] as String);

  await withProdServices(() async {
    final pool = Pool(concurrency);
    final futures = <Future>[];

    useLoggingPackageAdaptor();
    await for (Like l in dbService.query<Like>().run()) {
      final f = pool.withResource(() => _backfillLikes(l));
      futures.add(f);
    }

    await Future.wait(futures);
    await pool.close();
  });
}

Future<void> _backfillLikes(Like l) async {
  if (l.packageName != null) return;

  print(
      'Backfilling `packageName` on like entity for user ${l.userId} and package'
      ' ${l.package}');
  try {
    await dbService.withTransaction((Transaction tx) async {
      final like = await tx.lookupValue<Like>(l.key, orElse: () => null);
      if (like == null) {
        return;
      }
      like.packageName ??= like.package;
      tx.queueMutations(inserts: [like]);
      await tx.commit();
      print('Updated packageName on like entity for user ${like.userId} and '
          'package ${like.package}');
    });
  } catch (e) {
    print('Failed to update packageName on ike entity for user ${l.userId} and '
        'package ${l.package}, error $e');
  }
}
