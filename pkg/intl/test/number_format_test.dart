/// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
/// for details. All rights reserved. Use of this source code is governed by a
/// BSD-style license that can be found in the LICENSE file.

library number_format_test;

import 'package:test/test.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:intl/intl.dart';
import 'number_test_data.dart';
import 'dart:math';

/// Tests the Numeric formatting library in dart.
var testNumbersWeCanReadBack = {
  "-1": -1,
  "-2": -2.0,
  "-0.01": -0.01,
  "-1.23": -1.23,
  "0.001": 0.001,
  "0.01": 0.01,
  "0.1": 0.1,
  "1": 1,
  "2": 2.0,
  "10": 10,
  "100": 100,
  "1,000": 1000,
  "2,000,000,000,000": 2000000000000,
  "0.123": 0.123,
  "1,234": 1234.0,
  "1.234": 1.234,
  "1.23": 1.230,
  "NaN": double.NAN,
  "∞": double.INFINITY,
  "-∞": double.NEGATIVE_INFINITY,
};

/// Test numbers that we can't parse because we lose precision in formatting.
var testNumbersWeCannotReadBack = {
  "3.142": PI,
  "-1.234": -1.2342,
  "-1.235": -1.2348,
  "1.234": 1.2342,
  "1.235": 1.2348
};

/// Test numbers that won't work in Javascript because they're too big.
var testNumbersOnlyForTheVM = {
  "10,000,000,000,000,000,000,000,000,000,000":
      10000000000000000000000000000000,
};

get allTestNumbers => new Map.from(testNumbersWeCanReadBack)
  ..addAll(testNumbersWeCannotReadBack)
  ..addAll(inJavaScript() ? {} : testNumbersOnlyForTheVM);

var testExponential = const {"1E-3": 0.001, "1E-2": 0.01, "1.23E0": 1.23};

// TODO(alanknight): Test against currency, which requires generating data
// for the three different forms that this now supports.
// TODO(alanknight): Test against scientific, which requires significant
// digit support.
List<NumberFormat> standardFormats(String locale) {
  return [
    new NumberFormat.decimalPattern(locale),
    new NumberFormat.percentPattern(locale),
  ];
}

// Pay no attention to the hint. This is here deliberately to have different
// behavior in the Dart VM versus Javascript so we can distinguish the two.
inJavaScript() => 1 is double;

