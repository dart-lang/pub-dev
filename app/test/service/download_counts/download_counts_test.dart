// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'package:pub_dev/service/download_counts/backend.dart';
import 'package:pub_dev/service/download_counts/download_counts.dart';
import 'package:test/test.dart';

import '../../shared/test_services.dart';

void main() {
  group('', () {
    testWithProfile('Ingest download counts', fn: () async {
      final pkg = 'test';
      final downloadCounts =
          await downloadCountsBackend.lookupDownloadCounts(pkg);
      expect(downloadCounts, isNull);

      final countData = CountData.empty();
      final versionsCounts = {
        '1.0.1': 2,
        '2.0.0-alpha': 2,
        '2.0.0': 2,
        '2.1.0': 2,
        '3.1.0': 2,
        '4.0.0-0': 2,
        '6.1.0': 2,
      };
      final date = DateTime.parse('1986-02-16');
      countData.addDownloadCounts(versionsCounts, date);

      final downloadCountsIngested =
          await downloadCountsBackend.ingestDownloadCounts(pkg, countData);
      expect(downloadCountsIngested, isNotNull);
      expect(downloadCountsIngested.package, pkg);
      expect(downloadCountsIngested.countData, isNotNull);
      expect(downloadCountsIngested.countData!.majorRangeCounts.length, 5);
      expect(downloadCountsIngested.countData!.totalCounts[0], 14);

      final downloadCountsLookup =
          await downloadCountsBackend.lookupDownloadCounts(pkg);
      expect(downloadCountsLookup, isNotNull);
      expect(downloadCountsLookup!.package, pkg);
      expect(downloadCountsLookup.countData, isNotNull);
      expect(downloadCountsLookup.countData!.majorRangeCounts.length, 5);
      expect(downloadCountsLookup.countData!.totalCounts[0], 14);
    });
  });
}
