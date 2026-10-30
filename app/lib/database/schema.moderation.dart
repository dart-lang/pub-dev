// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'schema.dart';

/// Tracks the status of a moderation or appeal case.
///
/// TODO: rename to `ModerationCase` after the SQL migration.
@PrimaryKey(['caseId'])
abstract final class ModerationCaseRow extends Row {
  /// Matches `ModerationCase.caseId`.
  String get caseId;

  /// The email of the reporter.
  String get reporterEmail;

  /// The case was opened at this time.
  DateTime get openedAt;

  /// The case was resolved at this time (or `null` if it is still open).
  DateTime? get resolvedAt;

  /// One of the `ModerationSource` values.
  String get source;

  /// One of the `ModerationKind` values.
  String get kind;

  /// The fully qualified name of the subject (e.g. `package:<package>`).
  ///
  /// This is not a foreign key: the subject may be a user email, or an entity
  /// that has been deleted.
  @Index.field()
  String get subject;

  /// The URL of the page from where the reporter navigated to the report page.
  String? get url;

  /// The `caseId` of the appealed case (or `null`).
  @Index.field()
  String? get appealedCaseId;

  /// Whether the reporter is a known owner of the [subject].
  bool get isSubjectOwner;

  /// One of the `ModerationStatus` values.
  String get status;

  /// One of the `ModerationGrounds` values (or `null` while pending).
  String? get grounds;

  /// One of the `ModerationViolation` values (or `null` while pending).
  String? get violation;

  /// The text from the statement of reasons sent to the user.
  String? get reason;
}

/// An entry of the action log of a [ModerationCaseRow].
///
/// TODO: rename to `ModerationActionLogEntry` after the SQL migration.
@PrimaryKey(['caseId', 'logId'])
@ForeignKey(
  ['caseId'],
  table: 'moderationCases',
  fields: ['caseId'],
  name: 'parent',
  as: 'actionLogs',
  onDelete: .cascade,
  onUpdate: .cascade,
)
abstract final class ModerationActionLog extends Row {
  String get caseId;

  /// A ULID (in UUID format) generated from [createdAt], so ordering by it
  /// matches the order of the entries.
  String get logId;

  /// The timestamp of the action.
  DateTime get createdAt;

  /// The fully qualified name of the subject the action was applied to.
  String get subject;

  /// One of the `ModerationAction` enum names (`apply` or `revert`).
  String get action;

  String? get note;
}

extension ModerationCaseRowExt on ModerationCaseRow {
  Map<String, dynamic> toCompactInfo() {
    return {
      'caseId': caseId,
      'reporterEmail': reporterEmail,
      'kind': kind,
      'opened': openedAt.toIso8601String(),
      'resolved': resolvedAt?.toIso8601String(),
      'subject': subject,
      if (appealedCaseId != null) 'appealedCaseId': appealedCaseId,
    };
  }

  /// The debug information of the case, with the [actionLogs] sorted by
  /// `logId`.
  Map<String, dynamic> toDebugInfo(List<ModerationActionLog> actionLogs) {
    return {
      'caseId': caseId,
      'reporterEmail': reporterEmail,
      'kind': kind,
      'opened': openedAt.toIso8601String(),
      'resolved': resolvedAt?.toIso8601String(),
      'source': source,
      'subject': subject,
      'isSubjectOwner': isSubjectOwner,
      'url': url,
      'status': status,
      'grounds': grounds,
      'violation': violation,
      'reason': reason,
      'appealedCaseId': appealedCaseId,
      'actionLog': {
        'entries': [
          for (final l in actionLogs)
            {
              'timestamp': l.createdAt.toIso8601String(),
              'subject': l.subject,
              'moderationAction': l.action,
              if (l.note != null) 'note': l.note,
            },
        ],
      },
    };
  }
}
