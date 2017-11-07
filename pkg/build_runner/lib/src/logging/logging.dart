// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';
import 'dart:io';

import 'package:logging/logging.dart';

/// Calls [logger#info] with [description] before and after calling [action]
/// and waiting for the returned future to complete. The 2nd log message will
/// have the elapsed time appended.
///
/// This function also appends a newline after the 2nd log (unless on windows)
/// to ensure that it does not get overwritten by later log messages.
Future<T> logWithTime<T>(
    Logger logger, String description, Future<T> action()) async {
  var watch = new Stopwatch()..start();
  logger.info('$description...');
  var result = await action();
  watch.stop();
  logger.info('$description completed, took ${watch.elapsedMilliseconds}ms'
      '${Platform.isWindows ? '' : '\n'}');
  return result;
}
