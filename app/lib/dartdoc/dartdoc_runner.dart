// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pana/pana.dart' hide Pubspec;
import 'package:path/path.dart' as p;

import 'package:pub_dartdoc_data/pub_dartdoc_data.dart';

import '../job/backend.dart';
import '../job/job.dart';
import '../scorecard/backend.dart';
import '../scorecard/models.dart';
import '../shared/configuration.dart';
import '../shared/tool_env.dart';
import '../shared/urls.dart';
import '../shared/utils.dart' show createUuid;
import '../shared/versions.dart' as versions;

import 'backend.dart';
import 'customization.dart';
import 'models.dart';

final Logger _logger = Logger('pub.dartdoc.runner');

const statusFilePath = 'status.json';
const _archiveFilePath = 'package.tar.gz';
const _buildLogFilePath = 'log.txt';
const _packageTimeout = Duration(minutes: 10);
const _pubDataFileName = 'pub-data.json';
const _sdkTimeout = Duration(minutes: 20);
final Duration _twoYears = const Duration(days: 2 * 365);

final _pkgPubDartdocDir =
    Platform.script.resolve('../../pkg/pub_dartdoc').toFilePath();

class DartdocJobProcessor extends JobProcessor {
  DartdocJobProcessor({
    Duration lockDuration,
    @required AliveCallback aliveCallback,
  }) : super(
          service: JobService.dartdoc,
          lockDuration: lockDuration,
          aliveCallback: aliveCallback,
        );

  /// Uses the tool environment's SDK (the one that is used for analysis too) to
  /// generate dartdoc documentation and extracted data file for SDK API indexing.
  /// Only the extracted data file will be used and uploaded.
  Future<void> generateDocsForSdk() async {
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
        '--no-validate-links',
      ];
      if (envConfig.toolEnvDartSdkDir != null) {
        args.addAll(['--sdk-dir', envConfig.toolEnvDartSdkDir]);
      }
      final pr = await runProc(
        'dart',
        ['bin/pub_dartdoc.dart', ...args],
        workingDirectory: _pkgPubDartdocDir,
        timeout: _sdkTimeout,
      );

      final pubDataFile = File(p.join(outputDir, _pubDataFileName));
      final hasPubData = await pubDataFile.exists();
      final isOk = pr.exitCode == 0 && hasPubData;
      if (!isOk) {
        _logger.warning(
            'Error while generating SDK docs.\n\n${pr.stdout}\n\n${pr.stderr}');
        throw Exception(
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
    );
  }

