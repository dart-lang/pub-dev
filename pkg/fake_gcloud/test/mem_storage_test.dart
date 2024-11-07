// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:fake_gcloud/mem_storage.dart';
import 'package:test/test.dart';

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

  test('list', () async {
    final storage = MemStorage(buckets: ['test']);
    final bucket = storage.bucket('test');
    await bucket.writeBytes('a/b/c.txt', [0]);
    await bucket.writeBytes('a/b-local.txt', [0]);

    Future<List<String>> list(String? prefix, {String? delimiter}) async {
      final r = await bucket
          .list(prefix: prefix, delimiter: delimiter)
          .map((e) => e.name)
          .toList();
      r.sort();
      return r;
    }

    // no prefix
    expect(await list(null), ['a/']);
    expect(await list(''), ['a/']);

    // prefix does not exists
    expect(await list('x'), []);
    expect(await list('x/'), []);

    // directory prefix with both local file and subfolder
    expect(await list('a'), []);
    expect(await list('a/'), ['a/b-local.txt', 'a/b/']);

    // directory prefix with only local files
    expect(await list('a/b'), ['a/b-local.txt']);
    expect(await list('a/b/'), ['a/b/c.txt']);

    // no delimiter (recursive)
    expect(await list('', delimiter: ''), ['a/b-local.txt', 'a/b/c.txt']);
    expect(await list('a/b/', delimiter: ''), ['a/b/c.txt']);

    // non-standard delimiter
    expect(await list('', delimiter: '-'), ['a/b-', 'a/b/c.txt']);
  });

  test('page', () async {
    final storage = MemStorage(buckets: ['test']);
    final bucket = storage.bucket('test');
    await bucket.writeBytes('a/b/c.txt', [0]);
    await bucket.writeBytes('a/b-local.txt', [0]);

    final p1 = await bucket.page(delimiter: '', pageSize: 1);
    expect(p1.items.single.name, 'a/b-local.txt');
    expect(p1.isLast, false);

    final p2 = await p1.next();
    expect(p2.items.single.name, 'a/b/c.txt');
    expect(p2.isLast, true);
  });

  test('write and read', () async {
    final storage = MemStorage(buckets: ['test']);
    final bucket = storage.bucket('test');
    await bucket.writeBytes('file.txt', [1, 2]);
    final info = await bucket.info('file.txt');

    final sb = StringBuffer();
    storage.writeTo(sb);

    final newStorage = MemStorage();
    newStorage.readFrom(sb.toString().split('\n'));

    final newInfo = await newStorage.bucket('test').info('file.txt');
    expect(newInfo.length, info.length);
    expect(newInfo.etag, info.etag);
  });
}
