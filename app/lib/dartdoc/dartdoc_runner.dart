// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:pana/pana.dart' hide Pubspec;
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import 'package:pub_dartdoc_data/pub_dartdoc_data.dart';

import '../job/backend.dart';
import '../job/job.dart';
import '../scorecard/backend.dart';
import '../scorecard/models.dart';
import '../shared/configuration.dart' show envConfig;
import '../shared/tool_env.dart';
import '../shared/urls.dart';
import '../shared/versions.dart' as versions;

import 'backend.dart';
import 'coverage.dart';
import 'customization.dart';
import 'models.dart';

final Logger _logger = new Logger('pub.dartdoc.runner');
final Uuid _uuid = new Uuid();

const statusFilePath = 'status.json';
const _archiveFilePath = 'package.tar.gz';
const _buildLogFilePath = 'log.txt';
const _packageTimeout = const Duration(minutes: 10);
const _pubDataFileName = 'pub-data.json';
const _sdkTimeout = const Duration(minutes: 20);
final Duration _twoYears = const Duration(days: 2 * 365);

final _pkgPubDartdocDir =
    Platform.script.resolve('../../pkg/pub_dartdoc').toFilePath();

class DartdocJobProcessor extends JobProcessor {
  DartdocJobProcessor({Duration lockDuration})
      : super(service: JobService.dartdoc, lockDuration: lockDuration);

  /// Uses the tool environment's SDK (the one that is used for analysis too) to
  /// generate dartdoc documentation and extracted data file for SDK API indexing.
  /// Only the extracted data file will be used and uploaded.
  Future generateDocsForSdk() async {
    if (await dartdocBackend.hasValidDartSdkDartdocData()) return;
    final tempDir =
        await Directory.systemTemp.createTemp('pub-dartlang-dartdoc');
    try {
      final tempDirPath = tempDir.resolveSymbolicLinksSync();
      final outputDir = tempDirPath;
      final args = [
        '--sdk-docs',
        '--output',
        outputDir,
        '--hosted-url',
        siteRoot,
        '--link-to-remote',
        '--no-validate-links',
      ];
      if (envConfig.toolEnvDartSdkDir != null) {
        args.addAll(['--sdk-dir', envConfig.toolEnvDartSdkDir]);
      }
      final pr = await runProc(
        'dart',
        ['bin/pub_dartdoc.dart']..addAll(args),
        workingDirectory: _pkgPubDartdocDir,
        timeout: _sdkTimeout,
      );

      final pubDataFile = new File(p.join(outputDir, _pubDataFileName));
      final hasPubData = await pubDataFile.exists();
      final isOk = pr.exitCode == 0 && hasPubData;
      if (!isOk) {
        _logger.warning(
            'Error while generating SDK docs.\n\n${pr.stdout}\n\n${pr.stderr}');
        throw new Exception(
            'Error while generating SDK docs (hasPubData: $hasPubData).');
      }

      // prevent close races updating the same content in close succession
      if (await dartdocBackend.hasValidDartSdkDartdocData()) return;

      // upload only the pub dartdoc data file
      await dartdocBackend.uploadDartSdkDartdocData(pubDataFile);
    } catch (e, st) {
      _logger.warning('Error while generating SDK docs.', e, st);
    } finally {
      await tempDir.delete(recursive: true);
    }
  }

  @override
  Future<bool> shouldProcess(String package, String version, DateTime updated) {
    return scoreCardBackend.shouldUpdateReport(
      package,
      version,
      ReportType.dartdoc,
      updatedAfter: updated,
      includeDiscontinued: true,
      includeObsolete: true,
      successThreshold: const Duration(days: 90),
    );
  }

