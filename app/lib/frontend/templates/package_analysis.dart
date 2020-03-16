// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pana/models.dart' show SuggestionLevel;

import '../../analyzer/analyzer_client.dart';
import '../../scorecard/models.dart';
import '../../shared/markdown.dart';
import '../../shared/urls.dart' as urls;
import '../../shared/utils.dart';

import '../color.dart';
import '../request_context.dart';

import '_cache.dart';
import '_consts.dart';
import 'misc.dart';

/// Renders the `views/pkg/analysis/tab.mustache` template.
String renderAnalysisTab(String package, String sdkConstraint,
    ScoreCardData card, AnalysisView analysis) {
  if (card == null || analysis == null || !analysis.hasAnalysisData) {
    return '<i>Awaiting analysis to complete.</i>';
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

  final Map<String, dynamic> data = {
    'package': package,
    'show_discontinued': card.isDiscontinued,
    'show_outdated': card.isObsolete,
    'show_legacy': card.isLegacy,
    'show_analysis': !card.isSkipped,
    'analysis_tab_url': urls.pkgScoreUrl(package),
    'date_completed': analysis.timestamp == null
        ? null
        : shortDateFormat.format(analysis.timestamp),
    'analysis_status': statusText,
    'dart_sdk_version': analysis.dartSdkVersion,
    'pana_version': analysis.panaVersion,
    'flutter_version': analysis.flutterVersion,
    'analysis_suggestions_html':
        _renderSuggestionBlockHtml('Analysis', analysis.panaSuggestions),
    'health_suggestions_html':
        _renderSuggestionBlockHtml('Health', analysis.healthSuggestions),
    'maintenance_suggestions_html': _renderSuggestionBlockHtml(
        'Maintenance', analysis.maintenanceSuggestions),
    'score_table_html': _renderScoreTable(card),
    'dep_table_html': _renderDepTable(sdkConstraint, card, analysis),
  };

  return templateCache.renderTemplate('pkg/analysis/tab', data);
}

String _renderAnalysisDepRow(PkgDependency pd) {
  final emptyFiller = requestContext.isExperimental ? '-' : null;
  return templateCache.renderTemplate('pkg/analysis/dep_row', {
    'is_hosted': pd.isHosted,
    'package': pd.package,
    'package_url': urls.pkgPageUrl(pd.package),
    'constraint': pd.constraint?.toString() ?? emptyFiller,
    'resolved': pd.resolved?.toString() ?? emptyFiller,
    'available': pd.available?.toString() ?? emptyFiller,
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
  return templateCache.renderTemplate('pkg/analysis/suggestion_block', data);
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

String _renderScoreTable(ScoreCardData card) {
  String renderScoreBar(String categoryLabel, double score, Brush brush) {
    return templateCache.renderTemplate('pkg/analysis/score_bar', {
      'category_label': categoryLabel,
      'percent': formatScore(score ?? 0.0),
      'score': formatScore(score),
      // TODO: remove after we've migrated to the new UI
      'background': brush.background.toString(),
      'color': brush.color.toString(),
      'shadow': brush.shadow.toString(),
    });
  }

  final formattedScore = formatScore(card?.overallScore);
  final isSkipped = card?.isSkipped ?? false;
  final healthScore = isSkipped ? null : card?.healthScore;
  final maintenanceScore = isSkipped ? null : card?.maintenanceScore;
  final popularityScore = card?.popularityScore;
  final overallScore = card?.overallScore ?? 0.0;
  final values = {
    'health_html': renderScoreBar(
      'Health',
      healthScore,
      genericScoreBrush(healthScore),
    ),
    'maintenance_html': renderScoreBar(
      'Maintenance',
      maintenanceScore,
      genericScoreBrush(maintenanceScore),
    ),
    'popularity_html': renderScoreBar(
      'Popularity',
      popularityScore,
      genericScoreBrush(popularityScore),
    ),
    'overall_score_circle_html': renderScoreCircle(
      label: formattedScore,
      secondaryLabel: 'Overall',
      percent: (100 * overallScore).round(),
    ),
    // TODO: remove after we've migrated to the new UI
    'overall_html': renderScoreBar(
        'Overall', overallScore, overallScoreBrush(overallScore)),
  };
  return templateCache.renderTemplate('pkg/analysis/score_table', values);
}

String _renderDepTable(
    String sdkConstraint, ScoreCardData card, AnalysisView analysis) {
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

  final values = <String, dynamic>{
    'has_dependency': hasDependency,
    'has_sdk': hasSdkConstraint,
    'sdk': sdkConstraint,
    'has_direct': hasSdkConstraint || directDeps.isNotEmpty,
    'direct': directDeps,
    'has_transitive': transitiveDeps.isNotEmpty,
    'transitive': transitiveDeps,
    'has_dev': devDeps.isNotEmpty,
    'dev': devDeps,
  };
  return templateCache.renderTemplate('pkg/analysis/dep_table', values);
}
