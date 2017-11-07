// Copyright 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
import 'dart:io';
import 'package:io/ansi.dart';
import 'package:test/test.dart';

void main() {
  group('ansiOutputEnabled', () {
    test("default value matches dart:io", () {
      expect(ansiOutputEnabled,
          stdout.supportsAnsiEscapes && stderr.supportsAnsiEscapes);
    });

    test("override true", () {
      overrideAnsiOutput(true, () {
        expect(ansiOutputEnabled, isTrue);
      });
    });

    test("override false", () {
      overrideAnsiOutput(false, () {
        expect(ansiOutputEnabled, isFalse);
      });
    });
  });

  test('foreground and background colors match', () {
    expect(foregroundColors, hasLength(backgroundColors.length));

    for (var i = 0; i < foregroundColors.length; i++) {
      final foreground = foregroundColors[i];
      expect(foreground.type, AnsiCodeType.foreground);
      expect(foreground.name.toLowerCase(), foreground.name,
          reason: "All names should be lower case");
      final background = backgroundColors[i];
      expect(background.type, AnsiCodeType.background);
      expect(background.name.toLowerCase(), background.name,
          reason: "All names should be lower case");

      expect(foreground.name, background.name);

      // The last base-10 digit also matches – good to sanity check
      expect(foreground.code % 10, background.code % 10);
    }
  });

  test('all styles are styles', () {
    for (var style in styles) {
      expect(style.type, AnsiCodeType.style);
      expect(style.name.toLowerCase(), style.name,
          reason: "All names should be lower case");
      if (style == styleBold) {
        expect(style.reset, resetBold);
      } else {
        expect(style.reset.code, equals(style.code + 20));
      }
      expect(style.name, equals(style.reset.name));
    }
  });

  final sampleInput = 'sample input';

  group('wrap', () {
    _test("color", () {
      final expected = '\x1B[34m$sampleInput\x1B[0m';

      expect(blue.wrap(sampleInput), expected);
    });

    _test("style", () {
      final expected = '\x1B[1m$sampleInput\x1B[22m';

      expect(styleBold.wrap(sampleInput), expected);
    });

    _test("style", () {
      final expected = '\x1B[34m$sampleInput\x1B[0m';

      expect(blue.wrap(sampleInput), expected);
    });

    test("empty", () {
      expect(blue.wrap(''), '');
    });

    test(null, () {
      expect(blue.wrap(null), isNull);
    });
  });

  group('wrapWith', () {
    _test("foreground", () {
      final expected = '\x1B[34m$sampleInput\x1B[0m';

      expect(wrapWith(sampleInput, [blue]), expected);
    });

    _test("background", () {
      final expected = '\x1B[44m$sampleInput\x1B[0m';

      expect(wrapWith(sampleInput, [backgroundBlue]), expected);
    });

    _test("style", () {
      final expected = '\x1B[1m$sampleInput\x1B[0m';

      expect(wrapWith(sampleInput, [styleBold]), expected);
    });

    _test("2 styles", () {
      final expected = '\x1B[1;3m$sampleInput\x1B[0m';

      expect(wrapWith(sampleInput, [styleBold, styleItalic]), expected);
    });

    _test("2 foregrounds", () {
      expect(() => wrapWith(sampleInput, [blue, white]), throwsArgumentError);
    });

    _test("multi", () {
      final expected = '\x1B[1;4;34;107m$sampleInput\x1B[0m';

      expect(
          wrapWith(
              sampleInput, [blue, backgroundWhite, styleBold, styleUnderlined]),
          expected);
    });

    test('no codes', () {
      expect(wrapWith(sampleInput, []), sampleInput);
    });

    _test("empty", () {
      expect(wrapWith('', [blue, backgroundWhite, styleBold]), '');
    });

    _test(null, () {
      expect(wrapWith(null, [blue, backgroundWhite, styleBold]), isNull);
    });
  });
}

void _test<T>(String name, T body()) =>
    test(name, () => overrideAnsiOutput<T>(true, body));
