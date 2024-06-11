// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/search/text_utils.dart';
import 'package:test/test.dart';

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

  group('exact phrases', () {
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
    test('dart:async', () {
      expect(tokenize('dart:async'), {
        'dart': 1.0,
        'async': 1.0,
      });
    });

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
      expect(tokenize('snake_case'), {
        'snake': 1.0,
        'case': 1.0,
      });

      expect(tokenize('CamelCase snake_case firstLowerCase'), {
        'camelcase': 1.0,
        'camel': 0.7453559924999299,
        'case': 1.0, // firstLowerCase should not set a lower value
        'snake': 1.0,
        'firstlowercase': 1.0,
        'first': 0.5976143046671968,
        'lower': 0.5976143046671968,
      });

      expect(tokenize('firstLowerCase'), {
        'firstlowercase': 1.0,
        'first': 0.5976143046671968,
        'lower': 0.5976143046671968,
        'case': 0.5345224838248488,
      });
    });
  });

  group('trigrams', () {
    test('small input', () {
      expect(trigrams(''), isEmpty);
      expect(trigrams('a'), isEmpty);
      expect(trigrams('ab'), isEmpty);
    });

    test('small inputs', () {
      expect(trigrams('abc'), ['abc']);
      expect(trigrams('abcd'), ['abc', 'bcd']);
    });

    test('repeated values', () {
      expect(trigrams('aaaab'), ['aaa', 'aaa', 'aab']);
    });
  });
}
