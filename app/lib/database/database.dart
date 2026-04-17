// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:postgres/postgres.dart';
import 'package:pub_dev/database/migration.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/service/secret/backend.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/env_config.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:retry/retry.dart';
import 'package:typed_sql/typed_sql.dart';

final _logger = Logger('database');
final _random = Random.secure();

/// Sets the primary database service.
void registerPrimaryDatabase(PrimaryDatabase database) =>
    ss.register(#_primaryDatabase, database);

/// The active primary database service.
PrimaryDatabase? get primaryDatabase => _lookupPrimaryDatabase();

PrimaryDatabase? _lookupPrimaryDatabase() =>
    ss.lookup(#_primaryDatabase) as PrimaryDatabase?;

/// Access to the primary database connection and object mapping.
class PrimaryDatabase {
  final Pool _pg;
  final Future<void> Function()? _closeFn;

  PrimaryDatabase._(this._pg, this._closeFn);

  late final _adapter = DatabaseAdapter.postgres(_pg);
  late final _dialect = SqlDialect.postgres();
  late final _db = Database<PrimarySchema>(_adapter, _dialect);

  /// Gets the connection string either from the environment variable or from
  /// the secret backend, connects to it and registers the primary database
  /// service in the current scope.
  static Future<void> tryRegisterInScope() async {
    try {
      if (_lookupPrimaryDatabase() != null) {
        // Already initialized, must be in a local test environment.
        assert(activeConfiguration.isFakeOrTest);
        return;
      }
      final connectionString =
          envConfig.pubPostgresUrl ??
          (await secretBackend.lookup(SecretKey.databaseConnectionString));
      final database = await createAndInit(url: connectionString);
      registerPrimaryDatabase(database);
      ss.registerScopeExitCallback(database.close);
    } on PgException catch (e, st) {
      if (envConfig.isRunningInAppengine) {
        // ignore setup issues for now
        _logger.warning('Could not connect to Postgresql database.', e, st);
      } else {
        rethrow;
      }
    } on DatabaseException catch (e, st) {
      if (envConfig.isRunningInAppengine) {
        // ignore setup issues for now
        _logger.warning('Could not initialize typed_sql.', e, st);
      } else {
        rethrow;
      }
    }
  }

  /// Creates and initializes a [PrimaryDatabase] instance.
  ///
  /// When [url] is not provided, it will start a new local postgresql instance, or
  /// if it detects an existing one, connects to it.
  ///
  /// When NOT running in the AppEngine environment (e.g. testing or local fake),
  /// the initilization will create a new database, which will be dropped when the
  /// [close] method is called.
  static Future<PrimaryDatabase> createAndInit({
    String? url,
    bool skipProductionCheck = false,
  }) async {
    // The scope-specific custom database. We are creating a custom database for
    // each test run, in order to provide full isolation, however, this must not
    // be used in Appengine.
    String? customDb;
    if (url == null) {
      (url, customDb) = await _startOrUseLocalPostgresInDocker();
    }
    if (customDb == null && !envConfig.isRunningInAppengine) {
      customDb = await _createCustomDatabase(url);
    }

    final originalUrl = url;
    if (customDb != null) {
      if (envConfig.isRunningInAppengine) {
        throw StateError('Should not use custom database inside AppEngine.');
      }

      url = Uri.parse(url).replace(path: customDb).toString();
    }

    Future<void> closeFn() async {
      if (customDb != null) {
        await _dropCustomDatabase(originalUrl, customDb);
      }
    }

    url = _expandConnectionUrl(url);
    final db = PrimaryDatabase._(Pool.withUrl(url), closeFn);

    // =====
    // NOTE: We are not updating/migrating the production schema yet.
    // =====
    if (!skipProductionCheck && activeConfiguration.isProduction) {
      return db;
    }

    await retry(
      () async {
        await db._migrateSchema();
      },
      maxAttempts: 3,
      retryIf: (e) => e is DatabaseException,
    );
    return db;
  }

  Future<void> close() async {
    await _adapter.close();
    await _pg.close();
    if (_closeFn != null) {
      await _closeFn();
    }
  }

  Future<void> _migrateSchema() async {
    final migrationDb = Database<SchemaMigrationSchema>(
      _adapter,
      SqlDialect.postgres(),
    );

    // create migration_schema table (if not exists)
    // TODO(https://github.com/google/dart-neats/issues/348): use the output as-is after typed_sql supports it
    final createSql = createSchemaMigrationSchemaTables(
      _dialect,
    ).replaceFirst('CREATE TABLE "', 'CREATE TABLE IF NOT EXISTS "');
    await _pg.execute(createSql);

    // Read SQL migration files
    final files = Directory('migrations')
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.sql'))
        .toList();
    files.sort((a, b) => a.path.compareTo(b.path));
    final scripts = files
        .map((f) => (name: p.basename(f.path), content: f.readAsStringSync()))
        .toList();

    await migrateScripts(
      target: _adapter,
      table: migrationDb.schema_migrations,
      schemaName: 'pub-dev-primary',
      scripts: scripts,
    );
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

/// Expand the connection URL to override default parameters, unless specified in the provided URL.
String _expandConnectionUrl(String url) {
  final uri = Uri.parse(url.trim());
  return uri
      .replace(
        queryParameters: uri.queryParameters.map(
          (k, v) => MapEntry(k, v.toString().trim()),
        ),
      )
      .replace(
        queryParameters: {
          // replace connections after an hour (value is in seconds)
          'max_connection_age': '3600',
          'max_connection_count': '8',
          ...uri.queryParameters,
        },
      )
      .toString();
}

Future<(String, String?)> _startOrUseLocalPostgresInDocker() async {
  // sanity check
  if (envConfig.isRunningInAppengine) {
    throw StateError('Missing connection URL in Appengine environment.');
  }

  // the default connection URL for local server
  final url = Uri(
    scheme: 'postgresql',
    path: 'postgres',
    userInfo: 'postgres:postgres',
    queryParameters: {
      'host': '.dart_tool/postgresql/run/.s.PGSQL.5432',
      'sslmode': 'disable',
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

final _retryKey = #dbRetryKey;

extension PrimaryDatabaseExt on PrimaryDatabase {
  /// Runs [fn] in a retry block (without wrapping it in a transaction).
  ///
  /// The retry block is tracked with a [Zone], and if multiple retries are embeded
  /// (with or without transaction), only the outermost block will be retried.
  ///
  /// The call is retried if the generic [DatabaseException] is throw, which may be a
  /// connection issue, deadlock, timeout, constraint or any query-related problem.
  ///
  /// However, if inside the transaction an [Error] is thrown, or if the wrapped exception
  /// is [ResponseException], we don't retry [fn].
  Future<K> withRetry<K>(
    Future<K> Function(Database<PrimarySchema> db) fn,
  ) async {
    return await _withRetryZone(fn);
  }

  /// Runs [fn] in a transaction with retry block.
  ///
  /// The retry block is tracked with a [Zone], and if multiple retries are embeded
  /// (with or without transaction), only the outermost block will be retried.
  ///
  /// The call is retried if the generic [DatabaseException] is throw, which may be a
  /// connection issue, deadlock, timeout, constraint or any query-related problem.
  ///
  /// However, if inside the transaction an [Error] is thrown, or if the wrapped exception
  /// is [ResponseException], we don't retry [fn].
  Future<K> transactWithRetry<K>(
    Future<K> Function(Database<PrimarySchema> db) fn,
  ) async {
    return await _withRetryZone((db) => db.transact(() => fn(db)));
  }

  Future<K> _withRetryZone<K>(
    Future<K> Function(Database<PrimarySchema> db) fn,
  ) async {
    if (Zone.current[_retryKey] == null) {
      return await Zone.current.fork(zoneValues: {_retryKey: true}).run(() async {
        return await retry(
          () async {
            try {
              return await fn(_db);
            } on TransactionAbortedException catch (e) {
              final inner = e.reason;
              if (inner is Error || inner is ResponseException) {
                // TODO: we should keep and use the original stacktrace in typed_sql's exception
                throw inner;
              }
              rethrow;
            }
          },
          maxAttempts: 3,
          retryIf: (e) => e is DatabaseException,
        );
      });
    } else {
      return await fn(_db);
    }
  }
}
