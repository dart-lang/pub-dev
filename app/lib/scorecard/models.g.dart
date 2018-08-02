// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_final_locals

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoreCardData _$ScoreCardDataFromJson(Map<String, dynamic> json) {
  return new ScoreCardData(
      packageName: json['packageName'] as String,
      packageVersion: json['packageVersion'] as String,
      runtimeVersion: json['runtimeVersion'] as String,
      updated: json['updated'] == null
          ? null
          : DateTime.parse(json['updated'] as String),
      packageCreated: json['packageCreated'] == null
          ? null
          : DateTime.parse(json['packageCreated'] as String),
      packageVersionCreated: json['packageVersionCreated'] == null
          ? null
          : DateTime.parse(json['packageVersionCreated'] as String),
      healthScore: (json['healthScore'] as num)?.toDouble(),
      maintenanceScore: (json['maintenanceScore'] as num)?.toDouble(),
      popularityScore: (json['popularityScore'] as num)?.toDouble(),
      platformTags:
          (json['platformTags'] as List)?.map((e) => e as String)?.toList(),
      flags: (json['flags'] as List)?.map((e) => e as String)?.toList(),
      reportTypes:
          (json['reportTypes'] as List)?.map((e) => e as String)?.toList());
}

abstract class _$ScoreCardDataSerializerMixin {
  String get packageName;
  String get packageVersion;
  String get runtimeVersion;
  DateTime get updated;
  DateTime get packageCreated;
  DateTime get packageVersionCreated;
  double get healthScore;
  double get maintenanceScore;
  double get popularityScore;
  List<String> get platformTags;
  List<String> get flags;
  List<String> get reportTypes;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'packageName': packageName,
        'packageVersion': packageVersion,
        'runtimeVersion': runtimeVersion,
        'updated': updated?.toIso8601String(),
        'packageCreated': packageCreated?.toIso8601String(),
        'packageVersionCreated': packageVersionCreated?.toIso8601String(),
        'healthScore': healthScore,
        'maintenanceScore': maintenanceScore,
        'popularityScore': popularityScore,
        'platformTags': platformTags,
        'flags': flags,
        'reportTypes': reportTypes
      };
}

PanaReport _$PanaReportFromJson(Map<String, dynamic> json) {
  return new PanaReport(
      reportStatus: json['reportStatus'] as String,
      healthScore: (json['healthScore'] as num)?.toDouble(),
      maintenanceScore: (json['maintenanceScore'] as num)?.toDouble(),
      platformTags:
          (json['platformTags'] as List)?.map((e) => e as String)?.toList(),
      platformReason: json['platformReason'] as String,
      pkgDependencies: (json['pkgDependencies'] as List)
          ?.map((e) => e == null
              ? null
              : new PkgDependency.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      suggestions: (json['suggestions'] as List)
          ?.map((e) => e == null
              ? null
              : new Suggestion.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

abstract class _$PanaReportSerializerMixin {
  String get reportStatus;
  double get healthScore;
  double get maintenanceScore;
  List<String> get platformTags;
  String get platformReason;
  List<PkgDependency> get pkgDependencies;
  List<Suggestion> get suggestions;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'reportStatus': reportStatus,
        'healthScore': healthScore,
        'maintenanceScore': maintenanceScore,
        'platformTags': platformTags,
        'platformReason': platformReason,
        'pkgDependencies': pkgDependencies,
        'suggestions': suggestions
      };
}

DartdocReport _$DartdocReportFromJson(Map<String, dynamic> json) {
  return new DartdocReport(
      reportStatus: json['reportStatus'] as String,
      coverageScore: (json['coverageScore'] as num)?.toDouble(),
      suggestions: (json['suggestions'] as List)
          ?.map((e) => e == null
              ? null
              : new Suggestion.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

abstract class _$DartdocReportSerializerMixin {
  String get reportStatus;
  double get coverageScore;
  List<Suggestion> get suggestions;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'reportStatus': reportStatus,
        'coverageScore': coverageScore,
        'suggestions': suggestions
      };
}
