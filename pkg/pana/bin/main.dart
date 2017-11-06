#!/usr/bin/env dart --checked
// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:io/ansi.dart';
import 'package:logging/logging.dart' as log;
import 'package:pana/pana.dart';

main(List<String> arguments) async {
  // as provided, `arguments` is fixed length – turn it into a mutable `List`
  arguments = arguments.toList();

  var json = false;
  if (arguments.contains('--json')) {
    json = true;
    arguments.removeWhere((a) => a == '--json');
  }

  log.Logger.root.level = log.Level.ALL;

  if (json) {
    log.Logger.root.onRecord.listen((log) {
      var map = <String, Object>{};

      if (log.loggerName.isNotEmpty) {
        map['logName'] = log.loggerName;
      }

      map.addAll({
        'level': log.level.name,
        'message': log.message,
      });

      if (log.error != null) {
        map['error'] = log.error.toString();
      }

      if (log.stackTrace != null) {
        map['stackTrace'] = log.stackTrace.toString();
      }
      stderr.writeln(JSON.encode(map));
    });
  } else {
    log.Logger.root.onRecord.listen(_logWriter);
  }

  // Docker is WEIRD
  // The SIGTERM signal sent to `docker run...` DOES propagate a signal to the
  // running process. But...
  //   * It is received as SIGINT
  //   * It won't terminate the Dart process either – *BUT* we can listen for it
  // So this is how we do "clean" shutdown when running in Docker.
  var subscription = getSignals().listen((sig) async {
    log.Logger.root.severe("Received signal `$sig` – terminating.");
    exit(130);
  });

  var pkg = arguments.first;

  String version;
  if (arguments.length > 1) {
    version = arguments[1];
  }

  var tempDir = Directory.systemTemp
      .createTempSync('pana.${new DateTime.now().millisecondsSinceEpoch}.');

  // Critical to make sure analyzer paths align well
  var tempPath = await tempDir.resolveSymbolicLinks();

  try {
    try {
      var analyzer = new PackageAnalyzer(pubCacheDir: tempPath);
      var summary = await analyzer.inspectPackage(pkg, version: version);

      print(prettyJson(summary));
    } catch (e, stack) {
      var message = "Problem with pkg $pkg";
      if (version != null) {
        message = "$message ($version)";
      }
      log.Logger.root.shout(message, e, stack);
      exitCode = 1;
    }
  } finally {
    tempDir.deleteSync(recursive: true);
  }

  await subscription.cancel();
}

void _logWriter(log.LogRecord record) {
  var wroteHeader = false;

  var msg = LineSplitter
      .split([record.message, record.error, record.stackTrace]
          .where((e) => e != null)
          .join('\n'))
      .map((l) {
    String prefix;
    if (wroteHeader) {
      prefix = '';
    } else {
      wroteHeader = true;
      prefix = record.level.toString();
    }
    return "${prefix.padRight(10)} ${l}";
  }).join('\n');

  overrideAnsiOutput(stderr.supportsAnsiEscapes, () {
    stderr.writeln(darkGray.wrap(msg));
  });
}
