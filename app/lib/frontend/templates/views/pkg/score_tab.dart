// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pana/models.dart';

import '../../../dom/dom.dart' as d;
import '../../../static_files.dart';

/// Renders the report on the score page.
d.Node reportNode({required Report report}) {
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
                src: _statusIconUrls[section.status],
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
                  src: staticUrls
                      .getAssetUrl('/static/img/report-foldable-icon.svg'),
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

class ToolVersionInfo {
  final String name;
  final String version;

  ToolVersionInfo(this.name, this.version);
}

d.Node toolEnvInfoNode(List<ToolVersionInfo> values) {
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

d.Node keyFigureNode({
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
