// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_counts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountData _$CountDataFromJson(Map<String, dynamic> json) => CountData()
  ..lastDate = json['lastDate'] == null
      ? null
      : DateTime.parse(json['lastDate'] as String);

Map<String, dynamic> _$CountDataToJson(CountData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('lastDate', instance.lastDate?.toIso8601String());
  return val;
}
