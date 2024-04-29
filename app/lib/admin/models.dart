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
  @db.StringProperty()
  String? subject;

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
    required this.reporterEmail,
    required this.source,
    required this.kind,
    required this.status,
    this.subject,
  }) {
    id = caseId;
    opened = clock.now().toUtc();
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

/// Describes the parsed structure of a [ModerationCase.subject] (or the same as URL parameter).
class ModerationSubject {
  /// The kind of moderation as described by [ModerationSubjectKind], one of:
  /// - package,
  /// - package-version,
  /// - publisher.
  final String kind;

  /// The local name part of the subject, may be a composite, one of:
  /// - <package>,
  /// - <package>/<version>,
  /// - <publisherId>.
  final String localName;

  /// The package name of the subject (if not a publisher).
  final String? package;

  /// The package version of the subject (if the version was specified).
  final String? version;

  /// The publisher id (if not a package or package/version).
  final String? publisherId;

  ModerationSubject._({
    required this.kind,
    required this.localName,
    this.package,
    this.version,
    this.publisherId,
  });

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
      default:
        return null;
    }
  }

  late final fqn = '$kind:$localName';
}

class ModerationSubjectKind {
  static const unspecified = 'unspecified';
  static const package = 'package';
  static const packageVersion = 'package-version';
  static const publisher = 'publisher';
}
