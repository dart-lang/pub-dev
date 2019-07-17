// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:pana/pana.dart';
import 'package:pub_semver/pub_semver.dart';

import '../job/backend.dart';
import '../scorecard/backend.dart';
import '../scorecard/models.dart';

import 'urls.dart' as urls;

export 'package:pana/pana.dart' show LicenseFile, PkgDependency, Suggestion;

/// Sets the analyzer client.
void registerAnalyzerClient(AnalyzerClient client) =>
    ss.register(#_analyzerClient, client);

/// The active analyzer client.
AnalyzerClient get analyzerClient =>
    ss.lookup(#_analyzerClient) as AnalyzerClient;

final Logger _logger = Logger('pub.analyzer_client');

/// Client methods that access the analyzer service and the internals of the
/// analysis data. This keeps the interface narrow over the raw analysis data.
class AnalyzerClient {
  Future<AnalysisView> getAnalysisView(String package, String version) async {
    final card = await scoreCardBackend.getScoreCardData(package, version);
    if (card == null) {
      return AnalysisView();
    }
    final reports = await scoreCardBackend.loadReports(
      package,
      version,
      runtimeVersion: card.runtimeVersion,
    );
    final panaReport = reports[ReportType.pana] as PanaReport;
    final dartdocReport = reports[ReportType.dartdoc] as DartdocReport;
    return AnalysisView._(card, panaReport, dartdocReport);
  }

  Future triggerAnalysis(
      String package, String version, Set<String> dependentPackages) async {
    if (jobBackend == null) {
      _logger.warning('Job backend is not initialized!');
      return;
    }
    await jobBackend.trigger(JobService.analyzer, package, version);
    for (final String package in dependentPackages) {
      await jobBackend.trigger(JobService.analyzer, package);
    }
  }
}

class AnalysisView {
  final ScoreCardData _card;
  final PanaReport _pana;
  final DartdocReport _dartdoc;

  AnalysisView._(this._card, this._pana, this._dartdoc);

  factory AnalysisView({
    ScoreCardData card,
    PanaReport panaReport,
    DartdocReport dartdocReport,
  }) =>
      AnalysisView._(card, panaReport, dartdocReport);

  bool get hasAnalysisData => _card != null;
  bool get hasPanaSummary => _pana != null;
  ScoreCardData get card => _card;

  DateTime get timestamp => _pana?.timestamp;
  String get panaReportStatus => _pana?.reportStatus;

  String get dartSdkVersion => _pana?.panaRuntimeInfo?.sdkVersion;
  String get panaVersion => _pana?.panaRuntimeInfo?.panaVersion;
  String get flutterVersion {
    if (_card == null || _pana == null || !_card.usesFlutter) {
      return null;
    }
    final map = _pana?.panaRuntimeInfo?.flutterVersions;
    if (map == null) return null;
    final version = map['frameworkVersion'];
    return version as String;
  }

  List<String> get platforms => _card?.platformTags;
  String get platformsReason => _pana?.platformReason;

  List<LicenseFile> get licenses => _pana?.licenses;

  List<PkgDependency> get directDependencies =>
      _getDependencies(DependencyTypes.direct);

  List<PkgDependency> get transitiveDependencies =>
      _getDependencies(DependencyTypes.transitive);

  List<PkgDependency> get devDependencies =>
      _getDependencies(DependencyTypes.dev);

  List<PkgDependency> get allDependencies => _pana?.pkgDependencies;

  List<PkgDependency> _getDependencies(String type) {
    final List<PkgDependency> list = allDependencies
        ?.where((pd) => pd.dependencyType == type)
        ?.where((pd) => pd.package != _card.packageName)
        ?.toList();
    if (list == null || list.isEmpty) return const [];
    list.sort((a, b) => a.package.compareTo(b.package));
    return list;
  }

  double get health => _card?.healthScore ?? 0.0;

  List<Suggestion> get panaSuggestions => _pana?.panaSuggestions;
  List<Suggestion> get healthSuggestions =>
      _concat([_pana?.healthSuggestions, _dartdoc?.healthSuggestions]);
  List<Suggestion> get maintenanceSuggestions => _concat(
      [_pana?.maintenanceSuggestions, _dartdoc?.maintenanceSuggestions]);

  List<Suggestion> _concat(List<List<Suggestion>> list) =>
      list.where((item) => item != null).expand((list) => list).toList()
        ..sort();

  double get maintenanceScore => _card?.maintenanceScore ?? 0.0;
}

Summary createPanaSummaryForLegacy(String packageName, String packageVersion) {
  return Summary(
      runtimeInfo: PanaRuntimeInfo(),
      packageName: packageName,
      packageVersion: Version.parse(packageVersion),
      pubspec: null,
      pkgResolution: null,
      dartFiles: null,
      platform: null,
      licenses: null,
      health: null,
      maintenance: null,
      suggestions: <Suggestion>[
        Suggestion.error(
          'pubspec.sdk.legacy',
          'Support Dart 2 in `pubspec.yaml`.',
          'The SDK constraint in `pubspec.yaml` doesn\'t allow the Dart 2.0.0 release. '
              'For information about upgrading it to be Dart 2 compatible, please see '
              '[${urls.dartSiteRoot}/dart-2#migration](${urls.dartSiteRoot}/dart-2#migration).',
        ),
      ],
      stats: Stats(
        analyzeProcessElapsed: 0,
        formatProcessElapsed: 0,
        resolveProcessElapsed: 0,
        totalElapsed: 0,
      ));
}
