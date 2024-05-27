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
  static const countsCapacity = 731;
  final versionCounts = <({String versionRange, List<int> counts})>[];
  final patchCounts = <({String versionRange, List<int> counts})>[];
  final minorCounts = <({String versionRange, List<int> counts})>[];
  final majorCounts = <({String versionRange, List<int> counts})>[];
  final totalCounts = <int>[];

  // Last date with processed data.
  // The date only contains year, month and date.
  // Hours, minutes and seconds are disregarded.
  DateTime? lastDate;

  CountData();

  void addDownloadCounts(Map<String, int> dayCounts, DateTime dateTime) {
    final date = DateTime(dateTime.year, dateTime.month, dateTime.day);
    lastDate ??= date.addCalendarDays(-1);

    final nextLastDate = date.isAfter(lastDate!) ? date : lastDate!;
    final countsIndex = nextLastDate.difference(date).inDays;

    if (countsIndex >= countsCapacity) {
      // We don't store counts that are more than two years old.
      return;
    }

    _prepareDates(date, lastDate!, dayCounts, countsIndex, majorCounts);

    _processCounts(
        dayCounts, date, countsIndex, majorCounts, _createNewMajorVersionRange);

    lastDate = nextLastDate;
  }

  void _prepareDates(
    DateTime date,
    DateTime workingLastDate,
    Map<String, int> dayCounts,
    int countsIndex,
    List<({List<int> counts, String versionRange})> versionCounts,
  ) {
    if (date.isAfter(DateTime.now())) {
      // future date is not allowed
      return;
    }

    if (countsIndex >= countsCapacity) {
      // We don't store counts that are more than two years old.
      return;
    }

    List<int>? zerosList;
    final length = date.difference(workingLastDate).inDays;
    if (length > 0) {
      zerosList = List.filled(length, 0);
    }

    if (zerosList != null) {
      versionCounts.forEach((versionCount) {
        // Fill in with 0 on days with no data.
        final newCounts = [...zerosList!, ...versionCount.counts];
        _addToListAndPrune(versionCount.counts..clear(), newCounts);
      });
    }

    if (date.isAtOrBefore(workingLastDate)) {
      versionCounts.forEach((versionCount) {
        if (versionCount.counts.length < countsIndex + 1) {
          versionCount.counts.addAll(
              List.filled(countsIndex - versionCount.counts.length + 1, 0));
        }

        // Reset the counts for this date.
        versionCount.counts[countsIndex] = 0;
      });
    }
  }

  List<int> _addToListAndPrune(List<int> list, List<int> other) {
    list.addAll(other);
    return list.take(countsCapacity).toList();
  }

  void _processCounts(
    Map<String, int> dayCounts,
    DateTime date,
    int countsIndex,
    List<({List<int> counts, String versionRange})> versionCounts,
    VersionRange Function(Version version) createVersionRange,
  ) {
    // Sanity check
    if (countsIndex >= countsCapacity) {
      // We don't store counts that are more than two years old.
      return;
    }
    final countsLength = countsIndex + 1;

    dayCounts.forEach((v, count) {
      final version = Version.parse(v);
      if (versionCounts.isEmpty) {
        versionCounts.add((
          counts: List.filled(countsLength, 0, growable: true),
          versionRange: createVersionRange(version).toString()
        ));
      }

      for (int j = 0; j < versionCounts.length; j++) {
        final currentVersionRange =
            VersionConstraint.parse(versionCounts[j].versionRange)
                as VersionRange;
        if (currentVersionRange.allows(version)) {
          versionCounts[j].counts[countsIndex] += count;
          break;
        } else if (currentVersionRange.max! <= version.max) {
          versionCounts.insert(j, (
            counts: List.filled(countsLength, 0, growable: true)
              ..[countsIndex] = count,
            versionRange: createVersionRange(version).toString()
          ));
          if (versionCounts.length > 5) {
            versionCounts.removeLast();
          }
          break;
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