main() {
  // For data from a list of locales, run each locale's data as a separate
  // test so we can see exactly which ones pass or fail. The test data is
  // hard-coded as printing 123, -12.3, %12,300, -1,230% in each locale.
  var mainList = numberTestData;
  var sortedLocales = new List.from(numberFormatSymbols.keys);
  sortedLocales.sort((a, b) => a.compareTo(b));
  for (var locale in sortedLocales) {
    var testFormats = standardFormats(locale);
    var testLength = (testFormats.length * 3) + 1;
    var list = mainList.take(testLength).iterator;
    list.moveNext();
    mainList = mainList.skip(testLength);
    if (locale == list.current) {
      testAgainstIcu(locale, testFormats, list);
    }
  }

  test('Simple set of numbers', () {
    var number = new NumberFormat();
    for (var x in allTestNumbers.keys) {
      var formatted = number.format(allTestNumbers[x]);
      expect(formatted, x);
      if (!testNumbersWeCannotReadBack.containsKey(x)) {
        var readBack = number.parse(formatted);
        // Even among ones we can read back, we can't test NaN for equality.
        if (allTestNumbers[x].isNaN) {
          expect(readBack.isNaN, isTrue);
        } else {
          expect(readBack, allTestNumbers[x]);
        }
      }
    }
  });

  test('Padding left', () {
    var expected = [
      '1',
      '1',
      '01',
      '001',
      '0,001',
      '00,001',
      '000,001',
      '0,000,001'
    ];
    for (var i = 0; i < 7; i++) {
      var f = new NumberFormat.decimalPattern();
      f.minimumIntegerDigits = i;
      expect(f.format(1), expected[i]);
    }
  });

  test('Exponential form', () {
    var number = new NumberFormat("#.###E0");
    for (var x in testExponential.keys) {
      var formatted = number.format(testExponential[x]);
      expect(formatted, x);
      var readBack = number.parse(formatted);
      expect(testExponential[x], readBack);
    }
  });

  test('Percent with no decimals and no integer part', () {
    var number = new NumberFormat("#%");
    var formatted = number.format(0.12);
    expect(formatted, "12%");
    var readBack = number.parse(formatted);
    expect(0.12, readBack);
  });

  // We can't do these in the normal tests because those also format the
  // numbers and we're reading them in a format where they won't print
  // back the same way.
  test('Parsing modifiers,e.g. percent, in the base format', () {
    var number = new NumberFormat();
    var modified = {"12%": 0.12, "12\u2030": 0.012};
    modified.addAll(testExponential);
    for (var x in modified.keys) {
      var parsed = number.parse(x);
      expect(parsed, modified[x]);
    }
  });

  test('Explicit currency name', () {
    var amount = 1000000.32;
    var usConvention = new NumberFormat.currency(locale: 'en_US', symbol: '€');
    var formatted = usConvention.format(amount);
    expect(formatted, '€1,000,000.32');
    var readBack = usConvention.parse(formatted);
    expect(readBack, amount);
    var swissConvention = new NumberFormat.currencyPattern('de_CH', r'$');
    formatted = swissConvention.format(amount);
    var nbsp = new String.fromCharCode(0xa0);
    var backquote = new String.fromCharCode(0x2019);
    expect(formatted,
        r"$" + nbsp + "1" + backquote + "000" + backquote + "000.32");
    readBack = swissConvention.parse(formatted);
    expect(readBack, amount);

    var italianSwiss = new NumberFormat.currencyPattern('it_CH', r'$');
    formatted = italianSwiss.format(amount);
    expect(formatted,
        r"$" + nbsp + "1" + backquote + "000" + backquote + "000.32");
    readBack = italianSwiss.parse(formatted);
    expect(readBack, amount);

    /// Verify we can leave off the currency and it gets filled in.
    var plainSwiss = new NumberFormat.currency(locale: 'de_CH');
    formatted = plainSwiss.format(amount);
    expect(formatted,
        r"CHF" + nbsp + "1" + backquote + "000" + backquote + "000.32");
    readBack = plainSwiss.parse(formatted);
    expect(readBack, amount);

    // Verify that we can pass null in order to specify the currency symbol
    // but use the default locale.
    var defaultLocale = new NumberFormat.currencyPattern(null, 'Smurfs');
    formatted = defaultLocale.format(amount);
    // We don't know what the exact format will be, but it should have Smurfs.
    expect(formatted.contains('Smurfs'), isTrue);
    readBack = defaultLocale.parse(formatted);
    expect(readBack, amount);
  });

  test("Delta percent format", () {
    var f = new NumberFormat("+#,##0%;-#,##0%");
    expect(f.format(-0.07), "-7%");
    expect(f.format(0.12), "+12%");
  });

  test('Unparseable', () {
    var format = new NumberFormat.currency();
    expect(() => format.parse("abcdefg"), throwsFormatException);
    expect(() => format.parse(""), throwsFormatException);
    expect(() => format.parse("1.0zzz"), throwsFormatException);
    expect(() => format.parse("-∞+1"), throwsFormatException);
  });

  var digitsCheck = {
    0: "@4",
    1: "@4.3",
    2: "@4.32",
    3: "@4.322",
    4: "@4.3220",
  };

  test('Decimal digits', () {
    var amount = 4.3219876;
    for (var digits in digitsCheck.keys) {
      var f = new NumberFormat.currency(
          locale: 'en_US', symbol: '@', decimalDigits: digits);
      var formatted = f.format(amount);
      expect(formatted, digitsCheck[digits]);
    }
    var defaultFormat = new NumberFormat.currency(locale: 'en_US', symbol: '@');
    var formatted = defaultFormat.format(amount);
    expect(formatted, digitsCheck[2]);

    var jpyUs =
        new NumberFormat.currency(locale: 'en_US', name: 'JPY', symbol: '@');
    formatted = jpyUs.format(amount);
    expect(formatted, digitsCheck[0]);

    var jpyJa =
        new NumberFormat.currency(locale: 'ja', name: 'JPY', symbol: '@');
    formatted = jpyJa.format(amount);
    expect(formatted, digitsCheck[0]);

    var jpySimple = new NumberFormat.simpleCurrency(locale: 'ja', name: 'JPY');
    formatted = jpySimple.format(amount);
    expect(formatted, "¥4");

    var jpyLower =
        new NumberFormat.currency(locale: 'en_US', name: 'jpy', symbol: '@');
    formatted = jpyLower.format(amount);
    expect(formatted, digitsCheck[0]);

    var tnd = new NumberFormat.currency(name: 'TND', symbol: '@');
    formatted = tnd.format(amount);
    expect(formatted, digitsCheck[3]);
  });

  testSimpleCurrencySymbols();

  test('Padding digits with non-ascii zero', () {
    var format = new NumberFormat('000', 'ar');
    var padded = format.format(0);
    expect(padded, '٠٠٠');
  });
}

