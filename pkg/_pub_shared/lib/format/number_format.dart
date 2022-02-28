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
