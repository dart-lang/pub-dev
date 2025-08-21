// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/format/number_format.dart';

import '../../../dom/dom.dart' as d;

d.Node labeledScoresNode({
  required String package,
  required String pkgScorePageUrl,
  required int likeCount,
  required int? grantedPubPoints,
  required int? thirtyDaysDownloads,
}) {
  final formattedLikes = compactFormat(likeCount);
  final formattedDownloads =
      thirtyDaysDownloads == null ? null : compactFormat(thirtyDaysDownloads);
  return d.a(
    classes: ['packages-scores'],
    href: pkgScorePageUrl,
    children: [
      d.div(
        classes: ['packages-score', 'packages-score-like'],
        child: _labeledScore(
            'likes',
            // keep in-sync with pkg/web_app/lib/src/likes.dart
            '${formattedLikes.value}${formattedLikes.suffix}',
            sign: ''),
        attributes: {'data-package': package},
      ),
      d.div(
        classes: ['packages-score', 'packages-score-health'],
        child: _labeledScore('points', grantedPubPoints?.toString(), sign: ''),
      ),
      d.div(
        attributes: {
          'title': 'Number of downloads of this package during the past 30 days'
        },
        classes: ['packages-score', 'packages-score-downloads'],
        child: _labeledScore(
          'downloads',
          formattedDownloads != null
              ? '${formattedDownloads.value}${formattedDownloads.suffix}'
              : null,
          sign: '',
        ),
      ),
    ],
  );
}

d.Node _labeledScore(String label, String? value, {required String sign}) {
  return d.fragment([
    d.div(
      classes: ['packages-score-value', if (value != null) '-has-value'],
      children: [
        d.span(
          classes: ['packages-score-value-number'],
          text: value ?? '--',
        ),
        d.span(classes: ['packages-score-value-sign'], text: sign),
      ],
    ),
    d.div(classes: ['packages-score-label'], text: label),
  ]);
}
