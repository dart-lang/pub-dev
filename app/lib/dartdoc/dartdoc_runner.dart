// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:pana/pana.dart';
import 'package:path/path.dart' as p;

import '../shared/task_scheduler.dart' show Task, TaskRunner;

final Logger _logger = new Logger('pub.dartdoc.runner');

const metadataFilePath = 'doc/api/pub-dartlang-metadata.json';

class DartdocRunner implements TaskRunner {
  String _cachedDartdocVersion;

  @override
  Future<bool> hasCompletedRecently(Task task) async {
    // TODO: implement a metadata check
    return false;
  }

  @override
  Future<bool> runTask(Task task) async {
    final tempDir =
        await Directory.systemTemp.createTemp('pub-dartlang-dartdoc');
    final tempDirPath = tempDir.resolveSymbolicLinksSync();
    final pubCacheDir = p.join(tempDirPath, 'pub-cache');
    final outputDir = p.join(tempDirPath, 'output');

    final pubEnv =
        new PubEnvironment(await DartSdk.create(), pubCacheDir: pubCacheDir);

    try {
      // TODO: use direct link to download the package
      final pkgLocation =
          await pubEnv.getLocation(task.package, version: task.version);
      final pkgPath = pkgLocation.location;

      // resolve dependencies
      await pubEnv.runUpgrade(pkgPath, /* isFlutter */ false);

      await _generateDocs(task, pkgPath, outputDir);

      await _writeMetadata(task, pkgPath);

      // TODO: upload doc/api to the appropriate bucket
    } finally {
      await tempDir.delete(recursive: true);
    }
    return false; // no race detection
  }

  Future _generateDocs(Task task, String pkgPath, String outputDir) async {
    final pr = await Process.run(
      'dartdoc',
      ['--output', outputDir],
      workingDirectory: pkgPath,
    );
    if (pr.exitCode != 0) {
      _logger.severe('Error while running dartdoc for $task.\n'
          'exitCode: ${pr.exitCode}\n'
          'stdout: ${pr.stdout}\n'
          'stderr: ${pr.stderr}\n');
      throw new Exception('dartdoc execution failed with code ${pr.exitCode}');
    }
  }

  Future _writeMetadata(Task task, String pkgPath) async {
    await new File(p.join(pkgPath, metadataFilePath))
        .writeAsString(JSON.encode({
      'package': task.package,
      'version': task.version,
      'dartdoc': await _getDartdocVersion(),
      'timestamp': new DateTime.now().toUtc().toIso8601String(),
    }));
  }

  Future<String> _getDartdocVersion() async {
    if (_cachedDartdocVersion != null) return _cachedDartdocVersion;
    final pr = await Process.run('dartdoc', ['--version']);
    if (pr.exitCode != 0) {
      _logger.severe('Unable to detect dartdoc version\n'
          'exitCode: ${pr.exitCode}\n'
          'stdout: ${pr.stdout}\n'
          'stderr: ${pr.stderr}\n');
      throw new Exception('dartdoc execution failed with code ${pr.exitCode}');
    }

    final match = _versionRegExp.firstMatch(pr.stdout);
    if (match == null) {
      _logger.severe('Unable to parse dartdoc version: ${pr.stdout}');
      throw new Exception('Unable to parse dartdoc version: ${pr.stdout}');
    }

    final version = match.group(1).trim();
    if (version.isNotEmpty) {
      _cachedDartdocVersion = version;
    }
    return _cachedDartdocVersion;
  }
}

final RegExp _versionRegExp = new RegExp(r'dartdoc version: (.*)$');
