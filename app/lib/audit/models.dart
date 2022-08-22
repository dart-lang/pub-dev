// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:pub_dev/account/backend.dart';

import '../account/models.dart';
import '../shared/datastore.dart' as db;
import '../shared/utils.dart' show createUuid;

final _expiresInFarFuture = DateTime.utc(9999, 12, 31, 23, 59, 59);
final _defaultExpires = Duration(days: 61);

/// A single page of log records.
class AuditLogRecordPage {
  final List<AuditLogRecord> records;
  final String? nextTimestamp;

  AuditLogRecordPage(this.records, this.nextTimestamp);

  bool get hasNextPage => nextTimestamp != null;
}

@db.Kind(name: 'AuditLogRecord', idType: db.IdType.String)
class AuditLogRecord extends db.ExpandoModel<String> {
  @db.DateTimeProperty(required: true)
  DateTime? created;

  /// [DateTime] after which a background tasks should delete this entity.
  ///
  /// Set this to the far future ([_expiresInFarFuture]) for records that
  /// shouldn't expire anytime soon.
  /// NOTE(year 9998): Migrate expiry date even further in the future.
  @db.DateTimeProperty(required: true)
  DateTime? expires;

  /// String identifying the kind of event recorded.
  ///
  /// Allowed values are documented in [AuditLogRecordKind].
  @db.StringProperty(required: true)
  String? kind;

  /// [User.userId] of the user or a known service agent who initiated / authorized the recorded action.
  ///
  /// - For [User] accounts, this is a UUIDv4. If the user has been deleted,
  ///   it is possible that this property may not match any [User] entity.
  /// - For known service accounts this value starts with `service:` prefix.
  @db.StringProperty(required: true)
  String? agent;

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
  String? summary;

  /// A free-form Map of data about the event's details.
  @db.StringProperty(required: true, indexed: false)
  String? dataJson;

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
  List<String>? users;

  /// List of packages involved in this record.
  ///
  /// This is the list of packages who should have this record show up in their
  /// audit-log.
  ///
  /// This property **MUST** only be used for querying. The contents of this property is
  /// **NOT** intended for consumption or presentation by other means. It's only here
  /// to make it easy to find [AuditLogRecord]s relevant for a specific package.
  @db.StringListProperty()
  List<String>? packages;

  /// List of package versions involved in this record.
  ///
  /// This is the list of package version who should have this record show up in
  /// their audit-log.
  ///
  /// The format of the list entries is `<package>/<version>`.
  ///
  /// This property **MUST** only be used for querying. The contents of this property is
  /// **NOT** intended for consumption or presentation by other means. It's only here
  /// to make it easy to find [AuditLogRecord]s relevant for a specific package version.
  @db.StringListProperty()
  List<String>? packageVersions;

  /// List of publishers involved in this record.
  ///
  /// This is the list of publishers who should have this record show up in their
  /// audit-log.
  ///
  /// This property **MUST** only be used for querying. The contents of this property is
  /// **NOT** intended for consumption or presentation by other means. It's only here
  /// to make it easy to find [AuditLogRecord]s relevant for a specific publisher.
  @db.StringListProperty()
  List<String>? publishers;

  AuditLogRecord();

  bool get isExpired => clock.now().isAfter(expires!);
  bool get isNotExpired => !isExpired;

  /// Init log record with default id and timestamps
  AuditLogRecord._init() {
    final now = clock.now().toUtc();
    id = createUuid();
    created = now;
    expires = now.add(_defaultExpires);
  }

  Map<String, dynamic>? get data =>
      dataJson == null ? null : json.decode(dataJson!) as Map<String, dynamic>;
  set data(Map<String, dynamic>? value) {
    dataJson = value == null ? null : json.encode(value);
  }

  factory AuditLogRecord.packageOptionsUpdated({
    required String package,
    required User user,
    required List<String> options,
  }) {
    final optionsStr = options.map((o) => '`$o`').join(', ');
    return AuditLogRecord._init()
      ..kind = AuditLogRecordKind.packageOptionsUpdated
      ..agent = user.userId
      ..summary = '`${user.email}` updated $optionsStr of package `$package`.'
      ..data = {
        'package': package,
        'user': user.email,
        'options': options,
      }
      ..users = [user.userId]
      ..packages = [package]
      ..packageVersions = []
      ..publishers = [];
  }

  factory AuditLogRecord.packagePublicationAutomationUpdated({
    required String package,
    required User user,
  }) {
    return AuditLogRecord._init()
      ..kind = AuditLogRecordKind.packagePublicationAutomationUpdated
      ..agent = user.userId
      ..summary =
          '`${user.email}` updated the publication automation config of package `$package`.'
      ..data = {
        'package': package,
        'user': user.email,
      }
      ..users = [user.userId]
      ..packages = [package]
      ..packageVersions = []
      ..publishers = [];
  }

