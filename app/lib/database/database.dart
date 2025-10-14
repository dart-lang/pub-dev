// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/service_scope.dart' as ss;
import 'package:meta/meta.dart';
import 'package:postgres/postgres.dart';
import 'package:pub_dev/service/secret/backend.dart';
import 'package:pub_dev/shared/env_config.dart';

/// Sets the primary database service.
void registerPrimaryDatabase(PrimaryDatabase database) =>
    ss.register(#_primaryDatabase, database);

/// The active primary database service.
PrimaryDatabase? get primaryDatabase =>
    ss.lookup(#_primaryDatabase) as PrimaryDatabase?;

/// Access to the primary database connection and object mapping.
class PrimaryDatabase {
  final Pool _pg;

  PrimaryDatabase._(this._pg);

  /// Gets the connection string either from the environment variable or from
  /// the secret backend, connects to it and registers the primary database
  /// service in the current scope.
  static Future<void> tryRegisterInScope() async {
    final connectionString =
        envConfig.pubPostgresUrl ??
        (await secretBackend.lookup(SecretKey.postgresConnectionString));
    if (connectionString == null) {
      // ignore for now, must throw once we have the environment setup ready
      return;
    }
    final database = await _fromConnectionString(connectionString);
    registerPrimaryDatabase(database);
    ss.registerScopeExitCallback(database.close);
  }

  static Future<PrimaryDatabase> _fromConnectionString(String value) async {
    final pg = Pool.withUrl(value);
    return PrimaryDatabase._(pg);
  }

  Future<void> close() async {
    await _pg.close();
  }

  @visibleForTesting
  Future<void> verifyConnection() async {
    final rs = await _pg.execute('SELECT 1');
    if (rs.length != 1) {
      throw StateError('Connection is not returning expected rows.');
    }
  }
}
