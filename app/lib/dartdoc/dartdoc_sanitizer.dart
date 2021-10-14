// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;

class SanitizerResult {
  final bool passed;
  final String contentHtml;
  final List<String> removed;

  SanitizerResult(this.passed, this.contentHtml, this.removed);
}

/// Removes unsafe elements and attributes from the output of dartdoc.
SanitizerResult sanitizeDartdocHtml(String input, int directoryLevel) {
  final parsed = html_parser.parse(input);
  final removed = <String>[];

  void visit(Element elem) {
    // remove elements based on tag and position
    final tag = elem.localName?.toLowerCase() ?? '';
    if (tag == 'iframe') {
      removed.add('iframe src="${elem.attributes['src']}"');
      elem.remove();
      return;
    }

    // allow some <script> and remove everything else
    if (tag == 'script') {
      final src = elem.attributes['src'] ?? '';
      final prefix = '../' * directoryLevel;
      final allowed = [
        '${prefix}static-assets/highlight.pack.js?v1',
        '${prefix}static-assets/script.js?v1',
      ];
      if (!allowed.contains(src)) {
        removed.add('script src="${elem.attributes['src']}"');
        elem.remove();
        return;
      }
    }

    // remove on* attributes
    elem.attributes.removeWhere((a, value) {
      final key = a is String ? a : (a as AttributeName).name;
      if (key.toLowerCase().startsWith('on')) {
        removed.add('$tag $key');
        return true;
      }
      return false;
    });

    // visit children
    for (final c in elem.children) {
      visit(c);
    }
  }

  visit(parsed.documentElement!);
  return SanitizerResult(
    removed.isEmpty,
    removed.isNotEmpty ? parsed.outerHtml : input,
    removed,
  );
}
