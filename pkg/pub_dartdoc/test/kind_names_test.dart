// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:dartdoc/dartdoc.dart';
import 'package:pub_dartdoc_data/dartdoc_index.dart';
import 'package:test/test.dart';

void main() {
  test('kind names', () {
    // The `index.json`-parsing code should not depend on `package:dartdoc` in
    // the long term (e.g. when we want to call SDK-specific dartdoc and/or
    // non-customized dartdoc), however, we still need these values.
    // This test ensures that the mapping is still correct.
    final expected = <int, String>{};
    for (final k in Kind.values) {
      expected[k.index] = k.toString();
    }
    expect(kindNames, expected);
  });
}
