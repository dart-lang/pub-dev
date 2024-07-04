// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/service/download_counts/sync_download_counts.dart';

final backfillDownloadCounts = AdminAction(
  name: 'backfill-download-counts',
  options: {
    'date': 'the first date to sync data from',
    'sync-days': 'the number days to sync starting from "date" and going back',
  },
  summary: 'Sync download counts data from <date> and <sync-days> days back',
  description: '''
This action will trigger syncing of the download counts backend with download
counts data from <date> and <sync-days> days going back. For instance, given 3
sync days and the date '2024-05-29', data will be synced for '2024-05-27',
'2024-05-28', and '2024-05-29'.

If the `sync-days` option is not specified, this defaults to
$defaultNumberOfSyncDays days.
''',
  invoke: (options) async {
    final date = options['date'];
    final syncDays = options['sync-days'];

    InvalidInputException.check(
      date != null && date.isNotEmpty,
      'invalid date',
    );
    final parsedDate = DateTime.tryParse(date!);
    InvalidInputException.check(parsedDate != null, 'invalid date');

    int? parsedSyncDays;
    if (syncDays != null) {
      parsedSyncDays = int.tryParse(syncDays);
      InvalidInputException.check(parsedSyncDays != null && parsedSyncDays > 0,
          'invalid sync-days, must be a positive integer');
    }
    await syncDownloadCounts(
        date: parsedDate,
        numberOfSyncDays: parsedSyncDays ?? defaultNumberOfSyncDays);

    return {'message': 'syncing of download counts has been triggered.'};
  },
);
