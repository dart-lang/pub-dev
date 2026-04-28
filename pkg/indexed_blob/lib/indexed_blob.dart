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
/// The goal of this format is to support storing the many small files generated
/// by `dartdoc` as an indexed-blob.
library;

import 'dart:async';
import 'dart:convert' show ChunkedConversionSink, utf8;
import 'dart:math';
import 'dart:typed_data';
import 'package:collection/collection.dart';
import 'package:crypto/crypto.dart';
export 'src/blobindexpair.dart' show BlobIndexPair;

/// Reads a byte slice from the blob.
typedef BlobSliceReader = Future<List<int>?> Function(int start, int end);

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
/// // Add a file (duplicate paths are not allowed)
/// await builder.addFile('example/bin/main.dart', File('main.dart').openRead());
///
/// // Build index with 'mydata.blob' as blobId.
/// // blobId is a free-form string, returned when looking up file ranges, it's
/// // intended to be used for storing URL to the blob.
/// final index = await builder.buildIndex('mydata.blob');
///
/// // Write the index to a file
/// await File('mydata.index').writeAsBytes(index.asBytes());
/// ```
final class IndexedBlobBuilder {
  final StreamSink<List<int>> _blob;
  int _offset = 0;
  final _entries = <_Entry>[];
  final _paths = <String>{};
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

  /// Estimated maximum length of the index file.
  int get indexUpperLength => 128 + _entries.length * (32 + 8 + 2 + 8);

  /// Add a file at [path] with given [content] to blob being built.
  ///
  /// This cannot be called concurrently, callers must await this operation
  /// being completed.
  ///
  /// [path] must not exceed 4096 UTF-8 bytes and must not duplicate a path
  /// already added.
  ///
  /// When [skipAfterSize] is set, the blob file may contain the streamed content
  /// up to the specified number of bytes, but will skip updating the index file
  /// after the threshold is reached.
  ///
  /// If an exception is thrown generated blob is not valid.
  ///
  /// Returns `true` if the [content] was added successfully.
  Future<bool> addFile(
    String path,
    Stream<List<int>> content, {
    int skipAfterSize = 0,
  }) async {
    _checkState();
    if (!_paths.add(path)) {
      throw ArgumentError('Duplicate path: "$path".');
    }
    try {
      _isAdding = true;

      final startOffset = _offset;

      // sanity check for the encoded paths
      final pathBytes = utf8.encode(path);
      if (pathBytes.length > 4096) {
        throw ArgumentError('Path too long (must not exceed 4096 UTF-8 bytes).');
      }

      // Writing path (as `utf8(path) + zero terminator`) to allow path verification.
      _blob.add(pathBytes);
      _offset += pathBytes.length;
      _blob.add(const [0]);
      _offset += 1;

      final contentStart = _offset;
      var totalSize = 0;
      await _blob.addStream(
        content.map((chunk) {
          totalSize += chunk.length;
          if (skipAfterSize > 0 && totalSize > skipAfterSize) {
            // Do not store the remaining chunks, we will not store the entry.
            return const [];
          }

          _offset += chunk.length;
          return chunk;
        }),
      );

      if (skipAfterSize > 0 && totalSize > skipAfterSize) {
        return false;
      }

      final endOffset = _offset;
      _entries.add(
        _Entry(
          startOffset: startOffset,
          pathBytes: pathBytes,
          contentLength: endOffset - contentStart,
        ),
      );
      return true;
    } finally {
      _isAdding = false;
    }
  }

