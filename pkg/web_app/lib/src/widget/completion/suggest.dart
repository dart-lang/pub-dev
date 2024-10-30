// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' as math;

import 'package:_pub_shared/data/completion.dart';
import 'package:collection/collection.dart';

typedef Suggestions = List<Suggestion>;

class Suggestion {
  final int start;
  final int end;
  final String value;
  // TODO: Don't create HTML manually!
  final String html;
  final double score;

  Suggestion({
    required this.start,
    required this.end,
    required this.value,
    required this.html,
    required this.score,
  });

  Map<String, dynamic> toJson() => {
        'start': start,
        'end': end,
        'value': value,
        'html': html,
        'score': score,
      };
}

/// Given [data] and [caret] position inside [text] what suggestions do we
/// want to offer and should completion be automatically triggered?
({bool trigger, Suggestions suggestions}) suggest(
  CompletionData data,
  String text,
  int caret,
) {
  // Get position before caret
  final beforeCaret = caret > 0 ? caret - 1 : 0;
  // Get position of space after the caret
  final spaceAfterCaret = text.indexOf(' ', caret);

  // Start and end of word we are completing
  final start = text.lastIndexOf(' ', beforeCaret) + 1;
  final end = spaceAfterCaret != -1 ? spaceAfterCaret : text.length;

  // If caret is not at the end, and the next character isn't space then we
  // do not automatically trigger completion.
  bool trigger;
  if (caret < text.length && text[caret] != ' ') {
    trigger = false;
  } else {
    // If the part before the caret is matched, then we can auto trigger
    final wordBeforeCaret = text.substring(start, caret);
    trigger = data.completions.any(
      (c) => !c.forcedOnly && c.match.any(wordBeforeCaret.startsWith),
    );
  }

  // Get the word that we are completing
  final word = text.substring(start, end);

  // Find the longest match for each completion entry
  final completionWithBestMatch = data.completions.map((c) => (
        completion: c,
        match: maxBy(c.match.where(word.startsWith), (m) => m.length),
      ));
  // Find the best completion entry
  final (:completion, :match) = maxBy(completionWithBestMatch, (c) {
        final m = c.match;
        return m != null ? m.length : -1;
      }) ??
      (completion: null, match: null);
  if (completion == null || match == null) {
    return (
      trigger: false,
      suggestions: [],
    );
  }

  // prefix to be used for completion of options
  final prefix = word.substring(match.length);

  if (completion.options.contains(prefix)) {
    // If prefix is an option, and there is no other options we don't have
    // anything to suggest.
    if (completion.options.length == 1) {
      return (
        trigger: false,
        suggestions: [],
      );
    }
    // We don't to auto trigger completion unless there is an option that is
    // also a prefix and longer than what prefix currently matches.
    trigger &= completion.options.any(
      (opt) => opt.startsWith(prefix) && opt != prefix,
    );
  }

  // Terminate suggestion with a ' ' suffix, if this is a terminal completion
  final suffix = completion.terminal ? ' ' : '';

  final suggestions = completion.options.map((option) {
    final overlap = _lcs(prefix, option);
    var html = option;
    if (overlap.isNotEmpty) {
      html = html.replaceAll(
          overlap, '<span class="completion-overlap">$overlap</span>');
    }
    final score = (option.startsWith(word) ? math.pow(overlap.length, 3) : 0) +
        math.pow(overlap.length, 2) +
        (option.startsWith(overlap) ? overlap.length : 0) +
        overlap.length / option.length;
    return Suggestion(
      value: match + option + suffix,
      start: start,
      end: end,
      html: html,
      score: score,
    );
  }).sorted((a, b) {
    final x = -a.score.compareTo(b.score);
    if (x != 0) return x;
    return a.value.compareTo(b.value);
  });

  return (
    trigger: trigger,
    suggestions: suggestions,
  );
}

/// The longest common substring
String _lcs(String S, String T) {
  final r = S.length;
  final n = T.length;
  var Lp = List.filled(n, 0); // ignore: non_constant_identifier_names
  var Li = List.filled(n, 0); // ignore: non_constant_identifier_names
  var z = 0;
  var [start, end] = [0, 0];
  for (var i = 0; i < r; i++) {
    for (var j = 0; j < n; j++) {
      if (S[i] == T[j]) {
        if (i == 0 || j == 0) {
          Li[j] = 1;
        } else {
          Li[j] = Lp[j - 1] + 1;
        }
        if (Li[j] > z) {
          z = Li[j];
          [start, end] = [i - z + 1, i + 1];
        }
      }
    }
    [Lp, Li] = [Li, Lp..fillRange(0, Lp.length, 0)];
  }
  return S.substring(start, end);
}
