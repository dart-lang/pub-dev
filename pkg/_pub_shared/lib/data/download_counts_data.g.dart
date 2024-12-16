// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_counts_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeeklyVersionDownloadCounts _$WeeklyVersionDownloadCountsFromJson(
        Map<String, dynamic> json) =>
    WeeklyVersionDownloadCounts(
      newestDate: DateTime.parse(json['newestDate'] as String),
      majorRangeWeeklyDownloads:
          (json['majorRangeWeeklyDownloads'] as List<dynamic>)
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
          (json['minorRangeWeeklyDownloads'] as List<dynamic>)
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
          (json['patchRangeWeeklyDownloads'] as List<dynamic>)
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
      totalWeeklyDownloads: (json['totalWeeklyDownloads'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$WeeklyVersionDownloadCountsToJson(
        WeeklyVersionDownloadCounts instance) =>
    <String, dynamic>{
      'totalWeeklyDownloads': instance.totalWeeklyDownloads,
      'majorRangeWeeklyDownloads': instance.majorRangeWeeklyDownloads
          .map((e) => <String, dynamic>{
                'counts': e.counts,
                'versionRange': e.versionRange,
              })
          .toList(),
      'minorRangeWeeklyDownloads': instance.minorRangeWeeklyDownloads
          .map((e) => <String, dynamic>{
                'counts': e.counts,
                'versionRange': e.versionRange,
              })
          .toList(),
      'patchRangeWeeklyDownloads': instance.patchRangeWeeklyDownloads
          .map((e) => <String, dynamic>{
                'counts': e.counts,
                'versionRange': e.versionRange,
              })
          .toList(),
      'newestDate': instance.newestDate.toIso8601String(),
    };

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);
