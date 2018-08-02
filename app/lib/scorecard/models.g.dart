// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_final_locals

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
