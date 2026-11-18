// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'schema.dart';

/// TODO: rename to OutgoingEmail after fully migrated to SQL.
@PrimaryKey(['id'])
abstract final class OutgoingEmailRow extends Row {
  String get id;
  DateTime get createdAt;

  /// The total number of attempts.
  int get attempts;

  /// The timestamp of the last attempt.
  DateTime? get lastAttemptedAt;

  /// A random identifier to mark that the message is under processing.
  String? get claimId;

  /// The timestamp of the next attempt.
  @Index.field()
  DateTime get pendingAt;

  /// The email address of the sender.
  String get fromEmail;

  /// The List of  recipient emails as a JSON array of strings.
  JsonValue get recipientEmailsJson;

  String get subject;

  String get bodyText;

  String get bodyHtml;
}
