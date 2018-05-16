// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:pana/pana.dart' hide Pubspec;
import 'package:pana/src/download_utils.dart';
import 'package:pana/src/utils.dart' show runProc;
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import '../job/job.dart';
import '../shared/configuration.dart' show envConfig;
import '../shared/urls.dart';
import '../shared/versions.dart' as versions;

import 'backend.dart';
import 'customization.dart';
import 'models.dart';

final Logger _logger = new Logger('pub.dartdoc.runner');
final Uuid _uuid = new Uuid();

const statusFilePath = 'status.json';
const _buildLogFilePath = 'log.txt';
const _dartdocTimeout = const Duration(minutes: 10);

class DartdocJobProcessor extends JobProcessor {
  DartdocJobProcessor({Duration lockDuration})
      : super(service: JobService.dartdoc, lockDuration: lockDuration);

  @override
  Future<JobStatus> process(Job job) async {
    final tempDir =
        await Directory.systemTemp.createTemp('pub-dartlang-dartdoc');
    final tempDirPath = tempDir.resolveSymbolicLinksSync();
    final pkgPath = p.join(tempDirPath, 'pkg');
    final pubCacheDir = p.join(tempDirPath, 'pub-cache');
    final tarDir = p.join(tempDirPath, 'output');
    final outputDir = p.join(tarDir, job.packageName, job.packageVersion);

    // directories need to be created
    await new Directory(pubCacheDir).create(recursive: true);
    await new Directory(outputDir).create(recursive: true);

    final toolEnv = await ToolEnvironment.create(
      pubCacheDir: pubCacheDir,
      flutterSdkDir: envConfig.flutterSdkDir,
      useGlobalDartdoc: true,
    );

    final latestVersion =
        await dartdocBackend.getLatestVersion(job.packageName);
    final bool isLatestStable = latestVersion == job.packageVersion;
    bool hasContent = false;

    try {
      final pkgDir = await downloadPackage(job.packageName, job.packageVersion);
      if (pkgDir == null) {
        return JobStatus.failed;
      }
      await pkgDir.rename(pkgPath);
      final usesFlutter = await toolEnv.detectFlutterUse(pkgPath);

      final logFileOutput = new StringBuffer();
      logFileOutput.write('Dartdoc generation for $job\n\n'
          'runtime: ${versions.runtimeVersion}\n'
          'dartdoc: ${versions.dartdocVersion}\n'
          'flutter: ${versions.flutterVersion}\n'
          'customization: ${versions.customizationVersion}\n'
          'usesFlutter: $usesFlutter\n'
          'started: ${new DateTime.now().toUtc().toIso8601String()}\n\n');

      // resolve dependencies
      final bool depsResolved = await _resolveDependencies(
          toolEnv, job, pkgPath, usesFlutter, logFileOutput);

      if (depsResolved) {
        hasContent = await _generateDocs(
            toolEnv, job, pkgPath, outputDir, logFileOutput);
      }

      if (hasContent) {
        await new DartdocCustomizer(job.packageName, job.packageVersion)
            .customizeDir(outputDir);

        await _tar(tempDirPath, tarDir, outputDir, logFileOutput);
      }

      final entry = await _createEntry(
          job, outputDir, usesFlutter, depsResolved, hasContent);

      logFileOutput.write('completed: ${entry.timestamp.toIso8601String()}\n');
      await _writeLog(outputDir, logFileOutput);

      final oldEntry = await dartdocBackend.getLatestEntry(
          job.packageName, job.packageVersion, false);
      if (entry.isRegression(oldEntry)) {
        _logger.severe('Regression detected in $job, aborting upload.');
      } else {
        await dartdocBackend.uploadDir(entry, outputDir);
      }

      if (!hasContent && isLatestStable) {
        reportIssueWithLatest(job, 'No content.');
      }
    } catch (e, st) {
      if (isLatestStable) {
        reportIssueWithLatest(job, '$e\n$st');
      }
      rethrow;
    } finally {
      await tempDir.delete(recursive: true);
    }

    await dartdocBackend.removeObsolete(job.packageName, job.packageVersion);

    return hasContent ? JobStatus.success : JobStatus.failed;
  }

  Future<bool> _resolveDependencies(ToolEnvironment toolEnv, Job job,
      String pkgPath, bool usesFlutter, StringBuffer logFileOutput) async {
    logFileOutput.write('Running pub upgrade:\n');
    final pr = await toolEnv.runUpgrade(pkgPath, usesFlutter);
    _appendLog(logFileOutput, pr);
    if (pr.exitCode != 0) {
      _logger.warning('Error while running pub upgrade for $job.\n'
          'exitCode: ${pr.exitCode}\n'
          'stdout: ${pr.stdout}\n'
          'stderr: ${pr.stderr}\n');
      return false;
    }
    return true;
  }

  Future<bool> _generateDocs(
    ToolEnvironment toolEnv,
    Job job,
    String pkgPath,
    String outputDir,
    StringBuffer logFileOutput,
  ) async {
    logFileOutput.write('Running dartdoc:\n');
    final canonicalVersion = job.isLatestStable ? 'latest' : job.packageVersion;
    final canonicalUrl = pkgDocUrl(job.packageName,
        version: canonicalVersion, includeHost: true, omitTrailingSlash: true);

    Future<DartdocResult> runDartdoc(bool validateLinks) {
      return toolEnv.dartdoc(
        pkgPath,
        outputDir,
        canonicalPrefix: canonicalUrl,
        hostedUrl: siteRoot,
        timeout: _dartdocTimeout,
        validateLinks: validateLinks,
        linkToRemote: true,
      );
    }

    DartdocResult r = await runDartdoc(true);
    if (r.wasTimeout) {
      r = await runDartdoc(false);
    }

    _appendLog(logFileOutput, r.processResult);

    if (r.processResult.exitCode != 0) {
      _logger.warning('Error while running dartdoc for $job.\n'
          'exitCode: ${r.processResult.exitCode}\n'
          'stdout: ${r.processResult.stdout}\n'
          'stderr: ${r.processResult.stderr}\n');
    }

    return r.hasIndexHtml && r.hasIndexJson;
  }

  Future<DartdocEntry> _createEntry(Job job, String outputDir, bool usesFlutter,
      bool depsResolved, bool hasContent) async {
    final entry = new DartdocEntry(
        uuid: _uuid.v4(),
        packageName: job.packageName,
        packageVersion: job.packageVersion,
        usesFlutter: usesFlutter,
        runtimeVersion: versions.runtimeVersion,
        sdkVersion: versions.sdkVersion,
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
    await new File(p.join(outputDir, _buildLogFilePath))
        .writeAsString(buffer.toString());
  }

  void _appendLog(StringBuffer buffer, ProcessResult pr) {
    buffer.write('STDOUT:\n${pr.stdout}\n\n');
    buffer.write('STDERR:\n${pr.stderr}\n\n');
  }

  Future _tar(String tmpDir, String tarDir, String outputDir,
      StringBuffer logFileOutput) async {
    logFileOutput.write('Running tar:\n');
    final archive = 'package.tar.gz';
    final File tmpTar = new File(p.join(tmpDir, archive));
    final pr = await runProc(
      'tar',
      ['-czf', tmpTar.path, '.'],
      workingDirectory: tarDir,
    );
    await tmpTar.rename(p.join(outputDir, archive));
    _appendLog(logFileOutput, pr);
  }
}
