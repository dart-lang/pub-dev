// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/data/download_counts_data.dart';
import 'package:_pub_shared/format/number_format.dart';
import 'package:pana/models.dart';
import 'package:pub_dev/service/download_counts/backend.dart';
import 'package:pub_dev/shared/utils.dart';

import '../../../../scorecard/models.dart' hide ReportStatus;
import '../../../../shared/urls.dart' as urls;
import '../../../dom/dom.dart' as d;
import '../../../dom/material.dart';
import '../../../static_files.dart';
import '../../_consts.dart';

/// Renders the score page content.
d.Node scoreTabNode({
  required String package,
  required String version,
  required int? likeCount,
  required ScoreCardData? card,
  required bool usesFlutter,
  required bool isLatestStable,
}) {
  if (card == null) {
    return d.i(text: 'Awaiting analysis to complete.');
  }

  final report = card.report;
  final showReport = report != null;
  final showPending =
      !showReport &&
      (card.isPending || (card.hasNoTaskStatus && isLatestStable));
  final showNoReport = !showReport && !showPending;

  final toolEnvInfo = showReport
      ? _renderToolEnvInfoNode(card.panaReport?.panaRuntimeInfo, usesFlutter)
      : null;
  return d.fragment([
    d.div(
      classes: ['score-key-figures'],
      children: [
        _likeKeyFigureNode(likeCount),
        _pubPointsKeyFigureNode(report, showPending),
        _downloadCountsKeyFigureNode(
          downloadCountsBackend.lookup30DaysTotalCounts(package),
        ),
      ],
    ),
    if (showPending)
      d.p(
        classes: ['analysis-info'],
        text: 'The analysis of the package has not been completed yet.',
      )
    else if (showNoReport)
      d.p(
        classes: ['analysis-info'],
        children: [
          d.text('This package version is not analyzed. Check the '),
          d.a(
            href: urls.pkgScoreUrl(card.packageName!),
            text: 'latest stable version',
          ),
          d.text(' for its analysis.'),
        ],
      )
    else
      d.fragment([
        d.p(
          classes: ['analysis-info'],
          children: [
            d.text('We analyzed this package '),
            if (card.panaReport?.timestamp != null)
              d.xAgoTimestamp(card.panaReport!.timestamp!, datePrefix: 'on'),
            d.text(
              ', '
              'and awarded it ${report!.grantedPoints} '
              'pub points (of a possible ${report.maxPoints}):',
            ),
          ],
        ),
        _reportNode(report),
        if (toolEnvInfo != null) toolEnvInfo,
      ]),
    if (!showPending)
      d.p(
        classes: ['analysis-info'],
        children: [
          d.text('Check the '),
          d.a(
            href: urls.pkgScoreLogTxtUrl(
              package,
              version: isLatestStable ? null : version,
            ),
            text: 'analysis log',
            rel: 'nofollow',
          ),
          d.text(' for details.'),
        ],
      ),
    if (card.weeklyVersionDownloads != null)
      _downloadsChart(card.weeklyVersionDownloads!),
  ]);
}

/// Renders the report on the score page.
d.Node _reportNode(Report report) {
  return d.div(
    classes: ['pkg-report'],
    children: report.sections.map(_section),
  );
}

d.Node _section(ReportSection section) {
  return d.fragment([
    d.div(
      classes: ['pkg-report-section', 'foldable'],
      children: [
        d.div(
          classes: ['pkg-report-header', 'foldable-button'],
          attributes: {
            'data-ga-click-event': 'toggle-report-section-${section.id}',
          },
          children: [
            d.div(
              classes: ['pkg-report-header-icon'],
              child: d.img(
                classes: ['pkg-report-icon'],
                image: d.Image(
                  src: switch (section.status) {
                    ReportStatus.passed => staticUrls.reportOKIconGreen,
                    ReportStatus.partial => staticUrls.reportMissingIconYellow,
                    ReportStatus.failed => staticUrls.reportMissingIconRed,
                  },
                  alt: switch (section.status) {
                    ReportStatus.passed => 'Passed report section',
                    ReportStatus.partial => 'Partially passed report section',
                    ReportStatus.failed => 'Failed report section',
                  },
                  width: 18,
                  height: 18,
                ),
              ),
            ),
            d.div(classes: ['pkg-report-header-title'], text: section.title),
            d.div(
              classes: [
                'pkg-report-header-score',
                if (section.status == ReportStatus.partial) '-is-yellow',
                if (section.status == ReportStatus.failed) '-is-red',
              ],
              children: [
                d.span(
                  classes: ['pkg-report-header-score-granted'],
                  text: '${section.grantedPoints}',
                ),
                d.text(' / '),
                d.span(
                  classes: ['pkg-report-header-score-max'],
                  text: '${section.maxPoints}',
                ),
                d.img(
                  classes: ['foldable-icon'],
                  image: d.Image(
                    src: staticUrls.getAssetUrl(
                      '/static/img/foldable-section-icon.svg',
                    ),
                    alt: 'trigger folding of the section',
                    width: 13,
                    height: 6,
                  ),
                ),
              ],
            ),
          ],
        ),
        d.div(
          classes: ['foldable-content'],
          child: d.div(
            classes: ['pkg-report-content'],
            child: d.div(
              classes: ['pkg-report-content-summary', 'markdown-body'],
              child: d.markdown(
                _updatedSummary(section.summary),
                strictPruning: true,
              ),
            ),
          ),
        ),
      ],
    ),
  ]);
}

