// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModerationActionLog _$ModerationActionLogFromJson(Map<String, dynamic> json) =>
    ModerationActionLog(
      entries: (json['entries'] as List<dynamic>)
          .map((e) =>
              ModerationActionLogEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ModerationActionLogToJson(
        ModerationActionLog instance) =>
    <String, dynamic>{
      'entries': instance.entries.map((e) => e.toJson()).toList(),
    };

ModerationActionLogEntry _$ModerationActionLogEntryFromJson(
        Map<String, dynamic> json) =>
    ModerationActionLogEntry(
      timestamp: DateTime.parse(json['timestamp'] as String),
      subject: json['subject'] as String,
      moderationAction:
          $enumDecode(_$ModerationActionEnumMap, json['moderationAction']),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$ModerationActionLogEntryToJson(
    ModerationActionLogEntry instance) {
  final val = <String, dynamic>{
    'timestamp': instance.timestamp.toIso8601String(),
    'subject': instance.subject,
    'moderationAction': _$ModerationActionEnumMap[instance.moderationAction]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('note', instance.note);
  return val;
}

const _$ModerationActionEnumMap = {
  ModerationAction.apply: 'apply',
  ModerationAction.revert: 'revert',
};
