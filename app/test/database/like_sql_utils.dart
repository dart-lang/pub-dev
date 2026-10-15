// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:test/test.dart';
import 'package:typed_sql/typed_sql.dart';

/// Expects that the SQL likes match the [Like] entities, and that each
/// package's likes count matches its number of likes.
Future<void> expectLikesInSqlMatchDatastore() async {
  final datastoreLikes = <String, int>{};
  await for (final like in dbService.query<Like>().run()) {
    datastoreLikes['${like.userId}/${like.package}'] =
        like.created!.microsecondsSinceEpoch;
  }
  final rows = await primaryDatabase.withRetry((db) => db.packageLikes.fetch());
  expect({
    for (final r in rows)
      '${r.userId}/${r.package}': r.createdAt.microsecondsSinceEpoch,
  }, datastoreLikes);

  final counts = <String, int>{};
  for (final r in rows) {
    counts[r.package] = (counts[r.package] ?? 0) + 1;
  }
  final packages = await primaryDatabase.withRetry(
    (db) => db.packages.select((p) => (p.name, p.likesCount)).fetch(),
  );
  for (final (name, likesCount) in packages) {
    expect(likesCount, counts[name] ?? 0, reason: 'likes count of $name');
  }
}
