// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_final_locals

part of 'search_service.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

PackageDocument _$PackageDocumentFromJson(Map<String, dynamic> json) =>
    new PackageDocument(
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
        isDeprecated: json['isDeprecated'] as bool,
        platforms:
            (json['platforms'] as List)?.map((e) => e as String)?.toList(),
        health: (json['health'] as num)?.toDouble(),
        popularity: (json['popularity'] as num)?.toDouble(),
        maintenance: (json['maintenance'] as num)?.toDouble(),
        dependencies: json['dependencies'] == null
            ? null
            : new Map<String, String>.from(json['dependencies'] as Map),
        emails: (json['emails'] as List)?.map((e) => e as String)?.toList(),
        timestamp: json['timestamp'] == null
            ? null
            : DateTime.parse(json['timestamp'] as String));

abstract class _$PackageDocumentSerializerMixin {
  String get package;
  String get version;
  String get devVersion;
  String get description;
  DateTime get created;
  DateTime get updated;
  String get readme;
  bool get isDeprecated;
  List<String> get platforms;
  double get health;
  double get popularity;
  double get maintenance;
  Map<String, String> get dependencies;
  List<String> get emails;
  DateTime get timestamp;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'package': package,
        'version': version,
        'devVersion': devVersion,
        'description': description,
        'created': created?.toIso8601String(),
        'updated': updated?.toIso8601String(),
        'readme': readme,
        'isDeprecated': isDeprecated,
        'platforms': platforms,
        'health': health,
        'popularity': popularity,
        'maintenance': maintenance,
        'dependencies': dependencies,
        'emails': emails,
        'timestamp': timestamp?.toIso8601String()
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
        package: json['package'] as String,
        score: (json['score'] as num)?.toDouble());

abstract class _$PackageScoreSerializerMixin {
  String get package;
  double get score;
  Map<String, dynamic> toJson() {
    var val = <String, dynamic>{
      'package': package,
    };

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('score', score);
    return val;
  }
}
