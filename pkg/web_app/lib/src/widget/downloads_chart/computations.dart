// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/download_counts_data.dart';

Iterable<String> prepareRanges(List<VersionRangeCount> rangeDownloads) {
  return rangeDownloads.map((e) => e.versionRange);
}

/// Returns an iterable containing data to be shown in a chart displaying the
/// ranges in [rangeDownloads].
///
/// The 'i'th entry in the iterable is a list of the download values
/// (y coordinates) for the 'i'th week (x coordinate).
Iterable<List<int>> prepareWeekLists(
  List<int> totals,
  List<VersionRangeCount> rangeDownloads,
  int displayLength,
) {
  final result = <List<int>>[];

  final showOther =
      totals[0] > rangeDownloads.fold(0, (sum, d) => sum + d.counts[0]);

  for (int week = 0; week < displayLength; week++) {
    final weekList = <int>[];
    if (showOther) {
      weekList.add(totals[week] -
          rangeDownloads.fold(0, (sum, d) => sum + d.counts[week]));
    }
    rangeDownloads.forEach((d) => weekList.add(d.counts[week]));
    result.add(weekList);
  }
  return result.reversed;
}
