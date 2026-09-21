// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart' hide JsonValue;
import 'package:meta/meta.dart';
import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/task/models.dart';
import 'package:typed_sql/typed_sql.dart';

part 'schema.g.dart';
part 'schema.account.dart';
part 'schema.audit.dart';
part 'schema.global_lock.dart';
part 'schema.task.dart';

@SqlOverride.schema(naming: .snake_case)
abstract final class PrimarySchema extends Schema {
  // account tables

  Table<UserSession> get userSessions;

  // audit tables

  Table<AuditLogRecordRow> get auditLogRecords;

  Table<AuditLogAssociation> get auditLogAssociation;

  // global lock table

  Table<GlobalLockStateRow> get globalLockStates;

  // task tables

  Table<Task> get tasks;

  Table<TaskDependency> get taskDependencies;

  Table<TaskVersion> get taskVersions;

  Table<TaskAbortedToken> get taskAbortedTokens;
}
