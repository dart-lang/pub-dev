// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:term_glyph/term_glyph.dart' as glyph;

void main() {
  group("with ascii = false", () {
    setUpAll(() {
      glyph.ascii = false;
    });

    test("glyphs return Unicode versions", () {
      expect(glyph.topLeftCorner, equals("┌"));
      expect(glyph.teeUpBold, equals("┻"));
      expect(glyph.longLeftArrow, equals("◀━"));
    });

    test("glyphOrAscii returns the first argument", () {
      expect(glyph.glyphOrAscii("A", "B"), equals("A"));
    });
  });

  group("with ascii = true", () {
    setUpAll(() {
      glyph.ascii = true;
    });

    test("glyphs return ASCII versions", () {
      expect(glyph.topLeftCorner, equals(","));
      expect(glyph.teeUpBold, equals("+"));
      expect(glyph.longLeftArrow, equals("<="));
    });

    test("glyphOrAscii returns the second argument", () {
      expect(glyph.glyphOrAscii("A", "B"), equals("B"));
    });
  });
}
