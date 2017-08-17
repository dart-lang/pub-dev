// GENERATED CODE - DO NOT MODIFY BY HAND

part of pub_dartlang_org.shared.search_service;

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

PackageDocument _$PackageDocumentFromJson(Map<String, dynamic> json) =>
    new PackageDocument(
        url: json['url'] as String,
        package: json['package'] as String,
        version: json['version'] as String,
        devVersion: json['devVersion'] as String,
        description: json['description'] as String,
        lastUpdated: json['lastUpdated'] as String,
        readme: json['readme'] as String,
        detectedTypes:
            (json['detectedTypes'] as List)?.map((e) => e as String)?.toList(),
        popularity: json['popularity'] as double);

abstract class _$PackageDocumentSerializerMixin {
  String get url;
  String get package;
  String get version;
  String get devVersion;
  String get description;
  String get lastUpdated;
  String get readme;
  List<String> get detectedTypes;
  double get popularity;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'url': url,
        'package': package,
        'version': version,
        'devVersion': devVersion,
        'description': description,
        'lastUpdated': lastUpdated,
        'readme': readme,
        'detectedTypes': detectedTypes,
        'popularity': popularity
      };
}

PackageSearchResult _$PackageSearchResultFromJson(Map<String, dynamic> json) =>
    new PackageSearchResult(
        indexUpdated: json['indexUpdated'] as String,
        totalCount: json['totalCount'] as int,
        packages: (json['packages'] as List)
            ?.map((e) => e == null
                ? null
                : new PackageScore.fromJson(e as Map<String, dynamic>))
            ?.toList());

abstract class _$PackageSearchResultSerializerMixin {
  String get indexUpdated;
  int get totalCount;
  List<PackageScore> get packages;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'indexUpdated': indexUpdated,
        'totalCount': totalCount,
        'packages': packages
      };
}

PackageScore _$PackageScoreFromJson(Map<String, dynamic> json) =>
    new PackageScore(
        url: json['url'] as String,
        package: json['package'] as String,
        version: json['version'] as String,
        devVersion: json['devVersion'] as String,
        score: json['score'] as double);

abstract class _$PackageScoreSerializerMixin {
  String get url;
  String get package;
  String get version;
  String get devVersion;
  double get score;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'url': url,
        'package': package,
        'version': version,
        'devVersion': devVersion,
        'score': score
      };
}
