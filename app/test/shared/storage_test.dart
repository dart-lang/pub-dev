// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/storage.dart';
import 'package:pub_dev/shared/storage.dart';
import 'package:test/test.dart';

/// A [Bucket] whose reads connect and then never deliver a chunk.
class _StallingBucket implements Bucket {
  var readCount = 0;

  @override
  Stream<List<int>> read(String objectName, {int? offset, int? length}) {
    readCount++;
    return StreamController<List<int>>().stream;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test('readAsBytes gives up on a read that never delivers a chunk', () async {
    final bucket = _StallingBucket();
    await expectLater(
      bucket.readAsBytes(
        'object.txt',
        timeout: const Duration(milliseconds: 10),
      ),
      throwsA(isA<TimeoutException>()),
    );
    // The timeout is retryable, so all three attempts are used up.
    expect(bucket.readCount, 3);
  });
}
