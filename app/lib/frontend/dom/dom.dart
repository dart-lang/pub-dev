// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:clock/clock.dart';

import '../../shared/markdown.dart';
import '../../shared/utils.dart' show formatXAgo, shortDateFormat;

final _attributeEscape = HtmlEscape(HtmlEscapeMode.attribute);
final _attributeRegExp = RegExp(r'^[a-z](?:[a-z0-9\-\_]*[a-z0-9]+)?$');
final _elementRegExp = _attributeRegExp;

// As we want to store rawJson inside a HTML Element, it is better
// to escape all non-trusteded characters inside it. Non-trusted
// characters must include `</!>` characters.
final _ldJsonEscapedCharactersRegExp = RegExp(r'[^0-9a-zA-Z ,@\.\-]');

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

  /// Creates a DOM node with unsafe raw HTML content.
  Node unsafeRawHtml(String value);
}

void _verifyElementTag(String tag) {
  if (_elementRegExp.matchAsPrefix(tag) == null) {
    throw FormatException('Invalid element tag "$tag".');
  }
}

void _verifyAttributeKeys(String tag, Iterable<String>? keys) {
  if (keys == null) return;
  for (final key in keys) {
    if (_attributeRegExp.matchAsPrefix(key) != null) continue;
    if (tag == 'svg' && key == 'viewBox') continue;
    throw FormatException('Invalid attribute key "$key".');
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
  Node? child,
  String? text,
}) =>
    dom.element(
      tag,
      id: id,
      classes: classes,
      attributes: attributes,
      children: _children(children, child, text),
    );

/// Creates a DOM Text node using the default [DomContext].
Node text(String value) => dom.text(value);

/// Creates a DOM node with unsafe raw HTML content using the default [DomContext].
Node unsafeRawHtml(String value) => dom.unsafeRawHtml(value);

/// Creates a DOM node with the short, formatted x-ago [timestamp].
Node xAgoTimestamp(DateTime timestamp, {String? datePrefix}) {
  final title = [
    if (datePrefix != null) datePrefix,
    shortDateFormat.format(timestamp),
  ].join(' ');
  return a(
    classes: ['-x-ago'],
    href: '',
    title: title,
    attributes: {
      'aria-label': 'Switch between date and elapsed time.',
      'aria-role': 'button',
    },
    text: formatXAgo(clock.now().difference(timestamp)),
  );
}

/// Creates a DOM node with markdown content using the default [DomContext].
Node markdown(
  String text, {
  bool disableHashIds = false,
}) {
  return dom.unsafeRawHtml(markdownToHtml(
    text,
    disableHashIds: disableHashIds,
  )!);
}

/// Creates DOM elements with <pre> and <code> for HLJS and pub.dev's copy-to-clipboard.
Node codeSnippet({
  required String language,
  String? textToCopy,
  Iterable<Node>? children,
  Node? child,
  String? text,
}) {
  return pre(
    attributes: textToCopy == null ? null : {'data-text-to-copy': textToCopy},
    child: code(
      classes: ['language-$language'],
      children: children,
      child: child,
      text: text,
    ),
  );
}

/// Creates a DOM element with ld+json `<script>` content.
Node ldJson(Map<String, dynamic> content) {
  final sb = StringBuffer();

  /// Build the JSON content by manually escaping dangerous characters,
  /// and also building the object and list structures.
  void write(dynamic value) {
    if (value is String) {
      sb.write('"');
      sb.write(value.replaceAllMapped(
        _ldJsonEscapedCharactersRegExp,
        (m) {
          final code = m[0]!.codeUnitAt(0);
          return r'\u' + code.toRadixString(16).padLeft(4, '0');
        },
      ));
      sb.write('"');
    } else if (value is List) {
      sb.write('[');
      for (var i = 0; i < value.length; i++) {
        if (i > 0) sb.write(',');
        write(value[i]);
      }
      sb.write(']');
    } else if (value is Map) {
      final entries = value.entries.toList();
      sb.write('{');
      for (var i = 0; i < entries.length; i++) {
        if (i > 0) sb.write(',');
        write(entries[i].key);
        sb.write(':');
        write(entries[i].value);
      }
      sb.write('}');
    } else if (value is bool || value is num || value == null) {
      sb.write(json.encode(value));
    } else {
      throw ArgumentError(
          'Value `$value` could not be translated to JSON, unexpected type: `${value.runtimeType}`.');
    }
  }

  write(content);
  return script(
    type: 'application/ld+json',
    child: unsafeRawHtml(sb.toString()),
  );
}

