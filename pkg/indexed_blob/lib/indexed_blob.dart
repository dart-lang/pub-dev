// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// The `indexed_blob.dart` library provides support for
/// reading and writing indexed-blobs.
///
/// An _indexed blob_ is a blob-file and an index-file pointing into the blob.
/// The index-file can be used to find _start_ and _end_ offset for a file
/// stored inside the blob.
///
/// This is aimed to work efficiently with Google Cloud Storage, enabling
/// many small files to be stored as a single blob and index file. While
/// facilitating individual files to be retrieved by fetching the index file,
/// finding the _start_ and _end_ offset for use with an HTTP range request.
///
/// To goal of this format is to support storing the many small files generated
/// by `dartdoc` as an indexed-blob.
library;

import 'dart:async';
import 'dart:convert' show utf8;
import 'dart:typed_data';
import 'package:jsontool/jsontool.dart'
    show JsonReader, jsonStringWriter, JsonSink;
import 'package:meta/meta.dart';

export 'src/blobindexpair.dart' show BlobIndexPair;

/// Builder for creating an indexed-blob by adding files and finally generating
/// an index.
///
/// **Example**
/// ```dart
/// import 'dart:io';
///
/// // Create an IndexedBlobBuilder, that will write blob to 'mydata.blob'
/// final builder = IndexedBlobBuilder(File('mydata.blob').openWrite());
///
/// // Add a file (conflicting files CANNOT be added)
/// await builder.add('example/bin/main.dart', File('main.dart').openRead());
///
/// // Build index with 'mydata.blob' as blobId.
/// // blobId is a free-form string, returned when looking up file ranges, it's
/// // intended to be used for storing URL to the blob.
/// final index = await builder.buildIndex('mydata.blob');
///
/// // Finish building, and create the index
/// await File('mydata.index').writeBytes();
/// ```
@sealed
class IndexedBlobBuilder {
  final StreamSink<List<int>> _blob;
  int _offset = 0;
  final Map<String, dynamic> _index = {};
  bool _isAdding = false;
  bool _finished = false;

  /// Create an [IndexedBlobBuilder] that writes the blob to [blob].
  IndexedBlobBuilder(StreamSink<List<int>> blob) : _blob = blob;

  void _checkState() {
    if (_finished) {
      throw StateError(
        'IndexedBlobBuilder cannot be used after IndexedBlobBuilder.buildIndex() is called',
      );
    }

    if (_isAdding) {
      throw StateError(
        'IndexedBlobBuilder cannot be used concurrently with IndexedBlobBuilder.addFile()',
      );
    }
  }

  /// Add a file at [path] with given [content] to blob being built.
  ///
  /// This cannot be called concurrently, callers must await this operation
  /// being completed.
  ///
  /// If an exception is thrown generated blob is not valid.
  Future<void> addFile(String path, Stream<List<int>> content) async {
    _checkState();
    try {
      _isAdding = true;
      final start = _offset;
      await _blob.addStream(content.map((chunk) {
        _offset += chunk.length;
        return chunk;
      }));

      var target = _index;
      final segments = path.split('/');
      for (var i = 0; i < segments.length - 1; i++) {
        final segment = segments[i];
        final next = target[segment] ??= <String, dynamic>{};
        if (next is Map<String, dynamic>) {
          target = next;
        } else {
          // This really shouldn't be possible, if we're adding files
          throw StateError(
            'Folder required for "$path" conflicts with existing file at "${segments.sublist(0, i).join('/')}"',
          );
        }
      }
      if (target[segments.last] != null) {
        // This really shouldn't be possible, if we're adding files
        throw StateError('File at "$path" conflicts with existing file/folder');
      }
      target[segments.last] = '$start:$_offset';
    } finally {
      _isAdding = false;
    }
  }

  /// Build an index for the blob constructed, calling [addFile] after this
  /// is not allowed.
  ///
  /// The [blobId] is a free-form string that is included when a FileRange is
  /// returned by [BlobIndex.lookup]. It is intended to store an identifier for
  /// blob containing the file, or a URL to the blob.
  Future<BlobIndex> buildIndex(String blobId) async {
    _checkState();
    _finished = true;
    await _blob.close();

    final bytes = _buildIndexBytes(
      blobId: blobId,
      index: _index,
    );
    return BlobIndex.fromBytes(bytes);
  }

