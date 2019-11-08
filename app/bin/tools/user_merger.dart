// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:args/args.dart';
import 'package:gcloud/db.dart';

import 'package:pub_dev/service/entrypoint/tools.dart';
import 'package:pub_dev/shared/user_merger.dart';

final _argParser = ArgParser()
  ..addOption('concurrency',
      abbr: 'c', defaultsTo: '10', help: 'Number of concurrent processing.')
  ..addOption('oauth-user-id', help: 'The specific OAuthUserId object to fix.')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

int concurrency;

Future main(List<String> args) async {
  final argv = _argParser.parse(args);
  if (argv['help'] as bool == true) {
    print('Usage: dart user_merger.dart --oauth-user-id <id>');
    print(_argParser.usage);
    return;
  }

  concurrency = int.parse(argv['concurrency'] as String);
  final oauthUserId = argv['oauth-user-id'] as String;

  await withProdServices(() async {
    final userMerger = UserMerger(db: dbService, concurrency: concurrency);
    if (oauthUserId != null) {
      await userMerger.fixOAuthUserID(oauthUserId);
    } else {
      await userMerger.fixAll();
    }
  });
}
