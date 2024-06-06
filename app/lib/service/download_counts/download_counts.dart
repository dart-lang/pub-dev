// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:basics/basics.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:json_annotation/json_annotation.dart';
import 'package:pub_semver/pub_semver.dart';
part 'download_counts.g.dart';

typedef VersionRangeCount = ({String versionRange, List<int> counts});

@JsonSerializable(includeIfNull: false)
class CountData {
  // We store at most two years of data, one data point per day.
  static const maxAge = 731;

  // We store at most 5 ranges in the xxxxxCounts list;
  static const maxRanges = 5;

  // Newest date with processed data.
  // The date only contains year, month and date.
  // Hours, minutes and seconds are disregarded.
  DateTime? newestDate;

  /// A list of tuples containing a string describing a major `versionRange`,
  /// e.g. '>=1.0.0-0 <2.0.0', and a list of integers with a count for each day.
  /// The 'counts' list contains at most [maxAge] entries. The first entry in
  /// represents the number of downloads on `newestDate` followed by the
  /// downloads on `newestDate` - 1 and so on. E.g.
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
  /// [majorRangeCounts] has at most [maxRanges] elements and is sorted by
  ///  version ranges.
  final majorRangeCounts = <VersionRangeCount>[];
  final minorRangeCounts = <VersionRangeCount>[];
  final patchRangeCounts = <VersionRangeCount>[];

  /// A list of integers representing the total number of daily downloads of any
  /// version of the package. The list contains at most [maxAge] entries. The
  /// first entry in represents the total number of downloads on `newestDate`
  /// followed by the downloads on `newestDate` - 1 and so on.
  ///
  /// Days with no data are represented with `-1`.
  final totalCounts = List.filled(maxAge, -1, growable: true);

  CountData();

  /// Process and store download counts given in [dayCounts] on the form
  /// {version: #downloads} for a date given by [dateTime].
  void addDownloadCounts(Map<String, int> dayCounts, DateTime dateTime) {
    final date = DateTime(dateTime.year, dateTime.month, dateTime.day);
    newestDate ??= date.addCalendarDays(-1);

    final nextNewestDate = date.isAfter(newestDate!) ? date : newestDate!;
    final countsIndex = nextNewestDate.difference(date).inDays;

    if (countsIndex >= maxAge) {
      // We don't store counts that are more than two years old.
      return;
    }

    _prepareDates(date, countsIndex, majorRangeCounts);
    _prepareDates(date, countsIndex, minorRangeCounts);
    _prepareDates(date, countsIndex, patchRangeCounts);

    _processCounts(
        dayCounts, countsIndex, majorRangeCounts, _createNewMajorVersionRange);
    _processCounts(
        dayCounts, countsIndex, minorRangeCounts, _createNewMinorVersionRange);
    _processCounts(
        dayCounts, countsIndex, patchRangeCounts, _createNewPatchVersionRange);

    // Handle totalCounts
    if (date.isAfter(newestDate!)) {
      final minusOneList = List.filled(date.difference(newestDate!).inDays, -1);
      // Fill in with -1 on days with no data.
      totalCounts..insertAll(0, minusOneList);
      if (totalCounts.length > maxAge) {
        totalCounts.removeRange(maxAge, totalCounts.length);
      }
    }
    totalCounts[countsIndex] =
        dayCounts.values.fold(0, (prev, cur) => prev + cur);

    newestDate = nextNewestDate;
  }

  void _prepareDates(
    DateTime date,
    int countsIndex,
    List<VersionRangeCount> versionRangeCounts,
  ) {
    if (date.isAfter(newestDate!)) {
      final zerosList = List.filled(date.difference(newestDate!).inDays, 0);
      for (int i = 0; i < versionRangeCounts.length; i++) {
        // Fill in with 0 on days with no data.
        final newCounts = [...zerosList, ...versionRangeCounts[i].counts]
            .take(maxAge)
            .toList();
        versionRangeCounts[i] = (
          counts: newCounts,
          versionRange: versionRangeCounts[i].versionRange
        );
      }
    } else {
      versionRangeCounts.forEach((versionRangeCount) {
        // Reset the counts for this date.
        versionRangeCount.counts[countsIndex] = 0;
      });
    }
  }

  void _processCounts(
    Map<String, int> dayCounts,
    int countsIndex,
    List<VersionRangeCount> versionRangeCounts,
    VersionRange Function(Version version) createVersionRange,
  ) {
    dayCounts.forEach((v, count) {
      final version = Version.parse(v);
      final containingRange = versionRangeCounts.firstWhereOrNull((vc) {
        final currentVersionRange = VersionConstraint.parse(vc.versionRange);
        return currentVersionRange.allows(version);
      });

      if (containingRange != null) {
        containingRange.counts[countsIndex] += count;
      } else {
        final newVersionRange = (
          counts: List.filled(maxAge, 0)..[countsIndex] = count,
          versionRange: createVersionRange(version).toString()
        );
        versionRangeCounts.add(newVersionRange);
        versionRangeCounts.sortBy((vrc) =>
            (VersionConstraint.parse(vrc.versionRange) as VersionRange));

        if (versionRangeCounts.length > maxRanges) {
          versionRangeCounts.removeAt(0);
        }
      }
    });
  }

  VersionRange _createNewMajorVersionRange(Version version) {
    return VersionRange(
        min: Version(version.major, 0, 0, pre: '0'),
        max: Version(version.major + 1, 0, 0),
        includeMin: true);
  }

  VersionRange _createNewMinorVersionRange(Version version) {
    return VersionRange(
        min: Version(version.major, version.minor, 0, pre: '0'),
        max: Version(version.major, version.minor + 1, 0),
        includeMin: true);
  }

  VersionRange _createNewPatchVersionRange(Version version) {
    return VersionRange(
        min: Version(version.major, version.minor, version.patch, pre: '0'),
        max: Version(version.major, version.minor, version.patch + 1),
        includeMin: true);
  }

  factory CountData.fromJson(Map<String, dynamic> json) =>
      _$CountDataFromJson(json);
  Map<String, dynamic> toJson() => _$CountDataToJson(this);
}
