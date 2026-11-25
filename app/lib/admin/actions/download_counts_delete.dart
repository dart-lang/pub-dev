// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:typed_sql/typed_sql.dart';

final downloadCountsDelete = AdminAction(
  name: 'download-counts-delete',
  options: {},
  summary: 'Deletes all "DownloadCount" rows.',
  description: '''
This action will delete all "DownloadCount" rows.
The rows can be restored using the "backfill-download-counts" admin action.
''',
  invoke: (options) async {
    await primaryDatabase.withRetry(
      (db) => db.downloadCounts.where((_) => toExpr(true)).delete().execute(),
    );

    return {'message': 'Deleted all "DownloadCount" rows.'};
  },
);
