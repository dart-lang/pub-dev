// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:collection/collection.dart';
import 'package:pool/pool.dart';
import 'package:pub_dev/account/models.dart';

import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/env_config.dart';

final _argParser = ArgParser()
  ..addOption(
    'concurrency',
    abbr: 'c',
    defaultsTo: '1',
    help: 'Number of concurrent processing.',
  )
  ..addOption(
    'batch',
    defaultsTo: '1',
    help: 'Number of entities queried or updated at the same time.',
  )
  ..addOption(
    'input',
    mandatory: true,
    abbr: 'i',
    help: 'Input file - CSV of <userId, package, created> triplets.',
  )
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  if (argv['help'] as bool) {
    print('Usage: dart restore_likes.dart -i input.csv -c 10');
    print('Restores Likes into the configured Datastore.');
    print(_argParser.usage);
    return;
  }

  final concurrency = int.parse(argv['concurrency'] as String);
  final batchSize = int.parse(argv['batch'] as String);
  final inputPath = argv['input'] as String;

  print('running on: ${envConfig.googleCloudProject}');
  // if (envConfig.googleCloudProject != 'dartlang-pub-dev') {
  //   print('**ERROR**: The tool is meant to be used only on staging.');
  //   return;
  // }

  final lines = await File(inputPath).readAsLines();
  final batches =
      lines.splitBeforeIndexed((index, _) => index % batchSize == 0).toList();
  print('Processing ${lines.length} Likes in ${batches.length} batches.');

  var count = 0;
  var batchCount = 0;
  var createdCount = 0;
  await withToolRuntime(() async {
    final pool = Pool(concurrency);
    final futures = <Future>[];
    for (final batch in batches) {
      final newLikes = batch.map((line) {
        final parts = line.split(',');
        if (parts.length != 3) {
          throw ArgumentError('Unexpected input: `$line`');
        }
        final userId = parts[0].trim();
        final packageName = parts[1].trim();
        final created = DateTime.parse(parts[2].trim());
        if (userId.isEmpty ||
            packageName.isEmpty ||
            created.year < 2010 ||
            created.year > 2022) {
          throw ArgumentError('Unexpected input: `$line`');
        }
        return Like()
          ..parentKey = dbService.emptyKey.append(User, id: userId)
          ..id = packageName
          ..created = created
          ..packageName = packageName;
      }).toList();

      final f = pool.withResource(() async {
        var insertCount = 0;
        await withRetryTransaction(dbService, (tx) async {
          insertCount = 0;
          final oldLikes =
              await tx.lookup<Like>(newLikes.map((l) => l.key).toList());
          for (var i = 0; i < batch.length; i++) {
            final oldLike = oldLikes[i];
            if (oldLike != null) {
              continue;
            } else {
              tx.insert(newLikes[i]);
              insertCount++;
            }
          }
        });
        createdCount += insertCount;
        batchCount++;
        count += batch.length;
        if (batchCount % 1000 == 0) {
          print('Queried: $count Likes, created: $createdCount.');
        }
      });
      futures.add(f);
    }
    await Future.wait(futures);
    await pool.close();
  });
  print('Queried: $count Likes, created: $createdCount.');
}
