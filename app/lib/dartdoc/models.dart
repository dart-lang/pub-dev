// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../shared/versions.dart' as versions;
import 'storage_path.dart' as storage_path;

part 'models.g.dart';

/// Describes the details of a dartdoc-generated content.
@JsonSerializable()
class DartdocEntry {
  /// Random uuid for lookup in storage bucket, see [storage_path].
  final String uuid;
  final String packageName;
  final String packageVersion;

  /// Whether the [packageVersion] is the latest stable version of the package
  /// (at the time of the entry being created, but may be updated later).
  final bool isLatest;

  /// Whether the package version is too old. This is never set if the version
  /// is the latest stable version of the package..
  final bool isObsolete;

  /// Whether the package version uses Flutter.
  final bool usesFlutter;

  /// The pub site runtime version of the runtime that generated the content.
  final String runtimeVersion;

  /// The SDK version that was used to fetch dependencies.
  final String sdkVersion;

  /// The version of `package:dartdoc` that generated the content.
  final String dartdocVersion;

  /// The version of Flutter that was used to fetch dependencies.
  final String flutterVersion;

  /// When the content was generated.
  final DateTime timestamp;

  /// Whether the dependencies were resolved successfully.
  final bool depsResolved;

  /// Whether the dartdoc process produced valid content.
  final bool hasContent;

  /// The size of the compressed archive file.
  final int archiveSize;

  /// The size of all the individual files, uncompressed.
  final int totalSize;

  DartdocEntry({
    @required this.uuid,
    @required this.packageName,
    @required this.packageVersion,
    @required this.isLatest,
    @required this.isObsolete,
    @required this.usesFlutter,
    @required String runtimeVersion,
    @required this.sdkVersion,
    @required this.dartdocVersion,
    @required this.flutterVersion,
    @required this.timestamp,
    @required this.depsResolved,
    @required this.hasContent,
    @required this.archiveSize,
    @required this.totalSize,
  }) :
        // Some old entries do not have runtimeVersion filled, using the epoch.
        runtimeVersion = runtimeVersion ?? versions.dartdocRuntimeEpoch;

  factory DartdocEntry.fromJson(Map<String, dynamic> json) =>
      _$DartdocEntryFromJson(json);

  factory DartdocEntry.fromBytes(List<int> bytes) => DartdocEntry.fromJson(
      json.decode(utf8.decode(bytes)) as Map<String, dynamic>);

  static Future<DartdocEntry> fromStream(Stream<List<int>> stream) async {
    final bytes =
        await stream.fold<List<int>>([], (sum, list) => sum..addAll(list));
    return DartdocEntry.fromBytes(bytes);
  }

  /// Creates a new instance, copying fields that are not specified, overriding
  /// the ones that are.
  DartdocEntry replace({bool isLatest, bool isObsolete}) {
    return DartdocEntry(
      uuid: uuid,
      packageName: packageName,
      packageVersion: packageVersion,
      isLatest: isLatest ?? this.isLatest,
      isObsolete: isObsolete ?? this.isObsolete,
      usesFlutter: usesFlutter,
      runtimeVersion: runtimeVersion,
      sdkVersion: sdkVersion,
      dartdocVersion: dartdocVersion,
      flutterVersion: flutterVersion,
      timestamp: timestamp,
      depsResolved: depsResolved,
      hasContent: hasContent,
      archiveSize: archiveSize,
      totalSize: totalSize,
    );
  }

  Map<String, dynamic> toJson() => _$DartdocEntryToJson(this);

  /// Whether the version should be serving with (e.g. it is not a known
  /// coordinated upgrade of the templates and styles).
  bool get isServing => versions.shouldServeDartdoc(runtimeVersion);

  /// The path of the status while the upload is in progress
  String get inProgressPrefix =>
      storage_path.inProgressPrefix(packageName, packageVersion);

  /// The path of the particular JSON status while upload is in progress
  String get inProgressObjectName =>
      storage_path.inProgressObjectName(packageName, packageVersion, uuid);

  /// The path prefix where all of the entry JSON files are stored.
  String get entryPrefix =>
      storage_path.entryPrefix(packageName, packageVersion);

  /// The path of the particular JSON entry after the upload was completed.
  String get entryObjectName =>
      storage_path.entryObjectName(packageName, packageVersion, uuid);

  /// The path prefix where the content of this instance is stored.
  String get contentPrefix =>
      storage_path.contentPrefix(packageName, packageVersion, uuid);

  String objectName(String relativePath) {
    final isShared = storage_path.isSharedAsset(relativePath);
    if (isShared) {
      return storage_path.sharedAssetObjectName(dartdocVersion, relativePath);
    } else {
      return storage_path.contentObjectName(
          packageName, packageVersion, uuid, relativePath);
    }
  }

  List<int> asBytes() => utf8.encode(json.encode(toJson()));

  bool isRegression(DartdocEntry oldEntry) {
    if (oldEntry == null) {
      // Old entry does not exists, new entry wins.
      return false;
    }
    if (oldEntry.runtimeVersion != runtimeVersion) {
      // Different versions - not considered as a regression.
      return false;
    }
    if (!oldEntry.hasContent) {
      // The old entry had no content, the new should be better.
      return false;
    }
    if (hasContent) {
      // Having new content wins.
      return false;
    }
    // Older entry seems to be better.
    return true;
  }

  /// The current age of the entry.
  Duration get age {
    return DateTime.now().toUtc().difference(timestamp);
  }
}

@JsonSerializable()
class FileInfo {
  final DateTime lastModified;
  final String etag;

  FileInfo({@required this.lastModified, @required this.etag});

  factory FileInfo.fromJson(Map<String, dynamic> json) =>
      _$FileInfoFromJson(json);

  factory FileInfo.fromBytes(List<int> bytes) => FileInfo.fromJson(
      json.decode(utf8.decode(bytes)) as Map<String, dynamic>);

  List<int> asBytes() => utf8.encode(json.encode(toJson()));

  Map<String, dynamic> toJson() => _$FileInfoToJson(this);
}
