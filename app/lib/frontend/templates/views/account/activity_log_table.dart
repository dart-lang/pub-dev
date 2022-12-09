// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../../audit/models.dart';
import '../../../dom/dom.dart' as d;

d.Node activityLogNode({
  required String baseUrl,
  required AuditLogRecordPage activities,
  required String forCategory,
  String? forEntity,
}) {
  return d.fragment([
    d.p(children: [
      d.text('List of activities relevant to $forCategory'),
      if (forEntity != null) d.code(text: forEntity),
      d.text('. '),
      d.text('Events other than package publication expire after 2 months.'),
    ]),
    _activityLogTableNode(activities),
    if (activities.hasNextPage)
      _nextPageNode(baseUrl, activities.nextTimestamp!),
  ]);
}

d.Node _activityLogTableNode(AuditLogRecordPage activities) {
  final lastShortTermIndex =
      activities.records.lastIndexWhere((r) => r.isKeptShortTerm);
  final shortTermRecords =
      activities.records.take(lastShortTermIndex + 1).toList();
  final longTermRecords =
      activities.records.skip(lastShortTermIndex + 1).toList();
  final displaySeparator =
      shortTermRecords.isNotEmpty && longTermRecords.isNotEmpty;
  print([
    shortTermRecords.length,
    longTermRecords.length,
    activities.records.length,
    displaySeparator,
  ]);

  return d.table(
    classes: ['activity-log-table'],
    head: [
      d.tr(children: [
        d.th(classes: ['acdate'], text: ''),
        d.th(classes: ['summary'], text: 'Summary'),
      ]),
    ],
    body: [
      ...shortTermRecords.map(_recordNode),
      if (displaySeparator)
        d.tr(
          children: [
            d.td(classes: ['date'], text: ''),
            d.td(
              classes: ['summary'],
              text:
                  'Only package publication events are retained past 2 months.',
            ),
          ],
        ),
      ...longTermRecords.map(_recordNode),
    ],
  );
}

d.Node _recordNode(AuditLogRecord a) {
  return d.tr(
    children: [
      d.td(classes: ['date'], child: d.xAgoTimestamp(a.created!)),
      d.td(
        classes: ['summary'],
        children: [
          d.div(
            classes: ['markdown-body'],
            child: d.markdown(a.summary!),
          ),
        ],
      ),
    ],
  );
}

d.Node _nextPageNode(String baseUrl, String nextTimestamp) {
  final nextUri = Uri.parse(baseUrl).replace(
    queryParameters: {'before': nextTimestamp},
  );
  return d.p(
    child: d.a(href: nextUri.toString(), text: 'More...'),
  );
}
