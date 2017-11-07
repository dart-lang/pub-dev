// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:io/ansi.dart';
import 'package:logging/logging.dart';
import 'package:pana/pana.dart';
import 'package:path/path.dart' as p;
import 'package:pool/pool.dart';

// Name of Docker instance and output directory
final _dockerName = 'results';

final _dockerLogger = new Logger('*  Docker  *');

main(List<String> args) async {
  var instanceCount = Platform.numberOfProcessors ~/ 2;
  if (args.isNotEmpty) {
    //TODO(kevmoo) - use pkg/args here instead
    instanceCount = int.parse(args.single);
  }

  var packages = new File('input_packages.txt').readAsLinesSync();

  var existingResults = _getExistingResults();

  var toProcess = new SplayTreeSet<String>();

  for (var pkg in packages) {
    var existing = existingResults.remove(pkg);

    if (existing != null) {
      // we have existing files here
      // Delete the file(s) disk if any have a .txt extension
      if (existing.any((ex) => ex == '.txt')) {
        // delete these files
        _deleteExisting(pkg, existing);

        existing = null;
      }
    }

    if (existing == null) {
      // process it!
      toProcess.add(pkg);
    } else {
      // skip it
      stderr.writeln(cyan.wrap("Skipping `$pkg` – already exists."));
    }
  }

  existingResults.forEach(_deleteExisting);

  if (toProcess.isEmpty) {
    print("Nothing to process. You may want to delete your results first.");
    return;
  }

  var longestPkgLength = 0;

  final cols = 160;

  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((log) {
    var lines = <String>[log.message];

    if (log.error != null) {
      lines.add(log.error.toString());
    }
    if (log.stackTrace != null) {
      lines.add(log.stackTrace.toString());
    }

    for (var line in lines.expand(LineSplitter.split)) {
      line = line.trimRight();

      if (log.loggerName.isNotEmpty) {
        line = [log.loggerName.padRight(longestPkgLength), line].join(' ');
      }
      if (line.length > cols) {
        line = line.substring(0, cols);
      }

      overrideAnsiOutput(stderr.supportsAnsiEscapes, () {
        if (log.level < Level.INFO) {
          line = styleDim.wrap(line);
        } else if (log.level >= Level.WARNING) {
          line = red.wrap(line);
        }
      });

      stderr.writeln(line);
    }
  });

  ///
  /// Handle signals
  ///
  var cancelCompleter = new Completer<bool>.sync();
  StreamSubscription signalSubscription;
  close(bool shouldKill) async {
    if (signalSubscription == null) return;
    signalSubscription.cancel();
    signalSubscription = null;
    print("Trying to tear down gracefully.");
    print("Press Control-C again to terminate immediately.");
    cancelCompleter.complete(shouldKill);
  }

  signalSubscription = getSignals().listen((_) => close(true));

  ///
  /// docker build
  ///
  Logger.root.info("Building Docker image...");

  try {
    await _runProc(
        'docker',
        [
          'build',
          '-t',
          _dockerName,
          Directory.current.resolveSymbolicLinksSync()
        ],
        logger: new Logger('* docker *'),
        stdoutLevel: Level.INFO,
        cancel: cancelCompleter.future);
  } catch (e, stack) {
    if (signalSubscription == null) {
      // We've been canceled, don't need to provide stack info
      Logger.root.warning("Canceled", e);
      // assuming it was SIGINT - so using 130 as the exit code
      // http://tldp.org/LDP/abs/html/exitcodes.html
      exitCode = 130;
    } else {
      Logger.root.severe("Docker failed...", e, stack);
      exitCode = 1;
    }
    return;
  }
  Logger.root.info("...done building Docker image.");

  ///
  /// Run packages!
  ///
  longestPkgLength = toProcess.fold<int>(
      _dockerLogger.name.length, (len, pkg) => math.max(len, pkg.length));

  print("Hacking through ${toProcess.length} package(s) "
      "- $instanceCount at a time.");

  var pool = new Pool(instanceCount);

  var finished = 0;
  var watch = new Stopwatch()..start();
  await Future.wait(toProcess.map((pkg) async {
    var resource = await pool.request();

    try {
      if (signalSubscription == null) {
        return;
      }

      Logger.root.info("$pkg starting");

      var pkgWatch = new Stopwatch()..start();

      try {
        // do things here!
        var result = await _runProc(
          'docker', ['run', '--rm', _dockerName, '--json', pkg],
          logger: new Logger(pkg),
          cancel: cancelCompleter.future,
          // To kill `docker run` dead, use SIGKILL
          //killWith: ProcessSignal.SIGTERM
        );
        result = prettyJson(JSON.decode(result));
        await _writeResult(pkg, result, false);
      } catch (e, stack) {
        if (signalSubscription == null) {
          // We've been canceled, don't need to provide stack info
          Logger.root.warning("$pkg Canceled", e);
          return;
        }
        Logger.root.severe("$pkg Run failed", e, stack);
        await _writeResult(pkg, [e, stack].join('\n'), true);
      }

      finished++;
      print('''
    
Finished ${pkg}
  $finished of ${toProcess.length}
  Took ${pkgWatch.elapsed}
  Averaging ${watch.elapsed ~/
              finished} per pkg across $instanceCount instances.
''');
    } finally {
      resource.release();
    }
  }));

  if (signalSubscription != null) {
    signalSubscription.cancel();
    signalSubscription = null;
  } else {
    // we were canceled! Set the exit code
    exitCode = 130;
  }
}

