// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:indexed_blob/indexed_blob.dart';
import 'package:test/test.dart';

void main() {
  late Directory tmp;
  setUp(() async {
    tmp = await Directory.systemTemp.createTemp('pub_worker-test-');
  });
  tearDown(() async {
    await tmp.delete(recursive: true);
  });

  test('Simple files in blob', () async {
    final blobFile = File('${tmp.path}/test.blob');

    final b = IndexedBlobBuilder(blobFile.openWrite());
    await b.addFile('README.md', Stream.value([0, 0]));
    await b.addFile('hello.txt', Stream.value([1, 2, 3, 4, 5]));
    await b.addFile('lib/src/test-a.dart', Stream.value([100]));
    await b.addFile('lib/src/test-b.dart', Stream.value([101]));

    final index = await b.buildIndex('42');

    expect(index.blobId, equals('42'));

    expect(index.lookup('missing-file'), isNull);

    expect(index.lookup('hello.txt'), isNotNull);

    final blob = await blobFile.readAsBytes();
    void expectFile(String path, List<int> data) {
      final range = index.lookup(path);
      expect(range, isNotNull);
      expect(blob.sublist(range!.start, range.end), equals(data));
    }

    json.decode(utf8.decode(index.asBytes()));

    expectFile('README.md', [0, 0]);
    expectFile('hello.txt', [1, 2, 3, 4, 5]);
    expectFile('hello.txt', [1, 2, 3, 4, 5]);
    expectFile('lib/src/test-a.dart', [100]);
    expectFile('lib/src/test-b.dart', [101]);
  });

  test('BlobIndex.updated', () async {
    final blobFile = File('${tmp.path}/test.blob');

    final b = IndexedBlobBuilder(blobFile.openWrite());
    await b.addFile('README.md', Stream.value([0, 0]));
    await b.addFile('hello.txt', Stream.value([1, 2, 3, 4, 5]));
    await b.addFile('lib/src/test-a.dart', Stream.value([100]));
    await b.addFile('lib/src/test-b.dart', Stream.value([101]));

    final index1 = await b.buildIndex('hello-world');
    expect(index1.blobId, equals('hello-world'));

    final index2 = index1.update(blobId: '42');

    expect(index2.blobId, equals('42'));

    expect(index2.lookup('missing-file'), isNull);

    expect(index2.lookup('hello.txt'), isNotNull);

    final blob = await blobFile.readAsBytes();
    void expectFile(String path, List<int> data) {
      final range = index2.lookup(path);
      expect(range, isNotNull);
      expect(blob.sublist(range!.start, range.end), equals(data));
    }

    json.decode(utf8.decode(index2.asBytes()));

    expectFile('README.md', [0, 0]);
    expectFile('hello.txt', [1, 2, 3, 4, 5]);
    expectFile('hello.txt', [1, 2, 3, 4, 5]);
    expectFile('lib/src/test-a.dart', [100]);
    expectFile('lib/src/test-b.dart', [101]);
  });

  test('BlobIndex.files', () async {
    final blobFile = File('${tmp.path}/test.blob');

    final b = IndexedBlobBuilder(blobFile.openWrite());
    await b.addFile('README.md', Stream.value([0, 0]));
    await b.addFile('hello.txt', Stream.value([1, 2, 3, 4, 5]));
    await b.addFile('lib/src/test-a.dart', Stream.value([100]));
    await b.addFile('lib/src/test-b.dart', Stream.value([101]));
    await b.addFile('log.txt', Stream.value([0, 0]));

    expect(b.indexUpperLength, 184);
    final index = await b.buildIndex('42');
    expect(index.asBytes().length, 146);

    final files = index.files.toList();
    expect(files, hasLength(5));
  });

  test('size limit', () async {
    final controller = StreamController<List<int>>();
    final result = controller.stream.toList();
    final b = IndexedBlobBuilder(controller);
    expect(
      await b.addFile('a', Stream.value([0, 1]), skipAfterSize: 3),
      isTrue,
    );
    expect(
      await b.addFile(
        'b',
        Stream.fromIterable([
          [0],
          [1, 2, 3], // will be removed,
        ]),
        skipAfterSize: 3,
      ),
      isFalse,
    );
    expect(
      await b.addFile('c', Stream.value([8, 9]), skipAfterSize: 3),
      isTrue,
    );
    final index = await b.buildIndex('1');
    final files = index.files.toList();
    expect(files, hasLength(2));
    await controller.close();
    expect(await result, [
      [0, 1],
      [0],
      [],
      [8, 9],
    ]);

    expect(index.lookup('b'), isNull);

    final c = index.lookup('c')!;
    expect(c.start, 3);
    expect(c.end, 5);
  });
}
