// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageDocument _$PackageDocumentFromJson(Map<String, dynamic> json) =>
    PackageDocument(
      package: json['package'] as String,
      version: json['version'] as String?,
      description: json['description'] as String?,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      updated: json['updated'] == null
          ? null
          : DateTime.parse(json['updated'] as String),
      readme: json['readme'] as String? ?? '',
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      downloadCount: (json['downloadCount'] as num?)?.toInt(),
      likeCount: (json['likeCount'] as num?)?.toInt(),
      likeScore: (json['likeScore'] as num?)?.toDouble(),
      popularityScore: (json['popularityScore'] as num?)?.toDouble(),
      grantedPoints: (json['grantedPoints'] as num?)?.toInt(),
      maxPoints: (json['maxPoints'] as num?)?.toInt(),
      dependencies: (json['dependencies'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      apiDocPages: (json['apiDocPages'] as List<dynamic>?)
              ?.map((e) => ApiDocPage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      sourceUpdated: json['sourceUpdated'] == null
          ? null
          : DateTime.parse(json['sourceUpdated'] as String),
    )..overallScore = (json['overallScore'] as num?)?.toDouble();

Map<String, dynamic> _$PackageDocumentToJson(PackageDocument instance) =>
    <String, dynamic>{
      'package': instance.package,
      'version': instance.version,
      'description': instance.description,
      'created': instance.created.toIso8601String(),
      'updated': instance.updated.toIso8601String(),
      'readme': instance.readme,
      'tags': instance.tags,
      'downloadCount': instance.downloadCount,
      'likeCount': instance.likeCount,
      'likeScore': instance.likeScore,
      'popularityScore': instance.popularityScore,
      'grantedPoints': instance.grantedPoints,
      'maxPoints': instance.maxPoints,
      'overallScore': instance.overallScore,
      'dependencies': instance.dependencies,
      'apiDocPages': instance.apiDocPages,
      'timestamp': instance.timestamp.toIso8601String(),
      'sourceUpdated': instance.sourceUpdated?.toIso8601String(),
    };

ApiDocPage _$ApiDocPageFromJson(Map<String, dynamic> json) => ApiDocPage(
      relativePath: json['relativePath'] as String,
      symbols:
          (json['symbols'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ApiDocPageToJson(ApiDocPage instance) =>
    <String, dynamic>{
      'relativePath': instance.relativePath,
      'symbols': instance.symbols,
    };

PackageSearchResult _$PackageSearchResultFromJson(Map<String, dynamic> json) =>
    PackageSearchResult(
      timestamp: DateTime.parse(json['timestamp'] as String),
      totalCount: (json['totalCount'] as num).toInt(),
      nameMatches: (json['nameMatches'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sdkLibraryHits: (json['sdkLibraryHits'] as List<dynamic>?)
          ?.map((e) => SdkLibraryHit.fromJson(e as Map<String, dynamic>))
          .toList(),
      packageHits: (json['packageHits'] as List<dynamic>?)
          ?.map((e) => PackageHit.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorMessage: json['errorMessage'] as String?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PackageSearchResultToJson(PackageSearchResult instance) {
  final val = <String, dynamic>{
    'timestamp': instance.timestamp.toIso8601String(),
    'totalCount': instance.totalCount,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nameMatches', instance.nameMatches);
  val['sdkLibraryHits'] =
      instance.sdkLibraryHits.map((e) => e.toJson()).toList();
  val['packageHits'] = instance.packageHits.map((e) => e.toJson()).toList();
  writeNotNull('errorMessage', instance.errorMessage);
  writeNotNull('statusCode', instance.statusCode);
  return val;
}

SdkLibraryHit _$SdkLibraryHitFromJson(Map<String, dynamic> json) =>
    SdkLibraryHit(
      sdk: json['sdk'] as String?,
      version: json['version'] as String?,
      library: json['library'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      score: (json['score'] as num).toDouble(),
      apiPages: (json['apiPages'] as List<dynamic>?)
          ?.map((e) => ApiPageRef.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SdkLibraryHitToJson(SdkLibraryHit instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sdk', instance.sdk);
  writeNotNull('version', instance.version);
  writeNotNull('library', instance.library);
  writeNotNull('description', instance.description);
  writeNotNull('url', instance.url);
  val['score'] = instance.score;
  writeNotNull('apiPages', instance.apiPages?.map((e) => e.toJson()).toList());
  return val;
}

PackageHit _$PackageHitFromJson(Map<String, dynamic> json) => PackageHit(
      package: json['package'] as String,
      score: (json['score'] as num?)?.toDouble(),
      apiPages: (json['apiPages'] as List<dynamic>?)
          ?.map((e) => ApiPageRef.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PackageHitToJson(PackageHit instance) {
  final val = <String, dynamic>{
    'package': instance.package,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('score', instance.score);
  writeNotNull('apiPages', instance.apiPages?.map((e) => e.toJson()).toList());
  return val;
}

ApiPageRef _$ApiPageRefFromJson(Map<String, dynamic> json) => ApiPageRef(
      title: json['title'] as String?,
      path: json['path'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ApiPageRefToJson(ApiPageRef instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('path', instance.path);
  writeNotNull('url', instance.url);
  return val;
}
