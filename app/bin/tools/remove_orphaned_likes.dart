// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:args/args.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/package/backend.dart';

import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/shared/datastore.dart';

final _argParser = ArgParser()
  ..addFlag('dry-run',
      abbr: 'n', defaultsTo: false, help: 'Do not change Datastore.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

/// Deletes Like entities that were orphaned.
Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  if (argv['help'] as bool) {
    print('Usage: dart remove_orphaned_likes.dart');
    print('Deletes Like entities with non-existing Package.');
    print('Deletes Like entities with non-existing User.');
    print(_argParser.usage);
    return;
  }

  final dryRun = argv['dry-run'] as bool;

  await withToolRuntime(() async {
    final existingUserIds = <String>{};
    final existingPackages = <String>{};

    Future<bool> isUserIdMissing(String userId) async {
      if (existingUserIds.contains(userId)) return true;
      final user = await accountBackend.lookupUserById(userId);
      if (user != null) {
        existingUserIds.add(userId);
        return false;
      } else {
        return true;
      }
    }

    Future<bool> isPackageMissing(String package) async {
      if (existingPackages.contains(package)) return true;
      final p = await packageBackend.lookupPackage(package);
      if (p != null) {
        existingPackages.add(package);
        return false;
      } else {
        return true;
      }
    }

    final counts = await dbService.deleteWithQuery<Like>(
      dbService.query<Like>(),
      where: (like) async {
        if (await isUserIdMissing(like.userId)) {
          return true;
        }
        if (await isPackageMissing(like.package)) {
          return true;
        }
        return false;
      },
      beforeDelete: (values) {
        if (dryRun) {
          for (final like in values) {
            print(
                'Deleting: ${like.userId} ${like.package} ${like.created?.toIso8601String()}');
          }
        } else {
          print('Deleting ${values.length} entities...');
        }
      },
      dryRun: dryRun,
    );

    print('Deleted: $counts');
  });
}