void _deleteExisting(String pkg, Set<String> existing) {
  // delete these files
  for (var path in existing.map((ext) => p.join(_dockerName, "$pkg$ext"))) {
    print("Deleting $path");
    new File(path).deleteSync();
  }
}

final _tempDirFind = new RegExp(r'/pana\.\d+\.[a-zA-Z0-9]+');

Future _writeResult(String pkg, String output, bool isError) async {
  _ensureResultDir();

  // cleanup random pana path fun
  output = output.replaceAll(_tempDirFind, '/pana');

  var name = isError ? '$pkg.error.txt' : '$pkg.json';
  var file = new File(p.join(_dockerName, name));

  await file.writeAsString(output, mode: WRITE_ONLY, flush: true);
}

Future<String> _runProc(String proc, List<String> args,
    {Logger logger, Future<bool> cancel, Level stdoutLevel}) async {
  logger ??= Logger.root;
  stdoutLevel ??= Level.FINE;

  var stdoutLines = <String>[];
  var stderrLines = <String>[];

  var process = await Process.start(proc, args);

  if (cancel != null) {
    cancel.then((shouldCancel) {
      if (shouldCancel) {
        if (process != null) {
          logger.warning("Sending SIGTERM to process...");
          var result = process.kill();
          logger.warning("Signal received? $result");
        }
      } else {
        logger.info('Not going to cancel, I guess...');
      }
    });
  }

  var items = await Future.wait(<Future<Object>>[
    process.exitCode,
    byteStreamSplit(process.stdout).forEach((outLine) {
      stdoutLines.add(outLine);
      logger.log(stdoutLevel, outLine);
    }),
    byteStreamSplit(process.stderr).forEach((errLine) {
      Map<String, Object> json;
      try {
        json = JSON.decode(errLine) as Map<String, Object>;
      } catch (e) {
        //TODO: maybe log something here?
      }

      if (json != null) {
        var level = Level.LEVELS.singleWhere((l) => l.name == json['level']);

        var message = json['message'];
        var error = json['error'];
        var stack = json['stackTrace'] as String;
        var trace = stack == null ? null : new StackTrace.fromString(stack);

        // Only populate the stdeerLines with Warnings+
        if (level >= Level.WARNING) {
          stderrLines.addAll([message, error, stack]
              .where((e) => e != null)
              .map((e) => e.toString()));
        }

        logger.log(level, message, error, trace);
      } else {
        stderrLines.add(errLine);
        logger.info(errLine);
      }
    })
  ]);

  process = null;

  var exitCode = items.first as int;
  if (exitCode == 130) {
    throw "Process terminated by caller.";
  } else if (exitCode > 0) {
    throw stderrLines.join('\n');
  } else if (exitCode < 0) {
    throw "Process killed - $exitCode";
  }

  return stdoutLines.join('\n');
}

Directory _ensureResultDir() {
  var dir = new Directory(_dockerName);
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
  }
  return dir;
}

Map<String, Set<String>> _getExistingResults() {
  var resultsDir = _ensureResultDir();

  var items = new Map<String, Set<String>>();

  for (var item in resultsDir.listSync()) {
    assert(item is File);

    var set = items.putIfAbsent(
        p.basenameWithoutExtension(item.path), () => new Set<String>());

    set.add(p.extension(item.path));
  }

  return items;
}
