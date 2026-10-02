// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'schema.dart';

/// Entity representing a reserved package: the name is available only for a
/// subset of the users (`@google.com` + a list of emails).
///
/// TODO: rename to `ReservedPackage` after fully migrated to SQL.
@PrimaryKey(['name'])
abstract final class ReservedPackageRow extends Row {
  String get name;

  DateTime get createdAt;

  /// List of email addresses that are allowed to claim this package name,
  /// on top of the `@google.com` addresses.
  JsonValue get emailsJson;
}
