// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:cli_util/cli_logging.dart';

main(List<String> args) async {
  bool verbose = args.contains('-v');
  Logger logger = verbose ? new Logger.verbose() : new Logger.standard();

  logger.stdout('Hello world!');
  logger.trace('message 1');
  await new Future.delayed(new Duration(milliseconds: 200));
  logger.trace('message 2');
  logger.trace('message 3');

  Progress progress = logger.progress('doing some work');
  await new Future.delayed(new Duration(seconds: 2));
  progress.finish(showTiming: true);

  logger.stdout('All ${logger.ansi.emphasized('done')}.');
  logger.flush();
}
