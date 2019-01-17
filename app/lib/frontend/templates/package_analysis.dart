// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pana/models.dart' show SuggestionLevel;

import '../../scorecard/models.dart';
import '../../shared/analyzer_client.dart';
import '../../shared/markdown.dart';
import '../../shared/urls.dart' as urls;
import '../../shared/utils.dart';

import '../color.dart';
import '../template_consts.dart';

import '_cache.dart';
import 'misc.dart';

/// Renders the `views/pkg/analysis_tab.mustache` template.
String renderAnalysisTab(String package, String sdkConstraint,
    ScoreCardData card, AnalysisView analysis) {
  if (card == null || analysis == null || !analysis.hasAnalysisData) {
    return null;
  }

  String statusText;
  switch (analysis.panaReportStatus) {
    case ReportStatus.aborted:
      statusText = 'aborted';
      break;
    case ReportStatus.failed:
      statusText = 'tool failures';
      break;
    case ReportStatus.success:
      statusText = 'completed';
      break;
    default:
      break;
  }

  List<Map> prepareDependencies(List<PkgDependency> list) {
    if (list == null || list.isEmpty) return const [];
    return list.map((pd) => {'row_html': _renderAnalysisDepRow(pd)}).toList();
  }

  final hasSdkConstraint = sdkConstraint != null && sdkConstraint.isNotEmpty;
  final directDeps = prepareDependencies(analysis.directDependencies);
  final transitiveDeps = prepareDependencies(analysis.transitiveDependencies);
  final devDeps = prepareDependencies(analysis.devDependencies);
  final hasDependency = hasSdkConstraint ||
      directDeps.isNotEmpty ||
      transitiveDeps.isNotEmpty ||
      devDeps.isNotEmpty;

  final Map<String, dynamic> data = {
    'package': package,
    'show_discontinued': card.isDiscontinued,
    'show_outdated': card.isObsolete,
    'show_legacy': card.isLegacy,
    'show_analysis': !card.isSkipped,
    'analysis_tab_url': urls.analysisTabUrl(package),
    'date_completed': analysis.timestamp == null
        ? null
        : shortDateFormat.format(analysis.timestamp),
    'analysis_status': statusText,
    'dart_sdk_version': analysis.dartSdkVersion,
    'pana_version': analysis.panaVersion,
    'flutter_version': analysis.flutterVersion,
    'platforms_html': analysis.platforms
            ?.map((p) => getPlatformDict(p, nullIfMissing: true)?.name ?? p)
            ?.join(', ') ??
        '<i>unsure</i>',
    'platforms_reason_html': markdownToHtml(analysis.platformsReason, null),
    'analysis_suggestions_html':
        _renderSuggestionBlockHtml('Analysis', analysis.panaSuggestions),
    'health_suggestions_html':
        _renderSuggestionBlockHtml('Health', analysis.healthSuggestions),
    'maintenance_suggestions_html': _renderSuggestionBlockHtml(
        'Maintenance', analysis.maintenanceSuggestions),
    'has_dependency': hasDependency,
    'dependencies': {
      'has_sdk': hasSdkConstraint,
      'sdk': sdkConstraint,
      'has_direct': hasSdkConstraint || directDeps.isNotEmpty,
      'direct': directDeps,
      'has_transitive': transitiveDeps.isNotEmpty,
      'transitive': transitiveDeps,
      'has_dev': devDeps.isNotEmpty,
      'dev': devDeps,
    },
    'score_bars': _renderScoreBars(card),
  };

  return templateCache.renderTemplate('pkg/analysis_tab', data);
}

String _renderAnalysisDepRow(PkgDependency pd) {
  return templateCache.renderTemplate('pkg/analysis_dep_row', {
    'is_hosted': pd.isHosted,
    'package': pd.package,
    'package_url': urls.pkgPageUrl(pd.package),
    'constraint': pd.constraint?.toString(),
    'resolved': pd.resolved?.toString(),
    'available': pd.available?.toString(),
  });
}

String _renderSuggestionBlockHtml(String header, List<Suggestion> suggestions) {
  if (suggestions == null || suggestions.isEmpty) {
    return null;
  }

  final hasIssues = suggestions.any((s) => s.isError || s.isWarning);
  final label =
      hasIssues ? '$header issues and suggestions' : '$header suggestions';

  final mappedValues = suggestions.map((suggestion) {
    return {
      'icon_class': _suggestionIconClass(suggestion.level),
      'title_html': _renderSuggestionTitle(suggestion.title, suggestion.score),
      'description_html': markdownToHtml(suggestion.description, null),
      'suggestion_help_html': getSuggestionHelpMessage(suggestion.code),
    };
  }).toList();

  final data = <String, dynamic>{
    'label': label,
    'suggestions': mappedValues,
  };
  return templateCache.renderTemplate('pkg/analysis_suggestion_block', data);
}

String _suggestionIconClass(String level) {
  if (level == null) return 'suggestion-icon-info';
  switch (level) {
    case SuggestionLevel.error:
      return 'suggestion-icon-danger';
    case SuggestionLevel.warning:
      return 'suggestion-icon-warning';
    default:
      return 'suggestion-icon-info';
  }
}

String _renderSuggestionTitle(String title, double score) {
  final formattedScore = _formatSuggestionScore(score);
  if (formattedScore != null) {
    title = '$title ($formattedScore)';
  }
  return markdownToHtml(title, null);
}

String _formatSuggestionScore(double score) {
  if (score == null || score == 0.0) {
    return null;
  }
  final intValue = score.round();
  final isInt = intValue.toDouble() == score;
  final formatted = isInt ? intValue.toString() : score.toStringAsFixed(2);
  return '-$formatted points';
}

Map<String, dynamic> _renderScoreBars(ScoreCardData card) {
  String renderScoreBar(double score, Brush brush) {
    return templateCache.renderTemplate('pkg/score_bar', {
      'percent': formatScore(score ?? 0.0),
      'score': formatScore(score),
      'background': brush.background.toString(),
      'color': brush.color.toString(),
      'shadow': brush.shadow.toString(),
    });
  }

  final isSkipped = card?.isSkipped ?? false;
  final healthScore = isSkipped ? null : card?.healthScore;
  final maintenanceScore = isSkipped ? null : card?.maintenanceScore;
  final popularityScore = card?.popularityScore;
  final overallScore = card?.overallScore ?? 0.0;
  return {
    'health_html': renderScoreBar(healthScore, genericScoreBrush(healthScore)),
    'maintenance_html':
        renderScoreBar(maintenanceScore, genericScoreBrush(maintenanceScore)),
    'popularity_html':
        renderScoreBar(popularityScore, genericScoreBrush(popularityScore)),
    'overall_html':
        renderScoreBar(overallScore, overallScoreBrush(overallScore)),
  };
}