String stripExtras(String input) {
  // Some of these results from CLDR have a leading LTR/RTL indicator,
  // and/or Arabic letter indicator,
  // which we don't want. We also treat the difference between Unicode
  // minus sign (2212) and hyphen-minus (45) as not significant.
  return input
      .replaceAll("\u200e", "")
      .replaceAll("\u200f", "")
      .replaceAll("\u061c", "")
      .replaceAll("\u2212", "-");
}

void testAgainstIcu(locale, List<NumberFormat> testFormats, list) {
  test("Test against ICU data for $locale", () {
    for (var format in testFormats) {
      var formatted = format.format(123);
      var negative = format.format(-12.3);
      var large = format.format(1234567890);
      var expected = (list..moveNext()).current;
      expect(formatted, expected);
      var expectedNegative = (list..moveNext()).current;
      expect(stripExtras(negative), stripExtras(expectedNegative));
      var expectedLarge = (list..moveNext()).current;
      expect(large, expectedLarge);
      var readBack = format.parse(formatted);
      expect(readBack, 123);
      var readBackNegative = format.parse(negative);
      expect(readBackNegative, -12.3);
      var readBackLarge = format.parse(large);
      expect(readBackLarge, 1234567890);
    }
  });
}

testSimpleCurrencySymbols() {
  var currencies = ['USD', 'CAD', 'EUR', 'CRC', null];
  //  Note that these print using the simple symbol as if we were in a
  // a locale where that currency symbol is well understood. So we
  // expect Canadian dollars printed as $, even though our locale is
  // en_US, and this would confuse users.
  var simple = currencies.map((currency) =>
      new NumberFormat.simpleCurrency(locale: 'en_US', name: currency));
  var expectedSimple = [r'$', r'$', '\u20ac', '\u20a1', r'$'];
  // These will always print as the global name, regardless of locale
  var global = currencies.map(
      (currency) => new NumberFormat.currency(locale: 'en_US', name: currency));
  var expectedGlobal = currencies.map((curr) => curr ?? 'USD').toList();

  testCurrencySymbolsFor(expectedGlobal, global, "global");
  testCurrencySymbolsFor(expectedSimple, simple, "simple");
}

testCurrencySymbolsFor(expected, formats, name) {
  var amount = 1000000.32;
  new Map<Object, NumberFormat>.fromIterables(expected, formats)
      .forEach((expected, NumberFormat format) {
    test("Test $name ${format.currencyName}", () {
      // Allow for currencies with different fraction digits, e.g. CRC.
      var maxDigits = format.maximumFractionDigits;
      var rounded = maxDigits == 0 ? amount.round() : amount;
      var fractionDigits = (amount - rounded) < 0.00001 ? '.32' : '';
      var formatted = format.format(rounded);
      expect(formatted, "${expected}1,000,000$fractionDigits");
      var parsed = format.parse(formatted);
      expect(parsed, rounded);
    });
  });
}
