// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

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
      weekList.add(
        totals[week] - rangeDownloads.fold(0, (sum, d) => sum + d.counts[week]),
      );
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
  (num, num) startPoint,
  (num, num) endPoint,
  (num, num) point,
) {
  final directionVector = (
    endPoint.$1 - startPoint.$1,
    endPoint.$2 - startPoint.$2,
  );

  if (directionVector.$1 == 0 && directionVector.$2 == 0) {
    return startPoint;
  }

  final v = (point.$1 - startPoint.$1, point.$2 - startPoint.$2);

  // The dot product ((v · d) / (d · d))
  final t =
      ((v.$1 * directionVector.$1 + v.$2 * directionVector.$2) /
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
    startPoint.$2 + projectionVOntoD.$2,
  );
  return (closestPoint.$1, closestPoint.$2);
}

/// Calculates the Euclidean distance between two points.
double distance((num, num) point, (double, double) point2) {
  final dx = point.$1 - point2.$1;
  final dy = point.$2 - point2.$2;
  return sqrt(dx * dx + dy * dy);
}

/// Finds the closest point on [path] (a series of points defining the line
/// segments) to a given [point].
(num, num) closestPointOnPath(
  List<(double, double)> path,
  (double, double) point,
) {
  if (path.length < 2) {
    return (double.maxFinite, double.maxFinite);
  }
  (num, num) closestPoint = (double.maxFinite, double.maxFinite);
  var minDistance = double.infinity;
  for (int i = 0; i < path.length - 1; i++) {
    final p = closestPointOnLine(path[i], path[i + 1], point);
    final dist = distance(p, point);
    if (dist < minDistance) {
      minDistance = dist;
      closestPoint = p;
    }
  }
  return closestPoint;
}

/// Determines if a given [point] is within a specified [tolerance] distance of
/// a [path] defined by a series of points.
bool isPointOnPathWithTolerance(
  List<(double, double)> path,
  (double, double) point,
  double tolerance,
) {
  if (path.length < 2) {
    // Not enough points to define a line segment.
    return false;
  }

  final closestPoint = closestPointOnPath(path, point);
  final dist = distance(closestPoint, point);
  if (dist < tolerance) {
    return true;
  }
  return false;
}

/// Determines if a point is inside a polygon.
///
/// Uses the ray casting algorithm to determine if a given point lies inside
/// a polygon defined by a list of vertices. The polygon is assumed to be
/// closed and non-self-intersecting.
///
/// Returns `true` if the point is inside the polygon or exactly on a vertex or
/// an edge, and `false` otherwise.
bool isPointInPolygon(List<(double, double)> polygon, (double, double) point) {
  if (polygon.length < 3) {
    return false;
  }

  int intersections = 0;
  final (px, py) = point;

  // Check if the point is on an edge
  if (isPointOnPathWithTolerance(polygon, point, 0.001)) {
    return true;
  }

  for (int i = 0; i < polygon.length; i++) {
    final (x1, y1) = polygon[i];
    final (x2, y2) = polygon[(i + 1) % polygon.length];

    // Check if the point is on a vertex
    if ((px == x1 && py == y1) || (px == x2 && py == y2)) {
      return true;
    }

    if (py > min(y1, y2) && py <= max(y1, y2)) {
      double intersectX;
      if (y1 == y2) {
        // horizontal edge
        continue;
      } else {
        intersectX = x1 + (py - y1) * (x2 - x1) / (y2 - y1);
      }

      if (px < intersectX) {
        intersections++;
      }
    }
  }

  return intersections % 2 == 1;
}
