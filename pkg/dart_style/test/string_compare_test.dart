// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn("vm")
library dart_style.test.string_compare_test;

import 'package:test/test.dart';

import 'package:dart_style/src/string_compare.dart';

void main() {
  test("whitespace at end of string", () {
    expect(equalIgnoringWhitespace('foo bar\n', 'foo bar'), isTrue);
    expect(equalIgnoringWhitespace('foo bar', 'foo bar\n'), isTrue);
    expect(equalIgnoringWhitespace('foo bar \n', 'foo bar'), isTrue);
    expect(equalIgnoringWhitespace('foo bar', 'foo bar \n'), isTrue);
  });

  test("whitespace at start of string", () {
    expect(equalIgnoringWhitespace('\nfoo bar', 'foo bar'), isTrue);
    expect(equalIgnoringWhitespace('\n foo bar', 'foo bar'), isTrue);
    expect(equalIgnoringWhitespace('foo bar', '\nfoo bar'), isTrue);
    expect(equalIgnoringWhitespace('foo bar', '\n foo bar'), isTrue);
  });

  test("whitespace in the middle of string", () {
    expect(equalIgnoringWhitespace('foobar', 'foo bar'), isTrue);
    expect(equalIgnoringWhitespace('foo bar', 'foobar'), isTrue);
    expect(equalIgnoringWhitespace('foo\tbar', 'foobar'), isTrue);
    expect(equalIgnoringWhitespace('foobar', 'foo\tbar'), isTrue);
    expect(equalIgnoringWhitespace('foo\nbar', 'foobar'), isTrue);
    expect(equalIgnoringWhitespace('foobar', 'foo\nbar'), isTrue);
  });

  test("wdentical strings", () {
    expect(equalIgnoringWhitespace('foo bar', 'foo bar'), isTrue);
    expect(equalIgnoringWhitespace('', ''), isTrue);
  });

  test("test unicode whitespace characters", () {
    // Dart sources only allow ascii whitespace code points so we
    // should not consider the following strings equal.
    var whitespaceRunes = [
      0x00A0,
      0x1680,
      0x180E,
      0x2000,
      0x200A,
      0x2028,
      0x2029,
      0x202F,
      0x205F,
      0x3000,
      0xFEFF
    ];
    for (var rune in whitespaceRunes) {
      expect(
          equalIgnoringWhitespace(
              'foo${new String.fromCharCode(rune)}bar', 'foo    bar'),
          isFalse);
    }
  });

  test("different strings", () {
    expect(equalIgnoringWhitespace('foo bar', 'Foo bar'), isFalse);
    expect(equalIgnoringWhitespace('foo bar', 'foo bars'), isFalse);
    expect(equalIgnoringWhitespace('foo bars', 'foo bar'), isFalse);
    expect(equalIgnoringWhitespace('oo bar', 'foo bar'), isFalse);
    expect(equalIgnoringWhitespace('', 'foo bar'), isFalse);
    expect(equalIgnoringWhitespace('foo bar', ''), isFalse);
  });
}
