// Copyright (c) 2010, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:html/parser.dart';
import 'package:pub_dev/frontend/dom/dom.dart';
import 'package:test/test.dart';

void main() {
  group('Element', () {
    test('invalid tag', () {
      void invalid(String tag) {
        expect(() => dom.element(tag), throwsA(isA<FormatException>()));
      }

      invalid('');
      invalid('-');
      invalid('a-');
      invalid('1');
      invalid('A');
    });

    test('id', () {
      expect(dom.element('div', id: 'x1').toString(), '<div id="x1"></div>');
    });

    test('classes', () {
      expect(
        dom.element('div', classes: ['c1', 'c2']).toString(),
        '<div class="c1 c2"></div>',
      );
    });

    test('invalid attribute key', () {
      void invalid(String key) {
        expect(
          () => dom.element('div', attributes: {key: 'value'}),
          throwsA(isA<FormatException>()),
        );
      }

      invalid('');
      invalid('-');
      invalid('a-');
      invalid('1');
      invalid('A');
    });

    test('escaped attribute value', () {
      expect(
        dom.element('div', attributes: {'title': '\'@&%"'}).toString(),
        '<div title="\'@&amp;%&quot;"></div>',
      );
    });

    test('children', () {
      expect(
        dom
            .element(
              'div',
              children: [dom.element('header'), dom.element('footer')],
            )
            .toString(),
        '<div><header></header><footer></footer></div>',
      );
    });

    test('escaped text', () {
      expect(
        dom.element('div', children: [dom.text('\'&%/"<>abcd12')]).toString(),
        '<div>&#39;&amp;%&#47;&quot;&lt;&gt;abcd12</div>',
      );
    });

    test('fragment', () {
      expect(
        dom.fragment([dom.element('div'), dom.element('span')]).toString(),
        '<div></div><span></span>',
      );
    });
  });

  group('ld+json', () {
    test('beamer', () {
      final original = {
        'beamer': '...Navigator\'s [...] "Navigator 2.0".',
        'quote': "'",
        'doublequote': '"',
        'backslash': r'\',
      };
      final script = ldJson(original);
      expect(
        script.toString(),
        r'<script type="application/ld+json">'
        r'{"beamer":"...Navigator\u0027s \u005b...\u005d \u0022Navigator 2.0\u0022.",'
        r'"quote":"\u0027",'
        r'"doublequote":"\u0022",'
        r'"backslash":"\u005c"'
        r'}'
        r'</script>',
      );
      final fragment = parseFragment(script.toString());
      final value = json.decode(fragment.text!);
      expect(value, original);
    });

    test('character combinations', () {
      final characters = [
        'a', 'á', //
        "'", '"', '&', '/', r'\', '<', '>', // HTML characters
        ':', '[', ']', '{', '}', // JSON characters
      ];
      for (final first in characters) {
        for (final second in characters) {
          final text = '$first$second';
          final data = {
            'text': [text],
          };
          final script = ldJson(data);
          final fragment = parseFragment(script.toString());
          final value = json.decode(fragment.text!);
          expect(value, data, reason: text);
        }
      }
    });
  });
}