  @override
  Future<JobStatus> process(Job job) async {
    final tempDir =
        await Directory.systemTemp.createTemp('pub-dartlang-dartdoc');
    final tempDirPath = tempDir.resolveSymbolicLinksSync();
    final pkgPath = p.join(tempDirPath, 'pkg');
    final tarDir = p.join(tempDirPath, 'output');
    final outputDir = p.join(tarDir, job.packageName, job.packageVersion);

    // directories need to be created
    await new Directory(outputDir).create(recursive: true);

    final toolEnvRef = await getOrCreateToolEnvRef();

    final latestVersion =
        await dartdocBackend.getLatestVersion(job.packageName);
    final bool isLatestStable = latestVersion == job.packageVersion;
    bool depsResolved = false;
    DartdocResult dartdocResult;
    bool hasContent = false;
    PubDartdocData dartdocData;

    String reportStatus = ReportStatus.failed;
    String abortLog;
    final healthSuggestions = <Suggestion>[];
    final maintenanceSuggestions = <Suggestion>[];
    try {
      final pkgDir = await downloadPackage(job.packageName, job.packageVersion);
      if (pkgDir == null) {
        return JobStatus.failed;
      }
      await pkgDir.rename(pkgPath);
      final usesFlutter = await toolEnvRef.toolEnv.detectFlutterUse(pkgPath);

      final logFileOutput = new StringBuffer();
      logFileOutput.write('Dartdoc generation for $job\n\n'
          'runtime: ${versions.runtimeVersion}\n'
          'toolEnv Dart SDK: ${versions.toolEnvSdkVersion}\n'
          'runtime Dart SDK: ${versions.runtimeSdkVersion}\n'
          'pana: ${versions.panaVersion}\n'
          'dartdoc: ${versions.dartdocVersion}\n'
          'flutter: ${versions.flutterVersion}\n'
          'customization: ${versions.customizationVersion}\n'
          'usesFlutter: $usesFlutter\n'
          'started: ${new DateTime.now().toUtc().toIso8601String()}\n\n');

      final status = await scoreCardBackend.getPackageStatus(
          job.packageName, job.packageVersion);

      // Resolve dependencies only for non-legacy package versions.
      if (!status.isLegacy) {
        depsResolved = await _resolveDependencies(
            toolEnvRef.toolEnv, job, pkgPath, usesFlutter, logFileOutput);
      } else {
        logFileOutput.write(
            'Package version does not allow current SDK, skipping pub upgrade.\n\n');
      }

      // Generate docs only for packages that have healthy dependencies.
      if (depsResolved) {
        dartdocResult =
            await _generateDocs(job, pkgPath, outputDir, logFileOutput);
        hasContent = dartdocResult.hasIndexHtml && dartdocResult.hasIndexJson;
      } else {
        logFileOutput
            .write('Dependencies were not resolved, skipping dartdoc.\n\n');
      }

      if (hasContent) {
        await new DartdocCustomizer(
                job.packageName, job.packageVersion, job.isLatestStable)
            .customizeDir(outputDir);
        logFileOutput.write('Content customization completed.\n\n');

        await _tar(tempDirPath, tarDir, outputDir, logFileOutput);
      } else {
        logFileOutput.write('No content found!\n\n');
      }

      final entry = await _createEntry(
          job, outputDir, usesFlutter, depsResolved, hasContent);
      logFileOutput.write('entry created: ${entry.uuid}\n\n');

      logFileOutput.write('completed: ${entry.timestamp.toIso8601String()}\n');
      await _writeLog(outputDir, logFileOutput);

      final oldEntry = await dartdocBackend.getLatestEntry(
          job.packageName, job.packageVersion);
      if (entry.isRegression(oldEntry)) {
        _logger.severe('Regression detected in $job, aborting upload.');
        // If `isLatest` or `isObsolete` have changed, we still want to update
        // the old entry, even if the job failed. `isLatest` is used to redirect
        // latest versions from versioned url to url with `/latest/`, and this
        // is cheaper than checking it on each request.
        if (oldEntry.isLatest != entry.isLatest ||
            oldEntry.isObsolete != entry.isObsolete) {
          await dartdocBackend.updateOldEntry(oldEntry, entry);
        }
      } else {
        await dartdocBackend.uploadDir(entry, outputDir);
        reportStatus = hasContent ? ReportStatus.success : ReportStatus.failed;
      }

      if (!hasContent && isLatestStable) {
        reportIssueWithLatest(job, 'No content.');
      }

      dartdocData = await _loadPubDartdocData(outputDir);
    } catch (e, st) {
      reportStatus = ReportStatus.aborted;
      if (isLatestStable) {
        reportIssueWithLatest(job, '$e\n$st');
      }
      abortLog =
          'Running `dartdoc` failed with the following output: $e\n\n```\n$st\n```\n';
    } finally {
      await tempDir.delete(recursive: true);
      await toolEnvRef.release();
    }

    final coverage = calculateCoverage(dartdocData);

    if (hasContent && dartdocData != null) {
      if (coverage.penalty > 0) {
        final level = coverage.percent < 0.2
            ? SuggestionLevel.warning
            : SuggestionLevel.hint;
        final undocumented = coverage.total - coverage.documented;
        healthSuggestions.add(
          new Suggestion(
              SuggestionCode.dartdocCoverage,
              level,
              'Document public APIs.',
              '$undocumented out of ${coverage.total} API elements have no dartdoc comment.'
              'Providing good documentation for libraries, classes, functions, and other API '
              'elements improves code readability and helps developers find and use your API.',
              score: coverage.penalty),
        );
      }
    } else if (abortLog != null) {
      maintenanceSuggestions.add(Suggestion.error(
        SuggestionCode.dartdocAborted,
        "Make sure `dartdoc` successfully runs on your package's source files.",
        abortLog,
        score: 10.0,
      ));
    } else {
      maintenanceSuggestions.add(getDartdocRunFailedSuggestion(dartdocResult));
    }
    await scoreCardBackend.updateReport(
        job.packageName,
        job.packageVersion,
        new DartdocReport(
          reportStatus: reportStatus,
          coverage: coverage.percent,
          coverageScore: coverage.score,
          healthSuggestions:
              healthSuggestions.isEmpty ? null : healthSuggestions,
          maintenanceSuggestions:
              maintenanceSuggestions.isEmpty ? null : maintenanceSuggestions,
        ));
    await scoreCardBackend.updateScoreCard(job.packageName, job.packageVersion);

    await dartdocBackend.removeObsolete(job.packageName, job.packageVersion);

    if (abortLog != null) {
      return JobStatus.aborted;
    } else {
      return hasContent ? JobStatus.success : JobStatus.failed;
    }
  }

