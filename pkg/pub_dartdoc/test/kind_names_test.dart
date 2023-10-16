// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:dartdoc/dartdoc.dart';
import 'package:pub_dartdoc_data/dartdoc_index.dart';
import 'package:test/test.dart';

void main() {
  test('kind names', () {
    final expected = <int, String>{};
    for (final k in Kind.values) {
      expected[k.index] = k.toString();
    }
    expect(kindNames, expected);
  });
}
