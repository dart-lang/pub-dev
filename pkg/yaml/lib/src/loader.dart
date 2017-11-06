// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:charcode/ascii.dart';
import 'package:source_span/source_span.dart';

import 'equality.dart';
import 'event.dart';
import 'parser.dart';
import 'yaml_document.dart';
import 'yaml_exception.dart';
import 'yaml_node.dart';

/// A loader that reads [Event]s emitted by a [Parser] and emits
/// [YamlDocument]s.
///
/// This is based on the libyaml loader, available at
/// https://github.com/yaml/libyaml/blob/master/src/loader.c. The license for
/// that is available in ../../libyaml-license.txt.
class Loader {
  /// The underlying [Parser] that generates [Event]s.
  final Parser _parser;

  /// Aliases by the alias name.
  final _aliases = new Map<String, YamlNode>();

  /// The span of the entire stream emitted so far.
  FileSpan get span => _span;
  FileSpan _span;

  /// Creates a loader that loads [source].
  ///
  /// [sourceUrl] can be a String or a [Uri].
  Loader(String source, {sourceUrl})
      : _parser = new Parser(source, sourceUrl: sourceUrl) {
    var event = _parser.parse();
    _span = event.span;
    assert(event.type == EventType.STREAM_START);
  }

  /// Loads the next document from the stream.
  ///
  /// If there are no more documents, returns `null`.
  YamlDocument load() {
    if (_parser.isDone) return null;

    var event = _parser.parse();
    if (event.type == EventType.STREAM_END) {
      _span = _span.expand(event.span);
      return null;
    }

    var document = _loadDocument(event);
    _span = _span.expand(document.span);
    _aliases.clear();
    return document;
  }

  /// Composes a document object.
  YamlDocument _loadDocument(DocumentStartEvent firstEvent) {
    var contents = _loadNode(_parser.parse());

    var lastEvent = _parser.parse() as DocumentEndEvent;
    assert(lastEvent.type == EventType.DOCUMENT_END);

    return new YamlDocument.internal(
        contents,
        firstEvent.span.expand(lastEvent.span),
        firstEvent.versionDirective,
        firstEvent.tagDirectives,
        startImplicit: firstEvent.isImplicit,
        endImplicit: lastEvent.isImplicit);
  }

  /// Composes a node.
  YamlNode _loadNode(Event firstEvent) {
    switch (firstEvent.type) {
      case EventType.ALIAS:
        return _loadAlias(firstEvent);
      case EventType.SCALAR:
        return _loadScalar(firstEvent);
      case EventType.SEQUENCE_START:
        return _loadSequence(firstEvent);
      case EventType.MAPPING_START:
        return _loadMapping(firstEvent);
      default:
        throw "Unreachable";
    }
  }

  /// Registers an anchor.
  void _registerAnchor(String anchor, YamlNode node) {
    if (anchor == null) return;

    // libyaml throws an error for duplicate anchors, but example 7.1 makes it
    // clear that they should be overridden:
    // http://yaml.org/spec/1.2/spec.html#id2786448.

    _aliases[anchor] = node;
  }

  /// Composes a node corresponding to an alias.
  YamlNode _loadAlias(AliasEvent event) {
    var alias = _aliases[event.name];
    if (alias != null) return alias;

    throw new YamlException("Undefined alias.", event.span);
  }

  /// Composes a scalar node.
  YamlNode _loadScalar(ScalarEvent scalar) {
    var node;
    if (scalar.tag == "!") {
      node = new YamlScalar.internal(scalar.value, scalar);
    } else if (scalar.tag != null) {
      node = _parseByTag(scalar);
    } else {
      node = _parseScalar(scalar);
    }

    _registerAnchor(scalar.anchor, node);
    return node;
  }

  /// Composes a sequence node.
  YamlNode _loadSequence(SequenceStartEvent firstEvent) {
    if (firstEvent.tag != "!" &&
        firstEvent.tag != null &&
        firstEvent.tag != "tag:yaml.org,2002:seq") {
      throw new YamlException("Invalid tag for sequence.", firstEvent.span);
    }

    var children = <YamlNode>[];
    var node =
        new YamlList.internal(children, firstEvent.span, firstEvent.style);
    _registerAnchor(firstEvent.anchor, node);

    var event = _parser.parse();
    while (event.type != EventType.SEQUENCE_END) {
      children.add(_loadNode(event));
      event = _parser.parse();
    }

    setSpan(node, firstEvent.span.expand(event.span));
    return node;
  }

  /// Composes a mapping node.
  YamlNode _loadMapping(MappingStartEvent firstEvent) {
    if (firstEvent.tag != "!" &&
        firstEvent.tag != null &&
        firstEvent.tag != "tag:yaml.org,2002:map") {
      throw new YamlException("Invalid tag for mapping.", firstEvent.span);
    }

    var children = deepEqualsMap<dynamic, YamlNode>();
    var node =
        new YamlMap.internal(children, firstEvent.span, firstEvent.style);
    _registerAnchor(firstEvent.anchor, node);

    var event = _parser.parse();
    while (event.type != EventType.MAPPING_END) {
      var key = _loadNode(event);
      var value = _loadNode(_parser.parse());
      if (children.containsKey(key)) {
        throw new YamlException("Duplicate mapping key.", key.span);
      }

      children[key] = value;
      event = _parser.parse();
    }

    setSpan(node, firstEvent.span.expand(event.span));
    return node;
  }

