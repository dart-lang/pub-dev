// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../dom/dom.dart' as d;
import '../../_consts.dart';

d.Node renderSortControlNode({
  required List<SortDict> options,
  required SortDict selected,
}) {
  return d.div(
    classes: ['sort-control', 'hoverable'],
    children: [
      d.div(
        classes: ['info-identifier'],
        attributes: {'title': selected.tooltip},
        children: [
          d.text('Sort by '),
          d.span(
            classes: ['sort-control-selected'],
            children: [d.text(selected.label)],
          ),
        ],
      ),
      d.div(
        classes: ['sort-control-popup'],
        children: options.map(
          (o) => d.div(
            classes: [
              'sort-control-option',
              if (o == selected) 'selected',
            ],
            attributes: {'data-value': o.id},
            children: [d.text(o.label)],
          ),
        ),
      ),
    ],
  );
}
