// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Formats an int [value] to human readable chunk and suffix.
/// The chunk will have a single digit precision, and will be
/// rounded down, in order to prevent exaggerated counts.
String formatWithSuffix(int value) {
  if (value >= 1000000) {
    return '${_toFixed(value, 1000000)}m';
  } else if (value >= 1000) {
    return '${_toFixed(value, 1000)}k';
  } else {
    return value.toString();
  }
}

String _toFixed(int value, int d) {
  return (((value * 10) ~/ d) / 10).toStringAsFixed(1);
}

/// Formats an int [value] with commas as thousand seperators.
String formatWithThousandSeperators(int value) {
  final digits = value.toString().split('');
  final l = digits.length - 1;
  final buffer = StringBuffer();
  for (int j = 0; j <= l; j++) {
    if (j > 0 && j % 3 == 0) {
      buffer.write(',');
    }
    buffer.write(digits[l - j]);
  }
  return buffer.toString().split('').reversed.join();
}

/// Formats an int [value] to human readable chunk and suffix with at most 3
/// significant digits.
({String value, String suffix}) formatWith3SignificantDigits(int value) {
  if (value >= 999500000) {
    return (
      value: (value / 1000000000).toStringAsPrecision(3),
      suffix: 'B',
    );
  } else if (value >= 999500) {
    return (
      value: (value / 1000000).toStringAsPrecision(3),
      suffix: 'M',
    );
  } else if (value >= 1000) {
    return (
      value: (value / 1000).toStringAsPrecision(3),
      suffix: 'k',
    );
  } else {
    return (
      value: value.toString(),
      suffix: '',
    );
  }
}