  /// Build an index for the blob constructed, calling [addFile] after this
  /// is not allowed.
  ///
  /// The [blobId] is a free-form string that is included when a [FileRange] is
  /// returned by [BlobIndex.lookup]. It is intended to store an identifier for
  /// the blob containing the file, or a URL to the blob.
  ///
  /// ## Blob layout
  ///
  /// The written blob contains, in order:
  /// 1. **File entries** – for each file added via [addFile]:
  ///    `utf8(path) + 0x00 + <raw content bytes>`
  /// 2. **Subindex blocks** (if the index is large) – zero or more secondary
  ///    index blocks appended directly to the blob (see below).
  ///
  /// ## Index file format
  ///
  /// The returned [BlobIndex] is a single binary buffer with this layout:
  ///
  /// ```
  /// [ HashIndexHeader (18 + blobIdLength bytes) ]
  /// [ entry record × entryCount ]
  /// [ subindex record × subindexCount ]
  /// ```
  ///
  /// See [HashIndexHeader] for the exact byte layout of each record type.
  ///
  /// ## Subindex logic
  ///
  /// When the total index size would exceed [indexSizeThresholdKiB] KiB,
  /// entries are divided into equally-sized slices:
  ///
  /// - The **first slice** is stored in the returned index buffer (the main
  ///   index), covering the lowest-hash portion of the key space.
  /// - Each **remaining slice** is written as a self-contained subindex block
  ///   (its own [HashIndexHeader] + entry records) directly into the blob,
  ///   after all file data.
  /// - The main index contains one **subindex record** per remaining slice,
  ///   pointing to the slice's blob offset and byte-length, keyed by the
  ///   hash prefix of its first entry.
  ///
  /// Lookup therefore proceeds in at most two steps: a binary search over
  /// subindex records to identify the right subindex block (or determine the
  /// target is in the main index), then a binary search within that block.
  Future<BlobIndex> buildIndex(
    String blobId, {
    int indexSizeThresholdKiB = 512,
  }) async {
    _checkState();
    _finished = true;

    final blobIdBytes = utf8.encode(blobId);
    if (blobIdBytes.length > 4096) {
      throw ArgumentError('`blobId` must not exceed 4096 UTF-8 bytes.');
    }

    if (_entries.isEmpty) {
      await _blob.close();
      return BlobIndex.empty(blobId: blobId);
    }

    for (final entry in _entries) {
      entry.pathHash = _hash(blobIdBytes, entry.pathBytes);
    }
    _entries.sort((a, b) => _compareHash(a.pathHash, b.pathHash));

    final maxCommonHashPrefix = _entries.indexed
        .skip(1)
        .map((a) => _commonPrefix(_entries[a.$1 - 1].pathHash, a.$2.pathHash))
        .fold(0, (a, b) => max(a, b));
    final hashPrefixBytes = max(4, maxCommonHashPrefix + 1);

    final worstCaseIndexSize = (hashPrefixBytes + 8 + 2 + 8) * _entries.length;
    final worstCaseOffset =
        _offset +
        worstCaseIndexSize +
        /* arbitrary padding for headers and other overheads */
        128 * 1024;

    // always use path length of 2 bytes
    final pathLengthBytes = 2;

    final offsetMinBytes = (worstCaseOffset.bitLength ~/ 8) + 1;
    final offsetBytes = offsetMinBytes <= 2 ? 2 : (offsetMinBytes <= 4 ? 4 : 8);
    // A single file's content cannot exceed the total blob size, so the same
    // byte-width that fits blob offsets also fits content lengths.
    final contentLengthBytes = offsetBytes;

    final entryBytesLength =
        hashPrefixBytes + offsetBytes + pathLengthBytes + contentLengthBytes;

    final subindexCount =
        (_entries.length * entryBytesLength) ~/ (indexSizeThresholdKiB * 1024);
    final entryPerIndex = (_entries.length ~/ (subindexCount + 1)) + 1;

    final subindexEntries = <_Subindex>[];
    final slices = _entries.slices(entryPerIndex);
    for (final slice in slices.skip(1)) {
      final subindexStartOffset = _offset;

      final subIndexHeader = HashIndexHeader(
        version: 1,
        blobIdBytes: blobIdBytes,
        hashPrefixBytes: hashPrefixBytes,
        offsetBytes: offsetBytes,
        pathLengthBytes: pathLengthBytes,
        contentLengthBytes: contentLengthBytes,
        entryCount: slice.length,
        subindexCount: 0,
      );
      final headerBytes = subIndexHeader.asBytes();
      _blob.add(headerBytes);
      _offset += headerBytes.length;
      for (final entry in slice) {
        final entryBytes = entry.asBytes(
          hashPrefixBytes: hashPrefixBytes,
          offsetBytes: offsetBytes,
          pathLengthBytes: pathLengthBytes,
          contentLengthBytes: contentLengthBytes,
        );
        _blob.add(entryBytes);
        _offset += entryBytes.length;
      }
      final subindexEndOffset = _offset;
      subindexEntries.add(
        _Subindex(
          hashRangeStart: slice.first.pathHash,
          startOffset: subindexStartOffset,
          contentLength: subindexEndOffset - subindexStartOffset,
        ),
      );
    }

    await _blob.close();

    final indexHeader = HashIndexHeader(
      version: 1,
      blobIdBytes: blobIdBytes,
      hashPrefixBytes: hashPrefixBytes,
      offsetBytes: offsetBytes,
      pathLengthBytes: pathLengthBytes,
      contentLengthBytes: contentLengthBytes,
      entryCount: slices.first.length,
      subindexCount: subindexEntries.length,
    );
    final indexChunks = [
      indexHeader.asBytes(),
      ...slices.first.map(
        (item) => item.asBytes(
          hashPrefixBytes: hashPrefixBytes,
          offsetBytes: offsetBytes,
          pathLengthBytes: pathLengthBytes,
          contentLengthBytes: contentLengthBytes,
        ),
      ),
      ...subindexEntries.map(
        (entry) => entry.asBytes(
          hashPrefixBytes: hashPrefixBytes,
          offsetBytes: offsetBytes,
          contentLengthBytes: contentLengthBytes,
        ),
      ),
    ];
    final indexBytesBuilder = BytesBuilder();
    for (final chunk in indexChunks) {
      indexBytesBuilder.add(chunk);
    }
    final bytes = indexBytesBuilder.toBytes();
    return BlobIndex.fromBytes(bytes);
  }
}

