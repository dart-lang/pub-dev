// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:gcloud/db.dart' as db;
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'models.g.dart';

final _uuid = new Uuid();

abstract class HistorySource {
  static const String account = 'account';
  static const String analyzer = 'analyzer';
  static const String dartdoc = 'dartdoc';
}

abstract class HistoryScope {
  static const String package = 'package';
  static const String version = 'version';
}

@db.Kind(name: 'History', idType: db.IdType.String)
class History extends db.ExpandoModel implements HistoryData {
  History();

  History._({
    this.packageName,
    this.packageVersion,
    this.timestamp,
    this.source,
    this.scope,
    this.eventType,
    Map<String, dynamic> eventData,
  }) {
    id = _uuid.v4();
    timestamp ??= new DateTime.now().toUtc();
    this.eventData = eventData;
  }

  factory History.package({
    @required String packageName,
    String packageVersion,
    DateTime timestamp,
    @required String source,
    @required HistoryEvent event,
  }) {
    final union = new HistoryUnion.ofEvent(event);
    final map = union.toJson();
    final type = map.keys.single;
    return new History._(
      packageName: packageName,
      packageVersion: packageVersion,
      timestamp: timestamp,
      source: source,
      scope: HistoryScope.package,
      eventType: type,
      eventData: map,
    );
  }

  factory History.version({
    @required String packageName,
    @required String packageVersion,
    DateTime timestamp,
    @required String source,
    @required HistoryEvent event,
  }) {
    final union = new HistoryUnion.ofEvent(event);
    final map = union.toJson();
    final type = map.keys.single;
    return new History._(
      packageName: packageName,
      packageVersion: packageVersion,
      timestamp: timestamp,
      source: source,
      scope: HistoryScope.version,
      eventType: type,
      eventData: map,
    );
  }

  @db.StringProperty(required: true)
  String scope;

  @db.StringProperty(required: true)
  @override
  String packageName;

  @db.StringProperty()
  @override
  String packageVersion;

  /// The timestamp of the entry.
  @db.DateTimeProperty()
  @override
  DateTime timestamp;

  @db.StringProperty(required: true)
  String source;

  @db.StringProperty(required: true)
  String eventType;

  @db.StringProperty()
  String eventJson;

  Map<String, dynamic> get eventData =>
      json.decode(eventJson) as Map<String, dynamic>;
  set eventData(Map<String, dynamic> value) {
    eventJson = json.encode(value);
  }

  HistoryEvent get historyEvent {
    return new HistoryUnion.fromJson(eventData).event;
  }

  String formatMarkdown() => historyEvent?.formatMarkdown(this);
}

abstract class HistoryData {
  String get packageName;
  String get packageVersion;
  DateTime get timestamp;
}

// ignore: one_member_abstracts
abstract class HistoryEvent {
  String formatMarkdown(HistoryData data);
}

@JsonSerializable()
class HistoryUnion {
  final PackageVersionUploaded packageVersionUploaded;
  final UploaderChanged uploaderChanged;
  final AnalysisCompleted analysisCompleted;

  HistoryUnion({
    this.packageVersionUploaded,
    this.uploaderChanged,
    this.analysisCompleted,
  }) {
    assert(_items.where((x) => x != null).length == 1);
  }

  factory HistoryUnion.ofEvent(HistoryEvent event) {
    if (event is PackageVersionUploaded) {
      return new HistoryUnion(packageVersionUploaded: event);
    } else if (event is UploaderChanged) {
      return new HistoryUnion(uploaderChanged: event);
    } else if (event is AnalysisCompleted) {
      return new HistoryUnion(analysisCompleted: event);
    } else {
      throw new ArgumentError('Unknown type: ${event.runtimeType}');
    }
  }

  factory HistoryUnion.fromJson(Map<String, dynamic> json) =>
      _$HistoryUnionFromJson(json);

  List<HistoryEvent> get _items {
    return <HistoryEvent>[
      packageVersionUploaded,
      uploaderChanged,
      analysisCompleted,
    ];
  }

  HistoryEvent get event => _items.firstWhere((x) => x != null);

  Map<String, dynamic> toJson() => _$HistoryUnionToJson(this);
}

@JsonSerializable()
class PackageVersionUploaded implements HistoryEvent {
  final String uploaderEmail;

  PackageVersionUploaded({@required this.uploaderEmail});

  factory PackageVersionUploaded.fromJson(Map<String, dynamic> json) =>
      _$PackageVersionUploadedFromJson(json);

  @override
  String formatMarkdown(HistoryData data) {
    return 'Version ${data.packageVersion} was uploaded by `$uploaderEmail`.';
  }

  Map<String, dynamic> toJson() => _$PackageVersionUploadedToJson(this);
}

@JsonSerializable()
class UploaderChanged implements HistoryEvent {
  @JsonKey(includeIfNull: false)
  final String currentUserEmail;

  @JsonKey(includeIfNull: false)
  final List<String> addedUploaderEmails;

  @JsonKey(includeIfNull: false)
  final List<String> removedUploaderEmails;

  UploaderChanged({
    @required this.currentUserEmail,
    this.addedUploaderEmails,
    this.removedUploaderEmails,
  });

  factory UploaderChanged.fromJson(Map<String, dynamic> json) =>
      _$UploaderChangedFromJson(json);

  @override
  String formatMarkdown(HistoryData data) {
    final changes = <String>[];
    if (addedUploaderEmails != null && addedUploaderEmails.isNotEmpty) {
      final emails = addedUploaderEmails.map((e) => '`$e`').join(', ');
      changes.add('added $emails');
    }
    if (removedUploaderEmails != null && removedUploaderEmails.isNotEmpty) {
      final emails = removedUploaderEmails.map((e) => '`$e`').join(', ');
      changes.add('removed $emails');
    }
    final actor = (currentUserEmail != null && currentUserEmail.isNotEmpty)
        ? currentUserEmail
        : 'A site administrator';
    return '$actor has changed uploaders: ${changes.join(' and ')}.';
  }

  Map<String, dynamic> toJson() => _$UploaderChangedToJson(this);
}

@JsonSerializable()
class AnalysisCompleted implements HistoryEvent {
  final bool hasErrors;

  final bool hasPlatforms;

  AnalysisCompleted({this.hasErrors, this.hasPlatforms});

  factory AnalysisCompleted.fromJson(Map<String, dynamic> json) =>
      _$AnalysisCompletedFromJson(json);

  @override
  String formatMarkdown(HistoryData data) {
    if (hasErrors) {
      return 'Analysis of `package:${data.packageName}` failed.';
    } else if (hasPlatforms) {
      return 'Analysis of `package:${data.packageName}` completed successful.';
    } else {
      return 'Analysis of `package:${data.packageName}` completed, but no platform has been identified.';
    }
  }

  Map<String, dynamic> toJson() => _$AnalysisCompletedToJson(this);
}
