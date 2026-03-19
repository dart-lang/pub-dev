// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:pana/pana.dart';
import 'package:path/path.dart' as p;
import 'package:pub_dev/database/schema.dart';
import 'package:typed_sql/typed_sql.dart';

const _devDbContainerName = 'atlas-dev-postgres';
const _atlasMigratorContainerName = 'atlas-migrator';

/// Creates a new database migration by diffing the current desired schema
/// (from the generated `typed_sql` schema) against existing migrations using Atlas.
///
/// Usage: dart tool/create_migration.dart migration_name
Future<void> main(List<String> args) async {
  final migrationName = args.isEmpty ? 'new_migration' : args.first;

  final appDir = Directory(
    Platform.script.resolve('..').toFilePath(),
  ).absolute.path;
  final migrationsDir = p.join(appDir, 'migrations');
  await Directory(migrationsDir).create(recursive: true);

  final tempSql = File(p.join(appDir, 'tmp_schema.$pid.sql'));
  final tempConfig = File(p.join(appDir, 'tmp_config.$pid.hcl'));

  try {
    print('Starting dev postgres instance: $_devDbContainerName');
    await runConstrained([
      'docker',
      'run',
      '--rm',
      '-d',
      '--name',
      _devDbContainerName,
      '-e',
      'POSTGRES_PASSWORD=pass',
      '-p',
      '5432:5432',
      'postgres:17-alpine',
    ], throwOnError: true);
    await Future<void>.delayed(Duration(seconds: 3));

    await tempConfig.writeAsString('''
env "local" {
  migration {
    dir = "file://migrations"
  }
  src = "file://schema.sql"
  dev = "postgres://postgres:pass@localhost:5432/postgres?sslmode=disable"
}
''');

    print('Creating ${tempSql.path} with the current desired schema...');
    await tempSql.writeAsString(
      createPrimarySchemaTables(SqlDialect.postgres()),
    );

    // Clear existing atlas.sum and regenerate hash.
    final atlasSumFile = File('$migrationsDir/atlas.sum');
    if (atlasSumFile.existsSync()) {
      atlasSumFile.deleteSync();
    }

    final uid = (await runConstrained([
      'id',
      '-u',
    ], throwOnError: true)).stdout.toString().trim();
    final gid = (await runConstrained([
      'id',
      '-g',
    ], throwOnError: true)).stdout.toString().trim();

    print('Creating atlas hash on existing migrations...');
    await runConstrained([
      'docker',
      'run',
      '--rm',
      '--name',
      _atlasMigratorContainerName,
      '--network',
      'host',
      '-u',
      '$uid:$gid',
      '-v',
      '$migrationsDir:/migrations',
      '-v',
      '${tempSql.path}:/schema.sql',
      '-v',
      '${tempConfig.path}:/atlas.hcl',
      'arigaio/atlas:latest-community',
      'migrate',
      'hash',
      '--config',
      'file:///atlas.hcl',
      '--env',
      'local',
    ], throwOnError: true);

    print('Creating migration: $migrationName...');
    await runConstrained([
      'docker',
      'run',
      '--rm',
      '--name',
      _atlasMigratorContainerName,
      '--network',
      'host',
      '-u',
      '$uid:$gid',
      '-v',
      '$migrationsDir:/migrations',
      '-v',
      '${tempSql.path}:/schema.sql',
      '-v',
      '${tempConfig.path}:/atlas.hcl',
      'arigaio/atlas:latest-community',
      'migrate',
      'diff',
      migrationName,
      '--config',
      'file:///atlas.hcl',
      '--env',
      'local',
    ], throwOnError: true);

    print('Migration created successfully.');

    // No need for atlas.sum (we use our own sha256sum.txt).
    if (atlasSumFile.existsSync()) {
      atlasSumFile.deleteSync();
    }

    // Find the newest .sql file in migrations dir.
    final sqlFiles = Directory(migrationsDir)
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.sql'))
        .toList();
    sqlFiles.sort((a, b) => b.path.compareTo(a.path));

    if (sqlFiles.isEmpty) {
      print('Error: no SQL files found in migrations directory.');
      exit(1);
    }

    // Atlas creates timestamped files; find the one that does NOT match
    // our sequential format (6 digits + underscore).
    final sequentialPattern = RegExp(r'^\d{6}_');
    final latestFile = sqlFiles
        .where((f) => !sequentialPattern.hasMatch(f.uri.pathSegments.last))
        .firstOrNull;

    if (latestFile != null) {
      print(
        'Timestamp detected. Renaming ${latestFile.path} to sequential format...',
      );

      // generate the next number
      final nextVal = sqlFiles.length.toString().padLeft(6, '0');
      final newFileName = '${nextVal}_$migrationName.sql';
      final newFile = File(p.join(migrationsDir, newFileName));

      await latestFile.rename(newFile.path);

      // remove "public". schema prefix
      final rawContent = await newFile.readAsString();
      await newFile.writeAsString(rawContent.replaceAll('"public".', ''));

      // format sql file
      await runConstrained([
        'docker',
        'run',
        '--rm',
        '-u',
        '$uid:$gid',
        '-v',
        '$migrationsDir:/work',
        '-w',
        '/work',
        'backplane/sql-formatter',
        '--config',
        '{"language": "postgresql", "uppercase": true, "indent": "  "}',
        '--fix',
        newFileName,
      ], throwOnError: true);
    } else {
      print('File already follows sequential format, skipping rename.');
    }

    // Update sha256sum.txt.
    await _updateSha256sum(migrationsDir);
  } finally {
    if (tempSql.existsSync()) tempSql.deleteSync();
    if (tempConfig.existsSync()) tempConfig.deleteSync();
    await Process.run('docker', ['rm', '-f', _devDbContainerName]);
  }
}

/// Writes sha256sum.txt with checksums of all .sql files sorted by name.
Future<void> _updateSha256sum(String migrationsDir) async {
  final sqlFiles = Directory(
    migrationsDir,
  ).listSync().whereType<File>().where((f) => f.path.endsWith('.sql')).toList();
  sqlFiles.sort((a, b) => a.path.compareTo(b.path));

  final sb = StringBuffer();
  for (final file in sqlFiles) {
    final bytes = await file.readAsBytes();
    final hash = sha256.convert(bytes).toString();
    final name = file.uri.pathSegments.last;
    sb.writeln('$hash  $name');
  }

  await File(
    p.join(migrationsDir, 'sha256sum.txt'),
  ).writeAsString(sb.toString());
}
