// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../dom/dom.dart' as d;

/// Renders Table of Contents from [nodes].
///
/// The hiearchy of the sections is encoded in [TocNode.children].
d.Node renderToc(Iterable<TocNode> nodes) {
  return d.div(
    classes: ['pub-toc-container'],
    child: d.div(
      classes: ['pub-toc'],
      children: [
        d.div(child: d.b(text: 'Sections')),
        ...nodes.expand((n) => _renderNode(n, 0)),
      ],
    ),
  );
}

Iterable<d.Node> _renderNode(TocNode node, int level) sync* {
  yield d.div(
    classes: ['pub-toc-node', 'pub-toc-node-$level'],
    child: node.href == null
        ? d.text(node.label)
        : d.a(href: node.href, text: node.label),
  );
  if (node.children != null) {
    yield* node.children!.expand((n) => _renderNode(n, level + 1));
  }
}

/// Describes a tree node in the table of contents hierarchy.
class TocNode {
  /// The text label to be display.
  final String label;

  /// The link href to use, if omitted, only a regular text is displayed.
  final String? href;

  /// Children nodes of this node.
  List<TocNode>? children;

  TocNode(
    this.label, {
    this.href,
    this.children,
  });
}
