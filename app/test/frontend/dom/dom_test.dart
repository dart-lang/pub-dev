// Copyright (c) 2010, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dev/frontend/dom/dom.dart';

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
      expect(dom.element('div', classes: ['c1', 'c2']).toString(),
          '<div class="c1 c2"></div>');
    });

    test('invalid attribute key', () {
      void invalid(String key) {
        expect(() => dom.element('div', attributes: {key: 'value'}),
            throwsA(isA<FormatException>()));
      }

      invalid('');
      invalid('-');
      invalid('a-');
      invalid('1');
      invalid('A');
    });

    test('escaped attribute value', () {
      expect(dom.element('div', attributes: {'title': '\'@&%"'}).toString(),
          '<div title="\'@&amp;%&quot;"></div>');
    });

    test('children', () {
      expect(
          dom.element(
            'div',
            children: [dom.element('header'), dom.element('footer')],
          ).toString(),
          '<div><header></header><footer></footer></div>');
    });

    test('escaped text', () {
      expect(
          dom.element(
            'div',
            children: [dom.text('\'&%/"<>abcd12')],
          ).toString(),
          '<div>&#39;&amp;%&#47;&quot;&lt;&gt;abcd12</div>');
    });

    test('fragment', () {
      expect(
          dom.fragment([
            dom.element('div'),
            dom.element('span'),
          ]).toString(),
          '<div></div><span></span>');
    });
  });
}
