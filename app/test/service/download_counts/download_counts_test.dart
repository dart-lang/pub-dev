// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'package:pub_dev/service/download_counts/backend.dart';
import 'package:test/test.dart';

import '../../shared/test_services.dart';

void main() {
  group('', () {
    testWithProfile('Ingest download counts', fn: () async {
      final pkg = 'test';
      final downloadCounts =
          await downloadCountsBackend.lookupDownloadCountData(pkg);
      expect(downloadCounts, isNull);

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
      final updatedDownloadCounts = await downloadCountsBackend
          .updateDownloadCounts(pkg, versionsCounts, date);
      expect(updatedDownloadCounts, isNotNull);
      expect(updatedDownloadCounts.package, pkg);
      expect(updatedDownloadCounts.countData, isNotNull);
      expect(updatedDownloadCounts.countData.majorRangeCounts.length, 5);
      expect(updatedDownloadCounts.countData.totalCounts[0], 14);

      final countData =
          await downloadCountsBackend.lookupDownloadCountData(pkg);
      expect(countData, isNotNull);
      expect(countData!.majorRangeCounts.length, 5);
      expect(countData.totalCounts[0], 14);
    });
  });
}
