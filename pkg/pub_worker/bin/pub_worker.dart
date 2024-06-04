// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert' show json, jsonEncode;
import 'dart:io' show exit;

import 'package:_pub_shared/data/task_payload.dart';
import 'package:appengine/appengine.dart';
import 'package:logging/logging.dart';
import 'package:pub_worker/src/analyze.dart' show analyze;
import 'package:stack_trace/stack_trace.dart';

void _printUsage() => print('Usage: pub_worker.dart <JSON_PAYLOAD>');

Future<void> main(List<String> args) async {
  if (args.length != 1) {
    _printUsage();
    exit(1);
  }
  Payload payload;
  try {
    payload = Payload.fromJson(
      json.decode(args.first) as Map<String, dynamic>,
    );
  } on FormatException {
    _printUsage();
    exit(1);
  }
  _setupLogging({
    'package': payload.package,
    'pubHostedUrl': payload.pubHostedUrl,
  });

  try {
    await Chain.capture(() async {
      await analyze(payload);
    });
  } finally {
    // NOTE: When deployed pub_worker is responsible for terminating its own
    // process, and this must terminate the container. It is the responsibility
    // of the cloud-init configuration to launch the container and shutdown
    // after the container exits.
    exit(0); // forcibly exit, so there is no risk the process hangs.
  }
}

// TODO: Consider making a proper structure logging library
final Map<Level, LogLevel?> _loggingLevel2AppengineLoggingLevel = {
  Level.OFF: null,
  Level.ALL: LogLevel.DEBUG,
  Level.FINEST: LogLevel.DEBUG,
  Level.FINER: LogLevel.DEBUG,
  Level.FINE: LogLevel.DEBUG,
  Level.CONFIG: LogLevel.INFO,
  Level.INFO: LogLevel.INFO,
  Level.WARNING: LogLevel.WARNING,
  Level.SEVERE: LogLevel.ERROR,
  Level.SHOUT: LogLevel.CRITICAL,
};

/// Setup logging to stdout
void _setupLogging(Map<String, String> labels) {
  // TODO: Consider reducing the log-level or supporting a --verbosity option.
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    final level = _loggingLevel2AppengineLoggingLevel[record.level];
    if (level == null) {
      return;
    }

    var message = record.message;

    if (record.loggerName.isNotEmpty) {
      message = '${record.loggerName}: $message';
    }

    void addBlock(String header, String body) {
      body = body.replaceAll('\n', '\n    ');
      message = '$message\n\n$header:\n    $body';
    }

    final error = record.error;
    if (error != null) addBlock('Error', '$error');
    var stackTrace = record.stackTrace;
    if (stackTrace is Chain) {
      stackTrace = stackTrace.terse;
    }
    if (stackTrace != null) {
      addBlock('Stack', '$stackTrace');
    }

    // Truncated messages over 64kb
    if (message.length > 64 * 1024) {
      message = message.substring(0, 32 * 1024) +
          '...\n[truncated due to size]\n...' +
          message.substring(message.length - 16 * 1024);
    }

    print(jsonEncode({
      'severity': level.name.toUpperCase(),
      'message': message,
      'logging.googleapis.com/labels': {
        'logger': record.loggerName,
        ...labels,
      },
      'time': record.time.toUtc().toIso8601String(),
    }));
  });
}
