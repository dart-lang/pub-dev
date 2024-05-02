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
      'entries': instance.entries,
    };

ModerationActionLogEntry _$ModerationActionLogEntryFromJson(
        Map<String, dynamic> json) =>
    ModerationActionLogEntry(
      timestamp: DateTime.parse(json['timestamp'] as String),
      subject: json['subject'] as String,
      isModerated: json['isModerated'] as bool,
    );

Map<String, dynamic> _$ModerationActionLogEntryToJson(
        ModerationActionLogEntry instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'subject': instance.subject,
      'isModerated': instance.isModerated,
    };
