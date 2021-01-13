// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:meta/meta.dart';

import '../account/models.dart';
import '../shared/datastore.dart' as db;
import '../shared/utils.dart' show createUuid;

final _expiresInFarFuture = DateTime.utc(9999, 12, 31, 23, 59, 59);
final _defaultExpires = Duration(days: 61);

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
  @db.StringProperty(required: true, indexed: false)
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

  bool get isExpired => DateTime.now().isAfter(expires);
  bool get isNotExpired => !isExpired;

  /// Init log record with default id and timestamps
  AuditLogRecord._init() {
    final now = DateTime.now().toUtc();
    id = createUuid();
    created = now;
    expires = now.add(_defaultExpires);
  }

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

  factory AuditLogRecord.packageTransferred({
    @required User user,
    @required String package,
    @required String fromPublisherId,
    @required String toPublisherId,
  }) {
    return AuditLogRecord._init()
      ..kind = AuditLogRecordKind.packageTransferred
      ..agent = user.userId
      ..summary = [
        'Package `$package` ',
        if (fromPublisherId != null) 'from `$fromPublisherId` ',
        'was transferred to publisher `$toPublisherId` ',
        'by `${user.email}`.',
      ].join()
      ..data = {
        'package': package,
        if (fromPublisherId != null) 'fromPublisherId': fromPublisherId,
        'toPublisherId': toPublisherId,
        'user': user.email,
      }
      ..users = [user.userId]
      ..packages = [package]
      ..packageVersions = []
      ..publishers = [
        if (fromPublisherId != null) fromPublisherId,
        toPublisherId,
      ];
  }

  factory AuditLogRecord.publisherContactInvited({
    @required User user,
    @required String publisherId,
    @required String contactEmail,
  }) {
    return AuditLogRecord._init()
      ..kind = AuditLogRecordKind.publisherContactInvited
      ..agent = user.userId
      ..summary = [
        '`${user.email}` invited `$contactEmail` ',
        'to be contact email for publisher `$publisherId`.',
      ].join()
      ..data = {
        'publisherId': publisherId,
        'contactEmail': contactEmail,
        'user': user.email,
      }
      ..users = [user.userId]
      ..packages = []
      ..packageVersions = []
      ..publishers = [publisherId];
  }

  factory AuditLogRecord.publisherMemberInvited({
    @required User user,
    @required String publisherId,
    @required String memberEmail,
  }) {
    return AuditLogRecord._init()
      ..kind = AuditLogRecordKind.publisherMemberInvited
      ..agent = user.userId
      ..summary = [
        '`${user.email}` invited `$memberEmail` ',
        'to be a member for publisher `$publisherId`.',
      ].join()
      ..data = {
        'publisherId': publisherId,
        'memberEmail': memberEmail,
        'user': user.email,
      }
      ..users = [user.userId]
      ..packages = []
      ..packageVersions = []
      ..publishers = [publisherId];
  }

  factory AuditLogRecord.uploaderInvited({
    @required User user,
    @required String package,
    @required String uploaderEmail,
  }) {
    return AuditLogRecord._init()
      ..kind = AuditLogRecordKind.uploadedInvited
      ..agent = user.userId
      ..summary = [
        '`${user.email}` invited `$uploaderEmail` ',
        'to be an uploader for package `$package`.',
      ].join()
      ..data = {
        'package': package,
        'uploaderEmail': uploaderEmail,
        'user': user.email,
      }
      ..users = [user.userId]
      ..packages = [package]
      ..packageVersions = []
      ..publishers = [];
  }
}

abstract class AuditLogRecordKind {
  /// Event that a package was published.
  ///
  /// This can be an entirely new package or just a new version to an existing package.
  static const packagePublished = 'package-published';

  /// Event that a package has transferred to a (new) publisher.
  static const packageTransferred = 'package-transferred';

  /// Event that an e-mail was invited to be a publisher contact.
  static const publisherContactInvited = 'publisher-contact-invited';

  /// Event that an e-mail was invited to be a publisher member.
  static const publisherMemberInvited = 'publisher-member-invited';

  /// Event that an uploader was invited to a package.
  static const uploadedInvited = 'uploader-invited';

// TODO: implement further kinds
  // uploader-invite-accepted/added
  // uploader-invite-rejected
  // uploader-removed
  // publisher-created
  // publisher-updated
  // publisher-contact-changed
  // publisher-member-invite-accepted/added
  // publisher-member-invite-rejected
  // publisher-member-removed
}
