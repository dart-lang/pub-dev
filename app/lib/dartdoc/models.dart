// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: annotate_overrides

import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pub_semver/pub_semver.dart';

import '../shared/utils.dart' show isNewer;
import '../shared/versions.dart' as versions;

part 'models.g.dart';

@JsonSerializable()
class DartdocEntry extends Object with _$DartdocEntrySerializerMixin {
  final String uuid;
  final String packageName;
  final String packageVersion;
  final bool usesFlutter;
  final String dartdocVersion;
  final String flutterVersion;
  final String customizationVersion;
  final DateTime timestamp;
  final bool depsResolved;
  final bool hasContent;

  DartdocEntry({
    @required this.uuid,
    @required this.packageName,
    @required this.packageVersion,
    @required this.usesFlutter,
    @required this.dartdocVersion,
    @required this.flutterVersion,
    @required this.customizationVersion,
    @required this.timestamp,
    @required this.depsResolved,
    @required this.hasContent,
  });

  factory DartdocEntry.fromJson(Map<String, dynamic> json) =>
      _$DartdocEntryFromJson(json);

  factory DartdocEntry.fromBytes(List<int> bytes) =>
      new DartdocEntry.fromJson(JSON.decode(UTF8.decode(bytes)));

  static Future<DartdocEntry> fromStream(Stream<List<int>> stream) async {
    final bytes = await stream.fold([], (sum, list) => sum..addAll(list));
    return new DartdocEntry.fromBytes(bytes);
  }

  Version get _semanticDartdocVersion => new Version.parse(dartdocVersion);
  Version get _semanticFlutterVersion => new Version.parse(flutterVersion);
  Version get _semanticCustomizationVersion =>
      new Version.parse(customizationVersion);

  bool get isServing => versions.shouldServeDartdoc(
      dartdocVersion, flutterVersion, customizationVersion);

  /// The path of the status while the upload is in progress
  String get inProgressPrefix =>
      DartdocEntryPaths.inProgressPrefix(packageName, packageVersion);

  /// The path of the particular JSON status while upload is in progress
  String get inProgressPath => '$inProgressPrefix/$uuid.json';

  /// The path prefix where all of the entry JSON files are stored.
  String get entryPrefix =>
      DartdocEntryPaths.entryPrefix(packageName, packageVersion);

  /// The path of the particular JSON entry after the upload was completed.
  String get entryPath => '$entryPrefix/$uuid.json';

  /// The path prefix where the content of this instance is stored.
  String get contentPrefix => '$packageName/$packageVersion/content/$uuid';

  List<int> asBytes() => UTF8.encode(JSON.encode(this.toJson()));

  bool requiresNewRun() {
    if (isNewer(_semanticDartdocVersion, versions.semanticDartdocVersion)) {
      // our dartdoc version is newer -> regenerate
      return true;
    }
    if (isNewer(versions.semanticDartdocVersion, _semanticDartdocVersion)) {
      // our dartdoc version is older -> skip generating
      return false;
    }

    if (usesFlutter &&
        isNewer(_semanticFlutterVersion, versions.semanticFlutterVersion)) {
      // our flutter version is newer -> regenerate
      return true;
    }

    if (isNewer(
        _semanticCustomizationVersion, versions.semanticCustomizationVersion)) {
      // our customization version is newer -> regenerate
      return true;
    }
    return false;
  }
}

// TODO: use dartdocVersion in the prefix paths
abstract class DartdocEntryPaths {
  static String inProgressPrefix(String packageName, String packageVersion) =>
      '$packageName/$packageVersion/in-progress';

  static String entryPrefix(String packageName, String packageVersion) =>
      '$packageName/$packageVersion/entry';
}
