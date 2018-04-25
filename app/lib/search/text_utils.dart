// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:html/parser.dart';

import '../shared/markdown.dart';

final RegExp _separators =
    new RegExp(r'[_\.,;=\(\)\>\<\[\]\{\}\|\?\!\/\+\-\*]|\s');
final RegExp _nonCharacterRegExp = new RegExp('[^a-z0-9]');
final RegExp _multiWhitespaceRegExp = new RegExp('\\s+');
final RegExp _exactTermRegExp = new RegExp(r'"([^"]+)"');

final _commonApiSymbols = new Set.from([
  'toString',
  'noSuchMethod',
  'hashCode',
  'runtimeType',
]);

bool isCommonApiSymbol(String symbol) {
  if (_commonApiSymbols.contains(symbol)) {
    return true;
  }
  if (symbol.startsWith('operator ')) return true;
  return false;
}

String _compactText(String text, {int maxLength: -1}) {
  if (text == null) return '';
  String t = text.replaceAll(_multiWhitespaceRegExp, ' ').trim();
  if (maxLength > 0 && t.length > maxLength) {
    t = t.substring(0, maxLength);
  }
  return t;
}

String compactDescription(String text) => _compactText(text, maxLength: 500);

String compactReadme(String text) {
  if (text == null || text.isEmpty) return '';
  final html = markdownToHtml(text, null);
  final root = parseFragment(html);
  return _compactText(root.text, maxLength: 5000);
}

String normalizeBeforeIndexing(String text) {
  if (text == null) return '';
  final String t = text
      .toLowerCase()
      .replaceAll(_nonCharacterRegExp, ' ')
      .replaceAll(_multiWhitespaceRegExp, ' ')
      .trim();
  return t;
}

Iterable<String> splitForIndexing(String text) {
  if (text == null || text.isEmpty) return new Iterable.empty();
  return text.split(_separators).where((s) => s.isNotEmpty);
}

List<String> extractExactPhrases(String text) =>
    _exactTermRegExp.allMatches(text).map((m) => m.group(1)).toList();
