// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:gcloud/db.dart' as db;

@db.Kind(name: 'History', idType: db.IdType.String)
class History extends db.ExpandoModel {
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
  String packageName;

  /// exact version or the 'latest' string
  @db.StringProperty(required: true)
  String packageVersion;

  /// The timestamp of the entry.
  @db.DateTimeProperty()
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
}
