// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';

import 'package:test/test.dart';

import 'package:stream_transform/stream_transform.dart';

void main() {
  test('forwards only events that pass the predicate', () async {
    var values = new Stream.fromIterable([1, 2, 3, 4]);
    var filtered = values.transform(asyncWhere((e) async => e > 2));
    expect(await filtered.toList(), [3, 4]);
  });

  test('allows predicates that go through event loop', () async {
    var values = new Stream.fromIterable([1, 2, 3, 4]);
    var filtered = values.transform(asyncWhere((e) async {
      await new Future(() {});
      return e > 2;
    }));
    expect(await filtered.toList(), [3, 4]);
  });

  test('allows synchronous predicate', () async {
    var values = new Stream.fromIterable([1, 2, 3, 4]);
    var filtered = values.transform(asyncWhere((e) => e > 2));
    expect(await filtered.toList(), [3, 4]);
  });

  test('can result in empty stream', () async {
    var values = new Stream.fromIterable([1, 2, 3, 4]);
    var filtered = values.transform(asyncWhere((e) => e > 4));
    expect(await filtered.isEmpty, true);
  });

  test('forwards values to multiple listeners', () async {
    var values = new StreamController.broadcast();
    var filtered = values.stream.transform(asyncWhere((e) async => e > 2));
    var firstValues = [];
    var secondValues = [];
    filtered..listen(firstValues.add)..listen(secondValues.add);
    values..add(1)..add(2)..add(3)..add(4);
    await new Future(() {});
    expect(firstValues, [3, 4]);
    expect(secondValues, [3, 4]);
  });

  test('closes streams with multiple listeners', () async {
    var values = new StreamController.broadcast();
    var predicate = new Completer<bool>();
    var filtered = values.stream.transform(asyncWhere((_) => predicate.future));
    var firstDone = false;
    var secondDone = false;
    filtered
      ..listen(null, onDone: () => firstDone = true)
      ..listen(null, onDone: () => secondDone = true);
    values.add(1);
    await values.close();
    expect(firstDone, false);
    expect(secondDone, false);

    predicate.complete(true);
    await new Future(() {});
    expect(firstDone, true);
    expect(secondDone, true);
  });
}
