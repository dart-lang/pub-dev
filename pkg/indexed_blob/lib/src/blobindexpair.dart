// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io' show Directory, File, gzip;
import 'dart:typed_data' show Uint8List;

import 'package:async/async.dart';
import 'package:path/path.dart' as p;
import '../indexed_blob.dart' show BlobIndexReader, IndexedBlobBuilder;

/// Pair containing and in-memory [blob] and matching [index].
final class BlobIndexPair {
  /// Blob indexed by [index].
  final Uint8List blob;

  /// Index pointing into [blob].
  final BlobIndexReader index;

  BlobIndexPair(this.blob, Uint8List indexBytes)
    : index = BlobIndexReader.fromBytes(
        indexBytes,
        (start, end) async => Uint8List.sublistView(blob, start, end),
      );

  /// Create a blob and [BlobIndexReader] with [blobId] containing all files and
  /// folders within [folder], encoded with paths relative to [folder].
  static Future<BlobIndexPair> folderToIndexedBlob(
    String blobId,
    String folder,
  ) async {
    final c = StreamController<List<int>>();

    final indexBytesF = _folderToIndexedBlob(c, blobId, folder);
    final blobF = collectBytes(c.stream);

    await Future.wait([blobF, indexBytesF]);

    return BlobIndexPair(await blobF, await indexBytesF);
  }

  static Future<BlobIndexPair> build(
    String blobId,
    Future<void> Function(
      Future<void> Function(String path, Stream<List<int>> content) addFile,
    )
    builder, {
    int indexSizeThresholdKiB = 512,
  }) async {
    final c = StreamController<List<int>>();

    final b = IndexedBlobBuilder(c);

    try {
      final blobF = collectBytes(c.stream);

      await builder((path, content) async {
        await b.addFile(path, content);
      });

      final indexBytesF = b.buildIndex(
        blobId,
        indexSizeThresholdKiB: indexSizeThresholdKiB,
      );
      await Future.wait([blobF, indexBytesF]);
      return BlobIndexPair(await blobF, await indexBytesF);
    } finally {
      await c.close();
    }
  }
}

Future<Uint8List> _folderToIndexedBlob(
  StreamSink<List<int>> blob,
  String blobId,
  String sourcePath,
) async {
  final b = IndexedBlobBuilder(blob);

  final files = Directory(sourcePath).list(recursive: true, followLinks: false);
  await for (final f in files) {
    if (f is File) {
      final path = p.relative(f.path, from: sourcePath);
      await b.addFile(path, f.openRead().transform(gzip.encoder));
    }
  }

  return await b.buildIndex(blobId);
}
