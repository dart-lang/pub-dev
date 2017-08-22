// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:pana/pana.dart';

import 'analyzer_service.dart';
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

class AnalysisView {
  final AnalysisData _data;
  final Summary _summary;

  AnalysisView(this._data)
      : _summary = new Summary.fromJson(_data.analysisContent);

  DateTime get timestamp => _data.timestamp;
  AnalysisStatus get analysisStatus => _data.analysisStatus;

  String get licenseText {
    final String text = _summary?.license?.toString();
    if (text == LicenseNames.unknown || text == LicenseNames.missing) {
      return null;
    }
    return text;
  }

  List<String> getDependencies() {
    final List<String> list = _summary.pubSummary.packageVersions.keys.toList();
    list.remove(_summary.packageName);
    list.sort();
    return list;
  }
}