  Future<bool> _resolveDependencies(ToolEnvironment toolEnv, Job job,
      String pkgPath, bool usesFlutter, StringBuffer logFileOutput) async {
    logFileOutput.write('Running pub upgrade:\n');
    final pr = await toolEnv.runUpgrade(pkgPath, usesFlutter);
    _appendLog(logFileOutput, pr);
    if (pr.exitCode != 0) {
      final message = pr.stderr.toString() ?? '';
      final isUserProblem = message.contains('version solving failed') ||
          message.contains('Git error.');
      if (!isUserProblem) {
        final output = _mergeOutput(pr, compressStdout: true);
        _logger.warning('Error while running pub upgrade for $job.\n$output');
      }
      return false;
    }
    return true;
  }

  Future<DartdocResult> _generateDocs(
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
      if (envConfig.toolEnvDartSdkDir != null) {
        args.addAll(['--sdk-dir', envConfig.toolEnvDartSdkDir]);
      }
      final pr = await runProc(
        'dart',
        ['bin/pub_dartdoc.dart']..addAll(args),
        workingDirectory: _pkgPubDartdocDir,
        timeout: _packageTimeout,
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
    final hasContent = r.hasIndexHtml && r.hasIndexJson;

    if (r.processResult.exitCode != 0) {
      if (hasContent || _isKnownFailurePattern(_mergeOutput(r.processResult))) {
        _logger.info('Error while running dartdoc for $job (see log.txt).');
      } else {
        final output = _mergeOutput(r.processResult, compressStdout: true);
        _logger.warning('Error while running dartdoc for $job.\n$output');
      }
    }

    return r;
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

  Future<PubDartdocData> _loadPubDartdocData(String outputDir) async {
    final file = new File(p.join(outputDir, _pubDataFileName));
    if (!file.existsSync()) {
      return null;
    }
    try {
      final content = await file.readAsString();
      return new PubDartdocData.fromJson(
          convert.json.decode(content) as Map<String, dynamic>);
    } catch (e, st) {
      _logger.warning('Unable to parse $_pubDataFileName.', e, st);
      return null;
    }
  }
}

bool _isKnownFailurePattern(String output) {
  if (output.contains('Unhandled exception:') &&
      output.contains('encountered ') &&
      output.contains(' analysis errors') &&
      output.contains('Dartdoc.logAnalysisErrors')) {
    return true;
  }
  return false;
}

/// Merges the stdout and stderr of [ProcessResult] into a single String, which
/// can be used in log messages. For long output, set [compressStdout] to true,
/// keeping only the beginning and the end of stdout.
String _mergeOutput(ProcessResult pr, {bool compressStdout = false}) {
  String stdout = pr.stdout.toString();
  if (compressStdout) {
    final list = stdout.split('\n');
    if (list.length > 50) {
      stdout = list.take(20).join('\n') +
          '\n[...]\n' +
          list.skip(list.length - 20).join('\n');
    }
  }
  return 'exitCode: ${pr.exitCode}\nstdout: $stdout\nstderr: ${pr.stderr}\n';
}
