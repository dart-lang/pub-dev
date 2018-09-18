// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:pana/pana.dart';
import 'package:pana/src/maintenance.dart';
import 'package:pana/src/version.dart' as pana_version;

import '../job/job.dart';
import '../scorecard/backend.dart';
import '../scorecard/models.dart';
import '../shared/analyzer_client.dart'
    show createPanaSummaryForLegacy, getAllSuggestions;
import '../shared/analyzer_service.dart';
import '../shared/dartdoc_client.dart';
import '../shared/packages_overrides.dart';
import '../shared/platform.dart';
import '../shared/tool_env.dart';

import 'backend.dart';
import 'models.dart';

final Logger _logger = new Logger('pub.analyzer.pana');

class AnalyzerJobProcessor extends JobProcessor {
  final _urlChecker = new UrlChecker();

  AnalyzerJobProcessor({Duration lockDuration})
      : super(service: JobService.analyzer, lockDuration: lockDuration);

  @override
  Future<bool> shouldProcess(
      String package, String version, DateTime updated) async {
    final status =
        await analysisBackend.checkTargetStatus(package, version, updated);
    return !status.shouldSkip;
  }

  @override
  Future<JobStatus> process(Job job) async {
    final packageStatus = await analysisBackend.getPackageStatus(
        job.packageName, job.packageVersion);
    if (!packageStatus.exists) {
      _logger.info('Package does not exist: $job.');
      return JobStatus.skipped;
    }

    try {
      await analysisBackend.deleteObsoleteAnalysis(
          job.packageName, job.packageVersion);
    } catch (e) {
      _logger.warning('Analysis GC failed: $job', e);
    }

    final DateTime timestamp = new DateTime.now().toUtc();
    final Analysis analysis =
        new Analysis.init(job.packageName, job.packageVersion, timestamp);

    if (packageStatus.isDiscontinued) {
      _logger.info('Package is discontinued: $job.');
      analysis.analysisStatus = AnalysisStatus.discontinued;
      analysis.maintenanceScore = 0.0;
      await analysisBackend.storeAnalysis(analysis);
      await _storeScoreCard(job, null);
      return JobStatus.skipped;
    }

    if (packageStatus.isObsolete) {
      _logger
          .info('Package is older than two years and has newer release: $job.');
      analysis.analysisStatus = AnalysisStatus.outdated;
      analysis.maintenanceScore = 0.0;
      await analysisBackend.storeAnalysis(analysis);
      await _storeScoreCard(job, null);
      return JobStatus.skipped;
    }

    if (packageStatus.isLegacy) {
      _logger.info('Package is on legacy SDK: $job.');
      analysis.analysisStatus = AnalysisStatus.legacy;
      final summary =
          createPanaSummaryForLegacy(job.packageName, job.packageVersion);
      analysis.analysisJson = summary.toJson();
      analysis.maintenanceScore = 0.0;
      await analysisBackend.storeAnalysis(analysis);
      await _storeScoreCard(job, summary);
      return JobStatus.skipped;
    }

    Future<Summary> analyze() async {
      Directory tempDir;
      final toolEnvRef = await getOrCreateToolEnvRef();
      try {
        tempDir = await Directory.systemTemp.createTemp('pana');
        final PackageAnalyzer analyzer =
            new PackageAnalyzer(toolEnvRef.toolEnv, urlChecker: _urlChecker);
        final isInternal = internalPackageNames.contains(job.packageName);
        return await analyzer.inspectPackage(
          job.packageName,
          version: job.packageVersion,
          options: new InspectOptions(isInternal: isInternal),
          logger: new Logger.detached(
              'pana/${job.packageName}/${job.packageVersion}'),
        );
      } catch (e, st) {
        _logger.severe(
            'Failed (v${pana_version.packageVersion}) - ${job.packageVersion}/${job.packageVersion}',
            e,
            st);
      } finally {
        if (tempDir != null) {
          await tempDir.delete(recursive: true);
        }
        await toolEnvRef.release();
      }
      return null;
    }

    Summary summary = await analyze();
    final bool firstRunWithErrors =
        summary?.suggestions?.where((s) => s.isError)?.isNotEmpty ?? false;
    if (summary == null || firstRunWithErrors) {
      _logger.info('Retrying $job...');
      await new Future.delayed(new Duration(seconds: 15));
      summary = await analyze();
    }

    JobStatus status = JobStatus.failed;
    Summary scoreCardSummary = summary;
    if (summary == null) {
      analysis.analysisStatus = AnalysisStatus.aborted;
    } else {
      summary = applyPlatformOverride(summary);
      scoreCardSummary =
          await _expandSummary(summary, packageStatus.age, false);
      summary = await _expandSummary(summary, packageStatus.age, true);
      final isLegacy = summary.suggestions?.any(_isLegacy) ?? false;
      final bool lastRunWithErrors =
          summary.suggestions?.where((s) => s.isError)?.isNotEmpty ?? false;
      if (isLegacy) {
        analysis.analysisStatus = AnalysisStatus.legacy;
        analysis.maintenanceScore = 0.0;
      } else if (!lastRunWithErrors) {
        analysis.analysisStatus = AnalysisStatus.success;
        status = JobStatus.success;
      } else {
        analysis.analysisStatus = AnalysisStatus.failure;
      }
      analysis.analysisJson = summary.toJson();
      analysis.maintenanceScore ??=
          getMaintenanceScore(summary.maintenance) / 100.0;
    }

    final backendStatus = await analysisBackend.storeAnalysis(analysis);
    await _storeScoreCard(job, scoreCardSummary);

    if (backendStatus.isLatestStable &&
        analysis.analysisStatus != AnalysisStatus.success &&
        analysis.analysisStatus != AnalysisStatus.discontinued) {
      reportIssueWithLatest(job, '${analysis.analysisStatus}');
    }

    return status;
  }