Uint8List _hash(List<int> saltBytes, List<int> pathBytes) {
  Digest? digest;
  final input = sha256.startChunkedConversion(
    ChunkedConversionSink.withCallback((list) => digest = list.single),
  );
  input.add(saltBytes);
  input.add(pathBytes);
  input.close();
  return Uint8List.fromList(digest!.bytes);
}

int _compareHash(Uint8List a, Uint8List b) {
  assert(a.length == b.length);
  for (var i = 0; i < a.length; i++) {
    final x = a[i].compareTo(b[i]);
    if (x != 0) return x;
  }
  return 0;
}

int _compareHashWithOffset(
  Uint8List buffer,
  int offset,
  Uint8List other,
  int length,
) {
  for (var i = 0; i < length; i++) {
    final x = buffer[offset + i].compareTo(other[i]);
    if (x != 0) return x;
  }
  return 0;
}

int _commonPrefix(Uint8List a, Uint8List b) {
  assert(a.length == b.length);
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) {
      return i;
    }
  }
  return a.length;
}

/// Index for an indexed-blob, can be used to lookup [FileRange].
final class BlobIndex {
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
    : _indexFile = indexFile is Uint8List
          ? indexFile
          : Uint8List.fromList(indexFile);

  BlobIndex.empty({required String blobId})
    : _indexFile = HashIndexHeader(
        version: 1,
        blobIdBytes: utf8.encode(blobId),
        hashPrefixBytes: 4,
        offsetBytes: 4,
        pathLengthBytes: 2,
        contentLengthBytes: 4,
        entryCount: 0,
        subindexCount: 0,
      ).asBytes();

  late final _header = HashIndexHeader.parse(_indexFile);

