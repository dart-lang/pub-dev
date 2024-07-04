// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/service/download_counts/models.dart';
import 'package:pub_dev/shared/datastore.dart';

final deleteDownloadCounts = AdminAction(
  name: 'delete-download-counts',
  options: {},
  summary: 'Deletes all "DownloadCount" entities.',
  description: '''
This action will delete all "DownloadCount" entities. 
The entities can be restored using the "backfill-download-counts" admin action. 
''',
  invoke: (options) async {
    final result = await dbService
        .deleteWithQuery<DownloadCounts>(dbService.query<DownloadCounts>());

    return {
      'message': 'Found ${result.found} "DownloadCount" entities and '
          'deleted ${result.deleted} entities'
    };
  },
);
