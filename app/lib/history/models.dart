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
  }) =>
      new History._(
        packageName: packageName,
        packageVersion: packageVersion,
        timestamp: timestamp,
        source: source,
        scope: HistoryScope.package,
        eventType: event.getType(),
        eventData: event.toJson(),
      );

  factory History.version({
    @required String packageName,
    @required String packageVersion,
    DateTime timestamp,
    @required String source,
    @required HistoryEvent event,
  }) =>
      new History._(
        packageName: packageName,
        packageVersion: packageVersion,
        timestamp: timestamp,
        source: source,
        scope: HistoryScope.version,
        eventType: event.getType(),
        eventData: event.toJson(),
      );

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

  Map<String, dynamic> get eventData => json.decode(eventJson);
  set eventData(Map<String, dynamic> value) {
    eventJson = json.encode(value);
  }

  HistoryEvent get historyEvent {
    final fromJson = _eventDeserializers[eventType];
    if (fromJson == null) return null;
    return fromJson(eventData);
  }

  String formatMarkdown() => historyEvent?.formatMarkdown(this);
}

abstract class HistoryData {
  String get packageName;
  String get packageVersion;
  DateTime get timestamp;
}

abstract class HistoryEvent {
  String getType();

  Map<String, dynamic> toJson();

  String formatMarkdown(HistoryData data);
}

typedef HistoryEvent HistoryEventFromJson(Map<String, dynamic> json);

final _eventDeserializers = <String, HistoryEventFromJson>{
  PackageVersionUploaded._type: _$PackageVersionUploadedFromJson,
  UploaderChanged._type: _$UploaderChangedFromJson,
  AnalysisCompleted._type: _$AnalysisCompletedFromJson,
};

@JsonSerializable()
class PackageVersionUploaded extends Object
    with _$PackageVersionUploadedSerializerMixin
    implements HistoryEvent {
  static const _type = 'package-version-uploaded';

  @override
  final String uploaderEmail;

  PackageVersionUploaded({@required this.uploaderEmail});

  @override
  String getType() => _type;

  @override
  String formatMarkdown(HistoryData data) {
    return 'Version ${data.packageVersion} was uploaded by `$uploaderEmail`.';
  }
}

@JsonSerializable()
class UploaderChanged extends Object
    with _$UploaderChangedSerializerMixin
    implements HistoryEvent {
  static const _type = 'uploader-changed';

  @JsonKey(includeIfNull: false)
  @override
  final String currentUserEmail;

  @JsonKey(includeIfNull: false)
  @override
  final List<String> addedUploaderEmails;

  @JsonKey(includeIfNull: false)
  @override
  final List<String> removedUploaderEmails;

  UploaderChanged({
    @required this.currentUserEmail,
    this.addedUploaderEmails,
    this.removedUploaderEmails,
  });

  @override
  String getType() => _type;

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
}

@JsonSerializable()
class AnalysisCompleted extends Object
    with _$AnalysisCompletedSerializerMixin
    implements HistoryEvent {
  static const _type = 'analysis-completed';

  @override
  final bool hasErrors;

  @override
  final bool hasPlatforms;

  AnalysisCompleted({this.hasErrors, this.hasPlatforms});

  @override
  String getType() => _type;

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
}
