// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/completion.dart';
import 'package:test/test.dart';
import 'package:web_app/src/widget/completion/suggest.dart';

void main() {
  group('Completion suggest', () {
    final data = CompletionData(completions: [
      CompletionRule(
        match: {'', '-'},
        terminal: false,
        forcedOnly: true,
        options: [
          'has:',
          'is:',
        ],
      ),
      CompletionRule(
        match: {'is:', '-is:'},
        options: [
          'dart3-compatible',
          'flutter-favorite',
          'legacy',
          'null-safe',
          'plugin',
          'unlisted',
          'wasm-ready',
        ],
      ),
      CompletionRule(
        match: {'has:', '-has:'},
        options: [
          'executable',
          'screenshot',
        ],
      ),
    ]);

    test('no suggestion', () {
      final rs = suggest(data, 'zzzzzz', 5);
      expect(rs.trigger, false);
      expect(rs.suggestions.map((e) => e.toJson()).toList(), [
        {
          'start': 0,
          'end': 6,
          'value': 'is:',
          'html': 'is:',
          'score': 0.0,
        },
        {
          'start': 0,
          'end': 6,
          'value': 'has:',
          'html': 'has:',
          'score': 0.0,
        },
      ]);
    });

    test('some results', () {
      final rs = suggest(data, 'is:tt', 5);
      expect(rs.trigger, true);
      expect(rs.suggestions.map((e) => e.toJson()).toList(), [
        {
          'start': 0,
          'end': 5,
          'value': 'is:flutter-favorite ',
          'html': 'flu<strong>tt</strong>er-favorite',
          'score': 4.125,
        },
        {
          'start': 0,
          'end': 5,
          'value': 'is:unlisted ',
          'html': 'unlis<strong>t</strong>ed',
          'score': 1.125,
        },
        {
          'start': 0,
          'end': 5,
          'value': 'is:dart3-compatible ',
          'html': 'dar<strong>t</strong>3-compa<strong>t</strong>ible',
          'score': 1.0625,
        },
        {
          'start': 0,
          'end': 5,
          'value': 'is:wasm-ready ',
          'html': 'wasm-ready',
          'score': 0.0,
        },
        {
          'start': 0,
          'end': 5,
          'value': 'is:plugin ',
          'html': 'plugin',
          'score': 0.0
        },
        {
          'start': 0,
          'end': 5,
          'value': 'is:null-safe ',
          'html': 'null-safe',
          'score': 0.0,
        },
        {
          'start': 0,
          'end': 5,
          'value': 'is:legacy ',
          'html': 'legacy',
          'score': 0.0,
        },
      ]);
    });
  });
}