  /// Get the free-form [String] given as `blobId` when the blob was built.
  ///
  /// This is intended for an identifier or URL that can be used to find the
  /// blob indexed by this [BlobIndex].
  String get blobId => _header.blobId;

  bool get hasSubindexes => _header.subindexCount > 0;

  /// Looks up [path], automatically resolving subindex blocks via [readBlob].
  ///
  /// [readBlob] is called with `(start, end)` byte offsets into the blob and
  /// must return the bytes in that range. It is called at most once — only
  /// when the main index determines that [path] falls within a subindex block —
  /// and not at all when the entry is found directly in the main index.
  ///
  /// Returns a [FileRange] describing where the file lives in the blob,
  /// or `null` if [path] is not stored in this indexed blob.
  Future<FileRange?> lookup(String path, BlobSliceReader readBlob) async {
    final pathBytes = utf8.encode(path);
    final hashBytes = _hash(_header.blobIdBytes, pathBytes);

    int compareHashAtOffset(int offset) => _compareHashWithOffset(
      _indexFile,
      offset,
      hashBytes,
      _header.hashPrefixBytes,
    );

    final selectedSubindex = _search(
      _header.subindexCount,
      (i) => compareHashAtOffset(_header.getSubindexOffset(i)),
      exactMatch: false,
    );
    if (selectedSubindex >= 0) {
      final data = ByteData.sublistView(_indexFile);
      var dataOffset =
          _header.getSubindexOffset(selectedSubindex) + _header.hashPrefixBytes;
      final contentOffset = data.getUint(_header.offsetBytes, dataOffset);
      dataOffset += _header.offsetBytes;
      final contentLength = data.getUint(
        _header.contentLengthBytes,
        dataOffset,
      );

      final subindexBytes = await readBlob(
        contentOffset,
        contentOffset + contentLength,
      );
      if (subindexBytes == null) {
        return null;
      }
      final subindex = BlobIndex.fromBytes(subindexBytes);
      return subindex._lookupInEntries(path, pathBytes, hashBytes);
    }

    return _lookupInEntries(path, pathBytes, hashBytes);
  }

  FileRange? _lookupInEntries(
    String path,
    List<int> pathBytes,
    Uint8List hashBytes,
  ) {
    int compareHashAtOffset(int offset) => _compareHashWithOffset(
      _indexFile,
      offset,
      hashBytes,
      _header.hashPrefixBytes,
    );

    final selectedEntry = _search(
      _header.entryCount,
      (i) => compareHashAtOffset(_header.getEntryOffset(i)),
    );
    if (selectedEntry < 0) return null;

    final data = ByteData.sublistView(_indexFile);
    var dataOffset =
        _header.getEntryOffset(selectedEntry) + _header.hashPrefixBytes;
    final entryOffset = data.getUint(_header.offsetBytes, dataOffset);
    dataOffset += _header.offsetBytes;
    final pathLength = data.getUint(_header.pathLengthBytes, dataOffset);
    dataOffset += _header.pathLengthBytes;
    final contentLength = data.getUint(_header.contentLengthBytes, dataOffset);

    // sanity check on path length
    if (pathLength != pathBytes.length) return null;

    return FileRange._(
      path,
      entryOffset,
      entryOffset + pathLength + 1 + contentLength,
      blobId,
    );
  }

