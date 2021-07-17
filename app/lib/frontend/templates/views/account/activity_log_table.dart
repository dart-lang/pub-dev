// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/audit/models.dart';
import 'package:pub_dev/shared/markdown.dart';
import 'package:pub_dev/shared/utils.dart';

import '../../../dom/dom.dart' as d;

d.Node renderActivityLog({
  required Iterable<AuditLogRecord> activities,
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
  ]);
}

d.Node _renderActivityLogTable(Iterable<AuditLogRecord> activities) {
  return d.table(
    classes: ['activity-log-table'],
    head: [
      d.tr(children: [
        d.th(classes: ['acdate'], children: [d.text('')]),
        d.th(classes: ['summary'], children: [d.text('Summary')]),
      ]),
    ],
    body: activities.map((a) => d.tr(
          children: [
            d.td(
                classes: ['date'],
                children: [d.text(shortDateFormat.format(a.created!))]),
            d.td(
              classes: ['summary'],
              children: [
                d.div(classes: [
                  'markdown-body'
                ], children: [
                  d.rawUnsafeHtml(markdownToHtml(a.summary!)!),
                ]),
              ],
            ),
          ],
        )),
  );
}
