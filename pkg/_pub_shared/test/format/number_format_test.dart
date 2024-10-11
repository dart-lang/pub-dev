// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/format/number_format.dart';
import 'package:test/test.dart';

void main() {
  test('0-999', () {
    expect(formatWithSuffix(0), '0');
    expect(formatWithSuffix(1), '1');
    expect(formatWithSuffix(23), '23');
    expect(formatWithSuffix(999), '999');
  });

  test('1000-999999', () {
    expect(formatWithSuffix(1000), '1.0k');
    expect(formatWithSuffix(1049), '1.0k');
    expect(formatWithSuffix(1050), '1.0k');
    expect(formatWithSuffix(1099), '1.0k');
    expect(formatWithSuffix(1100), '1.1k');
    expect(formatWithSuffix(23456), '23.4k');
    expect(formatWithSuffix(999499), '999.4k');
    expect(formatWithSuffix(999500), '999.5k');
    expect(formatWithSuffix(999999), '999.9k');
  });

  test('1000000-', () {
    expect(formatWithSuffix(999999 + 1), '1.0m');
    expect(formatWithSuffix(1234000), '1.2m');
  });

  test('Significant digit 0-999', () {
    expect(computeWith3SignificantDigits(0), (value: '0', suffix: ''));
    expect(computeWith3SignificantDigits(1), (value: '1', suffix: ''));
    expect(computeWith3SignificantDigits(23), (value: '23', suffix: ''));
    expect(computeWith3SignificantDigits(999), (value: '999', suffix: ''));
  });

  test('Significant digit 1000-999499', () {
    expect(computeWith3SignificantDigits(1000), (value: '1.00', suffix: 'k'));
    expect(computeWith3SignificantDigits(1049), (value: '1.05', suffix: 'k'));
    expect(computeWith3SignificantDigits(1051), (value: '1.05', suffix: 'k'));
    expect(computeWith3SignificantDigits(1100), (value: '1.10', suffix: 'k'));
    expect(computeWith3SignificantDigits(9500), (value: '9.50', suffix: 'k'));
    expect(computeWith3SignificantDigits(99500), (value: '99.5', suffix: 'k'));
    expect(computeWith3SignificantDigits(100490), (value: '100', suffix: 'k'));
    expect(computeWith3SignificantDigits(100500), (value: '101', suffix: 'k'));
    expect(computeWith3SignificantDigits(199500), (value: '200', suffix: 'k'));
    expect(computeWith3SignificantDigits(999499), (value: '999', suffix: 'k'));
  });

  test('Significant digit 999500-100000000', () {
    expect(computeWith3SignificantDigits(999500), (value: '1.00', suffix: 'M'));
    expect(computeWith3SignificantDigits(999999), (value: '1.00', suffix: 'M'));
    expect(
        computeWith3SignificantDigits(900000000), (value: '900', suffix: 'M'));
    expect(
        computeWith3SignificantDigits(999500000), (value: '1.00', suffix: 'B'));
    expect(computeWith3SignificantDigits(1009450000),
        (value: '1.01', suffix: 'B'));
    expect(computeWith3SignificantDigits(1094599999),
        (value: '1.09', suffix: 'B'));
    expect(computeWith3SignificantDigits(1095000001),
        (value: '1.10', suffix: 'B'));
    expect(computeWith3SignificantDigits(19000000000),
        (value: '19.0', suffix: 'B'));
  });
}
