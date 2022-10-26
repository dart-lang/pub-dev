// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:_pub_shared/search/tags.dart';
import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pana/pana.dart' hide ReportStatus;
import 'package:pub_dev/package/screenshots/backend.dart';

import '../job/job.dart';
import '../package/overrides.dart';
import '../scorecard/backend.dart';
import '../scorecard/models.dart';
import '../shared/configuration.dart';
import '../shared/datastore.dart';
import '../shared/tool_env.dart';

final Logger _logger = Logger('pub.analyzer.pana');
String? _defaultAnalysisOptionsYaml;

@visibleForTesting
Future<String> getDefaultAnalysisOptionsYaml() async {
  if (_defaultAnalysisOptionsYaml == null) {
    final resource =
        await Isolate.resolvePackageUri(Uri.parse('package:lints/core.yaml'));
    final file = File.fromUri(resource!);
    _defaultAnalysisOptionsYaml = await file.readAsString();
  }
  return _defaultAnalysisOptionsYaml!;
}

/// Generic interface to run pana for package-analysis.
// ignore: one_member_abstracts
abstract class PanaRunner {
  Future<Summary?> analyze({
    required String package,
    required String version,
    required PackageStatus packageStatus,
  });
}

@visibleForTesting
Future<void> processJobsWithPanaRunner({
  PanaRunner? runner,
}) async {
  final jobProcessor = AnalyzerJobProcessor(
    aliveCallback: null,
    runner: runner ?? _PanaRunner(),
  );
  // ignore: invalid_use_of_visible_for_testing_member
  await JobMaintenance(dbService, jobProcessor).scanUpdateAndRunOnce();
}

class _PanaRunner implements PanaRunner {
  final _urlChecker = UrlChecker();

  @override
  Future<Summary?> analyze({
    required String package,
    required String version,
    required PackageStatus packageStatus,
  }) async {
    return await withToolEnv(
      usesPreviewSdk: packageStatus.usesPreviewAnalysisSdk,
      fn: (toolEnv) async {
        try {
          final PackageAnalyzer analyzer =
              PackageAnalyzer(toolEnv, urlChecker: _urlChecker);
          final isInternal = internalPackageNames.contains(package) ||
              packageStatus.isPublishedByDartDev;

          Future<void> store(String fileName, Uint8List data) async {
            final stream = () => Stream.value(data);
            await imageStorage.upload(
                package, version, stream, fileName, data.length);
          }

          return await analyzer.inspectPackage(
            package,
            version: version,
            options: InspectOptions(
              pubHostedUrl: activeConfiguration.primaryApiUri.toString(),
              analysisOptionsYaml: packageStatus.usesFlutter
                  ? null
                  : await getDefaultAnalysisOptionsYaml(),
              checkRemoteRepository: isInternal,
            ),
            logger: Logger.detached('pana/$package/$version'),
            storeResource: store,
          );
        } catch (e, st) {
          _logger.severe(
              'Failed (v$packageVersion) - $package/$version', e, st);
        }
        return null;
      },
    );
  }
}

class AnalyzerJobProcessor extends JobProcessor {
  final PanaRunner _runner;

  AnalyzerJobProcessor({
    PanaRunner? runner,
    required AliveCallback? aliveCallback,
  })  : _runner = runner ?? _PanaRunner(),
        super(
          service: JobService.analyzer,
          aliveCallback: aliveCallback,
        );

  @override
  Future<bool> shouldProcess(String package, String version, DateTime updated) {
    return scoreCardBackend.shouldUpdateReport(
      package,
      version,
      ReportType.pana,
      updatedAfter: updated,
    );
  }

  @override
  Future<JobStatus> process(Job job) async {
    final packageStatus = await scoreCardBackend.getPackageStatus(
        job.packageName!, job.packageVersion!);
    // In case the package was deleted between scheduling and the actual delete.
    if (!packageStatus.exists) {
      _logger.info('Package does not exist: $job.');
      return JobStatus.skipped;
    }

    // We know that pana will fail on this package, no reason to run it.
    if (packageStatus.isLegacy) {
      _logger.info('Package is on legacy SDK: $job.');
      await _storeScoreCard(job, null, packageStatus: packageStatus);
      return JobStatus.skipped;
    }

    if (packageStatus.isDiscontinued) {
      _logger.info('Package is discontinued: $job.');
      await _storeScoreCard(job, null, packageStatus: packageStatus);
      return JobStatus.skipped;
    }

    if (packageStatus.isObsolete) {
      _logger
          .info('Package is older than two years and has newer release: $job.');
      await _storeScoreCard(job, null, packageStatus: packageStatus);
      return JobStatus.skipped;
    }

    Future<Summary?> analyze() => _runner.analyze(
          package: job.packageName!,
          version: job.packageVersion!,
          packageStatus: packageStatus,
        );
    Summary? summary = await analyze();
    if (summary?.report == null) {
      _logger.info('Retrying $job...');
      await Future.delayed(Duration(seconds: 15));
      summary = await analyze();
    }

    JobStatus status = JobStatus.failed;
    if (packageStatus.isLegacy || summary?.report != null) {
      status = JobStatus.success;
    }

    final scoreCardFlags =
        packageStatus.isLegacy ? [PackageFlags.isLegacy] : null;
    await _storeScoreCard(job, summary,
        flags: scoreCardFlags, packageStatus: packageStatus);

    if (packageStatus.isLatestStable && status != JobStatus.success) {
      reportIssueWithLatest(job, '$status');
    }

    return status;
  }

  Future<void> _storeScoreCard(
    Job job,
    Summary? summary, {
    List<String>? flags,
    required PackageStatus packageStatus,
  }) async {
    await scoreCardBackend.updateReportOnCard(
      job.packageName!,
      job.packageVersion!,
      panaReport: _panaReportFromSummary(summary,
          flags: flags, packageStatus: packageStatus),
    );
  }
}

PanaReport _panaReportFromSummary(
  Summary? summary, {
  List<String>? flags,
  required PackageStatus packageStatus,
}) {
  final reportStatus =
      summary == null ? ReportStatus.aborted : ReportStatus.success;
  return PanaReport(
    timestamp: clock.now().toUtc(),
    panaRuntimeInfo: summary?.runtimeInfo,
    reportStatus: reportStatus,
    derivedTags: <String>{
      ...?summary?.tags,
      if (packageStatus.isLegacy) PackageVersionTags.isLegacy,
      if (packageStatus.isObsolete) PackageVersionTags.isObsolete,
      if (packageStatus.isDiscontinued) PackageTags.isDiscontinued,
    }.toList(),
    allDependencies: summary?.allDependencies,
    licenses: summary?.licenses,
    report: summary?.report,
    result: summary?.result,
    flags: flags,
    urlProblems: summary?.urlProblems,
    screenshots: summary?.screenshots,
  );
}
