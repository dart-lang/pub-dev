// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

part 'download_counts_data.g.dart';

/// A [VersionRangeCount] is a tuple containing a version range and a list of
/// download counts for periods of same length.
///
/// The first entry in the tuple is a string describing the `versionRange`, for
/// instance '>=1.0.0-0 <2.0.0'.
///
/// The second entry in the tuple is an integer list of `counts` with download
/// counts for each period. A period could for instance be a day, or a week etc.
///
/// Consider the example of period being one day. The first count represents the
/// number of downloads on `newestDate` followed by the downloads on
/// `newestDate` - 1 and so on. E.g.
///
///  counts = [ 42, 21, 55 ]
///              ▲   ▲   ▲
///              │   │   └──────────── Download count on newestDate - 2 days
///              │   │
///              │   └──────────────── Download count on newestDate - 1 day
///              │
///              └──────────────────── Download count on newestDate
///
///
/// Each entry in the `counts` list is non-negativ. A `0` entry can for a given
/// day mean that the version range has no downloads or that there is no data.
typedef VersionRangeCount = ({String versionRange, List<int> counts});

@JsonSerializable(includeIfNull: false)
class WeeklyVersionDownloadCounts {
  /// An integer list where each number is the total number of downloads for a
  /// given 7 day period starting from [newestDate].
  final List<int> totalWeeklyDownloads;

  /// A list of [VersionRangeCount] with major version ranges and weekly
  /// downloads for these ranges.
  ///
  /// E.g. each number in the `counts` list is the total number of downloads for
  /// the range in a 7 day period starting from [newestDate].
  final List<VersionRangeCount> majorRangeWeeklyDownloads;

  /// A list of [VersionRangeCount] with minor version ranges and weekly
  /// downloads for these ranges.
  ///
  /// E.g. each number in the `counts` list is the total number of downloads for
  /// the range in a 7 day period starting from [newestDate].
  final List<VersionRangeCount> minorRangeWeeklyDownloads;

  /// A list of [VersionRangeCount] with patch version ranges and weekly
  /// downloads for these ranges.
  ///
  /// E.g. each number in the `counts` list is the total number of downloads for
  /// the range in a 7 day period starting from [newestDate].
  final List<VersionRangeCount> patchRangeWeeklyDownloads;

  /// The newest date with download counts data available.
  final DateTime newestDate;

  WeeklyVersionDownloadCounts({
    required this.newestDate,
    required this.majorRangeWeeklyDownloads,
    required this.minorRangeWeeklyDownloads,
    required this.patchRangeWeeklyDownloads,
    required this.totalWeeklyDownloads,
  });

  factory WeeklyVersionDownloadCounts.fromJson(Map<String, dynamic> json) =>
      _$WeeklyVersionDownloadCountsFromJson(json);
  Map<String, dynamic> toJson() => _$WeeklyVersionDownloadCountsToJson(this);
}
