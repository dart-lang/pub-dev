// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:basics/basics.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pub_semver/pub_semver.dart';
part 'download_counts.g.dart';

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
  /// represents the number of downloads on `newestDate` followed by the downloads
  ///  on `newestDate` - 1 and so on. E.g.
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
  /// [majorCounts] has at most [maxRanges] elements and is sorted by version
  ///  ranges.
  final majorCounts = <({String versionRange, List<int> counts})>[];
  final minorCounts = <({String versionRange, List<int> counts})>[];
  final patchCounts = <({String versionRange, List<int> counts})>[];
  final totalCounts = <int>[];

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

    // TODO(zarah): call this with other ranges
    _prepareDates(date, countsIndex, majorCounts);

    _processCounts(
        dayCounts, countsIndex, majorCounts, _createNewMajorVersionRange);

    newestDate = nextNewestDate;
  }

  void _prepareDates(
    DateTime date,
    int countsIndex,
    List<({List<int> counts, String versionRange})> versionCounts,
  ) {
    if (date.isAfter(newestDate!)) {
      final zerosList = List.filled(date.difference(newestDate!).inDays, 0);
      for (int i = 0; i < versionCounts.length; i++) {
        // Fill in with 0 on days with no data.
        final newCounts =
            [...zerosList, ...versionCounts[i].counts].take(maxAge).toList();
        versionCounts[i] =
            (counts: newCounts, versionRange: versionCounts[i].versionRange);
      }
    } else {
      versionCounts.forEach((versionCount) {
        // Reset the counts for this date.
        versionCount.counts[countsIndex] = 0;
      });
    }
  }

  void _processCounts(
    Map<String, int> dayCounts,
    int countsIndex,
    List<({List<int> counts, String versionRange})> versionCounts,
    VersionRange Function(Version version) createVersionRange,
  ) {
    dayCounts.forEach((v, count) {
      void _addNewRangeForVersion(int i, Version version) {
        versionCounts.insert(i, (
          counts: List.filled(maxAge, 0)..[countsIndex] = count,
          versionRange: createVersionRange(version).toString()
        ));
        if (versionCounts.length > maxRanges) {
          versionCounts.removeLast();
        }
      }

      final version = Version.parse(v);
      for (int j = 0; j <= versionCounts.length; j++) {
        if (j == versionCounts.length) {
          // The `versionCounts` list is empty or we scanned through it without
          // finding a spot for the range covering this version.
          _addNewRangeForVersion(j, version);
          break;
        } else {
          final currentVersionRange =
              VersionConstraint.parse(versionCounts[j].versionRange)
                  as VersionRange;
          if (currentVersionRange.max! <= version.max) {
            _addNewRangeForVersion(j, version);
            break;
          } else if (currentVersionRange.allows(version)) {
            versionCounts[j].counts[countsIndex] += count;
            break;
          }
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

  factory CountData.fromJson(Map<String, dynamic> json) =>
      _$CountDataFromJson(json);
  Map<String, dynamic> toJson() => _$CountDataToJson(this);
}
