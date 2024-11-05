// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:meta/meta.dart';
import 'package:pub_dev/account/agent.dart';
import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/service/rate_limit/rate_limit.dart';

import '../account/models.dart';
import '../shared/datastore.dart' as db;
import '../shared/utils.dart' show createUuid;

@visibleForTesting
final auditLogRecordExpiresInFarFuture = DateTime.utc(9999, 12, 31, 23, 59, 59);
final _shortTermExpireThreshold =
    auditLogRecordExpiresInFarFuture.subtract(Duration(days: 1));
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
  /// Set this to the far future ([auditLogRecordExpiresInFarFuture]) for records that
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
  bool get isKeptShortTerm => expires!.isBefore(_shortTermExpireThreshold);

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

  /// Returns [AuditLogRecord] for the package options updated operation.
  ///
  /// Throws [RateLimitException] when the configured rate limit is reached.
  static Future<AuditLogRecord> packageOptionsUpdated({
    required AuthenticatedAgent agent,
    required String package,
    required String? publisherId,
    required List<String> options,
  }) {
    final optionsStr = options.map((o) => '`$o`').join(', ');
    return _checkRateLimit(AuditLogRecord._init()
      ..kind = AuditLogRecordKind.packageOptionsUpdated
      ..agent = agent.agentId
      ..summary =
          '`${agent.displayId}` updated $optionsStr of package `$package`.'
      ..data = {
        'package': package,
        if (agent.email != null) 'email': agent.email,
        if (publisherId != null) 'publisherId': publisherId,
        'options': options,
      }
      ..users = [
        if (agent is AuthenticatedUser) agent.userId,
      ]
      ..packages = [package]
      ..packageVersions = []
      ..publishers = [if (publisherId != null) publisherId]);
  }

  /// Returns [AuditLogRecord] for the package automatic publishing settings updated operation.
  ///
  /// Throws [RateLimitException] when the configured rate limit is reached.
  static Future<AuditLogRecord> packagePublicationAutomationUpdated({
    required String package,
    required String? publisherId,
    required User user,
  }) {
    return _checkRateLimit(AuditLogRecord._init()
      ..kind = AuditLogRecordKind.packagePublicationAutomationUpdated
      ..agent = user.userId
      ..summary =
          '`${user.email}` updated the publication automation config of package `$package`.'
      ..data = {
        'package': package,
        'user': user.email,
        if (publisherId != null) 'publisherId': publisherId,
      }
      ..users = [user.userId]
      ..packages = [package]
      ..packageVersions = []
      ..publishers = [if (publisherId != null) publisherId]);
  }

  /// Returns [AuditLogRecord] for the package version options updated operation.
  ///
  /// Throws [RateLimitException] when the configured rate limit is reached.
  static Future<AuditLogRecord> packageVersionOptionsUpdated({
    required AuthenticatedAgent agent,
    required String package,
    required String version,
    required String? publisherId,
    required List<String> options,
  }) {
    final optionsStr = options.map((o) => '`$o`').join(', ');
    return _checkRateLimit(AuditLogRecord._init()
      ..kind = AuditLogRecordKind.packageVersionOptionsUpdated
      ..agent = agent.agentId
      ..summary = '`${agent.displayId}` updated $optionsStr of '
          'package `$package` version `$version`.'
      ..data = {
        'package': package,
        'version': version,
        if (agent.email != null) 'email': agent.email,
        if (publisherId != null) 'publisherId': publisherId,
        'options': options,
      }
      ..users = [
        if (agent is AuthenticatedUser) agent.userId,
      ]
      ..packages = [package]
      ..packageVersions = ['$package/$version']
      ..publishers = [if (publisherId != null) publisherId]);
  }

  static Map<String, dynamic> _dataForPublishing({
    required AuthenticatedAgent uploader,
  }) {
    if (uploader is AuthenticatedGitHubAction) {
      final runId = uploader.payload.runId;
      final sha = uploader.payload.sha;
      return <String, dynamic>{
        'repository': uploader.payload.repository,
        if (runId != null) 'run_id': runId,
        if (sha != null) 'sha': sha,
      };
    } else {
      return const {};
    }
  }

  static String _summaryForPublishing({
    required AuthenticatedAgent uploader,
    required String package,
    String? version,
    String? publisherId,
  }) {
    final prefix = <String>[
      'Package `$package`',
      if (version != null) ' version `$version`',
      if (publisherId != null) ' owned by publisher `$publisherId`',
    ];
    if (uploader is AuthenticatedGitHubAction) {
      final repository = uploader.payload.repository;
      final runId = uploader.payload.runId;
      final sha = uploader.payload.sha;
      return [
        ...prefix,
        ' was published from GitHub Actions',
        if (runId != null)
          ' (`run_id`: [`$runId`](https://github.com/$repository/actions/runs/$runId))',
        ' triggered by pushing',
        if (sha != null) ' revision `$sha`',
        ' to the `$repository` repository.',
      ].join();
    } else if (uploader is AuthenticatedGcpServiceAccount) {
      return [
        ...prefix,
        ' was published by Google Cloud service account: `${uploader.payload.email}`.'
      ].join();
    } else {
      return [
        ...prefix,
        ' was published by `${uploader.displayId}`.',
      ].join();
    }
  }

  /// Returns [AuditLogRecord] for the package created operation.
  ///
  /// NOTE: rate limit check must happen outside of the transaction.
  factory AuditLogRecord.packageCreated({
    required AuthenticatedAgent uploader,
    required String package,
    required DateTime created,
    String? publisherId,
  }) {
    return AuditLogRecord._init()
      ..created = created
      ..kind = AuditLogRecordKind.packageCreated
      ..agent = uploader.agentId
      ..summary = _summaryForPublishing(
        uploader: uploader,
        package: package,
        publisherId: publisherId,
      )
      ..data = {
        'package': package,
        if (uploader.email != null) 'email': uploader.email,
        if (publisherId != null) 'publisherId': publisherId,
        ..._dataForPublishing(uploader: uploader),
      }
      ..users = [if (uploader is AuthenticatedUser) uploader.user.userId]
      ..packages = [package]
      ..packageVersions = []
      ..publishers = [if (publisherId != null) publisherId];
  }

  /// Returns [AuditLogRecord] for the package published operation.
  ///
  /// NOTE: rate limit check must happen outside of the transaction.
  factory AuditLogRecord.packagePublished({
    required AuthenticatedAgent uploader,
    required String package,
    required String version,
    required DateTime created,
    String? publisherId,
  }) {
    return AuditLogRecord()
      ..id = createUuid()
      ..created = created
      ..expires = auditLogRecordExpiresInFarFuture
      ..kind = AuditLogRecordKind.packagePublished
      ..agent = uploader.agentId
      ..summary = _summaryForPublishing(
        uploader: uploader,
        package: package,
        version: version,
        publisherId: publisherId,
      )
      ..data = {
        'package': package,
        'version': version,
        if (uploader.email != null) 'email': uploader.email,
        if (publisherId != null) 'publisherId': publisherId,
        ..._dataForPublishing(uploader: uploader),
      }
      ..users = [if (uploader is AuthenticatedUser) uploader.user.userId]
      ..packages = [package]
      ..packageVersions = ['$package/$version']
      ..publishers = [if (publisherId != null) publisherId];
  }

  /// Returns [AuditLogRecord] for the package option updated operation.
  ///
  /// Throws [RateLimitException] when the configured rate limit is reached.
  static Future<AuditLogRecord> packageTransferred({
    required User user,
    required String package,
    required String? fromPublisherId,
    required String toPublisherId,
  }) {
    return _checkRateLimit(AuditLogRecord._init()
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
      ]);
  }

  /// Returns [AuditLogRecord] for the package removed from publisher operation.
  ///
  /// Throws [RateLimitException] when the configured rate limit is reached.
  static Future<AuditLogRecord> packageRemovedFromPublisher({
    required String package,
    required String fromPublisherId,
  }) {
    // For now this is always done as an administrative action, so we hardcode
    // the email.
    return _checkRateLimit(AuditLogRecord._init()
      ..kind = AuditLogRecordKind.packageRemovedFromPublisher
      ..agent = KnownAgents.pubSupport
      ..summary = [
        'Package `$package` ',
        'was removed from `$fromPublisherId` ',
        'by `${KnownAgents.pubSupport}`.',
      ].join()
      ..data = {
        'package': package,
        'fromPublisherId': fromPublisherId,
        'user': KnownAgents.pubSupport,
      }
      ..users = []
      ..packages = [package]
      ..packageVersions = []
      ..publishers = [fromPublisherId]);
  }

  /// Returns [AuditLogRecord] for the publisher contact invite accepted operation.
  ///
  /// Throws [RateLimitException] when the configured rate limit is reached.
  static Future<AuditLogRecord> publisherContactInviteAccepted({
    required User user,
    required String publisherId,
    required String contactEmail,
  }) {
    return _checkRateLimit(AuditLogRecord._init()
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
      ..publishers = [publisherId]);
  }

  /// Returns [AuditLogRecord] for the publisher contact invited operation.
  ///
  /// Throws [RateLimitException] when the configured rate limit is reached.
  static Future<AuditLogRecord> publisherContactInvited({
    required User user,
    required String publisherId,
    required String contactEmail,
  }) {
    return _checkRateLimit(AuditLogRecord._init()
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
      ..publishers = [publisherId]);
  }

  /// Returns [AuditLogRecord] for the publisher contact invite expired operation.
  ///
  /// Throws [RateLimitException] when the configured rate limit is reached.
  static Future<AuditLogRecord> publisherContactInviteExpired({
    required String? fromAgent,
    required String publisherId,
    required String contactEmail,
  }) {
    final fromUserId =
        fromAgent != null && looksLikeUserId(fromAgent) ? fromAgent : null;
    return _checkRateLimit(AuditLogRecord._init()
      ..kind = AuditLogRecordKind.publisherContactInviteExpired
      ..agent = KnownAgents.pubSupport
      ..summary = 'Contact invite for publisher `$publisherId` expired, '
          '`$contactEmail` did not respond.'
      ..data = {
        if (fromUserId != null) 'fromUserId': fromUserId,
        'publisherId': publisherId,
        'contactEmail': contactEmail,
      }
      ..users = [if (fromUserId != null) fromUserId]
      ..packages = []
      ..packageVersions = []
      ..publishers = [publisherId]);
  }

  /// Returns [AuditLogRecord] for the publisher contact invite rejected operation.
  ///
  /// Throws [RateLimitException] when the configured rate limit is reached.
  static Future<AuditLogRecord> publisherContactInviteRejected({
    required String? fromAgent,
    required String publisherId,
    required String contactEmail,

    /// Optional, in the future we may allow invite rejection without sign-in.
    required String? userId,
    required String? userEmail,
  }) {
    final fromUserId =
        fromAgent != null && looksLikeUserId(fromAgent) ? fromAgent : null;
    final summary = (userEmail == null || userEmail == contactEmail)
        ? '`$contactEmail` rejected contact invite for publisher `$publisherId`.'
        : '`$userEmail` rejected contact invite of `$contactEmail` for publisher `$publisherId`.';
    return _checkRateLimit(AuditLogRecord._init()
      ..kind = AuditLogRecordKind.publisherContactInviteRejected
      ..agent = userId ?? KnownAgents.pubSupport
      ..summary = summary
      ..data = {
        if (fromUserId != null) 'fromUserId': fromUserId,
        'publisherId': publisherId,
        'contactEmail': contactEmail,
        if (userId != null) 'userId': userId,
        if (userEmail != null) 'userEmail': userEmail,
      }
      ..users = [
        if (fromUserId != null) fromUserId,
        if (userId != null) userId,
      ]
      ..packages = []
      ..packageVersions = []
      ..publishers = [publisherId]);
  }

  /// Returns [AuditLogRecord] for the publisher created operation.
  ///
  /// Throws [RateLimitException] when the configured rate limit is reached.
  static Future<AuditLogRecord> publisherCreated({
    required User user,
    required String publisherId,
  }) {
    return _checkRateLimit(AuditLogRecord._init()
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
      ..publishers = [publisherId]);
  }

  /// Returns [AuditLogRecord] for the publisher member invited operation.
  ///
  /// Throws [RateLimitException] when the configured rate limit is reached.
  static Future<AuditLogRecord> publisherMemberInvited({
    required AuthenticatedAgent agent,
    required String publisherId,
    required String memberEmail,
  }) {
    return _checkRateLimit(AuditLogRecord._init()
      ..kind = AuditLogRecordKind.publisherMemberInvited
      ..agent = agent.agentId
      ..summary = [
        '`${agent.displayId}` invited `$memberEmail` ',
        'to be a member for publisher `$publisherId`.',
      ].join()
      ..data = {
        'publisherId': publisherId,
        'memberEmail': memberEmail,
        if (agent.email != null) 'email': agent.email,
      }
      ..users = [if (agent is AuthenticatedUser) agent.userId]
      ..packages = []
      ..packageVersions = []
      ..publishers = [publisherId]);
  }

  /// Returns [AuditLogRecord] for the publisher member invite accepted operation.
  ///
  /// Throws [RateLimitException] when the configured rate limit is reached.
  static Future<AuditLogRecord> publisherMemberInviteAccepted({
    required User user,
    required String publisherId,
  }) {
    return _checkRateLimit(AuditLogRecord._init()
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
      ..publishers = [publisherId]);
  }

  /// Returns [AuditLogRecord] for the publisher member invite expired operation.
  ///
  /// Throws [RateLimitException] when the configured rate limit is reached.
  static Future<AuditLogRecord> publisherMemberInviteExpired({
    required String? fromAgent,
    required String publisherId,
    required String memberEmail,
  }) {
    final fromUserId =
        fromAgent != null && looksLikeUserId(fromAgent) ? fromAgent : null;
    return _checkRateLimit(AuditLogRecord._init()
      ..kind = AuditLogRecordKind.publisherMemberInviteExpired
      ..agent = KnownAgents.pubSupport
      ..summary = 'Member invite for publisher `$publisherId` expired, '
          '`$memberEmail` did not respond.'
      ..data = {
        if (fromUserId != null) 'fromUserId': fromUserId,
        'publisherId': publisherId,
        'memberEmail': memberEmail,
      }
      ..users = [if (fromUserId != null) fromUserId]
      ..packages = []
      ..packageVersions = []
      ..publishers = [publisherId]);
  }

  /// Returns [AuditLogRecord] for the publisher member invite rejected operation.
  ///
  /// Throws [RateLimitException] when the configured rate limit is reached.
  static Future<AuditLogRecord> publisherMemberInviteRejected({
    required String? fromAgent,
    required String publisherId,
    required String memberEmail,

    /// Optional, in the future we may allow invite rejection without sign-in.
    required String? userId,
  }) {
    final fromUserId =
        fromAgent != null && looksLikeUserId(fromAgent) ? fromAgent : null;
    return _checkRateLimit(AuditLogRecord._init()
      ..kind = AuditLogRecordKind.publisherMemberInviteRejected
      ..agent = userId ?? KnownAgents.pubSupport
      ..summary =
          '`$memberEmail` rejected member invite for publisher `$publisherId`.'
      ..data = {
        if (fromUserId != null) 'fromUserId': fromUserId,
        'publisherId': publisherId,
        'memberEmail': memberEmail,
        if (userId != null) 'userId': userId,
      }
      ..users = [
        if (fromUserId != null) fromUserId,
        if (userId != null) userId,
      ]
      ..packages = []
      ..packageVersions = []
      ..publishers = [publisherId]);
  }

  /// Returns [AuditLogRecord] for the publisher member removed operation.
  ///
  /// Throws [RateLimitException] when the configured rate limit is reached.
  static Future<AuditLogRecord> publisherMemberRemoved({
    required User activeUser,
    required String publisherId,
    required User memberToRemove,
  }) {
    return _checkRateLimit(AuditLogRecord._init()
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
      ..publishers = [publisherId]);
  }

  /// Returns [AuditLogRecord] for the publisher updated operation.
  ///
  /// Throws [RateLimitException] when the configured rate limit is reached.
  static Future<AuditLogRecord> publisherUpdated({
    required User user,
    required String publisherId,
  }) {
    return _checkRateLimit(AuditLogRecord._init()
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
      ..publishers = [publisherId]);
  }

  /// Returns [AuditLogRecord] for the package uploader added operation.
  ///
  /// Throws [RateLimitException] when the configured rate limit is reached.
  static Future<AuditLogRecord> uploaderAdded({
    required User activeUser,
    required String package,
    required User uploaderUser,
  }) {
    return _checkRateLimit(AuditLogRecord._init()
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
      ..publishers = []);
  }

  /// Returns [AuditLogRecord] for the package uploader invited operation.
  ///
  /// Throws [RateLimitException] when the configured rate limit is reached.
  static Future<AuditLogRecord> uploaderInvited({
    required AuthenticatedAgent agent,
    required String package,
    required String uploaderEmail,
  }) {
    return _checkRateLimit(AuditLogRecord._init()
      ..kind = AuditLogRecordKind.uploaderInvited
      ..agent = agent.agentId
      ..summary = [
        '`${agent.displayId}` invited `$uploaderEmail` ',
        'to be an uploader for package `$package`.',
      ].join()
      ..data = {
        'package': package,
        'uploaderEmail': uploaderEmail,
        if (agent.email != null) 'email': agent.email,
      }
      ..users = [
        if (agent is AuthenticatedUser) agent.userId,
      ]
      ..packages = [package]
      ..packageVersions = []
      ..publishers = []);
  }

  /// Returns [AuditLogRecord] for the package uploader invite accepted operation.
  ///
  /// Throws [RateLimitException] when the configured rate limit is reached.
  static Future<AuditLogRecord> uploaderInviteAccepted({
    required User user,
    required String package,
  }) {
    return _checkRateLimit(AuditLogRecord._init()
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
      ..publishers = []);
  }

  /// Returns [AuditLogRecord] for the package uploader invite expired operation.
  ///
  /// Throws [RateLimitException] when the configured rate limit is reached.
  static Future<AuditLogRecord> uploaderInviteExpired({
    required String? fromAgent,
    required String package,
    required String uploaderEmail,
  }) {
    final fromUserId =
        fromAgent != null && looksLikeUserId(fromAgent) ? fromAgent : null;
    return _checkRateLimit(AuditLogRecord._init()
      ..kind = AuditLogRecordKind.uploaderInviteExpired
      ..agent = KnownAgents.pubSupport
      ..summary = 'Uploader invite for package `$package` expired, '
          '`$uploaderEmail` did not respond.'
      ..data = {
        if (fromUserId != null) 'fromUserId': fromUserId,
        'package': package,
        'uploaderEmail': uploaderEmail,
      }
      ..users = [if (fromUserId != null) fromUserId]
      ..packages = [package]
      ..packageVersions = []
      ..publishers = []);
  }

  /// Returns [AuditLogRecord] for the package uploader invite rejected operation.
  ///
  /// Throws [RateLimitException] when the configured rate limit is reached.
  static Future<AuditLogRecord> uploaderInviteRejected({
    required String? fromAgent,
    required String package,
    required String uploaderEmail,

    /// Optional, in the future we may allow invite rejection without sign-in.
    required String? userId,
  }) {
    final fromUserId =
        fromAgent != null && looksLikeUserId(fromAgent) ? fromAgent : null;
    return _checkRateLimit(AuditLogRecord._init()
      ..kind = AuditLogRecordKind.uploaderInviteRejected
      ..agent = userId ?? KnownAgents.pubSupport
      ..summary =
          '`$uploaderEmail` rejected uploader invite for package `$package`.'
      ..data = {
        if (fromUserId != null) 'fromUserId': fromUserId,
        'package': package,
        'uploaderEmail': uploaderEmail,
        if (userId != null) 'userId': userId,
      }
      ..users = [
        if (fromUserId != null) fromUserId,
        if (userId != null) userId,
      ]
      ..packages = [package]
      ..packageVersions = []
      ..publishers = []);
  }

  /// Returns [AuditLogRecord] for the package uploader removed operation.
  ///
  /// Throws [RateLimitException] when the configured rate limit is reached.
  static Future<AuditLogRecord> uploaderRemoved({
    required AuthenticatedAgent agent,
    required String package,
    required User uploaderUser,
  }) {
    return _checkRateLimit(AuditLogRecord._init()
      ..kind = AuditLogRecordKind.uploaderRemoved
      ..agent = agent.agentId
      ..summary = [
        '`${agent.displayId}` removed `${uploaderUser.email}` ',
        'from the uploaders of package `$package`.',
      ].join()
      ..data = {
        'package': package,
        'uploaderEmail': uploaderUser.email,
        if (agent.email != null) 'email': agent.email,
      }
      ..users = [
        if (agent is AuthenticatedUser) agent.userId,
        uploaderUser.userId,
      ]
      ..packages = [package]
      ..packageVersions = []
      ..publishers = []);
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

  /// Event that a new package was created. This event is created alongside the
  /// [packagePublished] event, but is only kept until the default expiry period
  /// (to enforce rate limits).
  static const packageCreated = 'package-created';

  /// Event that a package was published.
  ///
  /// This can be an entirely new package or just a new version to an existing package.
  static const packagePublished = 'package-published';

  /// Event that a package has transferred to a (new) publisher.
  static const packageTransferred = 'package-transferred';

  /// Event that a package has been removed from a publisher.
  static const packageRemovedFromPublisher = 'package-removed-from-publisher';

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

Future<AuditLogRecord> _checkRateLimit(AuditLogRecord record) async {
  await verifyAuditLogRecordRateLimits(record);
  return record;
}
