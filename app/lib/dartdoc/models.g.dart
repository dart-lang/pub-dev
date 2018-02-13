// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_final_locals

part of 'models.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

DartdocEntry _$DartdocEntryFromJson(Map<String, dynamic> json) =>
    new DartdocEntry(
        uuid: json['uuid'] as String,
        packageName: json['packageName'] as String,
        packageVersion: json['packageVersion'] as String,
        dartdocVersion: json['dartdocVersion'] as String,
        timestamp: json['timestamp'] == null
            ? null
            : DateTime.parse(json['timestamp'] as String),
        hasContent: json['hasContent'] as bool);

abstract class _$DartdocEntrySerializerMixin {
  String get uuid;
  String get packageName;
  String get packageVersion;
  String get dartdocVersion;
  DateTime get timestamp;
  bool get hasContent;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'uuid': uuid,
        'packageName': packageName,
        'packageVersion': packageVersion,
        'dartdocVersion': dartdocVersion,
        'timestamp': timestamp?.toIso8601String(),
        'hasContent': hasContent
      };
}
