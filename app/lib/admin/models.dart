// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pub_dev/shared/utils.dart';

import '../shared/datastore.dart' as db;
import '../shared/urls.dart' as urls;

part 'models.g.dart';

/// Tracks the status of the moderation or appeal case.
@db.Kind(name: 'ModerationCase', idType: db.IdType.String)
class ModerationCase extends db.ExpandoModel<String> {
  /// Same as [id].
  /// A random UUID id.
  String get caseId => id!;

  /// The email of the reporter.
  @db.StringProperty(required: true)
  late String reporterEmail;

  /// The case was opened at this time.
  @db.DateTimeProperty(required: true)
  late DateTime opened;

  /// The case was resolved at this time (or null if it has not been resolved yet).
  @db.DateTimeProperty()
  DateTime? resolved;

  /// The source of the case, one of:
  /// - `external-notification`,
  /// - `internal-notification` (only used for reports from @google.com accounts), or,
  /// - `automated-detection`. (will not be used)
  @db.StringProperty(required: true)
  late String source;

  /// The kind of the case, one of:
  /// - `notification`, or,
  /// - `appeal`
  @db.StringProperty(required: true)
  late String kind;

  /// The fully qualified name of the entity this notification or appeal concerns.
  /// - `package:<package>`
  /// - `package-version:<package>/<version>`
  /// - `publisher:<publisherId>`
  @db.StringProperty(required: true)
  late String subject;

  /// The URL of the page from where the reporter navigated to the report page.
  @db.StringProperty()
  late String? url;

  /// The `caseId` of the appeal (or null).
  @db.StringProperty()
  String? appealedCaseId;

  /// Whether the reporter of the case is known owner of the [subject].
  @db.BoolProperty()
  bool isSubjectOwner = false;

  /// One of:
  /// - `pending`, if this is an appeal and we haven't decided anything yet.
  /// - `no-action`, if this is a notification (kind = notification) and
  ///   we decided to take no action.
  /// - `moderation-applied`, if this is a notification (kind = notification) and
  ///   we decided to apply content moderation.
  /// - `no-action-upheld`, if this is an appeal (kind = appeal) of a notification
  ///   where we took no-action, and we decided to uphold that decision.
  /// - `no-action-reverted`, if this is an appeal (kind = appeal) of a notification
  ///   where we took no-action, and we decided to revert that decision.
  /// - `moderation-upheld`, if this is an appeal (kind = appeal) of a notification
  ///   where we applied content moderation, and we decided to uphold that decision.
  /// - `moderation-reverted`, if this is an appeal (kind = appeal) of a notification
  ///   where we applied content moderation, and we decided to revert that decision.
  @db.StringProperty(required: true)
  String? status;

  /// The basic justification of the moderation actions, one of:
  /// - `null` if [status] is still `pending`.
  /// - `none`, if there was no moderation action taken.
  /// - `illegal`, if triggered by LCPS.
  /// - `policy`, if moderated on the basis of policy violation.
  @db.StringProperty()
  String? grounds;

  /// The high-level category of the violation reason:
  /// `null` if [status] is still `pending`.
  /// - `none`, if there was no violation and no moderation action has been taken.
  /// - Ìf moderation action was taken, must be one of
  ///   [ModerationViolation.violationValues].
  @db.StringProperty()
  String? violation;

  /// `null`, if no moderation action was taken or [status] is still `pending`.
  ///
  /// The text from SOR statement sent to the user, specifically:
  /// - What law was violated (if illegal content).
  /// - What policy section was violated (if policy violation).
  @db.StringProperty()
  String? reason;

  /// The JSON-encoded array of [ModerationActionLog] entries.
  @db.StringProperty(propertyName: 'actionLog', indexed: false)
  String? actionLogField;

  ModerationCase();

  ModerationCase.init({
    required String caseId,
    required this.reporterEmail,
    required this.source,
    required this.kind,
    required this.status,
    required this.subject,
    required this.isSubjectOwner,
    required this.url,
    required this.appealedCaseId,
  }) {
    id = caseId;
    opened = clock.now().toUtc();
  }

  /// Generates a short case id like `<yyyy><mm><dd>I0123456789`.
  static String generateCaseId({
    DateTime? now,
  }) {
    now ??= clock.now();
    return '${now.toIso8601String().split('T').first.replaceAll('-', '')}'
        'I'
        '${createUuid().split('-').join('').substring(0, 10)}';
  }

