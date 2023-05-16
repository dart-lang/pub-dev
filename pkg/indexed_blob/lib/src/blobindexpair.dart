// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io' show Directory, File, gzip;
import 'dart:typed_data' show Uint8List;

import 'package:async/async.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import '../indexed_blob.dart' show IndexedBlobBuilder, BlobIndex;

/// Pair containing and in-memory [blob] and matching [index].
@sealed
class BlobIndexPair {
  /// Blob indexed by [index].
  final Uint8List blob;

  /// Index pointing into [blob].
  final BlobIndex index;

  BlobIndexPair(this.blob, this.index);

  /// Create a blob and [BlobIndex] with [blobId] containing all files and
  /// folders within [folder], encoded with paths relative to [folder].
  static Future<BlobIndexPair> folderToIndexedBlob(
    String blobId,
    String folder,
  ) async {
    final c = StreamController<List<int>>();

    final indexF = _folderToIndexedBlob(c, blobId, folder);
    final blobF = collectBytes(c.stream);

    await Future.wait([blobF, indexF]);

    return BlobIndexPair(await blobF, await indexF);
  }

  static Future<BlobIndexPair> build(
    String blobId,
    Future<void> Function(
      Future<void> Function(String path, Stream<List<int>> content) addFile,
    ) builder,
  ) async {
    final c = StreamController<List<int>>();

    final b = IndexedBlobBuilder(c);

    try {
      final blobF = collectBytes(c.stream);

      await builder((path, content) async {
        await b.addFile(path, content);
      });

      final indexF = b.buildIndex(blobId);
      await Future.wait([blobF, indexF]);
      return BlobIndexPair(await blobF, await indexF);
    } finally {
      await c.close();
    }
  }

  /// Lookup [path] in [index] and return the range from [blob].
  ///
  /// Returns `null`, if [path] is not in the index.
  Uint8List? lookup(String path) {
    final range = index.lookup(path);
    if (range == null) {
      return null;
    }
    return Uint8List.sublistView(blob, range.start, range.end);
  }
}

Future<BlobIndex> _folderToIndexedBlob(
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
