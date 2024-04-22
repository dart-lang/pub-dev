// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';

import '../shared/datastore.dart' as db;

/// Tracks the status of the moderation or appeal case.
@db.Kind(name: 'ModerationCase', idType: db.IdType.String)
class ModerationCase extends db.ExpandoModel<String> {
  /// Same as [id].
  /// A random UUID id.
  String get caseId => id!;

  /// The `userId` of the reporter (may be null for non-authenticated reporter).
  @db.StringProperty()
  String? reporterUserId;

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
  late String detectedBy;

  /// The kind of the case, one of:
  /// - `notification`, or,
  /// - `appeal`
  @db.StringProperty(required: true)
  late String kind;

  /// The kind of the entity this notification or appeal concerns. On of:
  /// `package`, `package-version` or `publisher`.
  @db.StringProperty()
  String? subjectKind;

  /// The fully qualified name of the entity this notification or appeal concerns.
  /// - `package:<package>`
  /// - `package-version:<package>/<version>`
  /// - `publisher:<publisherId>`
  @db.StringProperty()
  String? subjectFqn;

  /// The local name of the entity (without the type qualifier) this notification or appeal concerns.
  /// - `package`: the package name
  /// - `package-version`: the `<package>/<version>`
  /// - `publisher`: the publisher ID
  String? subjectLocalName;

  /// The `caseId` of the appeal (or null).
  @db.StringProperty()
  String? appealedCaseId;

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

  ModerationCase();

  ModerationCase.init({
    required String caseId,
    required this.reporterUserId,
    required this.reporterEmail,
    required this.detectedBy,
    required this.kind,
    required this.status,
    this.subjectKind,
    this.subjectLocalName,
  }) {
    id = caseId;
    opened = clock.now().toUtc();
    if (subjectKind != null &&
        subjectKind!.isNotEmpty &&
        subjectLocalName != null &&
        subjectLocalName!.isNotEmpty) {
      subjectFqn = '$subjectKind:$subjectLocalName';
    }
  }
}

abstract class ModerationDetectedBy {
  static const externalNotification = 'external-notification';
}

abstract class ModerationKind {
  static const notification = 'notification';
}

abstract class ModerationStatus {
  static const pending = 'pending';
}
