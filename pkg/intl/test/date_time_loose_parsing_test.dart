// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Tests for the loose option when parsing dates and times, which accept
/// mixed-case input and are able to skip missing delimiters. Such valid input
/// is only tested in basic US locale, it's hard to define for others.
/// Inputs which should fail because they're missing data (currently only the
/// year) are tested in more locales.
library date_time_loose_test;

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:test/test.dart';

main() {
  var format;

  var date = new DateTime(2014, 9, 3);

  check(String s) {
    expect(() => format.parse(s), throwsFormatException);
    expect(format.parseLoose(s), date);
  }

  test("Loose parsing yMMMd", () {
    // Note: We can't handle e.g. Sept, we don't have those abbreviations
    // in our data.
    // Also doesn't handle "sep3,2014", or "sep 3.2014"
    format = new DateFormat.yMMMd("en_US");
    check("Sep 3 2014");
    check("sep 3 2014");
    check("sep 3  2014");
    check("sep  3 2014");
    check("sep  3       2014");
    check("sep3 2014");
    check("september 3, 2014");
    check("sEPTembER 3, 2014");
    check("seP 3, 2014");
    check("Sep 3,2014");
  });

  test("Loose parsing yMMMd that parses strict", () {
    expect(format.parseLoose("Sep 3, 2014"), date);
  });

  test("Loose parsing yMd", () {
    format = new DateFormat.yMd("en_US");
    check("09 3 2014");
    check("09 00003    2014");
    check("09/    03/2014");
    check("09 / 03 / 2014");
  });

  test("Loose parsing yMd that parses strict", () {
    expect(format.parseLoose("09/03/2014"), date);
    expect(format.parseLoose("09/3/2014"), date);
  });

  test("Loose parsing should handle standalone month format", () {
    // This checks that LL actually sets the month.
    // The appended whitespace and extra d pattern are present to trigger the
    // loose parsing code path.
    expect(new DateFormat('LL/d', 'en_US').parseLoose("05/ 2").month, 5);
  });

  group("Loose parsing with year formats", () {
    test("should fail when year is omitted (en_US)", () {
      expect(() => new DateFormat('yyyy-MM-dd').parseLoose("1/11"),
          throwsFormatException);
    });

    test("should fail when year is omitted (ja)", () {
      initializeDateFormatting('ja', null);
      expect(() => new DateFormat.yMMMd("ja").parseLoose('12月12日'),
          throwsFormatException);
      expect(() => new DateFormat.yMd("ja").parseLoose('12月12日'),
          throwsFormatException);
      expect(() => new DateFormat.yMEd("ja").parseLoose('12月12日'),
          throwsFormatException);
      expect(() => new DateFormat.yMMMEd("ja").parseLoose('12月12日'),
          throwsFormatException);
      expect(() => new DateFormat.yMMMMd("ja").parseLoose('12月12日'),
          throwsFormatException);
      expect(() => new DateFormat.yMMMMEEEEd("ja").parseLoose('12月12日'),
          throwsFormatException);
    });

    test("should fail when year is omitted (hu)", () {
      initializeDateFormatting('hu', null);
      expect(() => new DateFormat.yMMMd("hu").parseLoose('3. 17.'),
          throwsFormatException);
      expect(() => new DateFormat.yMd("hu").parseLoose('3. 17.'),
          throwsFormatException);
      expect(() => new DateFormat.yMEd("hu").parseLoose('3. 17.'),
          throwsFormatException);
      expect(() => new DateFormat.yMMMEd("hu").parseLoose('3. 17.'),
          throwsFormatException);
      expect(() => new DateFormat.yMMMMd("hu").parseLoose('3. 17.'),
          throwsFormatException);
      expect(() => new DateFormat.yMMMMEEEEd("hu").parseLoose('3. 17.'),
          throwsFormatException);
    });
  });
}
