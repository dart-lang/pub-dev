// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' as math;

import 'package:html/parser.dart';

import '../shared/markdown.dart';

final _separatorChars = '_.?!,;:=()<>[]{}~@#\$%&|+-*\\/"\'`';
final _escapedSeparators = _separatorChars.split('').map((s) => '\\$s').join();
final _separators = RegExp('[$_escapedSeparators]|\\s');
final _nonCharactersRegExp = RegExp('[^a-z0-9]+');
final RegExp _multiWhitespaceRegExp = RegExp('\\s+');
final RegExp _exactTermRegExp = RegExp(r'"([^"]+)"');

const _commonApiSymbols = {
  'toString',
  'noSuchMethod',
  'hashCode',
  'runtimeType',
};

bool isCommonApiSymbol(String symbol) {
  if (_commonApiSymbols.contains(symbol)) {
    return true;
  }
  if (symbol.startsWith('operator ')) return true;
  return false;
}

String _compactText(String? text, {int maxLength = -1}) {
  if (text == null) return '';
  String t = text.replaceAll(_multiWhitespaceRegExp, ' ').trim();
  if (maxLength > 0 && t.length > maxLength) {
    t = t.substring(0, maxLength);
  }
  return t;
}

String compactDescription(String? text) => _compactText(text, maxLength: 500);

String compactReadme(String? text) {
  if (text == null || text.isEmpty) return '';
  final html = markdownToHtml(text)
      .replaceAll('</li>', '\n</li>')
      .replaceAll('</p>', '\n</p>')
      .replaceAll('</ul>', '\n</ul>')
      .replaceAll('</ol>', '\n</ol>')
      .replaceAll('</dl>', '\n</dl>')
      .replaceAll('</dd>', '\n</dd>')
      .replaceAll('</pre>', '\n</pre>')
      .replaceAll('</blockquote>', '\n</blockquote>');
  final root = parseFragment(html);
  return _compactText(root.text!, maxLength: 5000);
}

String normalizeBeforeIndexing(String? text) {
  if (text == null) return '';
  return text.toLowerCase().replaceAll(_nonCharactersRegExp, ' ').trim();
}

Iterable<String> splitForIndexing(String? text) {
  if (text == null || text.isEmpty) return Iterable.empty();
  return text.split(_separators).where((s) => s.isNotEmpty);
}

List<String> splitForQuery(String? text) {
  final words = splitForIndexing(text).toSet().toList();

  // lookup longer words first, as it may restrict the result set better
  words.sort((a, b) => -a.length.compareTo(b.length));

  // limit the number of words to lookup
  if (words.length > 20) {
    words.removeRange(20, words.length);
  }

  return words;
}

List<String> extractExactPhrases(String text) =>
    _exactTermRegExp.allMatches(text).map((m) => m.group(1)!).toList();

const int _maxWordLength = 80;

Map<String, double>? tokenize(String? originalText, {bool isSplit = false}) {
  if (originalText == null || originalText.isEmpty) return null;
  final tokens = <String, double>{};

  final words = isSplit ? [originalText] : splitForIndexing(originalText);
  for (final word in words) {
    if (word.length > _maxWordLength) {
      continue;
    }

    final normalizedWord = normalizeBeforeIndexing(word);
    if (normalizedWord.isEmpty) continue;

    tokens[normalizedWord] = 1.0;

    // Scan for CamelCase phrases and extract Camel and Case separately.
    final wordCodeUnits = word.codeUnits;
    bool prevLower = _isLower(wordCodeUnits[0]);
    int prevIndex = 0;
    for (int i = 1; i <= word.length; i++) {
      if (i < word.length) {
        final lower = _isLower(wordCodeUnits[i]);
        final isChanging = !lower && prevLower;
        prevLower = lower;
        if (!isChanging) continue;
      }

      final token = normalizeBeforeIndexing(word.substring(prevIndex, i));
      final weight = math.pow((token.length / word.length), 0.5).toDouble();
      if ((tokens[token] ?? 0.0) < weight) {
        tokens[token] = weight;
      }

      prevIndex = i;
    }
  }
  return tokens;
}

final _upperA = 'A'.codeUnits.single;
final _upperZ = 'Z'.codeUnits.single;
bool _isLower(int c) => c < _upperA || _upperZ < c;

/// Generates the 3-grams of [input], which are continuous character strings of
/// length 3. Eg. `abcd` -> `abc`, `bcd`.
List<String> trigrams(String input) {
  if (input.length < 3) {
    return const <String>[];
  } else if (input.length == 3) {
    return [input];
  } else {
    final result = <String>[];
    for (var i = 0; i < input.length - 2; i++) {
      result.add(input.substring(i, i + 3));
    }
    return result;
  }
}
