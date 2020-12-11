// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:meta/meta.dart';

import '../account/models.dart';
import '../shared/datastore.dart' as db;
import '../shared/utils.dart' show createUuid;

final _expiresInFarFuture = DateTime.utc(9999, 12, 31, 23, 59, 59);

@db.Kind(name: 'AuditLogRecord', idType: db.IdType.String)
class AuditLogRecord extends db.ExpandoModel<String> {
  @db.DateTimeProperty(required: true)
  DateTime created;

  /// [DateTime] after which a background tasks should delete this entity.
  ///
  /// Set this to the far future ([_expiresInFarFuture]) for records that
  /// shouldn't expire anytime soon.
  /// NOTE(year 9998): Migrate expiry date even further in the future.
  @db.DateTimeProperty(required: true)
  DateTime expires;

  /// String identifying the kind of event recorded.
  ///
  /// Allowed values are documented in [AuditLogRecordKind].
  @db.StringProperty(required: true)
  String kind;

  /// [User.userId] of the user who initiated / authorized the recorded action.
  ///
  /// This is a UUIDv4. If the user has been deleted, it is possible that this
  /// property may not match any [User] entity.
  @db.StringProperty(required: true)
  String agent;

  /// Textual summary of the action that was performed in **markdown**.
  ///
  /// This summary should contain a full explanation of the action that was taken,
  /// including who authorized it, which user or resource was subject of the action.
  /// Users are identified by the email associated with their account at the point-in-time
  /// when the action was taken.
  ///
  /// The following properties are intended for presentation in a table when rendering an audit-log:
  ///  * [created]
  ///  * [kind]
  ///  * [agent] (left as `<deleted-user>` if user no longer exists)
  ///  * [summary]
  ///
  /// This can only use simple markdown formatting no block structures.
  @db.StringProperty(required: true, indexed: false)
  String summary;

  /// A free-form Map of data about the event's details.
  @db.StringProperty(indexed: false)
  String dataJson;

  /// List of [User.userId] for the users involved in this record.
  ///
  /// This is the list of users who should have this record show up in their personal audit-log.
  /// This should include [agent], as well as any users who is subject of this action, that's
  /// it should include the user who did this action, and the user who is invited/removed.
  ///
  /// This property **MUST** only be used for querying. The contents of this property is
  /// **NOT** intended for consumption or presentation by other means. It's only here
  /// to make it easy to find [AuditLogRecord]s relevant for a specific user.
  @db.StringListProperty()
  List<String> users;

  /// List of packages involved in this record.
  ///
  /// This is the list of packages who should have this record show up in their
  /// audit-log.
  ///
  /// This property **MUST** only be used for querying. The contents of this property is
  /// **NOT** intended for consumption or presentation by other means. It's only here
  /// to make it easy to find [AuditLogRecord]s relevant for a specific package.
  @db.StringListProperty()
  List<String> packages;

  /// List of package versions involved in this record.
  ///
  /// This is the list of package version who should have this record show up in
  /// their audit-log.
  ///
  /// This property **MUST** only be used for querying. The contents of this property is
  /// **NOT** intended for consumption or presentation by other means. It's only here
  /// to make it easy to find [AuditLogRecord]s relevant for a specific package version.
  @db.StringListProperty()
  List<String> packageVersions;

  /// List of publishers involved in this record.
  ///
  /// This is the list of publishers who should have this record show up in their
  /// audit-log.
  ///
  /// This property **MUST** only be used for querying. The contents of this property is
  /// **NOT** intended for consumption or presentation by other means. It's only here
  /// to make it easy to find [AuditLogRecord]s relevant for a specific publisher.
  @db.StringListProperty()
  List<String> publishers;

  AuditLogRecord();

  Map<String, dynamic> get data =>
      dataJson == null ? null : json.decode(dataJson) as Map<String, dynamic>;
  set data(Map<String, dynamic> value) {
    dataJson = json.encode(value);
  }

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
      ..expires = _expiresInFarFuture
      ..kind = AuditLogRecordKind.packagePublished
      ..agent = uploader.userId
      ..summary = summary
      ..data = {
        'package': package,
        'version': version,
        'email': uploader.email,
      }
      ..users = [uploader.userId]
      ..packages = [package]
      ..packageVersions = ['$package/$version']
      ..publishers = [];
  }
}

abstract class AuditLogRecordKind {
  static const packagePublished = 'package-published';
}
