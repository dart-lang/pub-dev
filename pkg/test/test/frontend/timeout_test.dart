// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

void main() {
  group("Timeout.parse", () {
    group('for "none"', () {
      test("successfully parses", () {
        expect(new Timeout.parse("none"), equals(Timeout.none));
      });

      test("rejects invalid input", () {
        expect(() => new Timeout.parse(" none"), throwsFormatException);
        expect(() => new Timeout.parse("none "), throwsFormatException);
        expect(() => new Timeout.parse("xnone"), throwsFormatException);
        expect(() => new Timeout.parse("nonex"), throwsFormatException);
        expect(() => new Timeout.parse("noxe"), throwsFormatException);
      });
    });

    group("for a relative timeout", () {
      test("successfully parses", () {
        expect(new Timeout.parse("1x"), equals(new Timeout.factor(1)));
        expect(new Timeout.parse("2.5x"), equals(new Timeout.factor(2.5)));
        expect(new Timeout.parse("1.2e3x"), equals(new Timeout.factor(1.2e3)));
      });

      test("rejects invalid input", () {
        expect(() => new Timeout.parse(".x"), throwsFormatException);
        expect(() => new Timeout.parse("x"), throwsFormatException);
        expect(() => new Timeout.parse("ax"), throwsFormatException);
        expect(() => new Timeout.parse("1x "), throwsFormatException);
        expect(() => new Timeout.parse("1x5m"), throwsFormatException);
      });
    });

    group("for an absolute timeout", () {
      test("successfully parses all supported units", () {
        expect(new Timeout.parse("2d"),
            equals(new Timeout(new Duration(days: 2))));
        expect(new Timeout.parse("2h"),
            equals(new Timeout(new Duration(hours: 2))));
        expect(new Timeout.parse("2m"),
            equals(new Timeout(new Duration(minutes: 2))));
        expect(new Timeout.parse("2s"),
            equals(new Timeout(new Duration(seconds: 2))));
        expect(new Timeout.parse("2ms"),
            equals(new Timeout(new Duration(milliseconds: 2))));
        expect(new Timeout.parse("2us"),
            equals(new Timeout(new Duration(microseconds: 2))));
      });

      test("supports non-integer units", () {
        expect(new Timeout.parse("2.73d"),
            equals(new Timeout(new Duration(days: 1) * 2.73)));
      });

      test("supports multiple units", () {
        expect(
            new Timeout.parse("1d 2h3m  4s5ms\t6us"),
            equals(new Timeout(new Duration(
                days: 1,
                hours: 2,
                minutes: 3,
                seconds: 4,
                milliseconds: 5,
                microseconds: 6))));
      });

      test("rejects invalid input", () {
        expect(() => new Timeout.parse(".d"), throwsFormatException);
        expect(() => new Timeout.parse("d"), throwsFormatException);
        expect(() => new Timeout.parse("ad"), throwsFormatException);
        expect(() => new Timeout.parse("1z"), throwsFormatException);
        expect(() => new Timeout.parse("1u"), throwsFormatException);
        expect(() => new Timeout.parse("1d5x"), throwsFormatException);
        expect(() => new Timeout.parse("1d*5m"), throwsFormatException);
      });
    });
  });
}
