// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:source_span/source_span.dart';
import 'package:source_span/src/colors.dart' as colors;

main() {
  var file;
  setUp(() {
    file = new SourceFile("""
foo bar baz
whiz bang boom
zip zap zop
""");
  });

  test("points to the span in the source", () {
    expect(file.span(4, 7).highlight(), equals("""
foo bar baz
    ^^^"""));
  });

  test("gracefully handles a missing source URL", () {
    var span = new SourceFile("foo bar baz").span(4, 7);
    expect(span.highlight(), equals("""
foo bar baz
    ^^^"""));
  });

  test("highlights the first line of a multiline span", () {
    expect(file.span(4, 20).highlight(), equals("""
foo bar baz
    ^^^^^^^^"""));
  });

  test("works for a point span", () {
    expect(file.location(4).pointSpan().highlight(), equals("""
foo bar baz
    ^"""));
  });

  test("works for a point span at the end of a line", () {
    expect(file.location(11).pointSpan().highlight(), equals("""
foo bar baz
           ^"""));
  });

  test("works for a point span at the end of the file", () {
    expect(file.location(38).pointSpan().highlight(), equals("""
zip zap zop
           ^"""));
  });

  test("works for a point span at the end of the file with no trailing newline",
      () {
    file = new SourceFile("zip zap zop");
    expect(file.location(11).pointSpan().highlight(), equals("""
zip zap zop
           ^"""));
  });

  test("works for a point span in an empty file", () {
    expect(new SourceFile("").location(0).pointSpan().highlight(),
        equals("""

^"""));
  });

  test("works for a single-line file without a newline", () {
    expect(new SourceFile("foo bar").span(0, 7).highlight(),
        equals("""
foo bar
^^^^^^^"""));
  });

  test("emits tabs for tabs", () {
    expect(new SourceFile(" \t \t\tfoo bar").span(5, 8).highlight(),
        equals("""
 \t \t\tfoo bar
 \t \t\t^^^"""));
  });

  test("supports lines of preceding context", () {
    var span = new SourceSpanWithContext(
        new SourceLocation(5, line: 3, column: 5, sourceUrl: "foo.dart"),
        new SourceLocation(12, line: 3, column: 12, sourceUrl: "foo.dart"),
        "foo bar",
        "previous\nlines\n-----foo bar-----\nfollowing line\n");

    expect(span.highlight(color: colors.YELLOW), equals("""
previous
lines
-----${colors.YELLOW}foo bar${colors.NONE}-----
     ${colors.YELLOW}^^^^^^^${colors.NONE}"""));
  });

  group("colors", () {
    test("doesn't colorize if color is false", () {
      expect(file.span(4, 7).highlight(color: false), equals("""
foo bar baz
    ^^^"""));
    });

    test("colorizes if color is true", () {
      expect(file.span(4, 7).highlight(color: true), equals("""
foo ${colors.RED}bar${colors.NONE} baz
    ${colors.RED}^^^${colors.NONE}"""));
    });

    test("uses the given color if it's passed", () {
      expect(file.span(4, 7).highlight(color: colors.YELLOW), equals("""
foo ${colors.YELLOW}bar${colors.NONE} baz
    ${colors.YELLOW}^^^${colors.NONE}"""));
    });
  });
}
