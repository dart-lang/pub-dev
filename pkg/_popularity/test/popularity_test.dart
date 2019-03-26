// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:_popularity/popularity.dart';
import 'package:test/test.dart';

void main() {
  test('popularity round trip', () {
    final string = File('test/popularity-sample.json').readAsStringSync();
    final popularity =
        PackagePopularity.fromJson(json.decode(string) as Map<String, dynamic>);
    expect(popularity.dateFirst.isUtc, isTrue);
    expect(popularity.dateFirst.isUtc, isTrue);

    final encoder = const JsonEncoder.withIndent(' ');

    expect(encoder.convert(popularity), string);
  });
}
