// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:html/dom.dart';
import 'package:test/test.dart';

void validateHtml(root) {
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
    expect(
        elem.attributes.keys
            .where((name) => name.toString().startsWith('on'))
            .toList(),
        []);
  }

  // All <a target="_blank"> links should have rel="noopener"
  for (Element elem in links) {
    if (elem.attributes['target'] == '_blank') {
      expect(elem.attributes['rel'], contains('noopener'));
    }
  }

  // No inline script tag.
  for (Element elem in scripts) {
    if (elem.attributes['type'] == 'application/ld+json') {
      expect(elem.attributes.length, 1);
      expect(json.decode(elem.text), isNotNull);
    } else {
      expect(elem.attributes['src'], isNotEmpty);
      expect(elem.text.trim(), isEmpty);
    }
  }
}
