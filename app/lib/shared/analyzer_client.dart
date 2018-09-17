// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:pana/pana.dart';
import 'package:pub_semver/pub_semver.dart';

import '../job/backend.dart';

import 'analyzer_memcache.dart';
import 'analyzer_service.dart';
import 'configuration.dart';
import 'memcache.dart' show analyzerDataLocalExpiration;
import 'platform.dart';
import 'popularity_storage.dart';
import 'utils.dart';
import 'versions.dart';

export 'package:pana/pana.dart' show LicenseFile, PkgDependency, Suggestion;
export 'analyzer_service.dart';

/// Sets the analyzer client.
void registerAnalyzerClient(AnalyzerClient client) =>
    ss.register(#_analyzerClient, client);

/// The active analyzer client.
AnalyzerClient get analyzerClient =>
    ss.lookup(#_analyzerClient) as AnalyzerClient;

final Logger _logger = new Logger('pub.analyzer_client');

/// Client methods that access the analyzer service and the internals of the
/// analysis data. This keeps the interface narrow over the raw analysis data.
class AnalyzerClient {
  final int _extractCacheSize = 10000;
  final Map<AnalysisKey, AnalysisExtract> _extractCache = {};
  final http.Client _client = new http.Client();
  String get _analyzerServiceHttpHostPort =>
      activeConfiguration.analyzerServicePrefix;

  Future<List<AnalysisView>> getAnalysisViews(Iterable<AnalysisKey> keys) {
    return Future.wait(keys.map(getAnalysisView));
  }

  Future<AnalysisView> getAnalysisView(AnalysisKey key) async {
    return new AnalysisView(await getAnalysisData(key));
  }

  Future<List<AnalysisExtract>> getAnalysisExtracts(
      Iterable<AnalysisKey> keys) {
    return Future.wait(keys.map(getAnalysisExtract));
  }

  Future<AnalysisExtract> getAnalysisExtract(AnalysisKey key) async {
    if (key == null) return null;
    final cached = _extractCache[key];
    if (cached?.timestamp != null) {
      final now = new DateTime.now().toUtc();
      final diff = now.difference(cached.timestamp);
      if (diff < analyzerDataLocalExpiration) {
        return cached;
      } else {
        _extractCache.remove(key);
      }
    }
    final extract = await _getAnalysisExtract(key);
    if (extract != null) {
      while (_extractCache.length >= _extractCacheSize) {
        _extractCache.remove(_extractCache.keys.first);
      }
      _extractCache[key] = extract;
    }
    return extract;
  }

  Future<AnalysisExtract> _getAnalysisExtract(AnalysisKey key) async {
    if (key == null) return null;
    final String cachedExtract =
        await analyzerMemcache?.getExtract(key.package, key.version);
    if (cachedExtract != null) {
      try {
        final cached = new AnalysisExtract.fromJson(
            json.decode(cachedExtract) as Map<String, dynamic>);
        // return the cached version only if status is populated (ignoring the
        // cache values from the previous version).
        // TODO: remove this check in the next release
        if (cached != null && cached.analysisStatus != null) {
          return cached;
        }
      } catch (e, st) {
        _logger.severe('Unable to parse analysis extract for $key', e, st);
      }
    }
    final view = await getAnalysisView(key);
    AnalysisExtract extract;
    if (!view.hasAnalysisData) {
      return null;
    } else if (!view.hasPanaSummary) {
      extract = new AnalysisExtract(
        analysisStatus: view.analysisStatus,
        timestamp: new DateTime.now().toUtc(),
      );
    } else {
      extract = new AnalysisExtract(
        analysisStatus: view.analysisStatus,
        popularity: popularityStorage?.lookup(key.package) ?? 0.0,
        maintenance: view.maintenanceScore,
        health: view.health,
        platforms: view.platforms,
        timestamp: new DateTime.now().toUtc(),
      );
    }
    await analyzerMemcache?.setExtract(
        key.package, key.version, json.encode(extract.toJson()));
    return extract;
  }

  /// Gets the analysis data from the analyzer service via HTTP.
  Future<AnalysisData> getAnalysisData(AnalysisKey key) async {
    if (key == null) return null;
    final String cachedContent = await analyzerMemcache?.getContent(
        key.package, key.version, panaVersion);
    if (cachedContent != null) {
      try {
        return new AnalysisData.fromJson(
            json.decode(cachedContent) as Map<String, dynamic>);
      } catch (e, st) {
        _logger.severe('Unable to parse analysis data for $key', e, st);
      }
    }
    final String uri =
        '$_analyzerServiceHttpHostPort/packages/${key.package}/${key.version}?panaVersion=$panaVersion';
    try {
      final http.Response rs = await getUrlWithRetry(_client, uri);
      if (rs.statusCode == 200) {
        final String content = rs.body;
        final AnalysisData data = new AnalysisData.fromJson(
            json.decode(content) as Map<String, dynamic>);
        await analyzerMemcache?.setContent(
            key.package, key.version, panaVersion, content);
        return data;
      }
    } catch (e, st) {
      _logger.shout('Analysis request failed on $uri', e, st);
    }
    return null;
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

  Future close() async {
    _client.close();
  }
}

class AnalysisView {
  final AnalysisData _data;
  final Summary _summary;

  AnalysisView._(this._data, this._summary);

  factory AnalysisView(AnalysisData data) {
    Summary summary;
    try {
      if (data != null &&
          data.analysisStatus != AnalysisStatus.aborted &&
          data.analysisContent != null) {
        summary =
            applyPlatformOverride(new Summary.fromJson(data.analysisContent));
      }
    } catch (e, st) {
      // don't block on faulty serialization
      _logger.warning(
          'Unable to read analysis content for package: '
          '${data.packageName} ${data.packageVersion}',
          e,
          st);
    }
    return new AnalysisView._(data, summary);
  }

  bool get hasAnalysisData => _data != null;
  bool get hasPanaSummary => _summary != null;

  DateTime get timestamp => _data?.timestamp;
  AnalysisStatus get analysisStatus => _data?.analysisStatus;

  String get dartSdkVersion => _summary?.runtimeInfo?.sdkVersion;
  String get panaVersion => _data?.panaVersion;
  String get flutterVersion =>
      (_summary?.pubspec?.usesFlutter ?? false) ? _data.flutterVersion : null;

  List<String> get platforms => indexDartPlatform(_summary?.platform);
  String get platformsReason => _summary?.platform?.reason;

  List<LicenseFile> get licenses => _summary?.licenses;

  List<PkgDependency> get directDependencies =>
      _getDependencies(DependencyTypes.direct);

  List<PkgDependency> get transitiveDependencies =>
      _getDependencies(DependencyTypes.transitive);

  List<PkgDependency> get devDependencies =>
      _getDependencies(DependencyTypes.dev);

  List<PkgDependency> get allDependencies =>
      _summary?.pkgResolution?.dependencies;

  List<PkgDependency> _getDependencies(String type) {
    final List<PkgDependency> list = _summary?.pkgResolution?.dependencies
        ?.where((pd) => pd.dependencyType == type)
        ?.where((pd) => pd.package != _summary.packageName)
        ?.toList();
    if (list == null || list.isEmpty) return const [];
    list.sort((a, b) => a.package.compareTo(b.package));
    return list;
  }

  double get health {
    if (_data == null || _summary == null) {
      return 0.0;
    }
    if (_data.analysisStatus == AnalysisStatus.legacy) {
      return 0.0;
    }
    return _summary?.health?.healthScore ?? 0.0;
  }

  List<Suggestion> get suggestions => getAllSuggestions(_summary);

  double get maintenanceScore => _data?.maintenanceScore ?? 0.0;
}

List<Suggestion> getAllSuggestions(Summary summary) {
  if (summary == null) return null;
  final list = <Suggestion>[];
  if (summary.suggestions != null) {
    list.addAll(summary.suggestions);
  }
  if (summary.health?.suggestions != null) {
    list.addAll(summary.health.suggestions);
  }
  if (summary.maintenance?.suggestions != null) {
    list.addAll(summary.maintenance.suggestions);
  }
  list.sort();
  return list;
}

Summary createPanaSummaryForLegacy(String packageName, String packageVersion) {
  return new Summary(
      runtimeInfo: new PanaRuntimeInfo(),
      packageName: packageName,
      packageVersion: new Version.parse(packageVersion),
      pubspec: null,
      pkgResolution: null,
      dartFiles: null,
      platform: null,
      licenses: null,
      health: null,
      maintenance: null,
      suggestions: <Suggestion>[
        new Suggestion.error(
          'pubspec.sdk.legacy',
          'Support Dart 2 in `pubspec.yaml`.',
          'The SDK constraint in `pubspec.yaml` doesn\'t allow the Dart 2.0.0 release. '
              'For information about upgrading it to be Dart 2 compatible, please see '
              '[https://www.dartlang.org/dart-2#migration](https://www.dartlang.org/dart-2#migration).',
        ),
      ],
      stats: new Stats(
        analyzeProcessElapsed: 0,
        formatProcessElapsed: 0,
        resolveProcessElapsed: 0,
        totalElapsed: 0,
      ));
}
