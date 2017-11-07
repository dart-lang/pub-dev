// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';

import 'package:test/test.dart';

import 'package:build_barback/src/util/stream.dart';

main() {
  test('combineByteStream', () async {
    var stream = _toByteStream([
      [1, 2, 3],
      [4, 5],
      [],
      [6]
    ]);
    var bytes = await combineByteStream(stream);
    expect(bytes, [1, 2, 3, 4, 5, 6]);
  });
}

Stream<List<int>> _toByteStream(List<List<int>> chunks) async* {
  for (var chunk in chunks) {
    yield chunk;
  }
}