  static Uint8List _buildIndexBytes({
    required String blobId,
    required Map<String, dynamic> index,
  }) {
    final out = StringBuffer();
    final w = jsonStringWriter(out);
    w.startObject();

    // Note. it's a bit of a hack, but keys are expected to be order as follows:
    // - version
    // - blobId
    // - index

    // Add version number
    w.addKey('version');
    w.addNumber(1);

    // Add blobId
    w.addKey('blobId');
    w.addString(blobId);

    // Add index
    w.addKey('index');
    _addMap(w, index);

    w.endObject();

    return utf8.encoder.convert(out.toString());
  }
}

void _addMap(JsonSink w, Map<String, dynamic> m) {
  w.startObject();
  for (final kv in m.entries) {
    w.addKey(kv.key);

    final value = kv.value;
    if (value is String) {
      w.addString(value);
    } else if (value is Map<String, dynamic>) {
      _addMap(w, value);
    } else {
      throw AssertionError('unexpected value: $value');
    }
  }
  w.endObject();
}

bool _skipUntilKey(JsonReader r, String key) {
  while (r.tryKey([key]) == null) {
    if (!r.skipObjectEntry()) {
      return false;
    }
  }
  return true;
}

/// Index for an indexed-blob, can be used to lookup [FileRange].
///
/// The internal byte format of a [BlobIndex] is encoded as JSON, but the order
/// of properties is significant and the format should be considered internal
/// to [BlobIndex] and [IndexedBlobBuilder].
///
/// ## Internal BlobIndex Format v1.0
///  * This format is **internal** to [BlobIndex] and [IndexedBlobBuilder].
///  * Order of properties is significant,
///  * Additional top-level properties must be ignored.
///
/// ```json
/// {
///   // First property must be version, the version is bumped when backwards
///   // compatibility is broken. Additional meta-data can be introduced without
///   // breaking compatibility as additional top-level properties **must** be
///   // ignored.
///   "version": 1,
///
///   // Identifier of the blob this index is pointing into.
///   "blobId": "<blobId>",
///
///   // Index into the blob, with paths split at '/' each folder becomes a map.
///   "index": {
///     // ordering within "index" property is insignificant in version 1.x
///     "README.md": "80:100",
///     "bin": {
///       "pub_worker.dart": "0:42"
///     },
///     "lib": {
///       // File "lib/blob.dart" starts at 42 and ends at 80 in <blobId>.
///       "blob.dart": "42:80"
///     }
///   }
/// }
/// ```
///
@sealed
class BlobIndex {
  final Uint8List _indexFile;

  /// Create [BlobIndex] from [indexFile] contents.
  ///
  /// A [BlobIndex] can be built using [IndexedBlobBuilder], or restored from
  /// a previous [BlobIndex] instance serialized with [BlobIndex.asBytes].
  ///
  /// The format of the [indexFile] is internal to [IndexedBlobBuilder] and
  /// [BlobIndex], attempts to read/write the format outside of these classes
  /// is unsupported.
  BlobIndex.fromBytes(List<int> indexFile)
      : _indexFile =
            indexFile is Uint8List ? indexFile : Uint8List.fromList(indexFile);

  BlobIndex.empty({required String blobId})
      : _indexFile =
            IndexedBlobBuilder._buildIndexBytes(blobId: blobId, index: {});

  /// Get the free-form [String] given as `blobId` when the blob was built.
  ///
  /// This is intended for an identifier or URL that can be used to find the
  /// blob indexed by this [BlobIndex].
  String get blobId {
    final r = JsonReader.fromUtf8(_indexFile);
    r.expectObject();

    // Expect a version key
    if (!_skipUntilKey(r, 'version')) {
      throw const FormatException('expected "version" key');
    }
    if (r.expectInt() != 1) {
      throw const FormatException('future index format not supported');
    }

    // Expect a blobId key
    if (!_skipUntilKey(r, 'blobId')) {
      throw const FormatException('expected "blobId" key');
    }
    return r.expectString();
  }

