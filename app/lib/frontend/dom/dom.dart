// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

final _attributeEscape = HtmlEscape(HtmlEscapeMode.attribute);

/// The DOM context to use while constructing nodes.
///
/// Override this in browser.
DomContext dom = _StringDomContext();

/// Opaque entity for DOM nodes.
abstract class Node {}

/// Factory class to create DOM [Node]s.
abstract class DomContext {
  /// Creates a DOM fragment from the list of [children] nodes.
  Node fragment(Iterable<Node> children);

  /// Creates a DOM Element.
  Node element(
    String tag, {
    String id,
    Iterable<String> classes,
    Map<String, String> attributes,
    Iterable<Node> children,
  });

  /// Creates a DOM Text node.
  Node text(String value);
}

extension DomContextExt on DomContext {
  Node div({
    String id,
    Iterable<String> classes,
    Map<String, String> attributes,
    Iterable<Node> children,
  }) =>
      element(
        'div',
        id: id,
        classes: classes,
        attributes: attributes,
        children: children,
      );

  Node span({
    String id,
    Iterable<String> classes,
    Map<String, String> attributes,
    Iterable<Node> children,
  }) =>
      element(
        'span',
        id: id,
        classes: classes,
        attributes: attributes,
        children: children,
      );
}

/// Uses DOM nodes to emit escaped HTML string.
class _StringDomContext extends DomContext {
  @override
  Node fragment(Iterable<Node> children) => _StringNodeList(children);

  @override
  Node element(
    String tag, {
    String id,
    Iterable<String> classes,
    Map<String, String> attributes,
    Iterable<Node> children,
  }) =>
      _StringElement(tag, _mergeAttributes(id, classes, attributes), children);

  @override
  Node text(String value) => _StringText(value);
}

Map<String, String> _mergeAttributes(
    String id, Iterable<String> classes, Map<String, String> attributes) {
  final hasClasses = classes != null && classes.isNotEmpty;
  final hasAttributes =
      id != null || hasClasses || (attributes != null && attributes.isNotEmpty);
  if (!hasAttributes) return null;
  return <String, String>{
    if (id != null) 'id': id,
    if (hasClasses) 'class': classes.join(' '),
    if (attributes != null) ...attributes,
  };
}

abstract class _StringNode extends Node {
  void writeHtml(StringSink sink);

  @override
  String toString() {
    final sb = StringBuffer();
    writeHtml(sb);
    return sb.toString();
  }
}

class _StringNodeList extends _StringNode {
  final List<_StringNode> _children;

  _StringNodeList(Iterable<Node> children)
      : _children = children.cast<_StringNode>().toList();

  @override
  void writeHtml(StringSink sink) {
    for (final node in _children) {
      node.writeHtml(sink);
    }
  }
}

class _StringElement extends _StringNode {
  final String tag;
  final Map<String, String> attributes;
  final List<_StringNode> _children;

  _StringElement(this.tag, this.attributes, Iterable<Node> children)
      : _children = children.cast<_StringNode>().toList();

  @override
  void writeHtml(StringSink sink) {
    sink.write('<$tag');
    if (attributes != null) {
      for (final e in attributes.entries) {
        sink.write(' ${e.key}="${_attributeEscape.convert(e.value)}"');
      }
    }
    final hasChildren = _children != null && _children.isNotEmpty;
    if (hasChildren) {
      sink.write('>');
      for (final child in _children) {
        child.writeHtml(sink);
      }
      sink.write('</$tag>');
    } else {
      // TODO: implement self-closing elements
      // TODO: implement non-closing elements
      sink.write('></$tag>');
    }
  }
}

class _StringText extends _StringNode {
  final String value;

  _StringText(this.value);

  @override
  void writeHtml(StringSink sink) {
    sink.write(htmlEscape.convert(value));
  }
}
