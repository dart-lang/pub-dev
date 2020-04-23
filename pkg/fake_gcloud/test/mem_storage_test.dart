// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:fake_gcloud/mem_storage.dart';

void main() {
  test('bucket existence', () async {
    final storage = MemStorage(buckets: ['test']);
    expect(await storage.bucketExists('test'), isTrue);
    await storage.deleteBucket('test');
    expect(await storage.bucketExists('test'), isFalse);
    await storage.createBucket('test');
    expect(await storage.bucketExists('test'), isTrue);
  });

  test('write and read content', () async {
    final storage = MemStorage(buckets: ['test']);
    final bucket = storage.bucket('test');
    expect(() => bucket.info('/file.txt'), throwsA(anything));
    expect(() => bucket.info('file.txt'), throwsA(anything));
    final info = await bucket.writeBytes('file.txt', [1, 2]);
    expect(info.length, 2);
    final data = await bucket
        .read('file.txt')
        .fold<List<int>>(<int>[], (buffer, data) => buffer..addAll(data));
    expect(data, [1, 2]);
    await bucket.delete('file.txt');
    expect(() => bucket.info('/file.txt'), throwsA(anything));
    expect(() => bucket.info('file.txt'), throwsA(anything));
  });
}