  /// Lists all [FileRange]s stored in the indexed blob.
  ///
  /// Iterates entries in the main index, then fetches and iterates each
  /// subindex block in turn. For every entry, [readBlob] is called once to
  /// read its path bytes from the blob; for each subindex block, [readBlob]
  /// is called once to load the block itself.
  ///
  /// Entries are yielded in hash order (not lexicographic path order).
  ///
  /// **Caution:** issues one [readBlob] call per entry plus one per subindex
  /// block. For remote blobs, callers may want to buffer the stream rather
  /// than issuing large numbers of individual range requests.
  ///
  /// Throws [FormatException] if the path bytes read from the blob do not
  /// match the hash stored in the index for that entry.
  Stream<FileRange> listFiles(BlobSliceReader readBlob) async* {
    yield* _listEntries(readBlob);
    final data = ByteData.sublistView(_indexFile);
    for (var i = 0; i < _header.subindexCount; i++) {
      var dataOffset = _header.getSubindexOffset(i) + _header.hashPrefixBytes;
      final contentOffset = data.getUint(_header.offsetBytes, dataOffset);
      dataOffset += _header.offsetBytes;
      final contentLength = data.getUint(
        _header.contentLengthBytes,
        dataOffset,
      );
      final subindexBytes = await readBlob(
        contentOffset,
        contentOffset + contentLength,
      );
      if (subindexBytes != null) {
        yield* BlobIndex.fromBytes(subindexBytes)._listEntries(readBlob);
      }
    }
  }

  Stream<FileRange> _listEntries(BlobSliceReader readBlob) async* {
    final data = ByteData.sublistView(_indexFile);
    for (var i = 0; i < _header.entryCount; i++) {
      var dataOffset = _header.getEntryOffset(i) + _header.hashPrefixBytes;
      final entryOffset = data.getUint(_header.offsetBytes, dataOffset);
      dataOffset += _header.offsetBytes;
      final pathLength = data.getUint(_header.pathLengthBytes, dataOffset);
      dataOffset += _header.pathLengthBytes;
      final contentLength = data.getUint(
        _header.contentLengthBytes,
        dataOffset,
      );
      final pathBytes = await readBlob(
        entryOffset,
        entryOffset + pathLength,
      );
      if (pathBytes == null) {
        continue;
      }
      final computedHash = _hash(_header.blobIdBytes, pathBytes);
      if (_compareHashWithOffset(
            _indexFile,
            _header.getEntryOffset(i),
            computedHash,
            _header.hashPrefixBytes,
          ) !=
          0) {
        throw FormatException(
          'Hash mismatch for entry $i: '
          'path bytes in blob do not match the stored hash.',
        );
      }
      final path = utf8.decode(pathBytes);
      yield FileRange._(
        path,
        entryOffset,
        entryOffset + pathLength + 1 + contentLength,
        blobId,
      );
    }
  }

  /// Returns `true` if [path] is stored in the indexed blob **and** the path
  /// bytes read from the blob match the expected value.
  ///
  /// Unlike [lookup], which only checks the hash index, this method also reads
  /// the path bytes from the blob via [readBlob] to confirm there is no hash
  /// collision or index/blob mismatch.
  ///
  /// [readBlob] may be called up to twice: once to resolve a subindex block
  /// (when the main index has subindexes), and once to read the path bytes.
  Future<bool> hasFile(String path, BlobSliceReader readBlob) async {
    final range = await lookup(path, readBlob);
    if (range == null) return false;
    final blobPathBytes = await readBlob(
      range.entryOffset,
      range.entryOffset + range.pathLength + 1,
    );
    if (blobPathBytes == null) {
      return false;
    }
    return range.matchesPathBytesPrefix(blobPathBytes);
  }

  Uint8List asBytes() => _indexFile;
}

/// Performs a binary search over a virtual indexed sequence.
///
/// Parameters:
/// - [length]: the number of elements to search over.
/// - [compare]: called with an index; should return:
///     - negative: element at index is **less than** the target
///     - zero:     element at index **equals** the target
///     - positive: element at index is **greater than** the target
/// - [exactMatch]: when `true`, only a zero-comparison result is accepted and
///   `-1` is returned if no exact match exists.  When `false`, the method
///   returns the largest index whose element is **≤ the target** (i.e. the
///   rightmost "lower-than-or-equal" position), or `-1` if every element is
///   greater than the target.
///
/// Returns the matched index, or `-1` if no acceptable match is found.
int _search(
  int length,
  int Function(int index) compare, {
  bool exactMatch = true,
}) {
  int lo = 0;
  int hi = length - 1;
  int best = -1; // best "lower-or-equal" candidate seen so far

  while (lo <= hi) {
    final mid = lo + (hi - lo) ~/ 2;
    final cmp = compare(mid);

    if (cmp == 0) {
      return mid; // exact match – always acceptable
    } else if (cmp < 0) {
      // list[mid] < target → mid is a lower-than candidate; search right
      best = mid;
      lo = mid + 1;
    } else {
      // list[mid] > target → search left
      hi = mid - 1;
    }
  }

  return exactMatch ? -1 : best;
}

