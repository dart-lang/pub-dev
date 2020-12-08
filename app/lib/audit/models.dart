// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';

import '../account/models.dart';
import '../shared/datastore.dart' as db;
import '../shared/utils.dart' show createUuid;

@db.Kind(name: 'AuditLogRecord', idType: db.IdType.String)
class AuditLogRecord extends db.ExpandoModel<String> {
  @db.DateTimeProperty(required: true)
  DateTime created;

  @db.DateTimeProperty()
  DateTime expires;

  @db.StringProperty(required: true)
  String kind;

  @db.StringProperty(required: true)
  String agent;

  @db.StringProperty(required: true)
  String summary;

  @db.StringListProperty()
  List<String> users;

  @db.StringListProperty()
  List<String> packages;

  @db.StringListProperty()
  List<String> packageVersions;

  @db.StringListProperty()
  List<String> publishers;

  AuditLogRecord();

  factory AuditLogRecord.packagePublished({
    @required User uploader,
    @required String package,
    @required String version,
    @required DateTime created,
  }) {
    final summary = 'Package `$package` '
        'version `$version` '
        'was published '
        'by `${uploader.email}`.';
    return AuditLogRecord()
      ..id = createUuid()
      ..created = created
      ..expires = null // does not expire
      ..kind = AuditLogRecordKind.packagePublished
      ..agent = uploader.userId
      ..summary = summary
      ..users = [uploader.userId]
      ..packages = [package]
      ..packageVersions = ['$package/$version']
      ..publishers = [];
  }
}

abstract class AuditLogRecordKind {
  static const packagePublished = 'package-published';
}