  @override
  Future<JobStatus> process(Job job) async {
    final packageStatus = await scoreCardBackend.getPackageStatus(
        job.packageName, job.packageVersion);
    // In case the package was deleted between scheduling and the actual delete.
    if (!packageStatus.exists) {
      _logger.info('Package does not exist: $job.');
      return JobStatus.skipped;
    }

    // We know that dartdoc will fail on this package, no reason to run it.
    if (packageStatus.isLegacy) {
      _logger.info('Package is on legacy SDK: $job.');
      await _storeScoreCard(job, _emptyReport());
      return JobStatus.skipped;
    }

    // Do not check for discontinued status, we still generate documentation for
    // such packages.

    if (packageStatus.isObsolete) {
      _logger
          .info('Package is older than two years and has newer release: $job.');
      await _storeScoreCard(job, _emptyReport());
      return JobStatus.skipped;
    }

    final logger =
        Logger('pub.dartdoc.runner/${job.packageName}/${job.packageVersion}');
    final tempDir =
        await Directory.systemTemp.createTemp('pub-dartlang-dartdoc');
    final tempDirPath = tempDir.resolveSymbolicLinksSync();
    final pkgPath = p.join(tempDirPath, 'pkg');
    final tarDir = p.join(tempDirPath, 'output');
    final outputDir = p.join(tarDir, job.packageName, job.packageVersion);

    // directories need to be created
    await Directory(outputDir).create(recursive: true);

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

      final logFileOutput = StringBuffer();
      logFileOutput.write('Dartdoc generation for $job\n\n'
          'runtime: ${versions.runtimeVersion}\n'
          'toolEnv Dart SDK: ${versions.toolEnvSdkVersion}\n'
          'runtime Dart SDK: ${versions.runtimeSdkVersion}\n'
          'pana: ${versions.panaVersion}\n'
          'dartdoc: ${versions.dartdocVersion}\n'
          'flutter: ${versions.flutterVersion}\n'
          'usesFlutter: $usesFlutter\n'
          'started: ${DateTime.now().toUtc().toIso8601String()}\n\n');

      final status = await scoreCardBackend.getPackageStatus(
          job.packageName, job.packageVersion);

      // Resolve dependencies only for non-legacy package versions.
      if (!status.isLegacy) {
        depsResolved = await _resolveDependencies(logger, toolEnvRef.toolEnv,
            job, pkgPath, usesFlutter, logFileOutput);
      } else {
        logFileOutput.write(
            'Package version does not allow current SDK, skipping pub upgrade.\n\n');
      }

      // Generate docs only for packages that have healthy dependencies.
      if (depsResolved) {
        dartdocResult =
            await _generateDocs(logger, job, pkgPath, outputDir, logFileOutput);
        hasContent = dartdocResult.hasIndexHtml && dartdocResult.hasIndexJson;
      } else {
        abortLog = 'Dependencies were not resolved.';
        logFileOutput
            .write('Dependencies were not resolved, skipping dartdoc.\n\n');
      }

      if (hasContent) {
        await DartdocCustomizer(
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
        logger.severe('Regression detected in $job, aborting upload.');
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

      dartdocData = await _loadPubDartdocData(logger, outputDir);
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

    final coverage = dartdocData?.coverage;
    if (hasContent && coverage != null) {
      if (coverage.penalty > 0) {
        final level = coverage.percent < 0.2
            ? SuggestionLevel.warning
            : SuggestionLevel.hint;
        final undocumented = coverage.total - coverage.documented;
        healthSuggestions.add(
          Suggestion(
              SuggestionCode.dartdocCoverage,
              level,
              'Document public APIs.',
              '$undocumented out of ${coverage.total} API elements have no dartdoc comment.'
                  'Providing good documentation for libraries, classes, functions, and other API '
                  'elements improves code readability and helps developers find and use your API.',
              score: coverage.penalty),
        );
      }
    } else {
      if (abortLog == null && dartdocResult != null) {
        abortLog =
            _mergeOutput(dartdocResult.processResult, compressStdout: true);
      }
      abortLog ??= '';
      maintenanceSuggestions.add(Suggestion.error(
        SuggestionCode.dartdocAborted,
        "Make sure `dartdoc` successfully runs on your package's source files.",
        abortLog,
        score: 10.0,
      ));
    }
    await _storeScoreCard(
        job,
        DartdocReport(
          reportStatus: reportStatus,
          coverage: coverage?.percent ?? 0.0,
          coverageScore: coverage?.score ?? 0.0,
          healthSuggestions:
              healthSuggestions.isEmpty ? null : healthSuggestions,
          maintenanceSuggestions:
              maintenanceSuggestions.isEmpty ? null : maintenanceSuggestions,
        ));
    await scoreCardBackend.updateScoreCard(job.packageName, job.packageVersion);

    if (abortLog != null) {
      return JobStatus.aborted;
    } else {
      return hasContent ? JobStatus.success : JobStatus.failed;
    }
  }

  Future _storeScoreCard(Job job, DartdocReport report) async {
    await scoreCardBackend.updateReport(
        job.packageName, job.packageVersion, report);
    await scoreCardBackend.updateScoreCard(job.packageName, job.packageVersion);
    dartdocBackend.scheduleGC(job.packageName, job.packageVersion);
  }

  Future<bool> _resolveDependencies(
      Logger logger,
      ToolEnvironment toolEnv,
      Job job,
      String pkgPath,
      bool usesFlutter,
      StringBuffer logFileOutput) async {
    logFileOutput.write('Running pub upgrade:\n');
    final pr = await toolEnv.runUpgrade(pkgPath, usesFlutter);
    _appendLog(logFileOutput, pr);
    if (pr.exitCode != 0) {
      final message = pr.stderr.toString() ?? '';
      final isUserProblem = message.contains('version solving failed') ||
          message.contains('Git error.');
      if (!isUserProblem) {
        final output = _mergeOutput(pr, compressStdout: true);
        logger.warning('Error while running pub upgrade for $job.\n$output');
      }
      return false;
    }
    return true;
  }

  Future<DartdocResult> _generateDocs(
    Logger logger,
    Job job,
    String pkgPath,
    String outputDir,
    StringBuffer logFileOutput,
  ) async {
    logFileOutput.write('Running dartdoc:\n');
    final canonicalVersion = job.isLatestStable ? 'latest' : job.packageVersion;
    final canonicalUrl = pkgDocUrl(job.packageName,
        version: canonicalVersion, includeHost: true, omitTrailingSlash: true);

    // dartdoc_options.yaml allows to change how doc content is generated.
    // To provide uniform experience across the pub site, and to reduce the
    // potential attack surface (HTML-, and code-injections, code executions),
    // we do not support the use of the options.
    //
    // https://github.com/dart-lang/dartdoc#dartdoc_optionsyaml
    final optionsFile = File(p.join(pkgPath, 'dartdoc_options.yaml'));
    if (await optionsFile.exists()) {
      await optionsFile.delete();
    }

    /// When [isReduced] is set, we are running dartdoc with reduced features,
    /// hopefully to complete within the time limit and fewer issues.
    Future<DartdocResult> runDartdoc({bool isReduced = false}) async {
      final args = [
        '--input',
        pkgPath,
        '--output',
        outputDir,
        '--rel-canonical-prefix',
        canonicalUrl,
        if (isReduced) '--no-link-to-remote',
        if (isReduced) '--no-validate-links',
      ];
      if (envConfig.toolEnvDartSdkDir != null) {
        args.addAll(['--sdk-dir', envConfig.toolEnvDartSdkDir]);
      }
      final environment = <String, String>{
        'PUB_HOSTED_URL': activeConfiguration.primaryApiUri.toString(),
      };
      environment.removeWhere((k, v) => v == null);
      logFileOutput.writeln('Running: pub_dartdoc ${args.join(' ')}');
      final pr = await runProc(
        'dart',
        ['bin/pub_dartdoc.dart', ...args],
        environment: environment,
        workingDirectory: _pkgPubDartdocDir,
        timeout: _packageTimeout,
      );
      final hasIndexHtml = await File(p.join(outputDir, 'index.html')).exists();
      final hasIndexJson = await File(p.join(outputDir, 'index.json')).exists();
      return DartdocResult(pr, pr.exitCode == 15, hasIndexHtml, hasIndexJson);
    }

    final sw = Stopwatch()..start();
    DartdocResult r = await runDartdoc();
    sw.stop();
    logger.info('Running dartdoc for ${job.packageName} ${job.packageVersion} '
        'completed in ${sw.elapsed}.');
    final shouldRetry = r.wasTimeout ||
        // TODO: remove this after https://github.com/dart-lang/dartdoc/issues/2101 gets fixed
        (!r.wasSuccessful &&
            r.processResult.stdout.toString().contains(
                "type 'FunctionTypeImpl' is not a subtype of type 'InterfaceType'"));
    if (shouldRetry) {
      r = await runDartdoc(isReduced: true);
    }

    _appendLog(logFileOutput, r.processResult);
    final hasContent = r.hasIndexHtml && r.hasIndexJson;

    if (r.processResult.exitCode != 0) {
      if (hasContent || _isKnownFailurePattern(_mergeOutput(r.processResult))) {
        logger.info('Error while running dartdoc for $job (see log.txt).');
      } else {
        final output = _mergeOutput(r.processResult, compressStdout: true);
        logger.warning('Error while running dartdoc for $job.\n$output');
      }
    }

    return r;
  }

  Future<DartdocEntry> _createEntry(Job job, String outputDir, bool usesFlutter,
      bool depsResolved, bool hasContent) async {
    int archiveSize;
    int totalSize;
    if (hasContent) {
      final archiveFile = File(p.join(outputDir, _archiveFilePath));
      archiveSize = await archiveFile.length();
      totalSize = await Directory(outputDir)
          .list(recursive: true)
          .where((fse) => fse is File)
          .cast<File>()
          .asyncMap((file) => file.length())
          .fold(0, (a, b) => a + b);
      totalSize -= archiveSize;
    }
    final now = DateTime.now();
    final isObsolete = job.isLatestStable == false &&
        job.packageVersionUpdated.difference(now).abs() > _twoYears;
    final entry = DartdocEntry(
      uuid: createUuid(),
      packageName: job.packageName,
      packageVersion: job.packageVersion,
      isLatest: job.isLatestStable,
      isObsolete: isObsolete,
      usesFlutter: usesFlutter,
      runtimeVersion: versions.runtimeVersion,
      sdkVersion: versions.toolEnvSdkVersion,
      dartdocVersion: versions.dartdocVersion,
      flutterVersion: versions.flutterVersion,
      timestamp: DateTime.now().toUtc(),
      depsResolved: depsResolved,
      hasContent: hasContent,
      archiveSize: archiveSize,
      totalSize: totalSize,
    );

    // write entry into local file
    await File(p.join(outputDir, statusFilePath)).writeAsBytes(entry.asBytes());

    return entry;
  }

  Future<void> _writeLog(String outputDir, StringBuffer buffer) async {
    await File(p.join(outputDir, _buildLogFilePath))
        .writeAsString(buffer.toString());
  }

  void _appendLog(StringBuffer buffer, ProcessResult pr) {
    buffer.write('STDOUT:\n${pr.stdout}\n\n');
    buffer.write('STDERR:\n${pr.stderr}\n\n');
  }

  Future<void> _tar(String tmpDir, String tarDir, String outputDir,
      StringBuffer logFileOutput) async {
    logFileOutput.write('Running tar:\n');
    final File tmpTar = File(p.join(tmpDir, _archiveFilePath));
    final pr = await runProc(
      'tar',
      ['-czf', tmpTar.path, '.'],
      workingDirectory: tarDir,
    );
    await tmpTar.rename(p.join(outputDir, _archiveFilePath));
    _appendLog(logFileOutput, pr);
  }

  Future<PubDartdocData> _loadPubDartdocData(
      Logger logger, String outputDir) async {
    final file = File(p.join(outputDir, _pubDataFileName));
    if (!file.existsSync()) {
      return null;
    }
    try {
      final content = await file.readAsString();
      return PubDartdocData.fromJson(
          convert.json.decode(content) as Map<String, dynamic>);
    } catch (e, st) {
      logger.warning('Unable to parse $_pubDataFileName.', e, st);
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

DartdocReport _emptyReport() => DartdocReport(
      reportStatus: ReportStatus.aborted,
      coverage: 0.0,
      coverageScore: 0.0,
      healthSuggestions: [],
      maintenanceSuggestions: [],
    );
