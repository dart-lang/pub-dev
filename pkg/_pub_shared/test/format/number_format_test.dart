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
}
