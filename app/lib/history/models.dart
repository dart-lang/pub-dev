// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:gcloud/db.dart' as db;
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@db.Kind(name: 'History', idType: db.IdType.String)
class History extends db.ExpandoModel implements HistoryData {
  History({
    String id,
    this.packageName,
    this.packageVersion,
    this.timestamp,
    this.source,
    this.type,
    Map<String, dynamic> paramsMap,
  }) {
    this.id = id;
    timestamp ??= new DateTime.now().toUtc();
    this.paramsMap = paramsMap;
  }

  @db.StringProperty(required: true)
  @override
  String packageName;

  /// exact version or the 'latest' string
  @db.StringProperty(required: true)
  @override
  String packageVersion;

  /// The timestamp of the entry.
  @db.DateTimeProperty()
  @override
  DateTime timestamp;

  @db.StringProperty(required: true)
  String source;

  @db.StringProperty(required: true)
  String type;

  @db.StringProperty()
  String paramsJson;

  Map<String, dynamic> get paramsMap => json.decode(paramsJson);
  set paramsMap(Map<String, dynamic> value) {
    paramsJson = json.encode(value);
  }

  HistoryEvent get historyEvent {
    final fromJson = _eventDeserializers[type];
    if (fromJson == null) return null;
    return fromJson(paramsMap);
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
  AnalysisCompleted._type: _$AnalysisCompletedFromJson,
};

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
