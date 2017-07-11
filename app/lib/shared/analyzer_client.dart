// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:pana/pana.dart';
// TODO: fix pana so that we won't need to import from src/
import 'package:pana/src/platform.dart' show KnownPlatforms;

import 'analyzer_service.dart';

// TODO: fix pana so that we won't need to import from src/
export 'package:pana/src/platform.dart' show KnownPlatforms;

/// Sets the analyzer client.
void registerAnalyzerClient(AnalyzerClient client) =>
    ss.register(#_analyzerClient, client);

/// The active analyzer client.
AnalyzerClient get analyzerClient => ss.lookup(#_analyzerClient);

final Logger _logger = new Logger('pub.analyzer_client');

/// Client methods that access the analyzer service and the internals of the
/// analysis data. This keeps the interface narrow over the raw analysis data.
class AnalyzerClient {
  final http.Client _client = new http.Client();
  final String _analyzerServiceHttpHostPort;
  AnalyzerClient(this._analyzerServiceHttpHostPort);

  /// Gets the analysis data from the analyzer service via HTTP.
  Future<AnalysisData> getAnalysisData(String package, String version) async {
    final String uri =
        '$_analyzerServiceHttpHostPort/packages/$package/$version';
    try {
      final http.Response rs = await _client.get(uri);
      if (rs.statusCode == 200) {
        return new AnalysisData.fromJson(JSON.decode(rs.body));
      }
    } catch (e, st) {
      _logger.warning('Analysis request failed on $uri', e, st);
    }
    return null;
  }

  Future close() async {
    _client.close();
  }
}

class AnalysisReport {
  AnalysisData _analysisData;
  PlatformReport _platformReport;

  AnalysisReport({PlatformReport platformReport})
      : _platformReport = platformReport;

  AnalysisReport.fromAnalysis(this._analysisData);

  PlatformReport get platformReport =>
      _platformReport ??= _extractPlatformReport();

  PlatformReport _extractPlatformReport() {
    if (_analysisData == null || _analysisData.analysisContent == null) {
      return null;
    }
    final Summary summary = new Summary.fromJson(_analysisData.analysisContent);

    final Set<String> uses = new Set();
    final Set<String> worksOn = new Set();
    final Set<String> conflictsWith = new Set();

    bool worksEverywhere = true;
    bool worksAnywhere = false;
    for (DartFileSummary dfs in summary.dartFiles.values) {
      // Files in `lib/src` do not have their platform field populated.
      // TODO: use a proper flag after pana got updated with it
      if (dfs.platform == null) continue;
      if (!dfs.platform.worksEverywhere || dfs.platform.hasConflict) {
        worksEverywhere = false;
      }
      if (dfs.platform.worksAnywhere) worksAnywhere = true;
      uses.addAll(dfs.platform.uses);

      void addWorks(bool works, String platform) {
        if (works) {
          worksOn.add(platform);
        } else {
          conflictsWith.add(platform);
        }
      }

      addWorks(dfs.platform.worksInBrowser, KnownPlatforms.browser);
      addWorks(dfs.platform.worksInConsole, KnownPlatforms.console);
      addWorks(dfs.platform.worksInFlutter, KnownPlatforms.flutter);
    }
    worksEverywhere = worksEverywhere && conflictsWith.isEmpty;

    return new PlatformReport(
      worksEverywhere: worksEverywhere,
      worksAnywhere: worksAnywhere,
      uses: uses.toList()..sort(),
      worksOn: worksOn.toList()..sort(),
      conflictsWith: conflictsWith.toList()..sort(),
    );
  }
}

// TODO: Backport this into pana and include in the Summary, after we stabilize
//       on the use of this.
class PlatformReport {
  final bool worksEverywhere;
  final bool worksAnywhere;
  final List<String> uses;
  final List<String> worksOn;
  final List<String> conflictsWith;

  PlatformReport({
    this.worksEverywhere,
    this.worksAnywhere,
    this.uses,
    this.worksOn,
    this.conflictsWith,
  });
}
