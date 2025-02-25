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
({List<String> ranges, List<List<int>> weekLists}) prepareWeekLists(
  List<int> totals,
  List<VersionRangeCount> rangeDownloads,
  int displayLength,
) {
  final result = <List<int>>[];
  final ranges = <String>[];

  final showOther =
      totals[0] > rangeDownloads.fold(0, (sum, d) => sum + d.counts[0]);

  if (showOther) {
    ranges.add('Other');
  }
  rangeDownloads.forEach((d) => ranges.add(d.versionRange));

  for (int week = 0; week < displayLength; week++) {
    final weekList = <int>[];
    if (showOther) {
      weekList.add(totals[week] -
          rangeDownloads.fold(0, (sum, d) => sum + d.counts[week]));
    }
    rangeDownloads.forEach((d) => weekList.add(d.counts[week]));
    result.add(weekList);
  }

  return (ranges: ranges, weekLists: result.reversed.toList());
}

/// Calculates the closest point on the line segment between [startPoint]
/// and [endPoint] to a given [point].
///
/// If [startPoint] and [endPoint] are the same, [startPoint] is returned.
///
/// If [point] is outside the line segment, that is the closest point would not
/// be within the thwo endpoints, `(double.maxFinite, double.maxFinite)`
/// is returned.
(num, num) closestPointOnLine(
    (num, num) startPoint, (num, num) endPoint, (num, num) point) {
  final directionVector =
      (endPoint.$1 - startPoint.$1, endPoint.$2 - startPoint.$2);

  if (directionVector.$1 == 0 && directionVector.$2 == 0) {
    return startPoint;
  }

  final v = (point.$1 - startPoint.$1, point.$2 - startPoint.$2);

  // The dot product ((v · d) / (d · d))
  final t = ((v.$1 * directionVector.$1 + v.$2 * directionVector.$2) /
      (directionVector.$1 * directionVector.$1 +
          directionVector.$2 * directionVector.$2));

  if (t < 0 || t > 1) {
    // Closest point is before or after the line.
    return (double.maxFinite, double.maxFinite);
  }

  // t * d
  final projectionVOntoD = (t * directionVector.$1, t * directionVector.$2);
  final closestPoint = (
    startPoint.$1 + projectionVOntoD.$1,
    startPoint.$2 + projectionVOntoD.$2
  );
  return (closestPoint.$1, closestPoint.$2);
}
