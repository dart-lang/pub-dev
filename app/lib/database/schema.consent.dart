// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'schema.dart';

/// TODO: rename to Consent after fully migrated to SQL.
@PrimaryKey(['id'])
abstract final class ConsentRow extends Row {
  /// Matches `Consent.consentId`.
  String get id;

  String get email;

  /// Used to detect duplicate invites.
  @Index.field()
  String get dedupId;

  /// One of the `ConsentKind` values.
  String get kind;

  /// The arguments for the consent, a JSON array of strings.
  JsonValue get argsJson;

  /// May be an `User.userId` or `support@pub.dev`.
  String get fromAgent;

  DateTime get createdAt;

  @Index.field()
  DateTime get expiresAt;

  DateTime? get lastNotifiedAt;

  int get notificationCount;
}
