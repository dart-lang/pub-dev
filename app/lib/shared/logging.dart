// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:pub_dev/shared/env_config.dart';

bool _envBasedLoggingSetupDone = false;

class _LoggerNamePattern {
  final bool negated;
  final RegExp pattern;
  _LoggerNamePattern(this.negated, this.pattern);
}

/// Setup logging if environment variable `DEBUG` is defined.
///
/// Logs are filtered based on `DEBUG='<filter>'`. This is simple filter
/// operating on log names.
///
/// **Examples**:
///  * `DEBUG='*'`, will show output from all loggers.
///  * `DEBUG='pub.*'`, will show output from loggers with name prefixed 'pub.'.
///  * `DEBUG='* -neat_cache'`, will show output from all loggers, except 'neat_cache'.
///
/// Multiple filters can be applied, the last matching filter will be applied.
void setupDebugEnvBasedLogging() {
  if (_envBasedLoggingSetupDone) {
    return;
  }
  _envBasedLoggingSetupDone = true;
  // ignore: invalid_use_of_visible_for_testing_member
  final debugEnv = envConfig.debug ?? 'fake_server pub.email';
  if (debugEnv.isEmpty) {
    return;
  }

  final patterns = debugEnv.split(' ').map((s) {
    var pattern = s.trim();
    final negated = pattern.startsWith('-');
    if (negated) {
      pattern = pattern.substring(1);
    }

    return _LoggerNamePattern(
      negated,
      RegExp('^' +
          pattern.splitMapJoin(
            '*',
            onMatch: (m) => '.*',
            onNonMatch: RegExp.escape,
          ) +
          '\$'),
    );
  }).toList();

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    final time = clock.now(); // rec.time

    var matched = false;
    for (final p in patterns) {
      if (p.pattern.hasMatch(rec.loggerName)) {
        matched = !p.negated;
      }
    }
    if (!matched) {
      return;
    }

    for (final line in rec.message.split('\n')) {
      print('$time [${rec.loggerName}] ${rec.level.name}: $line');
    }
    if (rec.error != null) {
      print('ERROR: ${rec.error}, ${rec.stackTrace}');
    }
  });
}
