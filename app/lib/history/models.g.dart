// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_final_locals

part of 'models.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

PackageVersionUploaded _$PackageVersionUploadedFromJson(
        Map<String, dynamic> json) =>
    new PackageVersionUploaded(uploaderEmail: json['uploaderEmail'] as String);

abstract class _$PackageVersionUploadedSerializerMixin {
  String get uploaderEmail;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'uploaderEmail': uploaderEmail};
}

AnalysisCompleted _$AnalysisCompletedFromJson(Map<String, dynamic> json) =>
    new AnalysisCompleted(
        hasErrors: json['hasErrors'] as bool,
        hasPlatforms: json['hasPlatforms'] as bool);

abstract class _$AnalysisCompletedSerializerMixin {
  bool get hasErrors;
  bool get hasPlatforms;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'hasErrors': hasErrors, 'hasPlatforms': hasPlatforms};
}
