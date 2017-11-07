// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:pana/src/utils.dart';
import 'package:test/test.dart';

void main() {
  test("sorted json", () {
    expect(
        JSON.encode(sortedJson({
          'b': [
            {'e': 3, 'd': 4}
          ],
          'a': 2
        })),
        '{"a":2,"b":[{"d":4,"e":3}]}');
  });
}