  ModerationActionLog getActionLog() {
    if (actionLogField == null) {
      return ModerationActionLog(entries: []);
    }
    return ModerationActionLog.fromJson(
        json.decode(actionLogField!) as Map<String, Object?>);
  }

  void setActionLog(ModerationActionLog value) {
    actionLogField = json.encode(value.toJson());
  }

  /// Adds a new entry to the log with the current timestamp.
  void addActionLogEntry(
    String subject,
    ModerationAction moderationAction,
    String? note,
  ) {
    final log = getActionLog();
    log.entries.add(ModerationActionLogEntry(
      timestamp: clock.now().toUtc(),
      subject: subject,
      moderationAction: moderationAction,
      note: note,
    ));
    setActionLog(log);
  }

  Map<String, dynamic> toCompactInfo() {
    return {
      'caseId': caseId,
      'reporterEmail': reporterEmail,
      'kind': kind,
      'opened': opened.toIso8601String(),
      'resolved': resolved?.toIso8601String(),
      'subject': subject,
      if (appealedCaseId != null) 'appealedCaseId': appealedCaseId,
    };
  }

  Map<String, dynamic> toDebugInfo() {
    return {
      'caseId': caseId,
      'reporterEmail': reporterEmail,
      'kind': kind,
      'opened': opened.toIso8601String(),
      'resolved': resolved?.toIso8601String(),
      'source': source,
      'subject': subject,
      'isSubjectOwner': isSubjectOwner,
      'url': url,
      'status': status,
      'grounds': grounds,
      'violation': violation,
      'reason': reason,
      'appealedCaseId': appealedCaseId,
      'actionLog': getActionLog().toJson(),
    };
  }
}

abstract class ModerationSource {
  static const externalNotification = 'external-notification';
  static const internalNotification = 'internal-notification';
  static const trustedFlagger = 'trusted-flagger';
  static const authorities = 'authorities';
  static const legalReferral = 'legal-referral';

  static const _values = [
    externalNotification,
    internalNotification,
    trustedFlagger,
    authorities,
    legalReferral,
  ];
  static bool isValidSource(String value) => _values.contains(value);
}

abstract class ModerationKind {
  static const notification = 'notification';
  static const appeal = 'appeal';

  static const _values = [
    notification,
    appeal,
  ];
  static bool isValidKind(String value) => _values.contains(value);
}

abstract class ModerationStatus {
  static const pending = 'pending';
  static const noAction = 'no-action';
  static const moderationApplied = 'moderation-applied';
  static const noActionUpheld = 'no-action-upheld';
  static const noActionReverted = 'no-action-reverted';
  static const moderationUpheld = 'moderation-upheld';
  static const moderationReverted = 'moderation-reverted';

  static const resolveValues = [
    noAction,
    moderationApplied,
    noActionUpheld,
    noActionReverted,
    moderationUpheld,
    moderationReverted,
  ];
  static const _values = [
    pending,
    ...resolveValues,
  ];

  static bool isValidStatus(String value) => _values.contains(value);
  static bool wasModerationApplied(String value) =>
      value == ModerationStatus.moderationApplied ||
      value == ModerationStatus.noActionReverted;
}

abstract class ModerationGrounds {
  static const none = 'none';
  static const illegal = 'illegal';
  static const policy = 'policy';

  static final resolveValues = [
    illegal,
    policy,
  ];
}

abstract class ModerationViolation {
  static const none = 'none';

  static const violationValues = [
    'animal_welfare',
    'data_protection_and_privacy_violations',
    'illegal_or_harmful_speech',
    'intellectual_property_infringements',
    'negative_effects_on_civic_discourse_or_elections',
    'non_consensual_behaviour',
    'pornography_or_sexualized_content',
    'protection_of_minors',
    'risk_for_public_security',
    'scams_and_fraud',
    'self_harm',
    'scope_of_platform_service',
    'unsafe_and_illegal_products',
    'violence',
  ];
}

/// Describes the parsed structure of a [ModerationCase.subject] (or the same as URL parameter).
class ModerationSubject {
  /// The kind of moderation as described by [ModerationSubjectKind], one of:
  /// - package,
  /// - package-version,
  /// - publisher,
  /// - user.
  final String kind;

  /// The local name part of the subject, may be a composite, one of:
  /// - <package>,
  /// - <package>/<version>,
  /// - <publisherId>,
  /// - <email>.
  final String localName;

