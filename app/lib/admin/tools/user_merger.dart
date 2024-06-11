// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:args/args.dart';

import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_dev/shared/user_merger.dart';

final _argParser = ArgParser()
  ..addOption('concurrency',
      abbr: 'c', defaultsTo: '10', help: 'Number of concurrent processing.')
  ..addOption('oauth-user-id', help: 'The specific OAuthUserId object to fix.')
  ..addOption('from-user-id',
      help: 'The User that will be removed. (must be in pair with to-user-id)')
  ..addOption('to-user-id',
      help:
          'The User that will be extended. (must be in pair with from-user-id)')
  ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

int? concurrency;

Future<String> executeUserMergerTool(List<String> args) async {
  final argv = _argParser.parse(args);
  if (argv['help'] as bool) {
    return 'Usage: dart user_merger.dart --oauth-user-id <id>\n'
        'Usage: dart user_merger.dart --from-user-id <id> --to-user-id <other-id>\n'
        '${_argParser.usage}';
  }

  concurrency = int.parse(argv['concurrency'] as String);
  final oauthUserId = argv['oauth-user-id'] as String?;
  final fromUserId = argv['from-user-id'] as String?;
  final toUserId = argv['to-user-id'] as String?;
  final userMerger = UserMerger(db: dbService, concurrency: concurrency);
  if (oauthUserId != null) {
    InvalidInputException.checkNull(fromUserId, 'fromUserId');
    InvalidInputException.checkNull(toUserId, 'toUserId');
    await userMerger.fixOAuthUserID(oauthUserId);
    return 'Fixed `oauthUserId`.';
  } else if (fromUserId != null && toUserId != null) {
    await userMerger.mergeUser(fromUserId, toUserId);
    return 'Merged `$fromUserId` into `$toUserId`.';
  } else {
    InvalidInputException.checkNull(fromUserId, 'fromUserId');
    InvalidInputException.checkNull(toUserId, 'toUserId');
    final count = await userMerger.fixAll();
    return 'Fixed $count `User` entities.';
  }
}
