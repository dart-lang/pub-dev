// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartlang_org/search/text_utils.dart';

void main() {
  group('text preparation', () {
    test('readme text extraction', () {
      final String input = '''Currently supports the following methods:

- camelize
- capitalize
- escape
- isLowerCase
- isUpperCase
- join
- printable
- reverse
- startsWithLowerCase
- startsWithUpperCase
- toUnicode
- underscore

Other useful methods will be added soon...
''';
      final text = compactReadme(input);
      expect(
          text,
          'Currently supports the following methods: camelize capitalize escape '
          'isLowerCase isUpperCase join printable reverse startsWithLowerCase '
          'startsWithUpperCase toUnicode underscore '
          'Other useful methods will be added soon...');
    });
  });

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

  group('compact readme', () {
    test('No formatting', () {
      expect(compactReadme('abc  123 '), 'abc 123');
    });

    test('link', () {
      expect(compactReadme('some [link](http://example.com) with text'),
          'some link with text');
    });
  });

  group('tokenize', () {
    test('simple text', () {
      expect(tokenize('The quick brown fox jumps over the lazy dog.'), {
        'the': 1.0,
        'quick': 1.0,
        'brown': 1.0,
        'fox': 1.0,
        'jumps': 1.0,
        'over': 1.0,
        'lazy': 1.0,
        'dog': 1.0,
      });
    });

    test('Cased words', () {
      expect(tokenize('CamelCase snake_case firstLowerCase'), {
        'camelcase': 1.0,
        'camel': 0.5555555555555556,
        'case': 1.0, // firstLowerCase should not set a lower value
        'snake': 1.0,
        'firstlowercase': 1.0,
        'first': 0.35714285714285715,
        'lower': 0.35714285714285715,
      });

      expect(tokenize('firstLowerCase'), {
        'firstlowercase': 1.0,
        'first': 0.35714285714285715,
        'lower': 0.35714285714285715,
        'case': 0.2857142857142857,
      });
    });
  });
}
