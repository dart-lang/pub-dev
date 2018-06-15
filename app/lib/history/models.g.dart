// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_final_locals

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageVersionUploaded _$PackageVersionUploadedFromJson(
    Map<String, dynamic> json) {
  return new PackageVersionUploaded(
      uploaderEmail: json['uploaderEmail'] as String);
}

abstract class _$PackageVersionUploadedSerializerMixin {
  String get uploaderEmail;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'uploaderEmail': uploaderEmail};
}

UploaderChanged _$UploaderChangedFromJson(Map<String, dynamic> json) {
  return new UploaderChanged(
      currentUserEmail: json['currentUserEmail'] as String,
      addedUploaderEmails: (json['addedUploaderEmails'] as List)
          ?.map((e) => e as String)
          ?.toList(),
      removedUploaderEmails: (json['removedUploaderEmails'] as List)
          ?.map((e) => e as String)
          ?.toList());
}

abstract class _$UploaderChangedSerializerMixin {
  String get currentUserEmail;
  List<String> get addedUploaderEmails;
  List<String> get removedUploaderEmails;
  Map<String, dynamic> toJson() {
    var val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('currentUserEmail', currentUserEmail);
    writeNotNull('addedUploaderEmails', addedUploaderEmails);
    writeNotNull('removedUploaderEmails', removedUploaderEmails);
    return val;
  }
}

AnalysisCompleted _$AnalysisCompletedFromJson(Map<String, dynamic> json) {
  return new AnalysisCompleted(
      hasErrors: json['hasErrors'] as bool,
      hasPlatforms: json['hasPlatforms'] as bool);
}

abstract class _$AnalysisCompletedSerializerMixin {
  bool get hasErrors;
  bool get hasPlatforms;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'hasErrors': hasErrors, 'hasPlatforms': hasPlatforms};
}
