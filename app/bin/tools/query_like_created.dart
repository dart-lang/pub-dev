// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:clock/clock.dart';
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
    help: 'Number of entities queried at the same time.',
  )
  ..addOption(
    'input',
    mandatory: true,
    abbr: 'i',
    help: 'Input file - CSV of <userId, package> pairs.',
  )
  ..addOption(
    'output-prefix',
    mandatory: true,
    abbr: 'o',
    help: 'Output file prefix - CSV of <userId, package, create> pairs.',
  )
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  if (argv['help'] as bool) {
    print('Usage: dart query_like_created.dart -i input.csv -o output -c 10');
    print(
        'Queries staging Datastore for Like entities and outputs the created property along the IDs.');
    print(_argParser.usage);
    return;
  }

  final concurrency = int.parse(argv['concurrency'] as String);
  final batchSize = int.parse(argv['batch'] as String);
  final inputPath = argv['input'] as String;
  final outputPrefix = argv['output-prefix'] as String;

  print('running on: ${envConfig.googleCloudProject}');
  if (envConfig.googleCloudProject != 'dartlang-pub-dev') {
    print('**ERROR**: The tool is meant to be used only on staging.');
    return;
  }

  final lines = await File(inputPath).readAsLines();
  final batches =
      lines.splitBeforeIndexed((index, _) => index % batchSize == 0).toList();
  print('Processing ${lines.length} Likes in ${batches.length} batches.');

  final found = <String>[];
  final missing = <String>[];

  var likeCount = 0;
  var batchCount = 0;
  await withToolRuntime(() async {
    final pool = Pool(concurrency);
    final futures = <Future>[];
    for (final batch in batches) {
      final keys = batch.map((line) {
        final parts = line.split(',');
        if (parts.length != 2) {
          throw ArgumentError('Unexpected input: `$line`');
        }
        final userId = parts[0].trim();
        final packageName = parts[1].trim();
        if (userId.isEmpty || packageName.isEmpty) {
          throw ArgumentError('Unexpected input: `$line`');
        }
        return dbService.emptyKey
            .append(User, id: userId)
            .append(Like, id: packageName);
      }).toList();
      final f = pool.withResource(() async {
        final likes = await dbService.lookup<Like>(keys);
        for (var i = 0; i < batch.length; i++) {
          final like = likes[i];
          final created = like?.created ?? clock.now();
          final newLine = '${batch[i]},${created.toUtc().toIso8601String()}';
          if (like == null) {
            missing.add(newLine);
          } else {
            found.add(newLine);
          }
        }
        batchCount++;
        likeCount += batch.length;
        if (batchCount % 1000 == 0) {
          print(
              'Queried: $likeCount Likes, found: ${found.length}, missing: ${missing.length}.');
        }
      });
      futures.add(f);
    }
    await Future.wait(futures);
    await pool.close();
  });
  print(
      'Queried: $likeCount Likes, found: ${found.length}, missing: ${missing.length}.');

  await File('$outputPrefix.found.csv').writeAsString(found.join('\n'));
  await File('$outputPrefix.missing.csv').writeAsString(missing.join('\n'));
}