final class _Entry {
  final int startOffset;
  final Uint8List pathBytes;
  final int contentLength;
  late Uint8List pathHash;

  _Entry({
    required this.startOffset,
    required this.pathBytes,
    required this.contentLength,
  });

  Uint8List asBytes({
    required int hashPrefixBytes,
    required int offsetBytes,
    required int pathLengthBytes,
    required int contentLengthBytes,
  }) {
    final bytes = Uint8List(
      hashPrefixBytes + offsetBytes + pathLengthBytes + contentLengthBytes,
    );
    for (var i = 0; i < hashPrefixBytes; i++) {
      bytes[i] = pathHash[i];
    }
    final data = bytes.buffer.asByteData();
    var offset = hashPrefixBytes;
    data.setUint(offsetBytes, offset, startOffset);
    offset += offsetBytes;
    data.setUint(pathLengthBytes, offset, pathBytes.length);
    offset += pathLengthBytes;
    data.setUint(contentLengthBytes, offset, contentLength);
    return bytes;
  }
}

final class _Subindex {
  final Uint8List hashRangeStart;
  final int startOffset;
  final int contentLength;

  _Subindex({
    required this.hashRangeStart,
    required this.startOffset,
    required this.contentLength,
  });

  Uint8List asBytes({
    required int hashPrefixBytes,
    required int offsetBytes,
    required int contentLengthBytes,
  }) {
    final bytes = Uint8List(hashPrefixBytes + offsetBytes + contentLengthBytes);
    for (var i = 0; i < hashPrefixBytes; i++) {
      bytes[i] = hashRangeStart[i];
    }
    final data = bytes.buffer.asByteData();
    var offset = hashPrefixBytes;
    data.setUint(offsetBytes, offset, startOffset);
    offset += offsetBytes;
    data.setUint(contentLengthBytes, offset, contentLength);
    return bytes;
  }
}

/// Range of a file in an indexed-blob.
final class FileRange {
  /// Path that was looked up in [BlobIndex].
  final String path;

  /// Start offset of the file entry in the blob.
  ///
  /// The entry begins with `utf8(path) + 0x00`, followed immediately by the
  /// raw file content.  Use [contentStart] to skip past the path header and
  /// reach the first content byte.
  final int entryOffset;

  /// End offset of file in blob.
  final int end;

  /// Identifier for the blob file associated this [FileRange] is pointing into.
  final String blobId;

  FileRange._(this.path, this.entryOffset, this.end, this.blobId);

  late final _pathBytes = utf8.encode(path);
  late final pathLength = _pathBytes.length;
  late final contentStart = entryOffset + pathLength + 1;

  /// Checks whether [slice] — which must start at [entryOffset] in the blob —
  /// begins with `utf8(path) + 0x00`.
  bool matchesPathBytesPrefix(List<int> slice) {
    if (slice.length < pathLength + 1) {
      return false;
    }
    for (var i = 0; i < pathLength; i++) {
      if (slice[i] != _pathBytes[i]) {
        return false;
      }
    }
    if (slice[pathLength] != 0) {
      return false;
    }
    return true;
  }

  /// Returns the file-content portion of [slice], where [slice] must start at
  /// [entryOffset] in the blob (i.e. it begins with `utf8(path) + 0x00`).
  /// Equivalent to `slice.sublist(pathLength + 1)`.
  Uint8List contentRange(Uint8List slice) {
    return slice.sublist(pathLength + 1);
  }

