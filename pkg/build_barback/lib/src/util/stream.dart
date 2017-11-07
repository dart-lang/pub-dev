// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';

Future<List<int>> combineByteStream(Stream<List<int>> stream) async {
  var chunks = await stream.toList();
  return chunks.fold<List<int>>(<int>[], (p, e) {
    p.addAll(e);
    return p;
  });
}
