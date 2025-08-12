// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_request_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchRequestData _$SearchRequestDataFromJson(Map<String, dynamic> json) =>
    SearchRequestData(
      query: json['query'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      publisherId: json['publisherId'] as String?,
      minPoints: (json['minPoints'] as num?)?.toInt(),
      order: $enumDecodeNullable(_$SearchOrderEnumMap, json['order']),
      offset: (json['offset'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      textMatchExtent: $enumDecodeNullable(
          _$TextMatchExtentEnumMap, json['textMatchExtent']),
    );

Map<String, dynamic> _$SearchRequestDataToJson(SearchRequestData instance) =>
    <String, dynamic>{
      'query': instance.query,
      'tags': instance.tags,
      'publisherId': instance.publisherId,
      'minPoints': instance.minPoints,
      'order': _$SearchOrderEnumMap[instance.order],
      'offset': instance.offset,
      'limit': instance.limit,
      'textMatchExtent': _$TextMatchExtentEnumMap[instance.textMatchExtent],
    };

const _$SearchOrderEnumMap = {
  SearchOrder.top: 'top',
  SearchOrder.text: 'text',
  SearchOrder.created: 'created',
  SearchOrder.updated: 'updated',
  SearchOrder.popularity: 'popularity',
  SearchOrder.downloads: 'downloads',
  SearchOrder.like: 'like',
  SearchOrder.points: 'points',
  SearchOrder.trending: 'trending',
};

const _$TextMatchExtentEnumMap = {
  TextMatchExtent.none: 'none',
  TextMatchExtent.name: 'name',
  TextMatchExtent.description: 'description',
  TextMatchExtent.readme: 'readme',
  TextMatchExtent.api: 'api',
};
