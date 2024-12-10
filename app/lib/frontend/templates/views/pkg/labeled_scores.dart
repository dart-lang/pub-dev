// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/format/number_format.dart';
import 'package:pub_dev/frontend/request_context.dart';
import 'package:pub_dev/shared/popularity_storage.dart';

import '../../../dom/dom.dart' as d;

d.Node labeledScoresNode({
  required String pkgScorePageUrl,
  required int likeCount,
  required int? grantedPubPoints,
  required int? popularity,
  required int? thirtyDaysDownloads,
}) {
  return d.a(
    classes: ['packages-scores'],
    href: pkgScorePageUrl,
    children: [
      d.div(
        classes: ['packages-score', 'packages-score-like'],
        child: _labeledScore(
            'likes',
            '${compactFormat(likeCount).value}'
                '${compactFormat(likeCount).suffix}',
            sign: ''),
      ),
      d.div(
        classes: ['packages-score', 'packages-score-health'],
        child: _labeledScore('points', grantedPubPoints?.toString(), sign: ''),
      ),
      requestContext.experimentalFlags.showDownloadCounts
          ? d.div(
              attributes: {
                'title':
                    'Number of downloads of this package during the past 30 days'
              },
              classes: ['packages-score', 'packages-score-downloads'],
              child: _labeledScore(
                'downloads',
                thirtyDaysDownloads != null
                    ? '${compactFormat(thirtyDaysDownloads).value}'
                        '${compactFormat(thirtyDaysDownloads).suffix}'
                    : null,
                sign: '',
              ),
            )
          : d.div(
              classes: ['packages-score', 'packages-score-popularity'],
              child: _labeledScore(
                'popularity',
                popularityStorage.isInvalid ? null : popularity.toString(),
                sign: popularityStorage.isInvalid ? '' : '%',
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
