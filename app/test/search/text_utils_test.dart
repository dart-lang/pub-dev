// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartlang_org/search/text_utils.dart';

void main() {
  group('extact phrases', () {
    test('no phrase', () {
      expect(extractExactPhrases(''), isEmpty);
      expect(extractExactPhrases('abc cde'), isEmpty);
    });

    test('no phrase with single "', () {
      expect(extractExactPhrases('"'), isEmpty);
      expect(extractExactPhrases('abc cde "'), isEmpty);
    });

    test('no empty phrases', () {
      expect(extractExactPhrases('""'), isEmpty);
      expect(extractExactPhrases('abc "" cde'), isEmpty);
    });

    test('entire text is a phrase', () {
      expect(extractExactPhrases('"abc"'), ['abc']);
      expect(extractExactPhrases('" abc cde "'), [' abc cde ']);
    });

    test('mixed phrase + non-phrase', () {
      expect(extractExactPhrases('"abc" cde'), ['abc']);
      expect(extractExactPhrases('123 "abc"'), ['abc']);
      expect(extractExactPhrases('123 "abc" cde'), ['abc']);
      expect(
          extractExactPhrases(
              'before "hello world" middle "greet from world" after'),
          ['hello world', 'greet from world']);
    });

    test('multiple phrases', () {
      expect(extractExactPhrases('"abc" "cde" "123 456"'),
          ['abc', 'cde', '123 456']);
    });
  });
}
