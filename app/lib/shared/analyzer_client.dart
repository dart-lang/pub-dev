// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:pana/pana.dart';

import 'package:pub_dartlang_org/analyzer/versions.dart';

import 'analyzer_memcache.dart';
import 'analyzer_service.dart';
import 'memcache.dart' show analyzerDataLocalExpiration;
import 'notification.dart' show notifyService;
import 'platform.dart';
import 'popularity_storage.dart';
import 'utils.dart';

export 'package:pana/pana.dart' show LicenseFile, PkgDependency, Suggestion;
export 'analyzer_service.dart';

/// Sets the analyzer client.
void registerAnalyzerClient(AnalyzerClient client) =>
    ss.register(#_analyzerClient, client);

/// The active analyzer client.
AnalyzerClient get analyzerClient => ss.lookup(#_analyzerClient);

final Logger _logger = new Logger('pub.analyzer_client');

/// Client methods that access the analyzer service and the internals of the
/// analysis data. This keeps the interface narrow over the raw analysis data.
class AnalyzerClient {
  final int _extractCacheSize = 10000;
  final Map<AnalysisKey, AnalysisExtract> _extractCache = {};
  final http.Client _client = new http.Client();
  final String _analyzerServiceHttpHostPort;
  AnalyzerClient(this._analyzerServiceHttpHostPort);

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
        return new AnalysisExtract.fromJson(JSON.decode(cachedExtract));
      } catch (e, st) {
        _logger.severe('Unable to parse analysis extract for $key', e, st);
      }
    }
    final view = await getAnalysisView(key);
    if (!view.hasAnalysisData) {
      return null;
    }
    final extract = new AnalysisExtract(
      popularity: popularityStorage.lookup(key.package) ?? 0.0,
      maintenance: view.maintenanceScore,
      health: view.health,
      platforms: view.platforms,
      timestamp: new DateTime.now().toUtc(),
    );
    await analyzerMemcache?.setExtract(
        key.package, key.version, JSON.encode(extract.toJson()));
    return extract;
  }

  /// Gets the analysis data from the analyzer service via HTTP.
  Future<AnalysisData> getAnalysisData(AnalysisKey key) async {
    if (key == null) return null;
    final String cachedContent = await analyzerMemcache?.getContent(
        key.package, key.version, panaVersion);
    if (cachedContent != null) {
      try {
        return new AnalysisData.fromJson(JSON.decode(cachedContent));
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
        final AnalysisData data =
            new AnalysisData.fromJson(JSON.decode(content));
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
    await notifyService(
        _client, _analyzerServiceHttpHostPort, package, version);

    for (final String package in dependentPackages) {
      await notifyService(_client, _analyzerServiceHttpHostPort, package, null);
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
        summary = new Summary.fromJson(data.analysisContent);
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

  bool get hasAnalysisData => _summary != null;

  DateTime get timestamp => _data.timestamp;
  AnalysisStatus get analysisStatus => _data.analysisStatus;

  String get dartSdkVersion => _summary.sdkVersion.toString();
  String get panaVersion => _summary.panaVersion.toString();
  String get flutterVersion =>
      _summary?.flutterVersion != null ? _data.flutterVersion : null;

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

  double get health => _summary?.fitness?.healthScore ?? 0.0;

  List<Suggestion> get suggestions => _summary?.suggestions;

  double get maintenanceScore => _data?.maintenanceScore ?? 0.0;
}
