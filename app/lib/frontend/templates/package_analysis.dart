// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pana/models.dart' show PanaRuntimeInfo, Report;

import '../../scorecard/models.dart' hide ReportStatus;
import '../../shared/urls.dart' as urls;
import '../../shared/utils.dart';

import '../dom/dom.dart' as d;

import '_cache.dart';
import 'package_misc.dart';
import 'views/pkg/score_tab.dart';

/// Renders the `views/pkg/analysis/tab.mustache` template.
String renderAnalysisTab(
  String? package,
  String? sdkConstraint,
  ScoreCardData? card, {
  required int? likeCount,
}) {
  if (card == null) {
    return '<i>Awaiting analysis to complete.</i>';
  }

  final report = card.getJoinedReport();
  final showAwaiting = !card.isSkipped && report == null;
  final Map<String, dynamic> data = {
    'package': package,
    'show_discontinued': card.isDiscontinued,
    'show_outdated': card.isObsolete,
    'show_legacy': card.isLegacy,
    'show_awaiting': showAwaiting,
    'show_analysis': !card.isSkipped && !showAwaiting,
    'analysis_tab_url': urls.pkgScoreUrl(package!),
    'date_completed': card.panaReport?.timestamp == null
        ? null
        : shortDateFormat.format(card.panaReport!.timestamp!),
    'granted_points': report?.grantedPoints ?? 0,
    'max_points': report?.maxPoints ?? 0,
    'report_html':
        report == null ? null : reportNode(report: report).toString(),
    'like_key_figure_html': _likeKeyFigureNode(likeCount).toString(),
    'popularity_key_figure_html':
        _popularityKeyFigureNode(card.popularityScore).toString(),
    'pubpoints_key_figure_html': _pubPointsKeyFigureNode(report).toString(),
    'tool_env_info_html':
        _renderToolEnvInfo(card.panaReport?.panaRuntimeInfo, card.usesFlutter),
  };

  return templateCache.renderTemplate('pkg/analysis/tab', data);
}

d.Node _likeKeyFigureNode(int? likeCount) {
  // TODO: implement k/m supplemental for values larger than 1000
  return keyFigureNode(
    value: '$likeCount',
    supplemental: '',
    label: 'likes',
  );
}

d.Node _popularityKeyFigureNode(double? popularity) {
  return keyFigureNode(
    value: formatScore(popularity),
    supplemental: '%',
    label: 'popularity',
  );
}

d.Node _pubPointsKeyFigureNode(Report? report) {
  if (report == null) {
    return keyFigureNode(
      value: '',
      supplemental: 'awaiting',
      label: 'pub points',
    );
  }
  var grantedPoints = 0;
  var maxPoints = 0;
  report.sections.forEach((section) {
    grantedPoints += section.grantedPoints;
    maxPoints += section.maxPoints;
  });
  return keyFigureNode(
    value: '$grantedPoints',
    supplemental: '/ $maxPoints',
    label: 'pub points',
  );
}

String? _renderToolEnvInfo(PanaRuntimeInfo? info, bool usesFlutter) {
  if (info == null) return null;
  final flutterVersions = info.flutterVersions;
  final flutterVersion = usesFlutter && flutterVersions != null
      ? flutterVersions['frameworkVersion']
      : null;
  final flutterDartVersion = usesFlutter && flutterVersions != null
      ? flutterVersions['dartSdkVersion']
      : null;
  return toolEnvInfoNode([
    ToolVersionInfo('Pana', info.panaVersion),
    if (flutterVersion != null)
      ToolVersionInfo('Flutter', flutterVersion.toString()),
    ToolVersionInfo('Dart', flutterDartVersion?.toString() ?? info.sdkVersion),
  ]).toString();
}
