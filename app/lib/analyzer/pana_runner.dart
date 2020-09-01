// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pana/pana.dart';

import '../job/job.dart';
import '../package/overrides.dart';
import '../scorecard/backend.dart';
import '../scorecard/models.dart';
import '../shared/configuration.dart';
import '../shared/tool_env.dart';

final Logger _logger = Logger('pub.analyzer.pana');

class AnalyzerJobProcessor extends JobProcessor {
  final _urlChecker = UrlChecker();

  AnalyzerJobProcessor({
    @required AliveCallback aliveCallback,
  }) : super(
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
        job.packageName, job.packageVersion);
    // In case the package was deleted between scheduling and the actual delete.
    if (!packageStatus.exists) {
      _logger.info('Package does not exist: $job.');
      return JobStatus.skipped;
    }

    // We know that pana will fail on this package, no reason to run it.
    if (packageStatus.isLegacy) {
      _logger.info('Package is on legacy SDK: $job.');
      await _storeScoreCard(job, null);
      return JobStatus.skipped;
    }

    if (packageStatus.isDiscontinued) {
      _logger.info('Package is discontinued: $job.');
      await _storeScoreCard(job, null);
      return JobStatus.skipped;
    }

    if (packageStatus.isObsolete) {
      _logger
          .info('Package is older than two years and has newer release: $job.');
      await _storeScoreCard(job, null);
      return JobStatus.skipped;
    }

    Future<Summary> analyze() async {
      final toolEnvRef = await getOrCreateToolEnvRef();
      try {
        final PackageAnalyzer analyzer =
            PackageAnalyzer(toolEnvRef.toolEnv, urlChecker: _urlChecker);
        final isInternal = internalPackageNames.contains(job.packageName);
        return await analyzer.inspectPackage(
          job.packageName,
          version: job.packageVersion,
          options: InspectOptions(
            isInternal: isInternal,
            pubHostedUrl: activeConfiguration.primaryApiUri.toString(),
            analysisOptionsUri: 'package:pedantic/analysis_options.1.8.0.yaml',
          ),
          logger:
              Logger.detached('pana/${job.packageName}/${job.packageVersion}'),
        );
      } catch (e, st) {
        _logger.severe(
            'Failed (v$packageVersion) - ${job.packageName}/${job.packageVersion}',
            e,
            st);
      } finally {
        await toolEnvRef.release();
      }
      return null;
    }

    Summary summary = await analyze();
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
    await _storeScoreCard(job, summary, flags: scoreCardFlags);

    if (packageStatus.isLatestStable && status != JobStatus.success) {
      reportIssueWithLatest(job, '$status');
    }

    return status;
  }

  Future<void> _storeScoreCard(Job job, Summary summary,
      {List<String> flags}) async {
    await scoreCardBackend.updateReport(
      job.packageName,
      job.packageVersion,
      panaReportFromSummary(summary, flags: flags),
    );
    await scoreCardBackend.updateScoreCard(job.packageName, job.packageVersion);
  }
}

PanaReport panaReportFromSummary(Summary summary, {List<String> flags}) {
  final reportStatus =
      summary == null ? ReportStatus.aborted : ReportStatus.success;
  return PanaReport(
    timestamp: DateTime.now().toUtc(),
    panaRuntimeInfo: summary?.runtimeInfo,
    reportStatus: reportStatus,
    derivedTags: summary?.tags,
    pkgDependencies: summary?.pkgResolution?.dependencies,
    licenseFile: summary?.licenseFile,
    report: summary?.report,
    flags: flags,
  );
}
