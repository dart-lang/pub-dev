// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageDocument _$PackageDocumentFromJson(Map<String, dynamic> json) {
  return PackageDocument(
    package: json['package'] as String,
    version: json['version'] as String,
    devVersion: json['devVersion'] as String,
    description: json['description'] as String,
    created: json['created'] == null
        ? null
        : DateTime.parse(json['created'] as String),
    updated: json['updated'] == null
        ? null
        : DateTime.parse(json['updated'] as String),
    readme: json['readme'] as String,
    tags: (json['tags'] as List)?.map((e) => e as String)?.toList(),
    health: (json['health'] as num)?.toDouble(),
    popularity: (json['popularity'] as num)?.toDouble(),
    maintenance: (json['maintenance'] as num)?.toDouble(),
    likeCount: json['likeCount'] as int,
    dependencies: (json['dependencies'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    publisherId: json['publisherId'] as String,
    uploaderEmails:
        (json['uploaderEmails'] as List)?.map((e) => e as String)?.toList(),
    apiDocPages: (json['apiDocPages'] as List)
        ?.map((e) =>
            e == null ? null : ApiDocPage.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
  );
}

Map<String, dynamic> _$PackageDocumentToJson(PackageDocument instance) =>
    <String, dynamic>{
      'package': instance.package,
      'version': instance.version,
      'devVersion': instance.devVersion,
      'description': instance.description,
      'created': instance.created?.toIso8601String(),
      'updated': instance.updated?.toIso8601String(),
      'readme': instance.readme,
      'tags': instance.tags,
      'health': instance.health,
      'popularity': instance.popularity,
      'maintenance': instance.maintenance,
      'likeCount': instance.likeCount,
      'dependencies': instance.dependencies,
      'publisherId': instance.publisherId,
      'uploaderEmails': instance.uploaderEmails,
      'apiDocPages': instance.apiDocPages,
      'timestamp': instance.timestamp?.toIso8601String(),
    };

ApiDocPage _$ApiDocPageFromJson(Map<String, dynamic> json) {
  return ApiDocPage(
    relativePath: json['relativePath'] as String,
    symbols: (json['symbols'] as List)?.map((e) => e as String)?.toList(),
    textBlocks: (json['textBlocks'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ApiDocPageToJson(ApiDocPage instance) =>
    <String, dynamic>{
      'relativePath': instance.relativePath,
      'symbols': instance.symbols,
      'textBlocks': instance.textBlocks,
    };

PackageSearchResult _$PackageSearchResultFromJson(Map<String, dynamic> json) {
  return PackageSearchResult(
    indexUpdated: json['indexUpdated'] as String,
    totalCount: json['totalCount'] as int,
    packages: (json['packages'] as List)
        ?.map((e) =>
            e == null ? null : PackageScore.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PackageSearchResultToJson(
        PackageSearchResult instance) =>
    <String, dynamic>{
      'indexUpdated': instance.indexUpdated,
      'totalCount': instance.totalCount,
      'packages': instance.packages,
    };

PackageScore _$PackageScoreFromJson(Map<String, dynamic> json) {
  return PackageScore(
    package: json['package'] as String,
    score: (json['score'] as num)?.toDouble(),
    url: json['url'] as String,
    version: json['version'] as String,
    description: json['description'] as String,
    apiPages: (json['apiPages'] as List)
        ?.map((e) =>
            e == null ? null : ApiPageRef.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PackageScoreToJson(PackageScore instance) {
  final val = <String, dynamic>{
    'package': instance.package,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('score', instance.score);
  writeNotNull('url', instance.url);
  writeNotNull('version', instance.version);
  writeNotNull('description', instance.description);
  writeNotNull('apiPages', instance.apiPages);
  return val;
}

ApiPageRef _$ApiPageRefFromJson(Map<String, dynamic> json) {
  return ApiPageRef(
    title: json['title'] as String,
    path: json['path'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$ApiPageRefToJson(ApiPageRef instance) {
  final val = <String, dynamic>{
    'title': instance.title,
    'path': instance.path,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('url', instance.url);
  return val;
}
