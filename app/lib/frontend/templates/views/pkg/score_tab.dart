// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pana/models.dart';

import '../../../../scorecard/models.dart' hide ReportStatus;
import '../../../../shared/urls.dart' as urls;
import '../../../dom/dom.dart' as d;
import '../../../static_files.dart';
import '../../package_misc.dart' show formatScore;

/// Renders the score page content.
d.Node scoreTabNode({
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
  final showPending = report == null && (card.isPending || isLatestStable);
  final showNoReport = !showReport && !showPending;

  final toolEnvInfo = showReport
      ? _renderToolEnvInfoNode(card.panaReport?.panaRuntimeInfo, usesFlutter)
      : null;
  return d.fragment([
    d.div(
      classes: ['score-key-figures'],
      children: [
        _likeKeyFigureNode(likeCount),
        _pubPointsKeyFigureNode(report),
        _popularityKeyFigureNode(card.popularityScore),
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
            d.text(', '
                'and awarded it ${report!.grantedPoints} '
                'pub points (of a possible ${report.maxPoints}):'),
          ],
        ),
        _reportNode(report),
        if (toolEnvInfo != null) toolEnvInfo,
        d.p(
          classes: ['analysis-info'],
          children: [
            d.text('You can check the '),
            d.a(href: 'score/log.txt', text: 'analysis log'),
            d.text(' for more details.'),
          ],
        ),
      ]),
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
                  src: _statusIconUrls[section.status]!,
                  alt: 'icon indicating section status',
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
                    text: '${section.grantedPoints}'),
                d.text(' / '),
                d.span(
                    classes: ['pkg-report-header-score-max'],
                    text: '${section.maxPoints}'),
                d.img(
                  classes: ['foldable-icon'],
                  image: d.Image(
                    src: staticUrls
                        .getAssetUrl('/static/img/report-foldable-icon.svg'),
                    alt: 'icon to trigger folding of the section',
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
                disableHashIds: true,
              ),
            ),
          ),
        ),
      ],
    ),
  ]);
}

final _statusIconUrls = {
  ReportStatus.passed:
      staticUrls.getAssetUrl('/static/img/report-ok-icon-green.svg'),
  ReportStatus.partial:
      staticUrls.getAssetUrl('/static/img/report-missing-icon-yellow.svg'),
  ReportStatus.failed:
      staticUrls.getAssetUrl('/static/img/report-missing-icon-red.svg'),
};

String _updatedSummary(String summary) {
  return summary.split('\n').map((line) {
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
}

d.Node? _renderToolEnvInfoNode(PanaRuntimeInfo? info, bool usesFlutter) {
  if (info == null) return null;
  final flutterVersion = usesFlutter ? info.flutterVersion : null;
  final flutterDartVersion =
      usesFlutter ? info.flutterInternalDartSdkVersion : null;
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
    children: [
      d.text('Analysed with '),
      ...nodes,
      d.text('.'),
    ],
  );
}

d.Node _likeKeyFigureNode(int? likeCount) {
  // TODO: implement k/m supplemental for values larger than 1000
  return _keyFigureNode(
    value: '$likeCount',
    supplemental: '',
    label: 'likes',
  );
}

d.Node _popularityKeyFigureNode(double? popularity) {
  return _keyFigureNode(
    value: formatScore(popularity),
    supplemental: '%',
    label: 'popularity',
  );
}

d.Node _pubPointsKeyFigureNode(Report? report) {
  if (report == null) {
    return _keyFigureNode(
      value: '',
      supplemental: 'pending',
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
}) {
  return d.div(
    classes: ['score-key-figure'],
    children: [
      d.div(
        classes: ['score-key-figure-title'],
        children: [
          d.span(
            classes: ['score-key-figure-value'],
            text: value,
          ),
          d.span(
            classes: ['score-key-figure-supplemental'],
            text: supplemental,
          ),
        ],
      ),
      d.div(
        classes: ['score-key-figure-label'],
        text: label,
      ),
    ],
  );
}
