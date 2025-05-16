// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

const analysisWindowDays = 30;
const totalTrendWindowDays = 330;
const minThirtyDaysDownloadThreshold = 30000;

/// Calculates the relative daily growth rate of a package's downloads.
///
/// Given a list with total daily downloads ([totalDownloads]), where the most
/// recent day's data is at index 0, this function analyzes the downloads trend
/// over the last ([analysisWindowDays]) days to determine how fast a package is
/// growing relative to its own current download volume.
///
/// A positive value indicates an upward trend in downloads, while a negative
/// value indicates a downward trend. The magnitude represents the growth (or
/// decline) rate normalized by the average daily downloads, allowing for
/// comparison across packages of different popularity. For example, a slope of
/// +10 downloads/day is more significant for a package with 100 average daily
/// downloads (10% relative growth) than for a package with 10000 average daily
/// downloads (0.1% relative growth).
double computeRelativeGrowthRate(List<int> totalDownloads) {
  if (totalDownloads.isEmpty) {
    return 0;
  }
  final List<int> data;
  if (totalDownloads.length < analysisWindowDays) {
    data = [
      ...totalDownloads,
      ...List.filled(analysisWindowDays - totalDownloads.length, 0)
    ];
  } else {
    data = totalDownloads;
  }

  final recentDownloads = data.sublist(0, analysisWindowDays);

  final averageRecentDownloads =
      recentDownloads.reduce((prev, element) => prev + element) /
          recentDownloads.length;

  final m = min(totalDownloads.length, totalTrendWindowDays);
  final averageTotalDownloads =
      totalDownloads.sublist(0, m).reduce((prev, element) => prev + element) /
          m;

  if (averageRecentDownloads == 0 || averageTotalDownloads == 0) {
    return 0;
  }

  // We reverse the recentDownloads list for regression, since the first entry
  // is the newest point in time. By reversing, we pass the data in
  // chronological order.
  final growthRate =
      calculateLinearRegressionSlope(recentDownloads.reversed.toList());

  // Normalize slope by average downloads to represent relative growth.
  // This measures how much the download count is growing relative to its
  // current volume.
  return growthRate / averageTotalDownloads;
}

/// Computes the slope of the best-fit line for a given list of data points
/// [yValues] using the method of least squares (linear regression).
///
/// The function assumes that the [yValues] are equally spaced in time and are
/// provided in chronological order
///
/// The slope `b` is calculated using the formula: `b = (N * sum(xy) - sum(x) *
/// sum(y)) / (N * sum(x^2) - (sum(x))^2)` where `N` is the number of data
/// points.
///
/// Returns `0.0` if the slope cannot be determined reliably (e.g., if there are
/// fewer than 2 data points, or if the denominator in the slope formula is
/// effectively zero).
double calculateLinearRegressionSlope(List<num> yValues) {
  double sumX = 0, sumY = 0, sumXY = 0, sumXX = 0;
  final n = yValues.length;

  // Slope is undefined or 0 for fewer than 2 points.
  if (n < 2) {
    return 0.0;
  }

  for (int x = 0; x < n; x++) {
    final y = yValues[x];
    sumX += x;
    sumY += y;
    sumXY += x * y;
    sumXX += x * x;
  }

  final double denominator = (n * sumXX - sumX * sumX);

  // If the denominator is very close to zero, the slope is unstable/undefined.
  if (denominator.abs() < 1e-9) {
    return 0.0;
  }
  return (n * sumXY - sumX * sumY) / denominator;
}

/// Computes a trend score for a package, factoring in both its recent
/// relative growth rate and its overall download volume.
///
/// This score is designed to balance how quickly a package is growing
/// ([computeRelativeGrowthRate]) against its existing popularity. Popularity is
/// assessed by comparing the sum of its downloads over the available history
/// (up to [analysisWindowDays]) against a [minThirtyDaysDownloadThreshold].
double computeTrendScore(List<int> totalDownloads) {
  final n = min(analysisWindowDays, totalDownloads.length);
  final thirtydaySum = totalDownloads.isEmpty
      ? 0
      : totalDownloads.sublist(0, n).reduce((prev, element) => prev + element);
  final dampening = min(thirtydaySum / minThirtyDaysDownloadThreshold, 1.0);
  final relativGrowth = computeRelativeGrowthRate(totalDownloads);

  return relativGrowth * dampening * dampening;
}
