// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_final_locals

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DartdocEntry _$DartdocEntryFromJson(Map<String, dynamic> json) {
  return new DartdocEntry(
      uuid: json['uuid'] as String,
      packageName: json['packageName'] as String,
      packageVersion: json['packageVersion'] as String,
      isLatest: json['isLatest'] as bool,
      isObsolete: json['isObsolete'] as bool,
      usesFlutter: json['usesFlutter'] as bool,
      runtimeVersion: json['runtimeVersion'] as String,
      sdkVersion: json['sdkVersion'] as String,
      dartdocVersion: json['dartdocVersion'] as String,
      flutterVersion: json['flutterVersion'] as String,
      customizationVersion: json['customizationVersion'] as String,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      depsResolved: json['depsResolved'] as bool,
      hasContent: json['hasContent'] as bool,
      archiveSize: json['archiveSize'] as int,
      totalSize: json['totalSize'] as int);
}

abstract class _$DartdocEntrySerializerMixin {
  String get uuid;
  String get packageName;
  String get packageVersion;
  bool get isLatest;
  bool get isObsolete;
  bool get usesFlutter;
  String get runtimeVersion;
  String get sdkVersion;
  String get dartdocVersion;
  String get flutterVersion;
  String get customizationVersion;
  DateTime get timestamp;
  bool get depsResolved;
  bool get hasContent;
  int get archiveSize;
  int get totalSize;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'uuid': uuid,
        'packageName': packageName,
        'packageVersion': packageVersion,
        'isLatest': isLatest,
        'isObsolete': isObsolete,
        'usesFlutter': usesFlutter,
        'runtimeVersion': runtimeVersion,
        'sdkVersion': sdkVersion,
        'dartdocVersion': dartdocVersion,
        'flutterVersion': flutterVersion,
        'customizationVersion': customizationVersion,
        'timestamp': timestamp?.toIso8601String(),
        'depsResolved': depsResolved,
        'hasContent': hasContent,
        'archiveSize': archiveSize,
        'totalSize': totalSize
      };
}

FileInfo _$FileInfoFromJson(Map<String, dynamic> json) {
  return new FileInfo(
      lastModified: json['lastModified'] == null
          ? null
          : DateTime.parse(json['lastModified'] as String),
      etag: json['etag'] as String);
}

abstract class _$FileInfoSerializerMixin {
  DateTime get lastModified;
  String get etag;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'lastModified': lastModified?.toIso8601String(),
        'etag': etag
      };
}
