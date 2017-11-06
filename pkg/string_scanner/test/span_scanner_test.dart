// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:source_span/source_span.dart';
import 'package:string_scanner/string_scanner.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  testForImplementation("lazy", ([string]) {
    return new SpanScanner(string ?? 'foo\nbar\nbaz', sourceUrl: 'source');
  });

  testForImplementation("eager", ([string]) {
    return new SpanScanner.eager(string ?? 'foo\nbar\nbaz',
        sourceUrl: 'source');
  });

  group("within", () {
    var text = 'first\nbefore: foo\nbar\nbaz :after\nlast';
    var startOffset = text.indexOf('foo');

    var scanner;
    setUp(() {
      var file = new SourceFile.fromString(text, url: 'source');
      scanner = new SpanScanner.within(
          file.span(startOffset, text.indexOf(' :after')));
    });

    test("string only includes the span text", () {
      expect(scanner.string, equals("foo\nbar\nbaz"));
    });

    test("line and column are span-relative", () {
      expect(scanner.line, equals(0));
      expect(scanner.column, equals(0));

      scanner.scan("foo");
      expect(scanner.line, equals(0));
      expect(scanner.column, equals(3));

      scanner.scan("\n");
      expect(scanner.line, equals(1));
      expect(scanner.column, equals(0));
    });

    test("tracks the span for the last match", () {
      scanner.scan('fo');
      scanner.scan('o\nba');

      var span = scanner.lastSpan;
      expect(span.start.offset, equals(startOffset + 2));
      expect(span.start.line, equals(1));
      expect(span.start.column, equals(10));
      expect(span.start.sourceUrl, equals(Uri.parse('source')));

      expect(span.end.offset, equals(startOffset + 6));
      expect(span.end.line, equals(2));
      expect(span.end.column, equals(2));
      expect(span.start.sourceUrl, equals(Uri.parse('source')));

      expect(span.text, equals('o\nba'));
    });

    test(".spanFrom() returns a span from a previous state", () {
      scanner.scan('fo');
      var state = scanner.state;
      scanner.scan('o\nba');
      scanner.scan('r\nba');

      var span = scanner.spanFrom(state);
      expect(span.text, equals('o\nbar\nba'));
    });

    test(".emptySpan returns an empty span at the current location", () {
      scanner.scan('foo\nba');

      var span = scanner.emptySpan;
      expect(span.start.offset, equals(startOffset + 6));
      expect(span.start.line, equals(2));
      expect(span.start.column, equals(2));
      expect(span.start.sourceUrl, equals(Uri.parse('source')));

      expect(span.end.offset, equals(startOffset + 6));
      expect(span.end.line, equals(2));
      expect(span.end.column, equals(2));
      expect(span.start.sourceUrl, equals(Uri.parse('source')));

      expect(span.text, equals(''));
    });

    test(".error() uses an absolute span", () {
      scanner.expect("foo");
      expect(() => scanner.error('oh no!'),
          throwsStringScannerException("foo"));
    });

    test(".isDone returns true at the end of the span", () {
      scanner.expect("foo\nbar\nbaz");
      expect(scanner.isDone, isTrue);
    });
  });
}

void testForImplementation(String name, SpanScanner create()) {
  group("for a $name scanner", () {
    var scanner;
    setUp(() => scanner = create());

    test("tracks the span for the last match", () {
      scanner.scan('fo');
      scanner.scan('o\nba');

      var span = scanner.lastSpan;
      expect(span.start.offset, equals(2));
      expect(span.start.line, equals(0));
      expect(span.start.column, equals(2));
      expect(span.start.sourceUrl, equals(Uri.parse('source')));

      expect(span.end.offset, equals(6));
      expect(span.end.line, equals(1));
      expect(span.end.column, equals(2));
      expect(span.start.sourceUrl, equals(Uri.parse('source')));

      expect(span.text, equals('o\nba'));
    });

    test(".spanFrom() returns a span from a previous state", () {
      scanner.scan('fo');
      var state = scanner.state;
      scanner.scan('o\nba');
      scanner.scan('r\nba');

      var span = scanner.spanFrom(state);
      expect(span.text, equals('o\nbar\nba'));
    });

    test(".spanFrom() handles surrogate pairs correctly", () {
      scanner = create('fo\u{12345}o');
      scanner.scan('fo');
      var state = scanner.state;
      scanner.scan('\u{12345}o');
      var span = scanner.spanFrom(state);
      expect(span.text, equals('\u{12345}o'));
    });

    test(".emptySpan returns an empty span at the current location", () {
      scanner.scan('foo\nba');

      var span = scanner.emptySpan;
      expect(span.start.offset, equals(6));
      expect(span.start.line, equals(1));
      expect(span.start.column, equals(2));
      expect(span.start.sourceUrl, equals(Uri.parse('source')));

      expect(span.end.offset, equals(6));
      expect(span.end.line, equals(1));
      expect(span.end.column, equals(2));
      expect(span.start.sourceUrl, equals(Uri.parse('source')));

      expect(span.text, equals(''));
    });
  });
}