  /// Returns the file content from the full [blob], i.e. `blob[contentStart..end]`.
  ///
  /// This returns a view of [blob] if it is a [Uint8List].
  List<int> slice(List<int> blob) {
    if (blob is Uint8List) {
      return Uint8List.sublistView(blob, contentStart, end);
    }
    return blob.sublist(contentStart, end);
  }
}

/// Binary header for a hash index block (main index or subindex).
///
/// ## Header layout (18 + blobIdLength bytes, big-endian)
///
/// ```
/// Offset    Size      Field
/// ------    ----      -----
///      0       1      Magic byte 'I' (0x49)
///      1       1      Magic byte 'B' (0x42)
///      2       2      version (uint16); currently always 1
///      4       1      hashPrefixBytes: number of hash bytes stored per entry (≥ 4)
///      5       1      offsetBytes: byte-width used for blob offsets (2, 4, or 8)
///      6       1      pathLengthBytes: byte-width used for path lengths (always 2)
///      7       1      contentLengthBytes: byte-width used for content lengths
///      8       4      entryCount (uint32): number of entry records that follow
///     12       4      subindexCount (uint32): number of subindex records that follow
///     16       2      blobIdLength (uint16): byte-length of the blobId UTF-8 string
///     18   [#16]      blobId: UTF-8 encoded, up to 4096 bytes
/// ```
///
/// ## Entry record layout (`entryCount` records after the header)
///
/// Each entry describes one file stored in the blob:
///
/// ```
/// Size              Field
/// ----              -----
/// hashPrefixBytes   leading bytes of SHA-256(blobIdBytes ++ pathBytes)
/// offsetBytes       start offset of the entry in the blob (uint)
/// pathLengthBytes   byte-length of the file path (uint)
/// contentLengthBytes byte-length of the file content (uint)
/// ```
///
/// The entry's blob region begins with `utf8(path) + 0x00`, followed
/// immediately by the raw file content.
///
/// ## Subindex record layout (`subindexCount` records after all entry records)
///
/// Each subindex record points to a secondary index block embedded in the blob:
///
/// ```
/// Size               Field
/// ----               -----
/// hashPrefixBytes    leading bytes of the hash of the first entry in the subindex
/// offsetBytes        start offset of the subindex block in the blob (uint)
/// contentLengthBytes byte-length of the subindex block (uint)
/// ```
///
/// A subindex block is itself a complete [HashIndexHeader] (with its own
/// entry records), but with `subindexCount = 0`.
class HashIndexHeader {
  final int version;
  final Uint8List blobIdBytes;

  final int hashPrefixBytes;
  final int offsetBytes;
  final int pathLengthBytes;
  final int contentLengthBytes;

  final int entryCount;
  final int subindexCount;

  HashIndexHeader({
    required this.version,
    required List<int> blobIdBytes,
    required this.hashPrefixBytes,
    required this.offsetBytes,
    required this.pathLengthBytes,
    required this.contentLengthBytes,
    required this.entryCount,
    required this.subindexCount,
  }) : blobIdBytes = Uint8List.fromList(blobIdBytes) {
    assert(hashPrefixBytes >= 4);
    if (blobIdBytes.length > 4096) {
      throw ArgumentError('blobId must not exceed 4096 UTF-8 bytes.');
    }
  }