  /// The package name of the subject (if not a publisher, or user).
  final String? package;

  /// The package version of the subject (if the version was specified).
  final String? version;

  /// The publisher id (if not a package or package/version, or user).
  final String? publisherId;

  /// The email address of the user (if not a package or publisher).
  final String? email;

  ModerationSubject._({
    required this.kind,
    required this.localName,
    this.package,
    this.version,
    this.publisherId,
    this.email,
  });

  factory ModerationSubject.package(String package, [String? version]) {
    return ModerationSubject._(
      kind: version == null
          ? ModerationSubjectKind.package
          : ModerationSubjectKind.packageVersion,
      localName: [package, if (version != null) version].join('/'),
      package: package,
      version: version,
    );
  }

  factory ModerationSubject.publisher(String publisherId) {
    return ModerationSubject._(
      kind: ModerationSubjectKind.publisher,
      localName: publisherId,
      publisherId: publisherId,
    );
  }

  factory ModerationSubject.user(String email) {
    return ModerationSubject._(
      kind: ModerationSubjectKind.user,
      localName: email,
      email: email,
    );
  }

  /// Tries to parse subject [value] and returns a [ModerationSubject]
  /// if it is recognized, or `null` if the format is not recognizable.
  static ModerationSubject? tryParse(String value) {
    final parts = value.split(':');
    if (parts.length != 2) {
      return null;
    }
    if (parts.any((p) => p.isEmpty || p.trim() != p)) {
      return null;
    }
    final kind = parts.first;
    switch (kind) {
      case ModerationSubjectKind.package:
        final package = parts[1];
        return ModerationSubject._(
          kind: kind,
          localName: package,
          package: package,
        );
      case ModerationSubjectKind.packageVersion:
        final localName = parts[1];
        final pvParts = localName.split('/');
        if (pvParts.length != 2) {
          return null;
        }
        final package = pvParts.first;
        final version = pvParts[1];
        return ModerationSubject._(
          kind: kind,
          localName: localName,
          package: package,
          version: version,
        );
      case ModerationSubjectKind.publisher:
        final publisherId = parts[1];
        return ModerationSubject._(
          kind: kind,
          localName: publisherId,
          publisherId: publisherId,
        );
      case ModerationSubjectKind.user:
        final email = parts[1];
        return ModerationSubject._(
          kind: kind,
          localName: email,
          email: email,
        );
      default:
        return null;
    }
  }

  late final fqn = '$kind:$localName';
  bool get isPackage => package != null;
  bool get isPublisher => publisherId != null;
  bool get isUser => email != null;

  late final canonicalUrl = () {
    if (isPackage) {
      return urls.pkgPageUrl(package!, version: version, includeHost: true);
    }
    if (isPublisher) {
      return urls.publisherUrl(publisherId!, includeHost: true);
    }
    if (isUser) {
      return email!;
    }
    throw UnimplementedError('Unknown subject kind: "$fqn"');
  }();
}

class ModerationSubjectKind {
  static const package = 'package';
  static const packageVersion = 'package-version';
  static const publisher = 'publisher';
  static const user = 'user';
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class ModerationActionLog {
  final List<ModerationActionLogEntry> entries;

  ModerationActionLog({
    required this.entries,
  });

  factory ModerationActionLog.fromJson(Map<String, Object?> json) =>
      _$ModerationActionLogFromJson(json);

  Map<String, Object?> toJson() => _$ModerationActionLogToJson(this);

  /// Returns true if the final state of the actions has at least one moderation.
  bool hasModeratedAction() {
    final subjects = <String>{};
    for (final entry in entries) {
      switch (entry.moderationAction) {
        case ModerationAction.apply:
          subjects.add(entry.subject);
          break;
        case ModerationAction.revert:
          subjects.remove(entry.subject);
          break;
      }
    }
    return subjects.isNotEmpty;
  }
}

enum ModerationAction {
  apply,
  revert,
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class ModerationActionLogEntry {
  final DateTime timestamp;
  final String subject;
  final ModerationAction moderationAction;
  final String? note;

  ModerationActionLogEntry({
    required this.timestamp,
    required this.subject,
    required this.moderationAction,
    required this.note,
  });

  factory ModerationActionLogEntry.fromJson(Map<String, Object?> json) =>
      _$ModerationActionLogEntryFromJson(json);

  Map<String, Object?> toJson() => _$ModerationActionLogEntryToJson(this);
}
