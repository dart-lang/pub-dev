// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../dom/dom.dart' as d;

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
