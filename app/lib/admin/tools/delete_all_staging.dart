// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:args/args.dart';
import 'package:pool/pool.dart';

import '../../account/models.dart';
import '../../audit/models.dart';
import '../../dartdoc/models.dart';
import '../../job/backend.dart';
import '../../package/models.dart';
import '../../publisher/models.dart';
import '../../scorecard/models.dart';
import '../../service/secret/models.dart';
import '../../shared/datastore.dart';
import '../../shared/env_config.dart';
import '../../task/models.dart';
import '../../tool/neat_task/datastore_status_provider.dart';

final _argParser = ArgParser()
  ..addOption('concurrency',
      abbr: 'c', defaultsTo: '1', help: 'Number of concurrent processing.')
  ..addFlag('dry-run',
      abbr: 'n', defaultsTo: false, help: 'Do not change Datastore.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

/// Deletes every (used) entity on staging.
Future<String> executeDeleteAllStaging(List<String> args) async {
  if (envConfig.googleCloudProject != 'dartlang-pub-dev') {
    return '**ERROR**: The tool is meant to be used only on staging.';
  }

  final argv = _argParser.parse(args);
  if (argv['help'] as bool) {
    return 'Usage: dart delete_all_staging.dart\n'
        'Deletes every (used) entity on staging.\n'
        '${_argParser.usage}';
  }

  final concurrency = int.parse(argv['concurrency'] as String);
  final dryRun = argv['dry-run'] == true;

  final entities = <Query, int>{
    dbService.query<AuditLogRecord>(): 500,
    dbService.query<Job>(): 500,
    dbService.query<DartdocRun>(): 100,
    dbService.query<UserInfo>(): 500,
    dbService.query<OAuthUserID>(): 500,
    dbService.query<UserSession>(): 500,
    dbService.query<User>(): 500,
    dbService.query<Like>(): 500,
    dbService.query<ScoreCard>(): 500,
    dbService.query<PackageVersionInfo>(): 500,
    dbService.query<PackageVersionAsset>(): 100,
    dbService.query<PackageVersion>(): 500,
    dbService.query<Package>(): 500,
    dbService.query<PublisherMember>(): 500,
    dbService.query<PublisherInfo>(): 500,
    dbService.query<Publisher>(): 500,
    dbService.query<ModeratedPackage>(): 500,
    dbService.query<NeatTaskStatus>(): 500,
    dbService.query<Secret>(): 500,
    dbService.query<PackageState>(): 100,
  };

  final pool = Pool(concurrency);
  for (final entity in entities.entries) {
    final futures = <Future>[];
    await _batchedQuery(
      entity.key,
      (keys) {
        final f = pool.withResource(() => _commit(keys, dryRun));
        futures.add(f);
      },
      maxBatchSize: entity.value,
    );
    await Future.wait(futures);
  }
  await pool.close();
  return 'Done.';
}

const _defaultBudget = 512000;

Future<void> _batchedQuery<T extends Model>(
  Query<T> query,
  void Function(List<Key> keys) fn, {
  int maxBatchSize = 100,
}) async {
  final keys = <Key>[];
  var budget = _defaultBudget;

  void flush() {
    if (keys.isEmpty) return;
    fn(List.from(keys));
    keys.clear();
    budget = _defaultBudget;
  }

  await for (Model m in query.run()) {
    final size = _estimateSize(m);
    if (size * 4 >= _defaultBudget) {
      flush();
      keys.add(m.key);
      flush();
      continue;
    }

    keys.add(m.key);
    budget -= size;
    if (keys.length >= maxBatchSize || budget < 0) {
      flush();
    }
  }
  flush();
}

// Unscientific estimate of the model's stored size in Datastore.
int _estimateSize(Model m) {
  var size = 1024;
  final entity = dbService.modelDB.toDatastoreEntity(m);
  entity.properties.forEach((k, v) {
    size += 128;
    size += k.toString().length;
    if (v == null || v is num || v is bool) {
      size += 8;
    } else if (v is String) {
      size += v.length;
    } else if (v is BlobValue) {
      size += v.bytes.length;
    } else {
      size += 1024;
    }
  });
  return size;
}

Future<void> _commit(List<Key> keys, bool dryRun) async {
  if (keys.isEmpty) return;
  if (!dryRun) {
    await dbService.commit(deletes: keys);
  }
}
