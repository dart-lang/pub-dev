// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartdoc_data/pub_dartdoc_data.dart';

void main() {
  test('name conversion', () {
    final value = ApiElement.fromJson({'name': 'a.B', 'parent': 'a'});
    expect(value.name, 'B');
    expect(value.qualifiedName, 'a.B');
  });
}
