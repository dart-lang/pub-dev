// Copyright 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:io/io.dart' hide sharedStdIn;
import 'package:test/test.dart';

void main() {
  StreamController<String> fakeStdIn;
  SharedStdIn sharedStdIn;

  setUp(() async {
    fakeStdIn = new StreamController<String>(sync: true);
    sharedStdIn = new SharedStdIn(fakeStdIn.stream.map((s) => s.codeUnits));
  });

  test('should allow a single subscriber', () async {
    final logs = <String>[];
    final sub = sharedStdIn.transform(UTF8.decoder).listen(logs.add);
    fakeStdIn.add('Hello World');
    await sub.cancel();
    expect(logs, ['Hello World']);
  });

  test('should allow multiple subscribers', () async {
    final logs = <String>[];
    final asUtf8 = sharedStdIn.transform(UTF8.decoder);
    var sub = asUtf8.listen(logs.add);
    fakeStdIn.add('Hello World');
    await sub.cancel();
    sub = asUtf8.listen(logs.add);
    fakeStdIn.add('Goodbye World');
    await sub.cancel();
    expect(logs, ['Hello World', 'Goodbye World']);
  });

  test('should throw if a subscriber is still active', () async {
    final active = sharedStdIn.listen((_) {});
    expect(() => sharedStdIn.listen((_) {}), throwsStateError);
    await active.cancel();
    expect(() => sharedStdIn.listen((_) {}), returnsNormally);
  });
}
