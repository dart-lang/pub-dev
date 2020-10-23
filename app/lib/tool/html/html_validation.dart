// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;

/// Validates the HTML content and throws ArgumentError if any of the
/// following issues are present:
/// - Inline JavaScript actions are present (e.g. `onclick`).
/// - Links with `<a target="_blank">` do not have `rel="repooner"`.
/// - `<script> tags have no `src` attribute or have content (except `ld+json`
///   meta content).
void parseAndValidateHtml(String html) {
  validateHtml(parser.parse(html));
}

/// Validates the parsed HTML content and throws ArgumentError if any of the
/// following issues are present:
/// - Inline JavaScript actions are present (e.g. `onclick`).
/// - Links with `<a target="_blank">` do not have `rel="repooner"`.
/// - `<script> tags have no `src` attribute or have content (except `ld+json`
///   meta content).
void validateHtml(Node root) {
  List<Element> elements;
  List<Element> links;
  List<Element> scripts;

  if (root is DocumentFragment) {
    elements = root.querySelectorAll('*');
    links = root.querySelectorAll('a');
    scripts = root.querySelectorAll('script');
  } else if (root is Document) {
    elements = root.querySelectorAll('*');
    links = root.querySelectorAll('a');
    scripts = root.querySelectorAll('script');
  } else {
    throw ArgumentError('Unknown html element type: $root');
  }

  // No inline JS attribute
  for (Element elem in elements) {
    for (final attr in elem.attributes.keys) {
      final name = attr.toString();
      if (name.toLowerCase().startsWith('on')) {
        throw ArgumentError(
            'No inline JS attribute is allowed, found: ${elem.outerHtml}.');
      }
    }
  }

  // All <a target="_blank"> links must have rel="noopener"
  for (Element elem in links) {
    if (elem.attributes['target'] == '_blank') {
      final rel = elem.attributes['rel'];
      if (!rel.split(' ').contains('noopener')) {
        throw ArgumentError(
            '_blank links must have rel=noopener, found: ${elem.outerHtml}.');
      }
    }
  }

  // No inline script tag.
  for (Element elem in scripts) {
    if (elem.attributes['type'] == 'application/ld+json') {
      if (elem.attributes.length != 1) {
        throw ArgumentError(
            'Only a single attribute is allowed on ld+json, found: ${elem.outerHtml}');
      }
      if (elem.text.trim().isEmpty) {
        throw ArgumentError('ld+json element must not be empty.');
      }
      // trigger parsing of the content
      json.decode(elem.text);
    } else {
      final src = elem.attributes['src'];
      if (src == null || src.isEmpty) {
        throw ArgumentError(
            'script tag must have src attribute, found: ${elem.parent?.outerHtml}');
      }
      if (elem.text.trim().isNotEmpty) {
        throw ArgumentError(
            'script tag must text content must be empty, found: ${elem.outerHtml}');
      }
    }
  }
}
