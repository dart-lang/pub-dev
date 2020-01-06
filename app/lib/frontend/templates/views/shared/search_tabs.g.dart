// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_tabs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SearchTabsToJson(SearchTabs instance) =>
    <String, dynamic>{
      'tabs': instance.tabs?.map((e) => e?.toJson())?.toList(),
    };

Map<String, dynamic> _$SearchTabToJson(SearchTab instance) => <String, dynamic>{
      'active': instance.active,
      'href': instance.href,
      'title': instance.title,
      'text': instance.text,
    };
