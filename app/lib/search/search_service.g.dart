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
      downloadScore: (json['downloadScore'] as num?)?.toDouble(),
      likeCount: (json['likeCount'] as num?)?.toInt(),
      likeScore: (json['likeScore'] as num?)?.toDouble(),
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
      'downloadScore': instance.downloadScore,
      'likeCount': instance.likeCount,
      'likeScore': instance.likeScore,
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
      topicMatches: (json['topicMatches'] as List<dynamic>?)
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

Map<String, dynamic> _$PackageSearchResultToJson(
        PackageSearchResult instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'totalCount': instance.totalCount,
      if (instance.nameMatches case final value?) 'nameMatches': value,
      if (instance.topicMatches case final value?) 'topicMatches': value,
      'sdkLibraryHits': instance.sdkLibraryHits.map((e) => e.toJson()).toList(),
      'packageHits': instance.packageHits.map((e) => e.toJson()).toList(),
      if (instance.errorMessage case final value?) 'errorMessage': value,
      if (instance.statusCode case final value?) 'statusCode': value,
    };

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

Map<String, dynamic> _$SdkLibraryHitToJson(SdkLibraryHit instance) =>
    <String, dynamic>{
      if (instance.sdk case final value?) 'sdk': value,
      if (instance.version case final value?) 'version': value,
      if (instance.library case final value?) 'library': value,
      if (instance.description case final value?) 'description': value,
      if (instance.url case final value?) 'url': value,
      'score': instance.score,
      if (instance.apiPages?.map((e) => e.toJson()).toList() case final value?)
        'apiPages': value,
    };

PackageHit _$PackageHitFromJson(Map<String, dynamic> json) => PackageHit(
      package: json['package'] as String,
      score: (json['score'] as num?)?.toDouble(),
      apiPages: (json['apiPages'] as List<dynamic>?)
          ?.map((e) => ApiPageRef.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PackageHitToJson(PackageHit instance) =>
    <String, dynamic>{
      'package': instance.package,
      if (instance.score case final value?) 'score': value,
      if (instance.apiPages?.map((e) => e.toJson()).toList() case final value?)
        'apiPages': value,
    };

ApiPageRef _$ApiPageRefFromJson(Map<String, dynamic> json) => ApiPageRef(
      title: json['title'] as String?,
      path: json['path'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ApiPageRefToJson(ApiPageRef instance) =>
    <String, dynamic>{
      if (instance.title case final value?) 'title': value,
      if (instance.path case final value?) 'path': value,
      if (instance.url case final value?) 'url': value,
    };
