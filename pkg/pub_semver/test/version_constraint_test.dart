// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_semver/pub_semver.dart';

import 'utils.dart';

main() {
  test('any', () {
    expect(VersionConstraint.any.isAny, isTrue);
    expect(VersionConstraint.any, allows(
        new Version.parse('0.0.0-blah'),
        new Version.parse('1.2.3'),
        new Version.parse('12345.678.90')));
  });

  test('empty', () {
    expect(VersionConstraint.empty.isEmpty, isTrue);
    expect(VersionConstraint.empty.isAny, isFalse);
    expect(VersionConstraint.empty, doesNotAllow(
        new Version.parse('0.0.0-blah'),
        new Version.parse('1.2.3'),
        new Version.parse('12345.678.90')));
  });

  group('parse()', () {
    test('parses an exact version', () {
      var constraint = new VersionConstraint.parse('1.2.3-alpha');

      expect(constraint is Version, isTrue);
      expect(constraint, equals(new Version(1, 2, 3, pre: 'alpha')));
    });

    test('parses "any"', () {
      var constraint = new VersionConstraint.parse('any');

      expect(constraint is VersionConstraint, isTrue);
      expect(constraint, allows(
          new Version.parse('0.0.0'),
          new Version.parse('1.2.3'),
          new Version.parse('12345.678.90')));
    });

    test('parses a ">" minimum version', () {
      var constraint = new VersionConstraint.parse('>1.2.3');

      expect(constraint, allows(
          new Version.parse('1.2.3+foo'),
          new Version.parse('1.2.4')));
      expect(constraint, doesNotAllow(
          new Version.parse('1.2.1'),
          new Version.parse('1.2.3-build'),
          new Version.parse('1.2.3')));
    });

    test('parses a ">=" minimum version', () {
      var constraint = new VersionConstraint.parse('>=1.2.3');

      expect(constraint, allows(
          new Version.parse('1.2.3'),
          new Version.parse('1.2.3+foo'),
          new Version.parse('1.2.4')));
      expect(constraint, doesNotAllow(
          new Version.parse('1.2.1'),
          new Version.parse('1.2.3-build')));
    });

    test('parses a "<" maximum version', () {
      var constraint = new VersionConstraint.parse('<1.2.3');

      expect(constraint, allows(
          new Version.parse('1.2.1'),
          new Version.parse('1.2.2+foo')));
      expect(constraint, doesNotAllow(
          new Version.parse('1.2.3'),
          new Version.parse('1.2.3+foo'),
          new Version.parse('1.2.4')));
    });

    test('parses a "<=" maximum version', () {
      var constraint = new VersionConstraint.parse('<=1.2.3');

      expect(constraint, allows(
          new Version.parse('1.2.1'),
          new Version.parse('1.2.3-build'),
          new Version.parse('1.2.3')));
      expect(constraint, doesNotAllow(
          new Version.parse('1.2.3+foo'),
          new Version.parse('1.2.4')));
    });

    test('parses a series of space-separated constraints', () {
      var constraint = new VersionConstraint.parse('>1.0.0 >=1.2.3 <1.3.0');

      expect(constraint, allows(
          new Version.parse('1.2.3'),
          new Version.parse('1.2.5')));
      expect(constraint, doesNotAllow(
          new Version.parse('1.2.3-pre'),
          new Version.parse('1.3.0'),
          new Version.parse('3.4.5')));
    });

    test('ignores whitespace around comparison operators', () {
      var constraint = new VersionConstraint.parse(' >1.0.0>=1.2.3 < 1.3.0');

      expect(constraint, allows(
          new Version.parse('1.2.3'),
          new Version.parse('1.2.5')));
      expect(constraint, doesNotAllow(
          new Version.parse('1.2.3-pre'),
          new Version.parse('1.3.0'),
          new Version.parse('3.4.5')));
    });

    test('does not allow "any" to be mixed with other constraints', () {
      expect(() => new VersionConstraint.parse('any 1.0.0'),
          throwsFormatException);
    });

    test('parses a "^" version', () {
      expect(new VersionConstraint.parse('^0.0.3'), equals(
          new VersionConstraint.compatibleWith(v003)));

      expect(new VersionConstraint.parse('^0.7.2'), equals(
          new VersionConstraint.compatibleWith(v072)));

      expect(new VersionConstraint.parse('^1.2.3'), equals(
          new VersionConstraint.compatibleWith(v123)));

      var min = new Version.parse('0.7.2-pre+1');
      expect(new VersionConstraint.parse('^0.7.2-pre+1'), equals(
          new VersionConstraint.compatibleWith(min)));
    });

    test('does not allow "^" to be mixed with other constraints', () {
      expect(() => new VersionConstraint.parse('>=1.2.3 ^1.0.0'),
          throwsFormatException);
      expect(() => new VersionConstraint.parse('^1.0.0 <1.2.3'),
          throwsFormatException);
    });

    test('ignores whitespace around "^"', () {
      var constraint = new VersionConstraint.parse(' ^ 1.2.3 ');

      expect(constraint, equals(
          new VersionConstraint.compatibleWith(v123)));
    });

    test('throws FormatException on a bad string', () {
      var bad = [
         "", "   ",               // Empty string.
         "foo",                   // Bad text.
         ">foo",                  // Bad text after operator.
         "^foo",                  // Bad text after "^".
         "1.0.0 foo", "1.0.0foo", // Bad text after version.
         "anything",              // Bad text after "any".
         "<>1.0.0",               // Multiple operators.
         "1.0.0<"                 // Trailing operator.
      ];

      for (var text in bad) {
        expect(() => new VersionConstraint.parse(text),
            throwsFormatException);
      }
    });
  });

  group('compatibleWith()', () {
    test('returns the range of compatible versions', () {
      var constraint = new VersionConstraint.compatibleWith(v072);

      expect(constraint, equals(new VersionRange(min: v072, includeMin: true,
          max: v072.nextBreaking)));
    });

    test('toString() uses "^"', () {
      var constraint = new VersionConstraint.compatibleWith(v072);

      expect(constraint.toString(), equals('^0.7.2'));
    });
  });
}
