// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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

    final indexBytes = await b.buildIndex('42');

    final blob = await blobFile.readAsBytes();
    Future<Uint8List> readBlob(int start, int end) async =>
        blob.sublist(start, end);

    final index = BlobIndex.fromBytes(indexBytes, readBlob);

    expect(index.blobId, equals('42'));

    expect(await index.lookup('missing-file'), isNull);

    expect(await index.lookup('hello.txt'), isNotNull);

    Future<void> expectFile(String path, List<int> data) async {
      final range = await index.lookup(path);
      expect(range, isNotNull);

      final pl = range!.pathLength;
      expect(
        blob.sublist(range.entryOffset, range.entryOffset + 2 + pl),
        equals([pl >> 8, pl & 0xFF, ...utf8.encode(range.path)]),
      );
      expect(blob.sublist(range.contentStart, range.end), equals(data));
    }

    await expectFile('README.md', [0, 0]);
    await expectFile('hello.txt', [1, 2, 3, 4, 5]);
    await expectFile('hello.txt', [1, 2, 3, 4, 5]);
    await expectFile('lib/src/test-a.dart', [100]);
    await expectFile('lib/src/test-b.dart', [101]);
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
    final indexBytes = await b.buildIndex('1');
    await controller.close();
    expect(await result, [
      [0, 1], // a: path length prefix (1)
      [97], // a: path
      [0, 1], // a: content
      [0, 1], // b: path length prefix (1)
      [98], // b: path
      [0], // b: content chunk 1
      [], // b: content chunk 2 (skipped)
      [0, 1], // c: path length prefix (1)
      [99], // c: path
      [8, 9], // c: content
    ]);

    // No subindexes for 3 files — readBlob will never be called.
    Future<Uint8List> readBlob(int start, int end) async =>
        throw StateError('unexpected readBlob call');

    final index = BlobIndex.fromBytes(indexBytes, readBlob);

    expect(await index.lookup('b'), isNull);

    final c = await index.lookup('c');
    expect(c!.entryOffset, 9);
    expect(c.end, 14);
  });

  test('hasFile', () async {
    final blobFile = File('${tmp.path}/test.blob');

    final b = IndexedBlobBuilder(blobFile.openWrite());
    await b.addFile('README.md', Stream.value([0, 0]));
    await b.addFile('hello.txt', Stream.value([1, 2, 3]));
    final indexBytes = await b.buildIndex('42');

    final blob = await blobFile.readAsBytes();
    Future<Uint8List> readBlob(int start, int end) async =>
        blob.sublist(start, end);

    final index = BlobIndex.fromBytes(indexBytes, readBlob);

    expect(await index.hasFile('README.md'), isTrue);
    expect(await index.hasFile('hello.txt'), isTrue);
    expect(await index.hasFile('missing.txt'), isFalse);

    // Verify that hasFile catches a blob/index mismatch that lookup ignores.
    // Corrupt the first byte of hello.txt's path in the blob (after the 2-byte length prefix).
    final range = await index.lookup('hello.txt');
    expect(range, isNotNull);
    final corrupted = Uint8List.fromList(blob.toList());
    corrupted[range!.entryOffset + 2] ^= 0x01;
    Future<Uint8List> readCorrupted(int start, int end) async =>
        corrupted.sublist(start, end);

    final corruptedIndex = BlobIndex.fromBytes(indexBytes, readCorrupted);

    // lookup still finds it (it only checks the hash index, not blob bytes)
    expect(await corruptedIndex.lookup('hello.txt'), isNotNull);
    // hasFile detects the mismatch
    expect(await corruptedIndex.hasFile('hello.txt'), isFalse);
    // listFiles also detects the mismatch via hash verification
    expect(
      () => corruptedIndex.listFiles().toList(),
      throwsA(isA<FormatException>()),
    );
  });

  test('subindexes', () async {
    final pair = await BlobIndexPair.build('large', ((addFile) async {
      await addFile('README.md', Stream.value([0, 0]));
      for (var i = 0; i < 100000; i++) {
        await addFile(
          'file-$i.txt',
          Stream.value(
            List.filled(
              (i + 1) % 1000,
              (i % 36).toRadixString(36).codeUnits.first,
            ),
          ),
        );
      }
      await addFile('hello.txt', Stream.value([1, 2, 3, 4, 5]));
    }), indexSizeThresholdKiB: 16);

    final blobBytes = pair.blob;
    var readBlobCallCount = 0;
    (int, int)? lastReadBlobRange;
    Future<Uint8List> readBlob(int start, int end) async {
      readBlobCallCount++;
      lastReadBlobRange = (start, end);
      return blobBytes.sublist(start, end);
    }

    final index = BlobIndex.fromBytes(pair.index.asBytes(), readBlob);

    expect(index.blobId, equals('large'));
    expect(index.hasSubindexes, true);
    expect(index.asBytes().length, greaterThan(15 * 1024));
    expect(index.asBytes().length, lessThan(17 * 1024));

    // A missing file still causes a subindex fetch to identify the right block.
    readBlobCallCount = 0;
    expect(await index.lookup('missing-file'), isNull);
    expect(readBlobCallCount, 1);

    // Each found file requires exactly one subindex fetch.
    for (final path in ['hello.txt', 'README.md', 'file-9999.txt']) {
      readBlobCallCount = 0;
      final range = await index.lookup(path);
      expect(range, isNotNull, reason: '$path should be found');
      expect(
        readBlobCallCount,
        1,
        reason: '$path should load exactly one subindex',
      );

      // The fetched subindex range must lie beyond the file content area and
      // parse as a valid BlobIndex whose entry contains the expected path.
      final (subStart, subEnd) = lastReadBlobRange!;
      expect(subEnd, lessThanOrEqualTo(blobBytes.length));
      final subindex = BlobIndex.fromBytes(
        blobBytes.sublist(subStart, subEnd),
        (_, __) async => Uint8List(0),
      );
      final subRange = await subindex.lookup(path);
      expect(subRange, isNotNull, reason: '$path should be in the subindex');
    }

    // listFiles must return every file exactly once.
    final allPaths = await index.listFiles().toList();
    expect(allPaths.length, 100002); // README.md + 100000 files + hello.txt
    expect(
      allPaths,
      containsAll(['README.md', 'hello.txt', 'file-0.txt', 'file-9999.txt']),
    );
    expect(allPaths.toSet().length, allPaths.length, reason: 'no duplicates');
  });

  test('duplicate path throws', () async {
    final controller = StreamController<List<int>>();
    final collected = controller.stream.toList();
    final b = IndexedBlobBuilder(controller);
    await b.addFile('a.txt', Stream.value([1]));
    // Duplicate is detected before any async stream work begins, so the
    // returned Future rejects immediately and no stream activity occurs.
    await expectLater(
      b.addFile('a.txt', Stream.value([2])),
      throwsArgumentError,
    );
    await b.buildIndex('x');
    await collected;
    await controller.close();
  });

  test('empty index', () async {
    final blobFile = File('${tmp.path}/empty.blob');

    final b = IndexedBlobBuilder(blobFile.openWrite());
    final indexBytes = await b.buildIndex('empty-blob-id');

    final blob = await blobFile.readAsBytes();
    Future<Uint8List> readBlob(int start, int end) async =>
        blob.sublist(start, end);

    final index = BlobIndex.fromBytes(indexBytes, readBlob);

    expect(index.blobId, equals('empty-blob-id'));
    expect(index.hasSubindexes, isFalse);

    expect(await index.lookup('missing.txt'), isNull);
    expect(await index.hasFile('missing.txt'), isFalse);
    expect(await index.listFiles().toList(), isEmpty);

    // Roundtrip through bytes preserves the empty index.
    final restored = BlobIndex.fromBytes(index.asBytes(), readBlob);
    expect(restored.blobId, equals('empty-blob-id'));
    expect(await restored.lookup('missing.txt'), isNull);
    expect(await restored.listFiles().toList(), isEmpty);
  });
}