/// Creates an `<a>` Element using the default [DomContext].
Node a({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
  String? href,
  String? rel,
  String? target,
  String? title,
}) {
  return dom.element(
    'a',
    id: id,
    classes: classes,
    attributes: <String, String>{
      if (href != null) 'href': href,
      if (rel != null) 'rel': rel,
      if (target != null) 'target': target,
      if (title != null) 'title': title,
      if (attributes != null) ...attributes,
    },
    children: _children(children, child, text),
  );
}

/// Creates a `<b>` Element using the default [DomContext].
Node b({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
}) =>
    dom.element(
      'b',
      id: id,
      classes: classes,
      attributes: attributes,
      children: _children(children, child, text),
    );

/// Creates a `<br>` Element using the default [DomContext].
Node br() => element('br');

/// Creates a `<button>` Element using the default [DomContext].
Node button({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
  String? ariaLabel,
}) =>
    dom.element(
      'button',
      id: id,
      classes: classes,
      attributes: {
        if (ariaLabel != null) 'aria-label': ariaLabel,
        ...?attributes,
      },
      children: _children(children, child, text),
    );

/// Creates a `<code>` Element using the default [DomContext].
Node code({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
}) =>
    dom.element(
      'code',
      id: id,
      classes: classes,
      attributes: attributes,
      children: _children(children, child, text),
    );

/// Creates a `<details>` Element using the default [DomContext].
Node details({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  required Iterable<Node> summary,
  Iterable<Node>? children,
  Node? child,
  String? text,
}) {
  final detailChildren = _children(children, child, text);
  return dom.element(
    'details',
    id: id,
    classes: classes,
    attributes: attributes,
    children: [
      dom.element('summary', children: summary),
      if (detailChildren != null) ...detailChildren,
    ],
  );
}

/// Creates a `<div>` Element using the default [DomContext].
Node div({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
}) =>
    dom.element(
      'div',
      id: id,
      classes: classes,
      attributes: attributes,
      children: _children(children, child, text),
    );

/// Creates an `<form>` Element using the default [DomContext].
Node form({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
  String? action,
  String? method,
}) {
  return dom.element(
    'form',
    id: id,
    classes: classes,
    attributes: <String, String>{
      if (action != null) 'action': action,
      if (method != null) 'method': method,
      if (attributes != null) ...attributes,
    },
    children: _children(children, child, text),
  );
}

/// Creates a `<h1>` Element using the default [DomContext].
Node h1({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
}) =>
    dom.element(
      'h1',
      id: id,
      classes: classes,
      attributes: attributes,
      children: _children(children, child, text),
    );

/// Creates a `<h1>` Element using the default [DomContext].
Node h2({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
}) =>
    dom.element(
      'h2',
      id: id,
      classes: classes,
      attributes: attributes,
      children: _children(children, child, text),
    );

/// Creates a `<h1>` Element using the default [DomContext].
Node h3({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
}) =>
    dom.element(
      'h3',
      id: id,
      classes: classes,
      attributes: attributes,
      children: _children(children, child, text),
    );

/// Creates an `<i>` Element using the default [DomContext].
Node i({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
}) {
  return dom.element(
    'i',
    id: id,
    classes: classes,
    attributes: attributes,
    children: _children(children, child, text),
  );
}

