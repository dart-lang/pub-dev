// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../../audit/models.dart';
import '../../../../shared/utils.dart';
import '../../../dom/dom.dart' as d;

d.Node renderActivityLog({
  required String baseUrl,
  required AuditLogRecordPage activities,
  required String forCategory,
  String? forEntity,
}) {
  return d.fragment([
    d.p(children: [
      d.text('List of activities relevant to $forCategory'),
      if (forEntity != null) d.code(children: [d.text(forEntity)]),
      d.text('. '),
      d.text('Events other than package publication expire after 2 months.'),
    ]),
    _renderActivityLogTable(activities),
    if (activities.hasNextPage)
      _renderNextPage(baseUrl, activities.nextTimestamp!),
  ]);
}

d.Node _renderActivityLogTable(AuditLogRecordPage activities) {
  return d.table(
    classes: ['activity-log-table'],
    head: [
      d.tr(children: [
        d.th(classes: ['acdate'], children: [d.text('')]),
        d.th(classes: ['summary'], children: [d.text('Summary')]),
      ]),
    ],
    body: activities.records.map(
      (a) => d.tr(
        children: [
          d.td(
              classes: ['date'],
              children: [d.text(shortDateFormat.format(a.created!))]),
          d.td(
            classes: ['summary'],
            children: [
              d.div(
                classes: ['markdown-body'],
                children: [d.markdown(a.summary!)],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

d.Node _renderNextPage(String baseUrl, String nextTimestamp) {
  final nextUri = Uri.parse(baseUrl).replace(
    queryParameters: {'before': nextTimestamp},
  );
  return d.p(children: [
    d.a(
      href: nextUri.toString(),
      children: [
        d.text('More...'),
      ],
    ),
  ]);
}
