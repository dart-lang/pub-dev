// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart' show StreamGroup;
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import 'logging.dart';

Stream<String> byteStreamSplit(Stream<List<int>> stream) =>
    stream.transform(SYSTEM_ENCODING.decoder).transform(const LineSplitter());

final _timeout = const Duration(minutes: 2);
final _maxLines = 100000;

ProcessResult runProcSync(String executable, List<String> arguments,
    {String workingDirectory, Map<String, String> environment}) {
  log.fine('Running `${ ([executable]..addAll(arguments)).join(' ') }`...');
  return Process.runSync(
    executable,
    arguments,
    workingDirectory: workingDirectory,
    environment: environment,
  );
}

Future<ProcessResult> runProc(String executable, List<String> arguments,
    {String workingDirectory, Map<String, String> environment}) async {
  log.fine('Running `${ ([executable]..addAll(arguments)).join(' ') }`...');
  var process = await Process.start(executable, arguments,
      workingDirectory: workingDirectory, environment: environment);

  var stdoutLines = <String>[];
  var stderrLines = <String>[];

  bool killed;
  String killMessage;

  void killProc(String message) {
    if (killed != true) {
      killMessage = message;
      stderr.writeln("Killing $process");
      stderr.writeln("  $message");
      killed = process.kill();
      stderr.writeln("  killed? - $killed");
    }
  }

  var timer = new Timer(_timeout, () {
    killProc("Exceeded timeout of $_timeout");
  });

  var items = await Future.wait(<Future<Object>>[
    process.exitCode,
    byteStreamSplit(process.stdout).forEach((outLine) {
      stdoutLines.add(outLine);
      // Uncomment to debug long execution
      // stderr.writeln(outLine);
      if (stdoutLines.length > _maxLines) {
        killProc("STDOUT exceeded $_maxLines lines.");
      }
    }),
    byteStreamSplit(process.stderr).forEach((errLine) {
      stderrLines.add(errLine);
      // Uncomment to debug long execution
      // stderr.writeln(errLine);
      if (stderrLines.length > _maxLines) {
        killProc("STDERR exceeded $_maxLines lines.");
      }
    })
  ]);

  timer.cancel();

  var exitCode = items[0] as int;
  if (killed == true) {
    assert(exitCode < 0);

    stdoutLines.insert(0, killMessage);
    stderrLines.insert(0, killMessage);

    return new ProcessResult(process.pid, exitCode,
        stdoutLines.take(1000).join('\n'), stderrLines.take(1000).join('\n'));
  }

  return new ProcessResult(
      process.pid, items[0], stdoutLines.join('\n'), stderrLines.join('\n'));
}

ProcessResult handleProcessErrors(ProcessResult result) {
  if (result.exitCode != 0) {
    if (result.exitCode == 69) {
      // could be a pub error. Let's try to parse!
      var lines = LineSplitter
          .split(result.stderr)
          .where((l) => l.startsWith("ERR "))
          .join('\n');
      if (lines.isNotEmpty) {
        throw lines;
      }
    }

    throw "Problem running proc: exit code - " +
        [result.exitCode, result.stdout, result.stderr]
            .map((e) => e.toString().trim())
            .join('<***>');
  }
  return result;
}

Stream<String> listFiles(String directory,
    {String endsWith, bool deleteBadExtracted = false}) {
  var dir = new Directory(directory);
  return dir
      .list(recursive: true)
      .where((fse) => fse is File)
      .where((fse) {
        if (deleteBadExtracted) {
          var segments = p.split(fse.path);
          if (segments.last.startsWith('._')) {
            log.warning("Deleting invalid file: `${fse.path}`.");
            fse.deleteSync();
            return false;
          }
        }
        return true;
      })
      .map((fse) => fse.path)
      .where((path) => endsWith == null || path.endsWith(endsWith))
      .map((path) => p.relative(path, from: directory));
}

Future<int> fileSize(String packageDir, String relativePath) =>
    new File(p.join(packageDir, relativePath)).length();

String prettyJson(obj) {
  try {
    return const JsonEncoder.withIndent(' ').convert(obj);
  } on JsonUnsupportedObjectError catch (e) {
    var error = e;

    while (error is JsonUnsupportedObjectError) {
      stderr.writeln([
        error,
        "${error.unsupportedObject} - (${error.unsupportedObject.runtimeType})",
        error.cause == null ? null : "Nested cause: ${error.cause}",
        error.stackTrace
      ].where((i) => i != null).join('\n'));

      error = error.cause;
    }
    rethrow;
  }
}

/// If no `pubspec.yaml` file exists, `null` is returned.
String getPubspecContent(String packagePath) {
  var theFile = new File(p.join(packagePath, 'pubspec.yaml'));
  if (theFile.existsSync()) {
    return theFile.readAsStringSync();
  }
  return null;
}

Object sortedJson(obj) {
  var fullJson = JSON.decode(JSON.encode(obj));
  return _toSortedMap(fullJson);
}

_toSortedMap(Object item) {
  if (item is Map) {
    return new SplayTreeMap<String, Object>.fromIterable(item.keys,
        value: (k) => _toSortedMap(item[k]));
  } else if (item is List) {
    return item.map(_toSortedMap).toList();
  } else {
    return item;
  }
}

Map<String, Object> yamlToJson(String yamlContent) {
  if (yamlContent == null) {
    return null;
  }
  var yamlMap = loadYaml(yamlContent) as YamlMap;

  // A bit paranoid, but I want to make sure this is valid JSON before we got to
  // the encode phase.
  return sortedJson(JSON.decode(JSON.encode(yamlMap)));
}

String toPackageUri(String package, String relativePath) {
  if (relativePath.startsWith('lib/')) {
    return 'package:$package/${relativePath.substring(4)}';
  } else {
    return 'asset:$package/$relativePath';
  }
}

String toRelativePath(String packageUri) {
  final uriPath = packageUri.substring(packageUri.indexOf('/') + 1);
  return packageUri.startsWith('package:') ? 'lib/$uriPath' : uriPath;
}

/// Returns the list of directories to focus on (e.g. bin, lib) - if they exist.
Future<List<String>> listFocusDirs(String packageDir) async {
  final dirs = <String>[];
  for (final dir in ['bin', 'lib']) {
    final path = p.join(packageDir, dir);
    if ((await FileSystemEntity.type(path)) == FileSystemEntityType.DIRECTORY) {
      dirs.add(dir);
    }
  }
  return dirs;
}

/// A merged stream of all signals that tell the test runner to shut down
/// gracefully.
///
/// Signals will only be captured as long as this has an active subscription.
/// Otherwise, they'll be handled by Dart's default signal handler, which
/// terminates the program immediately.
Stream<ProcessSignal> getSignals() => Platform.isWindows
    ? ProcessSignal.SIGINT.watch()
    : StreamGroup
        .merge([ProcessSignal.SIGTERM.watch(), ProcessSignal.SIGINT.watch()]);
