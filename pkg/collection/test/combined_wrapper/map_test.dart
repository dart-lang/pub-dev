// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:test/test.dart';

import '../unmodifiable_collection_test.dart' as common;

void main() {
  var map1 = const {1: 1, 2: 2, 3: 3};
  var map2 = const {4: 4, 5: 5, 6: 6};
  var map3 = const {7: 7, 8: 8, 9: 9};
  var concat = {}..addAll(map1)..addAll(map2)..addAll(map3);

  // In every way possible this should test the same as an UnmodifiableMapView.
  common.testReadMap(
      concat, new CombinedMapView([map1, map2, map3]), 'CombinedMapView');

  common.testReadMap(
      concat,
      new CombinedMapView([map1, {}, map2, {}, map3, {}]),
      'CombinedMapView (some empty)');

  test('should function as an empty map when no maps are passed', () {
    var empty = new CombinedMapView([]);
    expect(empty, isEmpty);
    expect(empty.length, 0);
  });

  test('should function as an empty map when only empty maps are passed', () {
    var empty = new CombinedMapView([{}, {}, {}]);
    expect(empty, isEmpty);
    expect(empty.length, 0);
  });

  test('should reflect underlying changes back to the combined map', () {
    var backing1 = <int, int>{};
    var backing2 = <int, int>{};
    var combined = new CombinedMapView([backing1, backing2]);
    expect(combined, isEmpty);
    backing1.addAll(map1);
    expect(combined, map1);
    backing2.addAll(map2);
    expect(combined, new Map.from(backing1)..addAll(backing2));
  });

  test('should reflect underlying changes with a single map', () {
    var backing1 = <int, int>{};
    var combined = new CombinedMapView([backing1]);
    expect(combined, isEmpty);
    backing1.addAll(map1);
    expect(combined, map1);
  });
}
