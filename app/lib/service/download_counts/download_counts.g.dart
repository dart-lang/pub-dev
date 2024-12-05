// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_counts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountData _$CountDataFromJson(Map<String, dynamic> json) => CountData(
      majorRangeCounts: (json['majorRangeCounts'] as List<dynamic>)
          .map((e) => _$recordConvert(
                e,
                ($jsonValue) => (
                  counts: ($jsonValue['counts'] as List<dynamic>)
                      .map((e) => (e as num).toInt())
                      .toList(),
                  versionRange: $jsonValue['versionRange'] as String,
                ),
              ))
          .toList(),
      minorRangeCounts: (json['minorRangeCounts'] as List<dynamic>)
          .map((e) => _$recordConvert(
                e,
                ($jsonValue) => (
                  counts: ($jsonValue['counts'] as List<dynamic>)
                      .map((e) => (e as num).toInt())
                      .toList(),
                  versionRange: $jsonValue['versionRange'] as String,
                ),
              ))
          .toList(),
      patchRangeCounts: (json['patchRangeCounts'] as List<dynamic>)
          .map((e) => _$recordConvert(
                e,
                ($jsonValue) => (
                  counts: ($jsonValue['counts'] as List<dynamic>)
                      .map((e) => (e as num).toInt())
                      .toList(),
                  versionRange: $jsonValue['versionRange'] as String,
                ),
              ))
          .toList(),
      totalCounts: (json['totalCounts'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    )..newestDate = json['newestDate'] == null
        ? null
        : DateTime.parse(json['newestDate'] as String);

Map<String, dynamic> _$CountDataToJson(CountData instance) => <String, dynamic>{
      if (instance.newestDate?.toIso8601String() case final value?)
        'newestDate': value,
      'majorRangeCounts': instance.majorRangeCounts
          .map((e) => <String, dynamic>{
                'counts': e.counts,
                'versionRange': e.versionRange,
              })
          .toList(),
      'minorRangeCounts': instance.minorRangeCounts
          .map((e) => <String, dynamic>{
                'counts': e.counts,
                'versionRange': e.versionRange,
              })
          .toList(),
      'patchRangeCounts': instance.patchRangeCounts
          .map((e) => <String, dynamic>{
                'counts': e.counts,
                'versionRange': e.versionRange,
              })
          .toList(),
      'totalCounts': instance.totalCounts,
    };

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);

WeeklyDownloadCounts _$WeeklyDownloadCountsFromJson(
        Map<String, dynamic> json) =>
    WeeklyDownloadCounts(
      weeklyDownloads: (json['weeklyDownloads'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      newestDate: DateTime.parse(json['newestDate'] as String),
    );

Map<String, dynamic> _$WeeklyDownloadCountsToJson(
        WeeklyDownloadCounts instance) =>
    <String, dynamic>{
      'weeklyDownloads': instance.weeklyDownloads,
      'newestDate': instance.newestDate.toIso8601String(),
    };

WeeklyVersionsDownloadCounts _$WeeklyVersionsDownloadCountsFromJson(
        Map<String, dynamic> json) =>
    WeeklyVersionsDownloadCounts(
      newestDate: DateTime.parse(json['newestDate'] as String),
      majorRangeWeeklyDownloads:
          (json['majorRangeWeeklyCounts'] as List<dynamic>)
              .map((e) => _$recordConvert(
                    e,
                    ($jsonValue) => (
                      counts: ($jsonValue['counts'] as List<dynamic>)
                          .map((e) => (e as num).toInt())
                          .toList(),
                      versionRange: $jsonValue['versionRange'] as String,
                    ),
                  ))
              .toList(),
      minorRangeWeeklyDownloads:
          (json['minorRangeWeeklyCounts'] as List<dynamic>)
              .map((e) => _$recordConvert(
                    e,
                    ($jsonValue) => (
                      counts: ($jsonValue['counts'] as List<dynamic>)
                          .map((e) => (e as num).toInt())
                          .toList(),
                      versionRange: $jsonValue['versionRange'] as String,
                    ),
                  ))
              .toList(),
      patchRangeWeeklyDownloads:
          (json['patchRangeWeeklyCounts'] as List<dynamic>)
              .map((e) => _$recordConvert(
                    e,
                    ($jsonValue) => (
                      counts: ($jsonValue['counts'] as List<dynamic>)
                          .map((e) => (e as num).toInt())
                          .toList(),
                      versionRange: $jsonValue['versionRange'] as String,
                    ),
                  ))
              .toList(),
      totalWeeklyDownloads: (json['totalWeeklyCounts'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$WeeklyVersionsDownloadCountsToJson(
        WeeklyVersionsDownloadCounts instance) =>
    <String, dynamic>{
      'newestDate': instance.newestDate.toIso8601String(),
      'majorRangeWeeklyCounts': instance.majorRangeWeeklyDownloads
          .map((e) => <String, dynamic>{
                'counts': e.counts,
                'versionRange': e.versionRange,
              })
          .toList(),
      'minorRangeWeeklyCounts': instance.minorRangeWeeklyDownloads
          .map((e) => <String, dynamic>{
                'counts': e.counts,
                'versionRange': e.versionRange,
              })
          .toList(),
      'patchRangeWeeklyCounts': instance.patchRangeWeeklyDownloads
          .map((e) => <String, dynamic>{
                'counts': e.counts,
                'versionRange': e.versionRange,
              })
          .toList(),
      'totalWeeklyCounts': instance.totalWeeklyDownloads,
    };
