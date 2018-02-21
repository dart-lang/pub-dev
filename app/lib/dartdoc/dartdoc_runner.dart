// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:pana/pana.dart';
import 'package:pana/src/download_utils.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import '../shared/configuration.dart' show envConfig;
import '../shared/task_scheduler.dart' show Task, TaskRunner;
import '../shared/utils.dart' show redirectDartdocPages;
import '../shared/versions.dart';

import 'backend.dart';
import 'customization.dart';
import 'models.dart';

final Logger _logger = new Logger('pub.dartdoc.runner');
final String _hostedUrl = 'https://www.dartdocs.org';
final Uuid _uuid = new Uuid();

const statusFilePath = 'status.json';
const buildLogFilePath = 'log.txt';

class DartdocRunner implements TaskRunner {
  @override
  Future<bool> shouldSkipTask(Task task) async {
    if (redirectDartdocPages.containsKey(task.package)) {
      return true;
    }
    final shouldRun = await dartdocBackend.shouldRunTask(task, dartdocVersion);
    return !shouldRun;
  }

  @override
  Future<bool> runTask(Task task) async {
    final tempDir =
        await Directory.systemTemp.createTemp('pub-dartlang-dartdoc');
    final tempDirPath = tempDir.resolveSymbolicLinksSync();
    final pkgPath = p.join(tempDirPath, 'pkg');
    final pubCacheDir = p.join(tempDirPath, 'pub-cache');
    final outputDir = p.join(tempDirPath, 'output');

    // pub cache dir needs to be created
    await new Directory(pubCacheDir).create(recursive: true);
    final pubEnv = new PubEnvironment(
      await DartSdk.create(),
      pubCacheDir: pubCacheDir,
      flutterSdk: envConfig.flutterSdkDir == null
          ? null
          : new FlutterSdk(sdkDir: envConfig.flutterSdkDir),
    );

    try {
      final pkgDir = await downloadPackage(task.package, task.version);
      if (pkgDir == null) return false;
      await pkgDir.rename(pkgPath);

      // resolve dependencies
      await _resolveDependencies(pubEnv, task, pkgPath);

      final dartdocEnv = {'PUB_CACHE': pubCacheDir};
      final entry = await _generateDocs(task, pkgPath, outputDir, dartdocEnv);

      await new DartdocCustomizer(task.package, task.version)
          .customizeDir(outputDir);

      if (entry.hasContent) {
        await dartdocBackend.uploadDir(entry, outputDir);
      }
    } finally {
      await tempDir.delete(recursive: true);
    }
    return false; // no race detection
  }

  Future _resolveDependencies(
      PubEnvironment pubEnv, Task task, String pkgPath) async {
    final pr = await pubEnv.runUpgrade(pkgPath, /* isFlutter */ false);
    if (pr.exitCode != 0) {
      _logger.severe('Error while running pub upgrade for $task.\n'
          'exitCode: ${pr.exitCode}\n'
          'stdout: ${pr.stdout}\n'
          'stderr: ${pr.stderr}\n');
      throw new Exception('pub upgrade failed with code ${pr.exitCode}');
    }
  }

  Future<DartdocEntry> _generateDocs(
    Task task,
    String pkgPath,
    String outputDir,
    Map<String, String> environment,
  ) async {
    final pr = await Process.run(
      'dartdoc',
      [
        '--output',
        outputDir,
        '--hosted-url',
        _hostedUrl,
        '--rel-canonical-prefix',
        p.join(_hostedUrl, 'documentation', task.package, task.version),
      ],
      workingDirectory: pkgPath,
      environment: environment,
    );

    if (pr.exitCode != 0) {
      _logger.severe('Error while running dartdoc for $task.\n'
          'exitCode: ${pr.exitCode}\n'
          'stdout: ${pr.stdout}\n'
          'stderr: ${pr.stderr}\n');
    }

    final hasContent = await new File(p.join(outputDir, 'index.html')).exists();
    final entry = new DartdocEntry(
        uuid: _uuid.v4(),
        packageName: task.package,
        packageVersion: task.version,
        dartdocVersion: dartdocVersion,
        timestamp: new DateTime.now().toUtc(),
        hasContent: hasContent);

    // write build logs
    await new File(p.join(outputDir, buildLogFilePath))
        .writeAsString('STDOUT:\n${pr.stdout}\n\nSTDERR:\n${pr.stderr}\n');

    // write entry into local file
    await new File(p.join(outputDir, statusFilePath))
        .writeAsBytes(entry.asBytes());

    return entry;
  }
}