  /// Lookup the [FileRange] for [path] in the indexed-blob.
  ///
  /// Returns `null` if the [path] does not point to a file.
  FileRange? lookup(String path) {
    final r = JsonReader.fromUtf8(_indexFile);
    r.expectObject();

    // Expect a version key
    if (!_skipUntilKey(r, 'version')) {
      throw const FormatException('expected "version" key');
    }
    if (r.expectInt() != 1) {
      throw const FormatException('future index format not supported');
    }

    // Expect a blobId key
    if (!_skipUntilKey(r, 'blobId')) {
      throw const FormatException('expected "blobId" key');
    }
    final blobId = r.expectString();

    // Expect an index key
    if (!_skipUntilKey(r, 'index')) {
      throw const FormatException('expected "index" key');
    }
    r.expectObject();

    final segments = path.split('/');
    for (var i = 0; i < segments.length - 1; i++) {
      if (!_skipUntilKey(r, segments[i]) || !r.tryObject()) {
        return null;
      }
    }

    if (_skipUntilKey(r, segments.last) && r.checkString()) {
      return FileRange._fromJson(path, r.expectString(), blobId);
    }

    return null;
  }

  /// Iterate through all indexed files.
  Iterable<FileRange> get files sync* {
    final r = JsonReader.fromUtf8(_indexFile);
    r.expectObject();

    // Expect a version key
    if (!_skipUntilKey(r, 'version')) {
      throw const FormatException('expected "version" key');
    }
    if (r.expectInt() != 1) {
      throw const FormatException('future index format not supported');
    }

    // Expect a blobId key
    if (!_skipUntilKey(r, 'blobId')) {
      throw const FormatException('expected "blobId" key');
    }
    final blobId = r.expectString();

    // Expect an index key
    if (!_skipUntilKey(r, 'index')) {
      throw const FormatException('expected "index" key');
    }

    // Traverse object
    Iterable<FileRange> traverse(String parent) sync* {
      r.expectObject();
      while (r.hasNextKey()) {
        final name = parent + r.nextKey()!;
        if (r.checkString()) {
          yield FileRange._fromJson(name, r.expectString(), blobId);
        } else {
          yield* traverse('$name/');
        }
      }
    }

    yield* traverse('');
  }

  Uint8List asBytes() => _indexFile;

  /// Create a new [BlobIndex] updated with a new [blobId].
  BlobIndex update({
    String? blobId,
  }) {
    final r = JsonReader.fromUtf8(_indexFile);
    r.expectObject();

    // Expect a version key
    if (!_skipUntilKey(r, 'version')) {
      throw const FormatException('expected "version" key');
    }
    if (r.expectInt() != 1) {
      throw const FormatException('future index format not supported');
    }

    // Expect a blobId key
    if (!_skipUntilKey(r, 'blobId')) {
      throw const FormatException('expected "blobId" key');
    }
    final originalBlobId = r.expectString();

    // Expect an index key
    if (!_skipUntilKey(r, 'index')) {
      throw const FormatException('expected "index" key');
    }
    if (!r.checkObject()) {
      throw const FormatException('expected "index" object');
    }

    // Create a writer for the new output
    final out = StringBuffer();
    final w = jsonStringWriter(out);
    w.startObject();

    // Note. it's a bit of a hack, but keys are expected to be order as follows:
    // - version
    // - blobId
    // - index

    // Write version number
    w.addKey('version');
    w.addNumber(1);

    // Write blobId
    w.addKey('blobId');
    w.addString(blobId ?? originalBlobId);

    // Add index
    w.addKey('index');
    w.addSourceValue(utf8.decode(r.expectAnyValueSource()));

    w.endObject();

    final bytes = utf8.encoder.convert(out.toString());

    return BlobIndex.fromBytes(bytes);
  }
}

/// Range of a file in an indexed-blob.
@sealed
class FileRange {
  /// Path that was looked up in [BlobIndex].
  final String path;

  /// Start offset of file in blob.
  final int start;

  /// End offset of file in blob.
  final int end;

  /// Identifier for the blob file associated this [FileRange] is pointing into.
  final String blobId;

  FileRange._(this.path, this.start, this.end, this.blobId);
  static FileRange _fromJson(String path, String range, String blobId) {
    final parts = range.split(':');
    if (parts.length != 2) {
      throw FormatException('invalid range "$range"');
    }
    return FileRange._(
      path,
      int.parse(parts[0]),
      int.parse(parts[1]),
      blobId,
    );
  }

  /// The length of the range in blob.
  int get length => end - start;

  /// Slice [start] to [end] from [blob].
  ///
  /// This returns a view of [blob] if it is a [Uint8List].
  List<int> slice(List<int> blob) {
    if (blob is Uint8List) {
      return Uint8List.sublistView(blob, start, end);
    }
    return blob.sublist(start, end);
  }
}
