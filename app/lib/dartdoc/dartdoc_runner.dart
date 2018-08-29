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

import '../analyzer/backend.dart';
import '../job/backend.dart';
import '../job/job.dart';
import '../shared/analyzer_client.dart';
import '../shared/configuration.dart' show envConfig;
import '../shared/urls.dart';
import '../shared/versions.dart' as versions;

import 'backend.dart';
import 'customization.dart';
import 'models.dart';

final Logger _logger = new Logger('pub.dartdoc.runner');
final Uuid _uuid = new Uuid();

const statusFilePath = 'status.json';
const _archiveFilePath = 'package.tar.gz';
const _buildLogFilePath = 'log.txt';
const _dartdocTimeout = const Duration(minutes: 10);
final Duration _twoYears = const Duration(days: 2 * 365);

final _pkgPubDartdocDir =
    Platform.script.resolve('../../pkg/pub_dartdoc').toFilePath();

class DartdocJobProcessor extends JobProcessor {
  DartdocJobProcessor({Duration lockDuration})
      : super(service: JobService.dartdoc, lockDuration: lockDuration);

  @override
  Future<bool> shouldProcess(
      String package, String version, DateTime updated) async {
    final status =
        await dartdocBackend.checkTargetStatus(package, version, updated, true);
    return !status.shouldSkip;
  }

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
      dartSdkDir: envConfig.toolEnvDartSdkDir,
      flutterSdkDir: envConfig.flutterSdkDir,
      pubCacheDir: pubCacheDir,
    );

    final latestVersion =
        await dartdocBackend.getLatestVersion(job.packageName);
    final bool isLatestStable = latestVersion == job.packageVersion;
    bool depsResolved = false;
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

      final isLegacy =
          await dartdocBackend.isLegacy(job.packageName, job.packageVersion);

      // Resolve dependencies only for non-legacy package versions.
      if (!isLegacy) {
        depsResolved = await _resolveDependencies(
            toolEnv, job, pkgPath, usesFlutter, logFileOutput);
      }

      // Generate docs only for packages that have healthy dependencies.
      if (depsResolved) {
        hasContent =
            await _generateDocs(job, pkgPath, outputDir, logFileOutput);
      }

      if (hasContent) {
        await new DartdocCustomizer(
                job.packageName, job.packageVersion, job.isLatestStable)
            .customizeDir(outputDir);

        await _tar(tempDirPath, tarDir, outputDir, logFileOutput);
      }

      final entry = await _createEntry(
          job, outputDir, usesFlutter, depsResolved, hasContent);

      logFileOutput.write('completed: ${entry.timestamp.toIso8601String()}\n');
      await _writeLog(outputDir, logFileOutput);

      final oldEntry = await dartdocBackend.getLatestEntry(
          job.packageName, job.packageVersion);
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

    // Trigger analyzer job to pick up the new dartdoc results.
    final pkgStatus = await analysisBackend.getPackageStatus(
        job.packageName, job.packageVersion);
    if (pkgStatus.exists &&
        !pkgStatus.isDiscontinued &&
        !pkgStatus.isObsolete) {
      await jobBackend.createOrUpdate(
          JobService.analyzer,
          job.packageName,
          job.packageVersion,
          job.isLatestStable,
          job.packageVersionUpdated,
          true);
    }

    analyzerClient.triggerAnalysis(
        job.packageName, job.packageVersion, new Set());

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
    Job job,
    String pkgPath,
    String outputDir,
    StringBuffer logFileOutput,
  ) async {
    logFileOutput.write('Running dartdoc:\n');
    final canonicalVersion = job.isLatestStable ? 'latest' : job.packageVersion;
    final canonicalUrl = pkgDocUrl(job.packageName,
        version: canonicalVersion, includeHost: true, omitTrailingSlash: true);

    Future<DartdocResult> runDartdoc(bool validateLinks) async {
      final args = [
        '--input',
        pkgPath,
        '--output',
        outputDir,
        '--hosted-url',
        siteRoot,
        '--rel-canonical-prefix',
        canonicalUrl,
        '--link-to-remote',
      ];
      if (!validateLinks) {
        args.add('--no-validate-links');
      }
      final pr = await runProc(
        'dart',
        ['bin/pub_dartdoc.dart']..addAll(args),
        workingDirectory: _pkgPubDartdocDir,
        timeout: _dartdocTimeout,
      );
      final hasIndexHtml =
          await new File(p.join(outputDir, 'index.html')).exists();
      final hasIndexJson =
          await new File(p.join(outputDir, 'index.json')).exists();
      return new DartdocResult(
          pr, pr.exitCode == 15, hasIndexHtml, hasIndexJson);
    }

    final sw = new Stopwatch()..start();
    DartdocResult r = await runDartdoc(true);
    sw.stop();
    _logger.info('Running dartdoc for ${job.packageName} ${job.packageVersion} '
        'completed in ${sw.elapsed}.');
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
    int archiveSize;
    int totalSize;
    if (hasContent) {
      final archiveFile = new File(p.join(outputDir, _archiveFilePath));
      archiveSize = await archiveFile.length();
      totalSize = await new Directory(outputDir)
          .list(recursive: true)
          .where((fse) => fse is File)
          .cast<File>()
          .asyncMap((file) => file.length())
          .fold(0, (a, b) => a + b);
      totalSize -= archiveSize;
    }
    final now = new DateTime.now();
    final isObsolete = job.isLatestStable == false &&
        job.packageVersionUpdated.difference(now).abs() > _twoYears;
    final entry = new DartdocEntry(
      uuid: _uuid.v4().toString(),
      packageName: job.packageName,
      packageVersion: job.packageVersion,
      isLatest: job.isLatestStable,
      isObsolete: isObsolete,
      usesFlutter: usesFlutter,
      runtimeVersion: versions.runtimeVersion,
      sdkVersion: versions.toolEnvSdkVersion,
      dartdocVersion: versions.dartdocVersion,
      flutterVersion: versions.flutterVersion,
      customizationVersion: versions.customizationVersion,
      timestamp: new DateTime.now().toUtc(),
      depsResolved: depsResolved,
      hasContent: hasContent,
      archiveSize: archiveSize,
      totalSize: totalSize,
    );

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
    final File tmpTar = new File(p.join(tmpDir, _archiveFilePath));
    final pr = await runProc(
      'tar',
      ['-czf', tmpTar.path, '.'],
      workingDirectory: tarDir,
    );
    await tmpTar.rename(p.join(outputDir, _archiveFilePath));
    _appendLog(logFileOutput, pr);
  }
}
