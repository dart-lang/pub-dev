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

Map<String, dynamic> _$CountDataToJson(CountData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('newestDate', instance.newestDate?.toIso8601String());
  val['majorRangeCounts'] = instance.majorRangeCounts
      .map((e) => <String, dynamic>{
            'counts': e.counts,
            'versionRange': e.versionRange,
          })
      .toList();
  val['minorRangeCounts'] = instance.minorRangeCounts
      .map((e) => <String, dynamic>{
            'counts': e.counts,
            'versionRange': e.versionRange,
          })
      .toList();
  val['patchRangeCounts'] = instance.patchRangeCounts
      .map((e) => <String, dynamic>{
            'counts': e.counts,
            'versionRange': e.versionRange,
          })
      .toList();
  val['totalCounts'] = instance.totalCounts;
  return val;
}

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);
