// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

const analysisWindowDays = 30;
const totalTrendWindowDays = 330;
const minThirtyDaysDownloadThreshold = 30000;

/// Calculates the exponential growth rate of a package's downloads.
///
/// Given a list with total daily downloads ([downloads]), where the most
/// recent day's data is at index 0, this function performs a
/// linear regression on the log-transformed download counts over the last
/// [analysisWindowDays].
///
/// The resulting slope represents the continuous daily growth rate. A positive
/// slope indicates exponential growth, while a negative slope indicates
/// exponential decline. For example, a slope of `0.1` corresponds to a growth
/// of approximately 10.5% per day.
double computeRelativeGrowthRate(List<int> downloads) {
  if (downloads.length < 2) {
    return 0;
  }

  final analysisData = downloads.length > analysisWindowDays
      ? downloads.sublist(0, analysisWindowDays)
      : downloads;

  // We reverse the recentDownloads list for regression, since the first entry
  // is the newest point in time. By reversing, we pass the data in
  // chronological order.
  return calculateLinearRegressionSlope(
      safeLogTransform(analysisData).reversed.toList());
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
  final sigmoid = calculateSigmoidScaleScore(total30Downloads: thirtydaySum);

  return computeRelativeGrowthRate(totalDownloads) * sigmoid;
}

/// Transforms a list of numbers to their natural logarithm.
///
/// Non-positive numbers (<= 0) are treated as 1 before the logarithm is taken,
/// resulting in a log value of 0.0.
List<double> safeLogTransform(List<int> numbers) {
  double myLog(int number) {
    if (number <= 0) {
      return log(1); // 0.0
    }
    return log(number);
  }

  return numbers.map(myLog).toList();
}

/// Calculates a dampening score between 0.0 and 1.0 based on download volume.
///
/// This uses a sigmoid function to create a smooth "S"-shaped curve. Packages
/// with very low download counts get a score near 0, while packages with high
/// download counts get a score near 1.
///
/// The function takes the total number of downloads in the last 30 days
/// ([total30Downloads]) and the parameter [midpoint] at which the score is
/// exactly 0.5 and [steepness] controlling how quickly the score transitions
/// from 0 to 1. Higher values create a steeper, more sudden transition.
double calculateSigmoidScaleScore({
  required int total30Downloads,
  double midpoint = 30000.0,
  double steepness = 0.00015,
}) {
  final double exponent = -steepness * (total30Downloads - midpoint);
  return 1 / (1 + exp(exponent));
}