  bool _isLegacy(Suggestion s) {
    final isVersionFailed = s.isError &&
        s.code == SuggestionCode.pubspecDependenciesFailedToResolve &&
        s.description != null &&
        s.description.contains('version solving failed');
    if (!isVersionFailed) {
      return false;
    }
    // Version resolution failure does not automatically indicate that a package
    // is not compatible with the latest Dart SDK. However, if the description has
    // patterns like "requires SDK version 1.8.0" or "requires SDK version <0.9.0",
    // then we can classify them as legacy packages. E.g. a typical pattern was:
    //
    // ERR: The current Dart SDK version is 2.0.0.
    // Because [A] >=0.2.3 <0.4.0 depends on [B] >=0.2.1 which requires SDK version <2.0.0, [A] >=0.2.3 <0.4.0 is forbidden.
    // So, because [C] depends on [A] ^0.2.3, version solving failed.
    return s.description.contains('requires SDK version 0.') ||
        s.description.contains('requires SDK version <0.') ||
        s.description.contains('requires SDK version 1.') ||
        s.description.contains('requires SDK version <1.') ||
        s.description.contains('requires SDK version <2.0.0');
  }

  Future<Summary> _expandSummary(
      Summary summary, Duration age, bool fetchDartdocData) async {
    if (summary.maintenance != null) {
      final suggestions =
          new List<Suggestion>.from(summary.maintenance.suggestions ?? []);

      // age suggestion
      final ageSuggestion = getAgeSuggestion(age);
      if (ageSuggestion != null) {
        suggestions.add(ageSuggestion);
      }

      bool dartdocSuccessful;
      if (fetchDartdocData) {
        // dartdoc status
        final dartdocEntry = await dartdocClient.getEntry(
            summary.packageName, summary.packageVersion.toString());
        if (dartdocEntry != null) {
          dartdocSuccessful = dartdocEntry.hasContent;
          if (!dartdocSuccessful) {
            suggestions.add(getDartdocRunFailedSuggestion());
          }
        }
      }

      suggestions.sort();
      final maintenance = summary.maintenance.change(
          dartdocSuccessful: dartdocSuccessful, suggestions: suggestions);
      summary = summary.change(maintenance: maintenance);
    }
    return summary;
  }

  Future _storeScoreCard(Job job, Summary summary) async {
    final reportStatus =
        summary == null ? ReportStatus.aborted : ReportStatus.success;
    await scoreCardBackend.updateReport(
        job.packageName,
        job.packageVersion,
        new PanaReport(
          timestamp: new DateTime.now().toUtc(),
          panaRuntimeInfo: summary?.runtimeInfo,
          reportStatus: reportStatus,
          healthScore: summary?.health?.healthScore ?? 0.0,
          maintenanceScore:
              summary == null ? 0.0 : getMaintenanceScore(summary.maintenance),
          platformTags: indexDartPlatform(summary?.platform),
          platformReason: summary?.platform?.reason,
          pkgDependencies: summary?.pkgResolution?.dependencies,
          suggestions: getAllSuggestions(summary),
          licenses: summary?.licenses,
        ));
    await scoreCardBackend.updateScoreCard(job.packageName, job.packageVersion);
  }
}
