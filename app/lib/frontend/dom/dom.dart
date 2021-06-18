// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.12

import 'dart:convert';

final _attributeEscape = HtmlEscape(HtmlEscapeMode.attribute);
final _attributeRegExp = RegExp(r'^[a-z](?:[a-z0-9\-\_]*[a-z0-9]+)?$');
final _elementRegExp = _attributeRegExp;

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
    String? id,
    Iterable<String>? classes,
    Map<String, String>? attributes,
    Iterable<Node>? children,
  });

  /// Creates a DOM Text node.
  Node text(String value);
}

void _verifyElementTag(String tag) {
  if (_elementRegExp.matchAsPrefix(tag) == null) {
    throw FormatException('Invalid element tag "$tag".');
  }
}

void _verifyAttributeKeys(Iterable<String>? keys) {
  if (keys == null) return;
  for (final key in keys) {
    if (_attributeRegExp.matchAsPrefix(key) == null) {
      throw FormatException('Invalid attribute key "$key".');
    }
  }
}

/// Creates a DOM fragment from the list of [children] nodes using the default [DomContext].
Node fragment(Iterable<Node> children) => dom.fragment(children);

/// Creates a DOM Element using the default [DomContext].
Node element(
  String tag, {
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
}) =>
    dom.element(
      tag,
      id: id,
      classes: classes,
      attributes: attributes,
      children: children,
    );

/// Creates a DOM Text node using the default [DomContext].
Node text(String value) => dom.text(value);

/// Creates a `<div>` Element using the default [DomContext].
Node div({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
}) =>
    dom.element(
      'div',
      id: id,
      classes: classes,
      attributes: attributes,
      children: children,
    );

/// Creates a `<span>` Element using the default [DomContext].
Node span({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
}) =>
    dom.element(
      'span',
      id: id,
      classes: classes,
      attributes: attributes,
      children: children,
    );

/// Uses DOM nodes to emit escaped HTML string.
class _StringDomContext extends DomContext {
  @override
  Node fragment(Iterable<Node> children) => _StringNodeList(children);

  @override
  Node element(
    String tag, {
    String? id,
    Iterable<String>? classes,
    Map<String, String>? attributes,
    Iterable<Node>? children,
  }) {
    _verifyElementTag(tag);
    _verifyAttributeKeys(attributes?.keys);
    return _StringElement(
        tag, _mergeAttributes(id, classes, attributes), children);
  }

  @override
  Node text(String value) => _StringText(value);
}

Map<String, String>? _mergeAttributes(
    String? id, Iterable<String>? classes, Map<String, String>? attributes) {
  final hasClasses = classes != null && classes.isNotEmpty;
  final hasAttributes =
      id != null || hasClasses || (attributes != null && attributes.isNotEmpty);
  if (!hasAttributes) return null;
  return <String, String>{
    if (id != null) 'id': id,
    if (classes != null && classes.isNotEmpty) 'class': classes.join(' '),
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
  final String _tag;
  final Map<String, String>? _attributes;
  final List<_StringNode>? _children;

  _StringElement(this._tag, this._attributes, Iterable<Node>? children)
      : _children = children?.cast<_StringNode>().toList();

  @override
  void writeHtml(StringSink sink) {
    sink.write('<$_tag');
    if (_attributes != null) {
      for (final e in _attributes!.entries) {
        sink.write(' ${e.key}="${_attributeEscape.convert(e.value)}"');
      }
    }
    final hasChildren = _children != null && _children!.isNotEmpty;
    if (hasChildren) {
      sink.write('>');
      for (final child in _children!) {
        child.writeHtml(sink);
      }
      sink.write('</$_tag>');
    } else {
      // TODO: implement self-closing elements
      // TODO: implement non-closing elements
      sink.write('></$_tag>');
    }
  }
}

class _StringText extends _StringNode {
  final String _value;

  _StringText(this._value);

  @override
  void writeHtml(StringSink sink) {
    sink.write(htmlEscape.convert(_value));
  }
}
