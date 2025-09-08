// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublisherPage _$PublisherPageFromJson(Map<String, dynamic> json) =>
    PublisherPage(
      publishers: (json['publishers'] as List<dynamic>?)
          ?.map((e) => PublisherSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PublisherPageToJson(PublisherPage instance) =>
    <String, dynamic>{'publishers': instance.publishers};

PublisherSummary _$PublisherSummaryFromJson(Map<String, dynamic> json) =>
    PublisherSummary(
      publisherId: json['publisherId'] as String,
      created: DateTime.parse(json['created'] as String),
    );

Map<String, dynamic> _$PublisherSummaryToJson(PublisherSummary instance) =>
    <String, dynamic>{
      'publisherId': instance.publisherId,
      'created': instance.created.toIso8601String(),
    };
