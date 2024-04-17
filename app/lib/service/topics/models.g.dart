// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CanonicalTopicFileContent _$CanonicalTopicFileContentFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'CanonicalTopicFileContent',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const ['topics'],
        );
        final val = CanonicalTopicFileContent(
          topics: $checkedConvert(
              'topics',
              (v) => (v as List<dynamic>)
                  .map(
                      (e) => CanonicalTopic.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$CanonicalTopicFileContentToJson(
        CanonicalTopicFileContent instance) =>
    <String, dynamic>{
      'topics': instance.topics.map((e) => e.toJson()).toList(),
    };

CanonicalTopic _$CanonicalTopicFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CanonicalTopic',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const ['topic', 'description', 'aliases'],
        );
        final val = CanonicalTopic(
          topic: $checkedConvert('topic', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          aliases: $checkedConvert('aliases',
              (v) => (v as List<dynamic>).map((e) => e as String).toSet()),
        );
        return val;
      },
    );

Map<String, dynamic> _$CanonicalTopicToJson(CanonicalTopic instance) =>
    <String, dynamic>{
      'topic': instance.topic,
      'description': instance.description,
      'aliases': instance.aliases.toList(),
    };
