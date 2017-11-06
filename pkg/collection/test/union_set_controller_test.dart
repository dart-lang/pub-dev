// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "package:test/test.dart";

import "package:collection/collection.dart";

void main() {
  var controller;
  var innerSet;
  setUp(() {
    innerSet = new Set.from([1, 2, 3]);
    controller = new UnionSetController<int>()..add(innerSet);
  });

  test("exposes a union set", () {
    expect(controller.set, unorderedEquals([1, 2, 3]));

    controller.add(new Set.from([3, 4, 5]));
    expect(controller.set, unorderedEquals([1, 2, 3, 4, 5]));

    controller.remove(innerSet);
    expect(controller.set, unorderedEquals([3, 4, 5]));
  });

  test("exposes a disjoint union set", () {
    expect(controller.set, unorderedEquals([1, 2, 3]));

    controller.add(new Set.from([4, 5, 6]));
    expect(controller.set, unorderedEquals([1, 2, 3, 4, 5, 6]));

    controller.remove(innerSet);
    expect(controller.set, unorderedEquals([4, 5, 6]));
  });
}
