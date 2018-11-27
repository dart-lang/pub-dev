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
class History extends db.ExpandoModel {
  History();

  History._({
    this.packageName,
    this.packageVersion,
    this.timestamp,
    this.source,
    this.scope,
    HistoryUnion union,
  }) {
    id = _uuid.v4();
    timestamp ??= new DateTime.now().toUtc();
    final map = union.toJson();
    eventType = map.keys.single;
    eventData = map.values.single as Map<String, dynamic>;
  }

  factory History.package({
    @required String source,
    @required HistoryEvent event,
  }) {
    return new History._(
      packageName: event.packageName,
      packageVersion: event.packageVersion,
      timestamp: event.timestamp,
      source: source,
      scope: HistoryScope.package,
      union: new HistoryUnion.ofEvent(event),
    );
  }

  factory History.version({
    @required String source,
    @required HistoryEvent event,
  }) {
    return new History._(
      packageName: event.packageName,
      packageVersion: event.packageVersion,
      timestamp: event.timestamp,
      source: source,
      scope: HistoryScope.version,
      union: new HistoryUnion.ofEvent(event),
    );
  }

  @db.StringProperty(required: true)
  String scope;

  @db.StringProperty(required: true)
  String packageName;

  @db.StringProperty()
  String packageVersion;

  /// The timestamp of the entry.
  @db.DateTimeProperty()
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

  HistoryUnion get historyUnion =>
      new HistoryUnion.fromJson({eventType: eventData});

  HistoryEvent get historyEvent => historyUnion.event;

  String formatMarkdown() => historyEvent?.formatMarkdown();
}

abstract class HistoryEvent {
  String get packageName;
  String get packageVersion;
  DateTime get timestamp;
  String formatMarkdown();
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class HistoryUnion {
  final PackageUploaded packageUploaded;
  final UploaderChanged uploaderChanged;
  final AnalysisCompleted analysisCompleted;

  HistoryUnion({
    this.packageUploaded,
    this.uploaderChanged,
    this.analysisCompleted,
  }) {
    assert(_items.where((x) => x != null).length == 1);
  }

  factory HistoryUnion.ofEvent(HistoryEvent event) {
    if (event is PackageUploaded) {
      return new HistoryUnion(packageUploaded: event);
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
      packageUploaded,
      uploaderChanged,
      analysisCompleted,
    ];
  }

  HistoryEvent get event => _items.firstWhere((x) => x != null);

  Map<String, dynamic> toJson() => _$HistoryUnionToJson(this);
}

@JsonSerializable()
class PackageUploaded implements HistoryEvent {
  @override
  final String packageName;
  @override
  final String packageVersion;
  final String uploaderEmail;
  @override
  final DateTime timestamp;

  PackageUploaded({
    @required this.packageName,
    @required this.packageVersion,
    @required this.uploaderEmail,
    DateTime timestamp,
  }) : this.timestamp = timestamp ?? new DateTime.now().toUtc();

  factory PackageUploaded.fromJson(Map<String, dynamic> json) =>
      _$PackageUploadedFromJson(json);

  @override
  String formatMarkdown() {
    return 'Version $packageVersion was uploaded by `$uploaderEmail`.';
  }

  Map<String, dynamic> toJson() => _$PackageUploadedToJson(this);
}

@JsonSerializable(includeIfNull: false)
class UploaderChanged implements HistoryEvent {
  @override
  final String packageName;
  final String currentUserEmail;
  final List<String> addedUploaderEmails;
  final List<String> removedUploaderEmails;
  @override
  final DateTime timestamp;

  UploaderChanged({
    @required this.packageName,
    @required this.currentUserEmail,
    this.addedUploaderEmails,
    this.removedUploaderEmails,
    DateTime timestamp,
  }) : this.timestamp = timestamp ?? new DateTime.now().toUtc();

  @override
  String get packageVersion => null;

  factory UploaderChanged.fromJson(Map<String, dynamic> json) =>
      _$UploaderChangedFromJson(json);

  @override
  String formatMarkdown() {
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
  @override
  final String packageName;
  @override
  final String packageVersion;
  final bool hasErrors;
  final bool hasPlatforms;
  @override
  final DateTime timestamp;

  AnalysisCompleted({
    @required this.packageName,
    @required this.packageVersion,
    @required this.hasErrors,
    @required this.hasPlatforms,
    DateTime timestamp,
  }) : this.timestamp = timestamp ?? new DateTime.now().toUtc();

  factory AnalysisCompleted.fromJson(Map<String, dynamic> json) =>
      _$AnalysisCompletedFromJson(json);

  @override
  String formatMarkdown() {
    if (hasErrors) {
      return 'Analysis of `package:$packageName` failed.';
    } else if (hasPlatforms) {
      return 'Analysis of `package:$packageName` completed successful.';
    } else {
      return 'Analysis of `package:$packageName` completed, but no platform has been identified.';
    }
  }

  Map<String, dynamic> toJson() => _$AnalysisCompletedToJson(this);
}