d.Node _downloadsChart(WeeklyVersionDownloadCounts weeklyVersionDownloads) {
  final versionModes = d.div(
    classes: ['downloads-chart-version-modes'],
    children: [
      radioButtons(
        leadingText: 'By versions: ',
        name: 'version-modes',
        radios: [
          (id: 'version-modes-major', value: 'major', label: 'Major'),
          (id: 'version-modes-minor', value: 'minor', label: 'Minor'),
          (id: 'version-modes-patch', value: 'patch', label: 'Patch'),
        ],
        classes: ['downloads-chart-radio-button'],
        initialValue: 'major',
      ),
    ],
  );

  final displayModes = d.div(
    classes: ['downloads-chart-display-modes'],
    children: [
      radioButtons(
        leadingText: 'Display as: ',
        name: 'display-modes',
        radios: [
          (
            id: 'display-modes-unstacked',
            value: 'unstacked',
            label: 'Unstacked',
          ),
          (id: 'version-modes-stacked', value: 'stacked', label: 'Stacked'),
          (
            id: 'version-modes-percentage',
            value: 'percentage',
            label: 'Percentage',
          ),
        ],
        classes: ['downloads-chart-radio-button'],
        initialValue: 'unstacked',
      ),
    ],
  );
  final container = d.div(
    classes: ['downloads-chart'],
    id: '-downloads-chart',
    attributes: {
      'data-widget': 'downloads-chart',
      'data-downloads-chart-points': base64Encode(
        jsonUtf8Encoder.convert(weeklyVersionDownloads),
      ),
      'data-downloads-chart-versions-radio': 'version-modes',
      'data-downloads-chart-display-radio': 'display-modes',
    },
  );

  return d.fragment([
    d.h1(text: 'Weekly downloads'),
    displayModes,
    versionModes,
    container,
  ]);
}

String _updatedSummary(String summary) {
  return summary
      .split('\n')
      .map((line) {
        if (!line.startsWith('### ')) return line;
        return line
            .replaceFirst(
              '[*]',
              '<img class="report-summary-icon" '
                  'alt="Passed check" '
                  'src="${staticUrls.reportOKIconGreen}" />',
            )
            .replaceFirst(
              '[x]',
              '<img class="report-summary-icon" '
                  'alt="Failed check" '
                  'src="${staticUrls.reportMissingIconRed}" />',
            )
            .replaceFirst(
              '[~]',
              '<img class="report-summary-icon" '
                  'alt="Partially passed check" '
                  'src="${staticUrls.reportMissingIconYellow}" />',
            );
      })
      .join('\n');
}

d.Node? _renderToolEnvInfoNode(PanaRuntimeInfo? info, bool usesFlutter) {
  if (info == null) return null;
  final flutterVersion = usesFlutter ? info.flutterVersion : null;
  final flutterDartVersion = usesFlutter
      ? info.flutterInternalDartSdkVersion
      : null;
  return _toolEnvInfoNode([
    _ToolVersionInfo('Pana', info.panaVersion),
    if (flutterVersion != null)
      _ToolVersionInfo('Flutter', flutterVersion.toString()),
    _ToolVersionInfo('Dart', flutterDartVersion?.toString() ?? info.sdkVersion),
  ]);
}

class _ToolVersionInfo {
  final String name;
  final String version;

  _ToolVersionInfo(this.name, this.version);
}

d.Node _toolEnvInfoNode(List<_ToolVersionInfo> values) {
  final nodes = <d.Node>[];
  for (var i = 0; i < values.length; i++) {
    if (i > 0) nodes.add(d.text(', '));
    nodes.addAll([
      d.text('${values[i].name} '),
      d.code(text: values[i].version),
    ]);
  }
  return d.p(
    classes: ['tool-env-info'],
    children: [d.text('Analyzed with '), ...nodes, d.text('.')],
  );
}

d.Node _likeKeyFigureNode(int? likeCount) {
  if (likeCount == null) {
    return _keyFigureNode(value: '--', supplemental: '', label: 'likes');
  }
  final formatted = compactFormat(likeCount);
  // keep in-sync with pkg/web_app/lib/src/likes.dart
  return _keyFigureNode(
    value: '${formatted.value}${formatted.suffix}',
    supplemental: '',
    label: 'likes',
    classes: ['score-key-figure--likes'],
  );
}

d.Node _downloadCountsKeyFigureNode(int? downloadCounts) {
  if (downloadCounts == null) {
    return _keyFigureNode(
      value: '--',
      supplemental: '',
      label: 'downloads',
      title: titleFor30DaysDownloadCounts,
    );
  }
  return _keyFigureNode(
    value:
        '${compactFormat(downloadCounts).value}'
        '${compactFormat(downloadCounts).suffix}',
    supplemental: '',
    label: 'downloads',
    title: titleFor30DaysDownloadCounts,
  );
}

d.Node _pubPointsKeyFigureNode(Report? report, bool showPending) {
  if (report == null) {
    return _keyFigureNode(
      value: showPending ? '' : '-',
      supplemental: showPending ? 'pending' : '/ -',
      label: 'pub points',
    );
  }
  var grantedPoints = 0;
  var maxPoints = 0;
  report.sections.forEach((section) {
    grantedPoints += section.grantedPoints;
    maxPoints += section.maxPoints;
  });
  return _keyFigureNode(
    value: '$grantedPoints',
    supplemental: '/ $maxPoints',
    label: 'pub points',
  );
}

d.Node _keyFigureNode({
  required String value,
  required String supplemental,
  required String label,
  String? title,
  List<String>? classes,
}) {
  final attributes = title == null ? null : {'title': title};
  return d.div(
    classes: ['score-key-figure', ...?classes],
    attributes: attributes,
    children: [
      d.div(
        classes: ['score-key-figure-title'],
        children: [
          d.span(classes: ['score-key-figure-value'], text: value),
          d.span(
            classes: ['score-key-figure-supplemental'],
            text: supplemental,
          ),
        ],
      ),
      d.div(classes: ['score-key-figure-label'], text: label),
    ],
  );
}
