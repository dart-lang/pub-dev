// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../dom/dom.dart' as d;

d.Node renderLabeledScoresNode({
  required String pkgScorePageUrl,
  required int? likeCount,
  required int? grantedPubPoints,
  required int? popularity,
}) {
  return d.a(
    classes: ['packages-scores'],
    href: pkgScorePageUrl,
    children: [
      d.div(
        classes: ['packages-score', 'packages-score-like'],
        child: _renderLabeledScore('likes', likeCount, ''),
      ),
      d.div(
        classes: ['packages-score', 'packages-score-health'],
        child: _renderLabeledScore('pub points', grantedPubPoints, ''),
      ),
      d.div(
        classes: ['packages-score', 'packages-score-popularity'],
        child: _renderLabeledScore('popularity', popularity, '%'),
      ),
    ],
  );
}

d.Node _renderLabeledScore(String label, int? value, String sign) {
  return d.fragment([
    d.div(
      classes: ['packages-score-value', if (value != null) '-has-value'],
      children: [
        d.span(
          classes: ['packages-score-value-number'],
          text: value?.toString() ?? '--',
        ),
        d.span(classes: ['packages-score-value-sign'], text: sign),
      ],
    ),
    d.div(classes: ['packages-score-label'], text: label),
  ]);
}
