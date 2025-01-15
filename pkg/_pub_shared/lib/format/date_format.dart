// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Formats a DateTime into abbriviated month and day

String formatAbbrMonthDay(DateTime date) {
  final String month;
  switch (date.month) {
    case 1:
      month = 'Jan';
    case 2:
      month = 'Feb';
    case 3:
      month = 'Mar';
    case 4:
      month = 'Apr';
    case 5:
      month = 'May';
    case 6:
      month = 'Jun';
    case 7:
      month = 'Jul';
    case 8:
      month = 'Aug';
    case 9:
      month = 'Sep';
    case 10:
      month = 'Oct';
    case 11:
      month = 'Nov';
    case 12:
      month = 'Dec';
    default:
      month = '';
  }
  return '$month ${date.day}';
}
