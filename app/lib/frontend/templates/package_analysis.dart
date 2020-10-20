// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';
import 'package:pana/models.dart' show Report;

import '../../analyzer/analyzer_client.dart';
import '../../scorecard/models.dart';
import '../../shared/markdown.dart';
import '../../shared/urls.dart' as urls;
import '../../shared/utils.dart';

import '../static_files.dart';

import '_cache.dart';
import 'package_misc.dart';

/// Renders the `views/pkg/analysis/tab.mustache` template.
String renderAnalysisTab(
  String package,
  String sdkConstraint,
  ScoreCardData card,
  AnalysisView analysis, {
  @required int likeCount,
}) {
  if (card == null || analysis == null || !analysis.hasAnalysisData) {
    return '<i>Awaiting analysis to complete.</i>';
  }

  final report = analysis.report;
  final showAwaiting = !card.isSkipped && report == null;
  final Map<String, dynamic> data = {
    'package': package,
    'show_discontinued': card.isDiscontinued,
    'show_outdated': card.isObsolete,
    'show_legacy': card.isLegacy,
    'show_awaiting': showAwaiting,
    'show_analysis': !card.isSkipped && !showAwaiting,
    'analysis_tab_url': urls.pkgScoreUrl(package),
    'date_completed': analysis.timestamp == null
        ? null
        : shortDateFormat.format(analysis.timestamp),
    'granted_points': report?.grantedPoints ?? 0,
    'max_points': report?.maxPoints ?? 0,
    'report_html': _renderReport(report),
    'like_key_figure_html': _renderLikeKeyFigure(likeCount),
    'popularity_key_figure_html':
        _renderPopularityKeyFigure(card.popularityScore),
    'pubpoints_key_figure_html': _renderPubPointsKeyFigure(report),
  };

  return templateCache.renderTemplate('pkg/analysis/tab', data);
}

/// Renders the `views/pkg/analysis/report.mustache` template.
String _renderReport(Report report) {
  if (report?.sections == null) return null;

  String renderSummary(String summary) {
    final updated = summary.split('\n').map((line) {
      if (!line.startsWith('### ')) return line;
      return line
          .replaceFirst(
              '[*]',
              '<img class="report-summary-icon" '
                  'src="${staticUrls.reportOKIconGreen}" />')
          .replaceFirst(
              '[x]',
              '<img class="report-summary-icon" '
                  'src="${staticUrls.reportMissingIconRed}" />')
          .replaceFirst(
              '[~]',
              '<img class="report-summary-icon" '
                  'src="${staticUrls.reportMissingIconYellow}" />');
    }).join('\n');
    return markdownToHtml(updated, disableHashIds: true);
  }

  return templateCache.renderTemplate('pkg/analysis/report', {
    'sections': report.sections.map((s) => {
          'title': s.title,
          'grantedPoints': s.grantedPoints,
          'maxPoints': s.maxPoints,
          'summary_html': renderSummary(s.summary),
          'event-id': 'toggle-report-section-${s.id}',
          'is_green': s.grantedPoints > 0 && s.grantedPoints == s.maxPoints,
          'is_yellow': s.grantedPoints > 0 && s.grantedPoints != s.maxPoints,
          'is_red': s.grantedPoints == 0,
        }),
  });
}

String _renderLikeKeyFigure(int likeCount) {
  // TODO: implement k/m supplemental for values larger than 1000
  return _renderKeyFigure(
    value: '$likeCount',
    supplemental: '',
    label: 'likes',
  );
}

String _renderPopularityKeyFigure(double popularity) {
  return _renderKeyFigure(
    value: formatScore(popularity),
    supplemental: '%',
    label: 'popularity',
  );
}

String _renderPubPointsKeyFigure(Report report) {
  if (report == null) {
    return _renderKeyFigure(
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
  return _renderKeyFigure(
    value: '$grantedPoints',
    supplemental: '/ $maxPoints',
    label: 'pub points',
  );
}

/// Renders the `views/pkg/analysis/key_figure.mustache` template.
String _renderKeyFigure({
  @required String value,
  @required String supplemental,
  @required String label,
}) {
  return templateCache.renderTemplate('pkg/analysis/key_figure', {
    'value': value,
    'supplemental': supplemental,
    'label': label,
  });
}
