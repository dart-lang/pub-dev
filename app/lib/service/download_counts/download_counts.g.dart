// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_counts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountData _$CountDataFromJson(Map<String, dynamic> json) => CountData()
  ..newestDate = json['newestDate'] == null
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
  return val;
}
