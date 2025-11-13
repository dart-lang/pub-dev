// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:meta/meta.dart';
import 'package:postgres/postgres.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/service/secret/backend.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/env_config.dart';
import 'package:typed_sql/typed_sql.dart';

final _random = Random.secure();

/// Sets the primary database service.
void registerPrimaryDatabase(PrimaryDatabase database) =>
    ss.register(#_primaryDatabase, database);

/// The active primary database service.
PrimaryDatabase? get primaryDatabase =>
    ss.lookup(#_primaryDatabase) as PrimaryDatabase?;

/// Access to the primary database connection and object mapping.
class PrimaryDatabase {
  final Pool _pg;
  final DatabaseAdapter _adapter;
  final Database<PrimarySchema> db;

  PrimaryDatabase._(this._pg, this._adapter, this.db);

  /// Gets the connection string either from the environment variable or from
  /// the secret backend, connects to it and registers the primary database
  /// service in the current scope.
  static Future<void> tryRegisterInScope() async {
    if (activeConfiguration.isProduction) {
      // Production is not configured for postgresql yet.
      return;
    }
    var connectionString =
        envConfig.pubPostgresUrl ??
        (await secretBackend.lookup(SecretKey.postgresConnectionString));
    if (connectionString == null && activeConfiguration.isStaging) {
      // Staging may not have the connection string set yet.
      return;
    }
    // The scope-specific custom database. We are creating a custom database for
    // each test run, in order to provide full isolation, however, this must not
    // be used in Appengine.
    String? customDb;
    if (connectionString == null) {
      (connectionString, customDb) = await _startOrUseLocalPostgresInDocker();
    }
    if (customDb == null && !envConfig.isRunningInAppengine) {
      customDb = await _createCustomDatabase(connectionString);
    }

    if (customDb != null) {
      if (envConfig.isRunningInAppengine) {
        throw StateError('Should not use custom database inside AppEngine.');
      }

      final originalUrl = connectionString;
      connectionString = Uri.parse(
        connectionString,
      ).replace(path: customDb).toString();
      ss.registerScopeExitCallback(() async {
        await _dropCustomDatabase(originalUrl, customDb!);
      });
    }

    final database = await _fromConnectionString(connectionString);
    registerPrimaryDatabase(database);
    ss.registerScopeExitCallback(database.close);
  }

  static Future<PrimaryDatabase> _fromConnectionString(String value) async {
    final pg = Pool.withUrl(value);
    final adapter = DatabaseAdapter.postgres(pg);
    final db = Database<PrimarySchema>(adapter, SqlDialect.postgres());
    await db.createTables();
    return PrimaryDatabase._(pg, adapter, db);
  }

  Future<void> close() async {
    await _adapter.close();
    await _pg.close();
  }

  @visibleForTesting
  Future<String> verifyConnection() async {
    final rs = await _pg.execute('SELECT current_database();');
    if (rs.length != 1) {
      throw StateError('Connection is not returning expected rows.');
    }
    return rs.single.single as String;
  }
}

Future<(String, String?)> _startOrUseLocalPostgresInDocker() async {
  // sanity check
  if (envConfig.isRunningInAppengine) {
    throw StateError('Missing connection URL in Appengine environment.');
  }

  final socketFile = File('/tmp/pub_dev_postgres/run/.s.PGSQL.5432');

  // the default connection URL for local server
  final url = Uri(
    scheme: 'postgresql',
    path: 'postgres',
    userInfo: 'postgres:postgres',
    queryParameters: {
      // If the socket file is present, let's try to use it, otherwise connect through the port.
      // Both has benefits:
      // - (during startup) calling the port is a blocking call and waits until the service is started,
      // - (while the service is running) the socket file seems to provide a bit faster connection.
      'host': await socketFile.exists() ? socketFile.path : 'localhost:55432',
      'sslmode': 'disable',
      'max_connection_count': '8',
    },
  ).toString();

  try {
    // try opening the connection
    final customDb = await _createCustomDatabase(url);
    return (url, customDb);
  } catch (_) {
    // on failure start the local server
    final pr = await Process.run('tool/start-local-postgres.sh', []);
    if (pr.exitCode != 0) {
      throw StateError(
        'Unexpect exit code from tool/start-local-postgres.sh\n${pr.stderr}',
      );
    }
    // The socket file may be present sooner than the server is accepting connections.
    // This arbitrary wait is probably enough to have a working server at this point.
    await Future.delayed(Duration(seconds: 2));
  }
  return (url, null);
}

int _customDbCount = 0;

Future<String> _createCustomDatabase(String url) async {
  _customDbCount++;
  final dbName =
      'fake_pub_${pid.toRadixString(36)}'
      '${_customDbCount.toRadixString(36)}'
      '${clock.now().millisecondsSinceEpoch.toRadixString(36)}'
      '${_random.nextInt(1 << 32).toRadixString(36)}';
  final conn = Pool.withUrl(url);
  await conn.execute('CREATE DATABASE "$dbName";');
  await conn.close(force: true);
  return dbName;
}

Future<void> _dropCustomDatabase(String url, String dbName) async {
  final conn = Pool.withUrl(url);
  await conn.execute('DROP DATABASE "$dbName";');
  await conn.close(force: true);
}
