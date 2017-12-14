// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartlang_org/frontend/highlight.dart';

void main() {
  test('no change', () {
    expect(highlightText('Hello World!', ['abc']), 'Hello World!');
  });

  test('html escape', () {
    expect(highlightText('HTTP/2 ><', []), 'HTTP/2 &gt;&lt;');
  });

  test('inside text node', () {
    expect(highlightText('Hello World!', ['World']),
        'Hello <highlight>World</highlight>!');
  });

  test('lowercase', () {
    expect(highlightText('Hello World!', ['world']),
        'Hello <highlight>World</highlight>!');
  });

  test('multiple match', () {
    expect(highlightText('abcdefgh', ['ab', 'abcd', 'def', 'ef']),
        '<highlight>abcd</highlight><highlight>ef</highlight>gh');
  });
}