class Image {
  final String src;
  final String alt;
  final int? width;
  final int? height;

  Image({
    required this.src,
    required this.alt,
    required this.width,
    required this.height,
  });
}

/// Creates an `<img>` Element using the default [DomContext].
Node img({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  required Image image,
  String? title,
  bool lazy = false,
}) {
  return dom.element(
    'img',
    id: id,
    classes: classes,
    attributes: <String, String>{
      'src': image.src,
      'alt': image.alt,
      if (image.width != null) 'width': image.width.toString(),
      if (image.height != null) 'height': image.height.toString(),
      if (title != null) 'title': title,
      if (lazy) 'loading': 'lazy',
      if (attributes != null) ...attributes,
    },
    children: children,
  );
}

/// Creates an `<input>` Element using the default [DomContext].
Node input({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
  String? type,
  String? name,
  String? placeholder,
  String? value,
  String? autocomplete,
  bool autofocus = false,
  bool disabled = false,
}) {
  return dom.element(
    'input',
    id: id,
    classes: classes,
    attributes: <String, String>{
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (placeholder != null) 'placeholder': placeholder,
      if (autocomplete != null) 'autocomplete': autocomplete,
      if (value != null) 'value': value,
      if (autofocus) 'autofocus': 'autofocus',
      if (disabled) 'disabled': 'disabled',
      if (attributes != null) ...attributes,
    },
    children: _children(children, child, text),
  );
}

/// Creates a `<label>` Element using the default [DomContext].
Node label({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
}) =>
    dom.element(
      'label',
      id: id,
      classes: classes,
      attributes: attributes,
      children: _children(children, child, text),
    );

/// Creates a `<li>` Element using the default [DomContext].
Node li({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
}) =>
    dom.element(
      'li',
      id: id,
      classes: classes,
      attributes: attributes,
      children: _children(children, child, text),
    );

/// Creates a `<link>` Element using the default [DomContext].
Node link({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
  String? rel,
  String? type,
  String? title,
  String? href,
  String? as,
}) =>
    dom.element(
      'link',
      id: id,
      classes: classes,
      attributes: <String, String>{
        if (rel != null) 'rel': rel,
        if (type != null) 'type': type,
        if (title != null) 'title': title,
        if (href != null) 'href': href,
        if (as != null) 'as': as,
        if (attributes != null) ...attributes,
      },
      children: _children(children, child, text),
    );

/// Creates a `<meta>` Element using the default [DomContext].
Node meta({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
  String? httpEquiv,
  String? name,
  String? property,
  String? charset,
  String? content,
}) =>
    dom.element(
      'meta',
      id: id,
      classes: classes,
      attributes: <String, String>{
        if (httpEquiv != null) 'http-equiv': httpEquiv,
        if (name != null) 'name': name,
        if (property != null) 'property': property,
        if (charset != null) 'charset': charset,
        if (content != null) 'content': content,
        if (attributes != null) ...attributes,
      },
      children: _children(children, child, text),
    );

/// Creates an `<option>` Element using the default [DomContext].
Node option({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
  String? value,
  bool disabled = false,
  bool selected = false,
}) {
  return dom.element(
    'option',
    id: id,
    classes: classes,
    attributes: <String, String>{
      if (value != null) 'value': value,
      if (disabled) 'disabled': 'disabled',
      if (selected) 'selected': 'selected',
      if (attributes != null) ...attributes,
    },
    children: _children(children, child, text),
  );
}

/// Creates a `<p>` Element using the default [DomContext].
Node p({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
}) =>
    dom.element(
      'p',
      id: id,
      classes: classes,
      attributes: attributes,
      children: _children(children, child, text),
    );

/// Creates a `<pre>` Element using the default [DomContext].
Node pre({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
}) =>
    dom.element(
      'pre',
      id: id,
      classes: classes,
      attributes: attributes,
      children: _children(children, child, text),
    );

