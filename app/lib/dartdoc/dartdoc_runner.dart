// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:pana/pana.dart' hide Pubspec;
import 'package:pana/src/download_utils.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import '../frontend/model_properties.dart' show Pubspec;

import '../shared/configuration.dart' show envConfig;
import '../shared/task_scheduler.dart' show Task, TaskRunner;
import '../shared/utils.dart' show redirectDartdocPages;
import '../shared/versions.dart' as versions;

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
    final shouldRun = await dartdocBackend.shouldRunTask(
        task.package, task.version, task.updated, true);
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

    // directories need to be created
    await new Directory(pubCacheDir).create(recursive: true);
    await new Directory(outputDir).create(recursive: true);

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

      final logFileOutput = new StringBuffer();
      logFileOutput.write('Dartdoc generation for $task\n\n'
          'dartdoc: ${versions.dartdocVersion}\n'
          'flutter: ${versions.flutterVersion}\n'
          'customization: ${versions.customizationVersion}\n'
          'started: ${new DateTime.now().toUtc().toIso8601String()}\n\n');
      final usesFlutter = await _usesFlutter(pkgPath);

      // resolve dependencies
      final bool depsResolved = await _resolveDependencies(
          pubEnv, task, pkgPath, usesFlutter, logFileOutput);

      final dartdocEnv = {'PUB_CACHE': pubCacheDir};
      final hasContent = await _generateDocs(
          task, pkgPath, outputDir, dartdocEnv, logFileOutput);

      await new DartdocCustomizer(task.package, task.version)
          .customizeDir(outputDir);

      final entry = await _createEntry(
          task, outputDir, usesFlutter, depsResolved, hasContent);

      logFileOutput.write('completed: ${entry.timestamp.toIso8601String()}\n');
      await _writeLog(outputDir, logFileOutput);

      final oldEntry = await dartdocBackend.getLatestEntry(
          task.package, task.version, false);
      if (entry.isRegression(oldEntry)) {
        _logger.severe('Regression detected in $task, aborting upload.');
      } else {
        await dartdocBackend.uploadDir(entry, outputDir);
      }
    } finally {
      await tempDir.delete(recursive: true);
    }

    await dartdocBackend.removeObsolete(task.package, task.version);

    return false; // no race detection
  }

  Future<bool> _usesFlutter(String pkgPath) async {
    final File file = new File(p.join(pkgPath, 'pubspec.yaml'));
    if (await file.exists()) {
      final content = await file.readAsString();
      final pubspec = new Pubspec.fromYaml(content);
      return pubspec.usesFlutter;
    }
    // something may be wrong with the package with a missing pubspec.yaml
    _logger.warning('Missing pubspec.yaml in $pkgPath');
    return false;
  }

  Future<bool> _resolveDependencies(PubEnvironment pubEnv, Task task,
      String pkgPath, bool usesFlutter, StringBuffer logFileOutput) async {
    logFileOutput.write('Running pub upgrade:\n');
    final pr = await pubEnv.runUpgrade(pkgPath, usesFlutter);
    _appendLog(logFileOutput, pr);
    if (pr.exitCode != 0) {
      _logger.warning('Error while running pub upgrade for $task.\n'
          'exitCode: ${pr.exitCode}\n'
          'stdout: ${pr.stdout}\n'
          'stderr: ${pr.stderr}\n');
      return false;
    }
    return true;
  }

  Future<bool> _generateDocs(
    Task task,
    String pkgPath,
    String outputDir,
    Map<String, String> environment,
    StringBuffer logFileOutput,
  ) async {
    logFileOutput.write('Running dartdoc:\n');
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
    _appendLog(logFileOutput, pr);

    if (pr.exitCode != 0) {
      _logger.warning('Error while running dartdoc for $task.\n'
          'exitCode: ${pr.exitCode}\n'
          'stdout: ${pr.stdout}\n'
          'stderr: ${pr.stderr}\n');
    }

    final hasContent = await new File(p.join(outputDir, 'index.html')).exists();
    return hasContent;
  }

  Future<DartdocEntry> _createEntry(Task task, String outputDir,
      bool usesFlutter, bool depsResolved, bool hasContent) async {
    final entry = new DartdocEntry(
        uuid: _uuid.v4(),
        packageName: task.package,
        packageVersion: task.version,
        usesFlutter: usesFlutter,
        dartdocVersion: versions.dartdocVersion,
        flutterVersion: versions.flutterVersion,
        customizationVersion: versions.customizationVersion,
        timestamp: new DateTime.now().toUtc(),
        depsResolved: depsResolved,
        hasContent: hasContent);

    // write entry into local file
    await new File(p.join(outputDir, statusFilePath))
        .writeAsBytes(entry.asBytes());

    return entry;
  }

  Future _writeLog(String outputDir, StringBuffer buffer) async {
    await new File(p.join(outputDir, buildLogFilePath))
        .writeAsString(buffer.toString());
  }

  void _appendLog(StringBuffer buffer, ProcessResult pr) {
    buffer.write('STDOUT:\n${pr.stdout}\n\n');
    buffer.write('STDERR:\n${pr.stderr}\n\n');
  }
}
