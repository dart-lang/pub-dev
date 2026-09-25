// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_counts_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeeklyVersionDownloadCounts _$WeeklyVersionDownloadCountsFromJson(
  Map<String, dynamic> json,
) => WeeklyVersionDownloadCounts(
  newestDate: DateTime.parse(json['newestDate'] as String),
  majorRangeWeeklyDownloads:
      (json['majorRangeWeeklyDownloads'] as List<dynamic>)
          .map(
            (e) => _$recordConvert(
              e,
              ($jsonValue) => (
                counts: ($jsonValue['counts'] as List<dynamic>)
                    .map((e) => (e as num).toInt())
                    .toList(),
                versionRange: $jsonValue['versionRange'] as String,
              ),
            ),
          )
          .toList(),
  minorRangeWeeklyDownloads:
      (json['minorRangeWeeklyDownloads'] as List<dynamic>)
          .map(
            (e) => _$recordConvert(
              e,
              ($jsonValue) => (
                counts: ($jsonValue['counts'] as List<dynamic>)
                    .map((e) => (e as num).toInt())
                    .toList(),
                versionRange: $jsonValue['versionRange'] as String,
              ),
            ),
          )
          .toList(),
  patchRangeWeeklyDownloads:
      (json['patchRangeWeeklyDownloads'] as List<dynamic>)
          .map(
            (e) => _$recordConvert(
              e,
              ($jsonValue) => (
                counts: ($jsonValue['counts'] as List<dynamic>)
                    .map((e) => (e as num).toInt())
                    .toList(),
                versionRange: $jsonValue['versionRange'] as String,
              ),
            ),
          )
          .toList(),
  totalWeeklyDownloads: (json['totalWeeklyDownloads'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$WeeklyVersionDownloadCountsToJson(
  WeeklyVersionDownloadCounts instance,
) => <String, dynamic>{
  'totalWeeklyDownloads': instance.totalWeeklyDownloads,
  'majorRangeWeeklyDownloads': instance.majorRangeWeeklyDownloads
      .map(
        (e) => <String, dynamic>{
          'counts': e.counts,
          'versionRange': e.versionRange,
        },
      )
      .toList(),
  'minorRangeWeeklyDownloads': instance.minorRangeWeeklyDownloads
      .map(
        (e) => <String, dynamic>{
          'counts': e.counts,
          'versionRange': e.versionRange,
        },
      )
      .toList(),
  'patchRangeWeeklyDownloads': instance.patchRangeWeeklyDownloads
      .map(
        (e) => <String, dynamic>{
          'counts': e.counts,
          'versionRange': e.versionRange,
        },
      )
      .toList(),
  'newestDate': instance.newestDate.toIso8601String(),
};

$Rec _$recordConvert<$Rec>(Object? value, $Rec Function(Map) convert) =>
    convert(value as Map<String, dynamic>);

DailyDownloadCounts _$DailyDownloadCountsFromJson(
  Map<String, dynamic> json,
) => DailyDownloadCounts(
  newestDate: DateTime.parse(json['newestDate'] as String),
  totalDailyDownloads: (json['totalDailyDownloads'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  majorRangeDailyDownloads: (json['majorRangeDailyDownloads'] as List<dynamic>?)
      ?.map(
        (e) => _$recordConvert(
          e,
          ($jsonValue) => (
            counts: ($jsonValue['counts'] as List<dynamic>)
                .map((e) => (e as num).toInt())
                .toList(),
            versionRange: $jsonValue['versionRange'] as String,
          ),
        ),
      )
      .toList(),
  minorRangeDailyDownloads: (json['minorRangeDailyDownloads'] as List<dynamic>?)
      ?.map(
        (e) => _$recordConvert(
          e,
          ($jsonValue) => (
            counts: ($jsonValue['counts'] as List<dynamic>)
                .map((e) => (e as num).toInt())
                .toList(),
            versionRange: $jsonValue['versionRange'] as String,
          ),
        ),
      )
      .toList(),
  patchRangeDailyDownloads: (json['patchRangeDailyDownloads'] as List<dynamic>?)
      ?.map(
        (e) => _$recordConvert(
          e,
          ($jsonValue) => (
            counts: ($jsonValue['counts'] as List<dynamic>)
                .map((e) => (e as num).toInt())
                .toList(),
            versionRange: $jsonValue['versionRange'] as String,
          ),
        ),
      )
      .toList(),
  versionDailyDownloads: (json['versionDailyDownloads'] as List<dynamic>?)
      ?.map(
        (e) => _$recordConvert(
          e,
          ($jsonValue) => (
            counts: ($jsonValue['counts'] as List<dynamic>)
                .map((e) => (e as num).toInt())
                .toList(),
            version: $jsonValue['version'] as String,
          ),
        ),
      )
      .toList(),
);

Map<String, dynamic> _$DailyDownloadCountsToJson(
  DailyDownloadCounts instance,
) => <String, dynamic>{
  'newestDate': instance.newestDate.toIso8601String(),
  'totalDailyDownloads': instance.totalDailyDownloads,
  'majorRangeDailyDownloads': ?instance.majorRangeDailyDownloads
      ?.map(
        (e) => <String, dynamic>{
          'counts': e.counts,
          'versionRange': e.versionRange,
        },
      )
      .toList(),
  'minorRangeDailyDownloads': ?instance.minorRangeDailyDownloads
      ?.map(
        (e) => <String, dynamic>{
          'counts': e.counts,
          'versionRange': e.versionRange,
        },
      )
      .toList(),
  'patchRangeDailyDownloads': ?instance.patchRangeDailyDownloads
      ?.map(
        (e) => <String, dynamic>{
          'counts': e.counts,
          'versionRange': e.versionRange,
        },
      )
      .toList(),
  'versionDailyDownloads': ?instance.versionDailyDownloads
      ?.map((e) => <String, dynamic>{'counts': e.counts, 'version': e.version})
      .toList(),
};
