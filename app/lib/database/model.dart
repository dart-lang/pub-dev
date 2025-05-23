// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert' show json;

import 'package:gcloud/service_scope.dart' as ss;
import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:postgres/postgres.dart';
import 'package:pub_dev/service/secret/backend.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_dev/task/models.dart'
    show AbortedTokenInfo, PackageVersionStateInfo;
import 'package:typed_sql/typed_sql.dart';

export 'package:typed_sql/typed_sql.dart' hide AuthenticationException;

part 'model.g.dart';
part 'model.task.dart';

final _log = Logger('database');

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

Future<DatabaseAdapter> setupDatabaseConnection() async {
  final connectionString =
      await secretBackend.lookup(SecretKey.databaseConnectionString);
  if (connectionString == null) {
    _log.shout('Missing database connection string from secrets');
    throw AssertionError('Missing database connection string from secrets');
  }
  final u = Uri.parse(connectionString);
  if (!u.isScheme('postgres')) {
    _log.shout('Invalid database connection string scheme: ${u.scheme}');
    throw AssertionError(
        'Invalid database connection string scheme: ${u.scheme}');
  }

  if (u.host.isEmpty) {
    throw AssertionError('Missing database host');
  }

  var database = u.path;
  if (database.startsWith('/')) {
    database = database.substring(1);
  }

  String? username, password;
  final userInfo = u.userInfo;
  if (userInfo.isNotEmpty) {
    if (userInfo.split(':').length != 2) {
      throw AssertionError(
        'Invalid database connection string: unable to parse username/password',
      );
    }
    username = userInfo.split(':').firstOrNull;
    password = userInfo.split(':').lastOrNull;
  }

  return DatabaseAdapter.postgres(Pool.withEndpoints(
    [
      Endpoint(
        host: u.host,
        port: u.port == 0 ? 5432 : u.port,
        database: database,
        username: username,
        password: password,
      ),
    ],
    settings: PoolSettings(
      applicationName: 'pub-dev',
      maxConnectionCount: 10,
    ),
  ));
}