  static HashIndexHeader parse(Uint8List bytes) {
    if (bytes.length < 18) {
      throw FormatException(
        'Index data too short to contain a valid header '
        '(${bytes.length} bytes, need at least 18).',
      );
    }
    final data = ByteData.sublistView(bytes);
    if (data.getUint8(0) != 0x49 || data.getUint8(1) != 0x42) {
      throw FormatException('Magic bytes do not match');
    }
    final version = data.getUint16(2);
    if (version != 1) {
      throw FormatException('Unexpected version: $version');
    }
    final hashPrefixBytes = data.getUint8(4);
    final offsetBytes = data.getUint8(5);
    final pathLengthBytes = data.getUint8(6);
    final contentLengthBytes = data.getUint8(7);
    final entryCount = data.getUint32(8);
    final subindexCount = data.getUint32(12);
    final blobIdLength = data.getUint16(16);
    if (bytes.length < 18 + blobIdLength) {
      throw FormatException(
        'Index data too short to contain the blobId '
        '(${bytes.length} bytes, need ${18 + blobIdLength}).',
      );
    }
    if (hashPrefixBytes < 4) {
      throw FormatException(
        'Invalid hashPrefixBytes: $hashPrefixBytes (must be ≥ 4).',
      );
    }
    if (offsetBytes != 2 && offsetBytes != 4 && offsetBytes != 8) {
      throw FormatException(
        'Invalid offsetBytes: $offsetBytes (must be 2, 4, or 8).',
      );
    }
    if (pathLengthBytes != 2) {
      throw FormatException(
        'Invalid pathLengthBytes: $pathLengthBytes (must be 2).',
      );
    }
    if (contentLengthBytes != 2 &&
        contentLengthBytes != 4 &&
        contentLengthBytes != 8) {
      throw FormatException(
        'Invalid contentLengthBytes: $contentLengthBytes (must be 2, 4, or 8).',
      );
    }
    final blobIdBytes = bytes.sublist(18, 18 + blobIdLength);
    return HashIndexHeader(
      version: version,
      blobIdBytes: blobIdBytes,
      hashPrefixBytes: hashPrefixBytes,
      offsetBytes: offsetBytes,
      pathLengthBytes: pathLengthBytes,
      contentLengthBytes: contentLengthBytes,
      entryCount: entryCount,
      subindexCount: subindexCount,
    );
  }

  Uint8List asBytes() {
    final bytes = Uint8List(18 + blobIdBytes.length);
    final data = bytes.buffer.asByteData();
    data.setUint8(0, 0x49);
    data.setUint8(1, 0x42);
    data.setUint16(2, 1); // fixed version
    data.setUint8(4, hashPrefixBytes);
    data.setUint8(5, offsetBytes);
    data.setUint8(6, pathLengthBytes);
    data.setUint8(7, contentLengthBytes);
    data.setUint32(8, entryCount);
    data.setUint32(12, subindexCount);
    data.setUint16(16, blobIdBytes.length);
    for (var i = 0; i < blobIdBytes.length; i++) {
      data.setUint8(18 + i, blobIdBytes[i]);
    }
    return bytes;
  }

  late final entryBlockOffset = 18 + blobIdBytes.length;
  late final entryLength =
      hashPrefixBytes + offsetBytes + pathLengthBytes + contentLengthBytes;
  late final subindexBlockOffset = entryBlockOffset + entryCount * entryLength;
  late final subindexLength =
      hashPrefixBytes + offsetBytes + contentLengthBytes;

  int getEntryOffset(int index) => entryBlockOffset + entryLength * index;
  int getSubindexOffset(int index) =>
      subindexBlockOffset + subindexLength * index;

  late final blobId = utf8.decode(blobIdBytes);
}

extension on ByteData {
  void setUint(int length, int byteOffset, int value) {
    switch (length) {
      case 1:
        setUint8(byteOffset, value);
        break;
      case 2:
        setUint16(byteOffset, value);
        break;
      case 4:
        setUint32(byteOffset, value);
        break;
      case 8:
        setUint64(byteOffset, value);
        break;
      default:
        throw UnimplementedError('Length $length is not supported.');
    }
  }

  int getUint(int length, int byteOffset) {
    switch (length) {
      case 1:
        return getUint8(byteOffset);
      case 2:
        return getUint16(byteOffset);
      case 4:
        return getUint32(byteOffset);
      case 8:
        return getUint64(byteOffset);
      default:
        throw UnimplementedError('Length $length is not supported.');
    }
  }
}
