// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dartdoc_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Breadcrumb _$BreadcrumbFromJson(Map<String, dynamic> json) => Breadcrumb(
      title: json['title'] as String,
      href: json['href'] as String?,
    );

Map<String, dynamic> _$BreadcrumbToJson(Breadcrumb instance) =>
    <String, dynamic>{
      'title': instance.title,
      'href': instance.href,
    };

DartDocPage _$DartDocPageFromJson(Map<String, dynamic> json) => DartDocPage(
      title: json['title'] as String,
      description: json['description'] as String,
      breadcrumbs: (json['breadcrumbs'] as List<dynamic>)
          .map((e) => Breadcrumb.fromJson(e as Map<String, dynamic>))
          .toList(),
      left: json['left'] as String,
      right: json['right'] as String,
      content: json['content'] as String,
      baseHref: json['baseHref'] as String?,
      usingBaseHref: json['usingBaseHref'] as String?,
      aboveSidebarUrl: json['aboveSidebarUrl'] as String?,
      belowSidebarUrl: json['belowSidebarUrl'] as String?,
    );

Map<String, dynamic> _$DartDocPageToJson(DartDocPage instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'breadcrumbs': instance.breadcrumbs,
      'left': instance.left,
      'right': instance.right,
      'content': instance.content,
      'baseHref': instance.baseHref,
      'usingBaseHref': instance.usingBaseHref,
      'aboveSidebarUrl': instance.aboveSidebarUrl,
      'belowSidebarUrl': instance.belowSidebarUrl,
    };
