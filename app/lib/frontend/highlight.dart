// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:math' as math;

const HtmlEscape _htmlEscape = const HtmlEscape(HtmlEscapeMode.ELEMENT);

/// Returns an escaped HTML with `<highlight>phrase</highlight>` markup.
String highlightText(String text, Iterable<String> phrases) {
  if (text == null || text.isEmpty) return text;

  final String html = _htmlEscape.convert(text);
  if (phrases == null || phrases.isEmpty) {
    return html;
  }
  final String escapedLowerText = html.toLowerCase();

  final List<String> sortedPhrases =
      phrases.map((p) => _htmlEscape.convert(p.toLowerCase())).toList();
  sortedPhrases.sort((a, b) => -a.length.compareTo(b.length));

  final StringBuffer sb = new StringBuffer();
  int start = 0;
  while (start < html.length) {
    final List<int> indexOfList =
        sortedPhrases.map((p) => escapedLowerText.indexOf(p, start)).toList();
    if (indexOfList.every((x) => x == -1)) {
      sb.write(html.substring(start));
      break;
    }
    final int minIndex =
        indexOfList.where((x) => x != -1).fold(html.length, math.min);
    final int phraseIndex = indexOfList.indexOf(minIndex);
    final String phrase = sortedPhrases[phraseIndex];
    if (start != minIndex) {
      sb.write(html.substring(start, minIndex));
      start = minIndex;
    }
    sb.write('<highlight>');
    sb.write(html.substring(start, start + phrase.length));
    sb.write('</highlight>');
    start += phrase.length;
  }

  return sb.toString();
}