/// Creates a `<script>` Element using the default [DomContext].
Node script({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
  String? type,
  String? src,
  bool async = false,
  bool defer = false,
}) =>
    dom.element(
      'script',
      id: id,
      classes: classes,
      attributes: <String, String>{
        if (type != null) 'type': type,
        if (src != null) 'src': src,
        if (async) 'async': 'async',
        if (defer) 'defer': 'defer',
        if (attributes != null) ...attributes,
      },
      children: _children(children, child, text),
    );

/// Creates an `<select>` Element using the default [DomContext].
Node select({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
}) {
  return dom.element(
    'select',
    id: id,
    classes: classes,
    attributes: attributes,
    children: _children(children, child, text),
  );
}

/// Creates a `<span>` Element using the default [DomContext].
Node span({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
}) =>
    dom.element(
      'span',
      id: id,
      classes: classes,
      attributes: attributes,
      children: _children(children, child, text),
    );

/// Creates a `<strong>` Element using the default [DomContext].
Node strong({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
}) =>
    dom.element(
      'strong',
      id: id,
      classes: classes,
      attributes: attributes,
      children: _children(children, child, text),
    );

/// Creates a `<table>` Element using the default [DomContext].
Node table({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? head,
  Iterable<Node>? body,
}) =>
    dom.element(
      'table',
      id: id,
      classes: classes,
      attributes: attributes,
      children: [
        if (head != null) dom.element('thead', children: head),
        if (body != null) dom.element('tbody', children: body),
      ],
    );

/// Creates a `<td>` Element using the default [DomContext].
Node td({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
}) =>
    dom.element(
      'td',
      id: id,
      classes: classes,
      attributes: attributes,
      children: _children(children, child, text),
    );

/// Creates a `<th>` Element using the default [DomContext].
Node th({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
  Node? child,
  String? text,
}) =>
    dom.element(
      'th',
      id: id,
      classes: classes,
      attributes: attributes,
      children: _children(children, child, text),
    );

/// Creates a `<tr>` Element using the default [DomContext].
Node tr({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
}) =>
    dom.element(
      'tr',
      id: id,
      classes: classes,
      attributes: attributes,
      children: children,
    );

/// Creates a `<ul>` Element using the default [DomContext].
Node ul({
  String? id,
  Iterable<String>? classes,
  Map<String, String>? attributes,
  Iterable<Node>? children,
}) =>
    dom.element(
      'ul',
      id: id,
      classes: classes,
      attributes: attributes,
      children: children,
    );

Iterable<Node>? _children(Iterable<Node>? children, Node? child, String? text) {
  if (children != null) {
    if (child != null) {
      throw ArgumentError(
          'Only one of `child`, `children` or `text` may be specified');
    }
    if (text != null) {
      throw ArgumentError('`text` is not null');
    }
    return children;
  } else if (child != null) {
    if (text != null) {
      throw ArgumentError('`text` is not null');
    }
    return [child];
  } else if (text != null) {
    return [dom.text(text)];
  } else {
    return null;
  }
}

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
    _verifyAttributeKeys(tag, attributes?.keys);
    return _StringElement(
        tag, _mergeAttributes(id, classes, attributes), children);
  }

  @override
  Node text(String value) => _StringText(value);

  @override
  Node unsafeRawHtml(String value) => _StringRawUnsafeHtml(value);
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
  static const _selfClosing = <String>{
    'area',
    'base',
    'br',
    'col',
    'embed',
    'hr',
    'img',
    'input',
    'link',
    'meta',
    'param',
    'path',
    'source',
    'track',
    'wbr',
  };

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
    } else if (_selfClosing.contains(_tag)) {
      sink.write('/>');
    } else {
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

class _StringRawUnsafeHtml extends _StringNode {
  final String _value;

  _StringRawUnsafeHtml(this._value);

  @override
  void writeHtml(StringSink sink) {
    sink.write(_value);
  }
}
