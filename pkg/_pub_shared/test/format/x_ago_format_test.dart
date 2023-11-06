// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/format/x_ago_format.dart';
import 'package:test/test.dart';

void main() {
  test('formatXAgo', () {
    expect(formatXAgo(Duration()), 'in the last hour');
    expect(formatXAgo(Duration(minutes: 59)), 'in the last hour');
    expect(formatXAgo(Duration(minutes: 60)), '1 hour ago');
    expect(formatXAgo(Duration(minutes: 119)), '1 hour ago');
    expect(formatXAgo(Duration(minutes: 120)), '2 hours ago');
    expect(formatXAgo(Duration(minutes: 179)), '2 hours ago');
    expect(formatXAgo(Duration(minutes: 180)), '3 hours ago');
    expect(formatXAgo(Duration(hours: 47)), '47 hours ago');
    expect(formatXAgo(Duration(hours: 48)), '2 days ago');
    expect(formatXAgo(Duration(hours: 72)), '3 days ago');
    expect(formatXAgo(Duration(days: 60)), '60 days ago');
    expect(formatXAgo(Duration(days: 61)), '2 months ago');
    expect(formatXAgo(Duration(days: 365 * 2)), '24 months ago');
    expect(formatXAgo(Duration(days: 365 * 2 + 1)), '2 years ago');
  });
}