  /// Parses a scalar according to its tag name.
  YamlScalar _parseByTag(ScalarEvent scalar) {
    switch (scalar.tag) {
      case "tag:yaml.org,2002:null":
        var result = _parseNull(scalar);
        if (result != null) return result;
        throw new YamlException("Invalid null scalar.", scalar.span);
      case "tag:yaml.org,2002:bool":
        var result = _parseBool(scalar);
        if (result != null) return result;
        throw new YamlException("Invalid bool scalar.", scalar.span);
      case "tag:yaml.org,2002:int":
        var result = _parseNumber(scalar, allowFloat: false);
        if (result != null) return result;
        throw new YamlException("Invalid int scalar.", scalar.span);
      case "tag:yaml.org,2002:float":
        var result = _parseNumber(scalar, allowInt: false);
        if (result != null) return result;
        throw new YamlException("Invalid float scalar.", scalar.span);
      case "tag:yaml.org,2002:str":
        return new YamlScalar.internal(scalar.value, scalar);
      default:
        throw new YamlException('Undefined tag: ${scalar.tag}.', scalar.span);
    }
  }

  /// Parses [scalar], which may be one of several types.
  YamlScalar _parseScalar(ScalarEvent scalar) =>
      _tryParseScalar(scalar) ?? new YamlScalar.internal(scalar.value, scalar);

  /// Tries to parse [scalar].
  ///
  /// If parsing fails, this returns `null`, indicating that the scalar should
  /// be parsed as a string.
  YamlScalar _tryParseScalar(ScalarEvent scalar) {
    // Quickly check for the empty string, which means null.
    var length = scalar.value.length;
    if (length == 0) return new YamlScalar.internal(null, scalar);

    // Dispatch on the first character.
    var firstChar = scalar.value.codeUnitAt(0);
    switch (firstChar) {
      case $dot:
      case $plus:
      case $minus:
        return _parseNumber(scalar);
      case $n:
      case $N:
        return length == 4 ? _parseNull(scalar) : null;
      case $t:
      case $T:
        return length == 4 ? _parseBool(scalar) : null;
      case $f:
      case $F:
        return length == 5 ? _parseBool(scalar) : null;
      case $tilde:
        return length == 1 ? new YamlScalar.internal(null, scalar) : null;
      default:
        if (firstChar >= $0 && firstChar <= $9) return _parseNumber(scalar);
        return null;
    }
  }

  /// Parse a null scalar.
  ///
  /// Returns a Dart `null` if parsing fails.
  YamlScalar _parseNull(ScalarEvent scalar) {
    switch (scalar.value) {
      case "":
      case "null":
      case "Null":
      case "NULL":
      case "~":
        return new YamlScalar.internal(null, scalar);
      default:
        return null;
    }
  }

  /// Parse a boolean scalar.
  ///
  /// Returns `null` if parsing fails.
  YamlScalar _parseBool(ScalarEvent scalar) {
    switch (scalar.value) {
      case "true":
      case "True":
      case "TRUE":
        return new YamlScalar.internal(true, scalar);
      case "false":
      case "False":
      case "FALSE":
        return new YamlScalar.internal(false, scalar);
      default:
        return null;
    }
  }

  /// Parses a numeric scalar.
  ///
  /// Returns `null` if parsing fails.
  YamlNode _parseNumber(ScalarEvent scalar,
      {bool allowInt: true, bool allowFloat: true}) {
    var value = _parseNumberValue(scalar.value,
        allowInt: allowInt, allowFloat: allowFloat);
    return value == null ? null : new YamlScalar.internal(value, scalar);
  }

  /// Parses the value of a number.
  ///
  /// Returns the number if it's parsed successfully, or `null` if it's not.
  num _parseNumberValue(String contents,
      {bool allowInt: true, bool allowFloat: true}) {
    assert(allowInt || allowFloat);

    var firstChar = contents.codeUnitAt(0);
    var length = contents.length;

    // Quick check for single digit integers.
    if (allowInt && length == 1) {
      var value = firstChar - $0;
      return value >= 0 && value <= 9 ? value : null;
    }

    var secondChar = contents.codeUnitAt(1);

    // Hexadecimal or octal integers.
    if (allowInt && firstChar == $0) {
      // int.parse supports 0x natively.
      if (secondChar == $x) return int.parse(contents, onError: (_) => null);

      if (secondChar == $o) {
        var afterRadix = contents.substring(2);
        return int.parse(afterRadix, radix: 8, onError: (_) => null);
      }
    }

    // Int or float starting with a digit or a +/- sign.
    if ((firstChar >= $0 && firstChar <= $9) ||
        ((firstChar == $plus || firstChar == $minus) &&
            secondChar >= $0 &&
            secondChar <= $9)) {
      // Try to parse an int or, failing that, a double.
      var result = null;
      if (allowInt) {
        // Pass "radix: 10" explicitly to ensure that "-0x10", which is valid
        // Dart but invalid YAML, doesn't get parsed.
        result = int.parse(contents, radix: 10, onError: (_) => null);
      }

      if (allowFloat) result ??= double.parse(contents, (_) => null);
      return result;
    }

    if (!allowFloat) return null;

    // Now the only possibility is to parse a float starting with a dot or a
    // sign and a dot, or the signed/unsigned infinity values and not-a-numbers.
    if ((firstChar == $dot && secondChar >= $0 && secondChar <= $9) ||
        (firstChar == $minus || firstChar == $plus) && secondChar == $dot) {
      // Starting with a . and a number or a sign followed by a dot.
      if (length == 5) {
        switch (contents) {
          case "+.inf":
          case "+.Inf":
          case "+.INF":
            return double.INFINITY;
          case "-.inf":
          case "-.Inf":
          case "-.INF":
            return -double.INFINITY;
        }
      }

      return double.parse(contents, (_) => null);
    }

    if (length == 4 && firstChar == $dot) {
      switch (contents) {
        case ".inf":
        case ".Inf":
        case ".INF":
          return double.INFINITY;
        case ".nan":
        case ".NaN":
        case ".NAN":
          return double.NAN;
      }
    }

    return null;
  }
}
