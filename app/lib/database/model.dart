// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert' show json;

import 'package:gcloud/service_scope.dart' as ss;
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_dev/task/models.dart'
    show AbortedTokenInfo, PackageVersionStateInfo;
import 'package:typed_sql/typed_sql.dart';

export 'package:typed_sql/typed_sql.dart' hide AuthenticationException;

part 'model.g.dart';
part 'model.task.dart';

/// Sets the active [database].
void registerDatabase(Database<PrimaryDatabase> value) =>
    ss.register(#_database, value);

/// The active [Database<PrimaryDatabase>].
Database<PrimaryDatabase> get database =>
    ss.lookup(#_database) as Database<PrimaryDatabase>;

abstract final class PrimaryDatabase extends Schema {
  Table<Task> get tasks;

  Table<TaskDependency> get taskDependencies;
}
