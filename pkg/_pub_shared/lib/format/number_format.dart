// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Formats an int [value] to human readable chunk and suffix.
/// The chunk will have a single digit precision, and will be
/// rounded down, in order to prevent exaggerated counts.
String formatWithSuffix(int value) {
  final f = computeValueWithSuffix(value);
  return '${_toFixed(f.value)}${f.suffix}';
}

({num value, String suffix}) computeValueWithSuffix(int value) {
  if (value >= 1000000) {
    return (value: _singleDigitDivision(value, 1000000), suffix: 'm');
  } else if (value >= 1000) {
    return (value: _singleDigitDivision(value, 1000), suffix: 'k');
  } else {
    return (value: value, suffix: '');
  }
}

num _singleDigitDivision(int value, int d) {
  return (((value * 10) ~/ d) / 10);
}

String _toFixed(num value) {
  return value < 1000 ? '$value' : value.toStringAsFixed(1);
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