  factory AuditLogRecord.packageVersionOptionsUpdated({
    required String package,
    required String version,
    required User user,
    required List<String> options,
  }) {
    final optionsStr = options.map((o) => '`$o`').join(', ');
    return AuditLogRecord._init()
      ..kind = AuditLogRecordKind.packageVersionOptionsUpdated
      ..agent = user.userId
      ..summary = '`${user.email}` updated $optionsStr of '
          'package `$package` version `$version`.'
      ..data = {
        'package': package,
        'version': version,
        'user': user.email,
        'options': options,
      }
      ..users = [user.userId]
      ..packages = [package]
      ..packageVersions = ['$package/$version']
      ..publishers = [];
  }

  factory AuditLogRecord.packagePublished({
    required AuthenticatedAgent uploader,
    required String package,
    required String version,
    required DateTime created,
    String? publisherId,
  }) {
    final summary = [
      'Package `$package` version `$version`',
      if (publisherId != null) ' owned by publisher `$publisherId`',
      ' was published by `${uploader.displayId}`.',
    ].join();
    return AuditLogRecord()
      ..id = createUuid()
      ..created = created
      ..expires = _expiresInFarFuture
      ..kind = AuditLogRecordKind.packagePublished
      ..agent = uploader.agentId
      ..summary = summary
      ..data = {
        'package': package,
        'version': version,
        if (uploader is AuthenticatedUser) 'email': uploader.user.email,
        if (publisherId != null) 'publisherId': publisherId,
      }
      ..users = [if (uploader is AuthenticatedUser) uploader.user.userId]
      ..packages = [package]
      ..packageVersions = ['$package/$version']
      ..publishers = [if (publisherId != null) publisherId];
  }

