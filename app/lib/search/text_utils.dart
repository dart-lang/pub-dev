// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

final RegExp _separators =
    new RegExp(r'[_\.,;=\(\)\>\<\[\]\{\}\|\?\!\/\+\-\*]|\s');
final RegExp _nonCharacterRegExp = new RegExp('[^a-z0-9]');
final RegExp _multiWhitespaceRegExp = new RegExp('\\s+');
final RegExp _exactTermRegExp = new RegExp(r'"([^"]+)"');

String compactText(String text, {int maxLength: -1}) {
  if (text == null) return '';
  String t = text.replaceAll(_multiWhitespaceRegExp, ' ').trim();
  if (maxLength > 0 && t.length > maxLength) {
    t = t.substring(0, maxLength);
  }
  return t;
}

String compactDescription(String text) => compactText(text, maxLength: 500);
String compactReadme(String text) => compactText(text, maxLength: 1000);

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

class StringInternPool {
  final Map<String, String> _values = <String, String>{};

  String intern(String value) => _values.putIfAbsent(value, () => value);

  void checkUnboundGrowth() {
    if (_values.length > 100000) {
      _values.clear();
    }
  }
}
