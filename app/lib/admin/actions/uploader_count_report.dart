// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/admin/actions/actions.dart';

const _monthNames = {
  1: 'January',
  2: 'February',
  3: 'March',
  4: 'April',
  5: 'May',
  6: 'June',
  7: 'July',
  8: 'August',
  9: 'September',
  10: 'October',
  11: 'November',
  12: 'December',
};

final uploaderCountReport = AdminAction(
    name: 'uploader-count-report',
    options: {},
    summary:
        'Returns a report of the number of uploaders for each of the last 12 months.',
    description: '''
Returns a report of the number of uploaders for each of the last 12 months.

The report is based on "UploadEvents".

To pretty-print in the terminal pipe through `| jq -r .record'.
''',
    invoke: (args) async {
      final buckets = <DateTime, Set<String>>{};
      final now = clock.now();

      await for (final record in accountBackend.getUploadEvents(
        begin: DateTime(now.year, now.month - 12),
      )) {
        final created = record.created;
        final agent = record.agent;
        if (created == null) continue;
        if (agent == null) continue;
        final bucket = buckets.putIfAbsent(
            DateTime(created.year, created.month), () => {});
        bucket.add(agent);
      }
      final buffer = StringBuffer();
      buffer.writeln('Monthly unique uploading users:');

      for (int i = 11; i >= 0; i--) {
        final month = DateTime(now.year, now.month - i);
        final bucket = buckets[month] ?? {};
        buffer.writeln(
            '${_monthNames[month.month]} ${month.year}: ${bucket.length}');
      }
      return {'report': buffer.toString()};
    });