  factory AuditLogRecord.packageTransferred({
    required User user,
    required String package,
    required String? fromPublisherId,
    required String toPublisherId,
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

  factory AuditLogRecord.publisherContactInviteAccepted({
    required User user,
    required String publisherId,
    required String contactEmail,
  }) {
    return AuditLogRecord._init()
      ..kind = AuditLogRecordKind.publisherContactInviteAccepted
      ..agent = user.userId
      ..summary = [
        '`${user.email}` accepted `$contactEmail` ',
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

  factory AuditLogRecord.publisherContactInvited({
    required User user,
    required String publisherId,
    required String contactEmail,
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

  factory AuditLogRecord.publisherContactInviteExpired({
    required String fromUserId,
    required String publisherId,
    required String contactEmail,
  }) {
    return AuditLogRecord._init()
      ..kind = AuditLogRecordKind.publisherContactInviteExpired
      ..agent = fromUserId
      ..summary = 'Contact invite for publisher `$publisherId` expired, '
          '`$contactEmail` did not respond.'
      ..data = {
        'fromUserId': fromUserId,
        'publisherId': publisherId,
        'contactEmail': contactEmail,
      }
      ..users = [fromUserId]
      ..packages = []
      ..packageVersions = []
      ..publishers = [publisherId];
  }

  factory AuditLogRecord.publisherContactInviteRejected({
    required String fromUserId,
    required String publisherId,
    required String contactEmail,

    /// Optional, in the future we may allow invite rejection without sign-in.
    required String? userId,
    required String? userEmail,
  }) {
    final summary = (userEmail == null || userEmail == contactEmail)
        ? '`$contactEmail` rejected contact invite for publisher `$publisherId`.'
        : '`$userEmail` rejected contact invite of `$contactEmail` for publisher `$publisherId`.';
    return AuditLogRecord._init()
      ..kind = AuditLogRecordKind.publisherContactInviteRejected
      ..agent = userId ?? fromUserId
      ..summary = summary
      ..data = {
        'fromUserId': fromUserId,
        'publisherId': publisherId,
        'contactEmail': contactEmail,
        if (userId != null) 'userId': userId,
        if (userEmail != null) 'userEmail': userEmail,
      }
      ..users = [fromUserId, if (userId != null) userId]
      ..packages = []
      ..packageVersions = []
      ..publishers = [publisherId];
  }

  factory AuditLogRecord.publisherCreated({
    required User user,
    required String publisherId,
  }) {
    return AuditLogRecord._init()
      ..kind = AuditLogRecordKind.publisherCreated
      ..agent = user.userId
      ..summary = '`${user.email}` created publisher `$publisherId`.'
      ..data = {
        'publisherId': publisherId,
        'user': user.email,
      }
      ..users = [user.userId]
      ..packages = []
      ..packageVersions = []
      ..publishers = [publisherId];
  }

  factory AuditLogRecord.publisherMemberInvited({
    required User user,
    required String publisherId,
    required String memberEmail,
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

  factory AuditLogRecord.publisherMemberInviteAccepted({
    required User user,
    required String publisherId,
  }) {
    return AuditLogRecord._init()
      ..kind = AuditLogRecordKind.publisherMemberInviteAccepted
      ..agent = user.userId
      ..summary =
          '`${user.email}` accepted member invite for publisher `$publisherId`.'
      ..data = {
        'publisherId': publisherId,
        'user': user.email,
      }
      ..users = [user.userId]
      ..packages = []
      ..packageVersions = []
      ..publishers = [publisherId];
  }

  factory AuditLogRecord.publisherMemberInviteExpired({
    required String fromUserId,
    required String publisherId,
    required String memberEmail,
  }) {
    return AuditLogRecord._init()
      ..kind = AuditLogRecordKind.publisherMemberInviteExpired
      ..agent = fromUserId
      ..summary = 'Member invite for publisher `$publisherId` expired, '
          '`$memberEmail` did not respond.'
      ..data = {
        'fromUserId': fromUserId,
        'publisherId': publisherId,
        'memberEmail': memberEmail,
      }
      ..users = [fromUserId]
      ..packages = []
      ..packageVersions = []
      ..publishers = [publisherId];
  }

  factory AuditLogRecord.publisherMemberInviteRejected({
    required String fromUserId,
    required String publisherId,
    required String memberEmail,

    /// Optional, in the future we may allow invite rejection without sign-in.
    required String? userId,
  }) {
    return AuditLogRecord._init()
      ..kind = AuditLogRecordKind.publisherMemberInviteRejected
      ..agent = userId ?? fromUserId
      ..summary =
          '`$memberEmail` rejected member invite for publisher `$publisherId`.'
      ..data = {
        'fromUserId': fromUserId,
        'publisherId': publisherId,
        'memberEmail': memberEmail,
        if (userId != null) 'userId': userId,
      }
      ..users = [fromUserId, if (userId != null) userId]
      ..packages = []
      ..packageVersions = []
      ..publishers = [publisherId];
  }

  factory AuditLogRecord.publisherMemberRemoved({
    required User activeUser,
    required String publisherId,
    required User memberToRemove,
  }) {
    return AuditLogRecord._init()
      ..kind = AuditLogRecordKind.publisherMemberRemoved
      ..agent = activeUser.userId
      ..summary = [
        '`${activeUser.email}` removed `${memberToRemove.email}` ',
        'from publisher `$publisherId`.',
      ].join()
      ..data = {
        'publisherId': publisherId,
        'memberEmail': memberToRemove.email,
        'user': activeUser.email,
      }
      ..users = [activeUser.userId, memberToRemove.userId]
      ..packages = []
      ..packageVersions = []
      ..publishers = [publisherId];
  }

  factory AuditLogRecord.publisherUpdated({
    required User user,
    required String publisherId,
  }) {
    return AuditLogRecord._init()
      ..kind = AuditLogRecordKind.publisherUpdated
      ..agent = user.userId
      ..summary = '`${user.email}` updated publisher `$publisherId`.'
      ..data = {
        'publisherId': publisherId,
        'user': user.email,
      }
      ..users = [user.userId]
      ..packages = []
      ..packageVersions = []
      ..publishers = [publisherId];
  }

  factory AuditLogRecord.uploaderAdded({
    required User activeUser,
    required String package,
    required User uploaderUser,
  }) {
    return AuditLogRecord._init()
      ..kind = AuditLogRecordKind.uploaderAdded
      ..agent = activeUser.userId
      ..summary = [
        '`${activeUser.email}` added `${uploaderUser.email}` ',
        'to the uploaders of package `$package`.',
      ].join()
      ..data = {
        'package': package,
        'uploaderEmail': uploaderUser.email,
        'user': activeUser.email,
      }
      ..users = [activeUser.userId, uploaderUser.userId]
      ..packages = [package]
      ..packageVersions = []
      ..publishers = [];
  }

  factory AuditLogRecord.uploaderInvited({
    required User user,
    required String package,
    required String uploaderEmail,
  }) {
    return AuditLogRecord._init()
      ..kind = AuditLogRecordKind.uploaderInvited
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

  factory AuditLogRecord.uploaderInviteAccepted({
    required User user,
    required String package,
  }) {
    return AuditLogRecord._init()
      ..kind = AuditLogRecordKind.uploaderInviteAccepted
      ..agent = user.userId
      ..summary = [
        '`${user.email}` accepted uploader invite for package `$package`.',
      ].join()
      ..data = {
        'package': package,
        'user': user.email,
      }
      ..users = [user.userId]
      ..packages = [package]
      ..packageVersions = []
      ..publishers = [];
  }

  factory AuditLogRecord.uploaderInviteExpired({
    required String fromUserId,
    required String package,
    required String uploaderEmail,
  }) {
    return AuditLogRecord._init()
      ..kind = AuditLogRecordKind.uploaderInviteExpired
      ..agent = fromUserId
      ..summary = 'Uploader invite for package `$package` expired, '
          '`$uploaderEmail` did not respond.'
      ..data = {
        'fromUserId': fromUserId,
        'package': package,
        'uploaderEmail': uploaderEmail,
      }
      ..users = [fromUserId]
      ..packages = [package]
      ..packageVersions = []
      ..publishers = [];
  }

  factory AuditLogRecord.uploaderInviteRejected({
    required String fromUserId,
    required String package,
    required String uploaderEmail,

    /// Optional, in the future we may allow invite rejection without sign-in.
    required String? userId,
  }) {
    return AuditLogRecord._init()
      ..kind = AuditLogRecordKind.uploaderInviteRejected
      ..agent = userId ?? fromUserId
      ..summary =
          '`$uploaderEmail` rejected uploader invite for package `$package`.'
      ..data = {
        'fromUserId': fromUserId,
        'package': package,
        'uploaderEmail': uploaderEmail,
        if (userId != null) 'userId': userId,
      }
      ..users = [fromUserId, if (userId != null) userId]
      ..packages = [package]
      ..packageVersions = []
      ..publishers = [];
  }

  factory AuditLogRecord.uploaderRemoved({
    required User activeUser,
    required String package,
    required User uploaderUser,
  }) {
    return AuditLogRecord._init()
      ..kind = AuditLogRecordKind.uploaderRemoved
      ..agent = activeUser.userId
      ..summary = [
        '`${activeUser.email}` removed `${uploaderUser.email}` ',
        'from the uploaders of package `$package`.',
      ].join()
      ..data = {
        'package': package,
        'uploaderEmail': uploaderUser.email,
        'user': activeUser.email,
      }
      ..users = [activeUser.userId, uploaderUser.userId]
      ..packages = [package]
      ..packageVersions = []
      ..publishers = [];
  }
}

abstract class AuditLogRecordKind {
  /// Event that a package was updated with new options
  static const packageOptionsUpdated = 'package-options-updated';

  /// Event that a package was updated with new automated publishing config.
  static const packagePublicationAutomationUpdated =
      'package-publication-automation-updated';

  /// Event that a package version was updated with new options
  static const packageVersionOptionsUpdated = 'package-version-options-updated';

  /// Event that a package was published.
  ///
  /// This can be an entirely new package or just a new version to an existing package.
  static const packagePublished = 'package-published';

  /// Event that a package has transferred to a (new) publisher.
  static const packageTransferred = 'package-transferred';

  /// Event that an e-mail was invited to be a publisher contact.
  static const publisherContactInvited = 'publisher-contact-invited';

  /// Event that an e-mail consent was accepted to become a publisher contact.
  static const publisherContactInviteAccepted =
      'publisher-contact-invite-accepted';

  /// Event that a publisher contact invite expired.
  static const publisherContactInviteExpired =
      'publisher-contact-invite-expired';

  /// Event that a user has rejected the invite to use email as contact of a publisher.
  static const publisherContactInviteRejected =
      'publisher-contact-invite-rejected';

  /// Event that a publisher was created.
  static const publisherCreated = 'publisher-created';

  /// Event that an e-mail was invited to be a publisher member.
  static const publisherMemberInvited = 'publisher-member-invited';

  /// Event that a user has accepted the invite to become member of a publisher.
  static const publisherMemberInviteAccepted =
      'publisher-member-invite-accepted';

  /// Event that a publisher member invite expired.
  static const publisherMemberInviteExpired = 'publisher-member-invite-expired';

  /// Event that a user has rejected the invite to become member of a publisher.
  static const publisherMemberInviteRejected =
      'publisher-member-invite-rejected';

  /// Event that a publisher member was removed.
  static const publisherMemberRemoved = 'publisher-member-removed';

  /// Event that a publisher was updated.
  static const publisherUpdated = 'publisher-updated';

  /// Event that an uploader was added to a package (by an admin).
  static const uploaderAdded = 'uploader-added';

  /// Event that an uploader was invited to a package.
  static const uploaderInvited = 'uploader-invited';

  /// Event that an uploader accepted the invite for a package.
  static const uploaderInviteAccepted = 'uploader-invite-accepted';

  /// Event that an uploader invite expired.
  static const uploaderInviteExpired = 'uploader-invite-expired';

  /// Event that an uploader rejected the invite for a package.
  static const uploaderInviteRejected = 'uploader-invite-rejected';

  /// Event that an uploader was removed from a package.
  static const uploaderRemoved = 'uploader-removed';
}
