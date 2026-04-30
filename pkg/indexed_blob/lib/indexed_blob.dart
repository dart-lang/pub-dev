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
import 'dart:convert' show utf8;
import 'dart:math';
import 'dart:typed_data';
import 'package:collection/collection.dart';
import 'package:crypto/crypto.dart';
export 'src/blobindexpair.dart' show BlobIndexPair;

/// Reads a byte slice from the blob.
typedef BlobSliceReader = Future<Uint8List?> Function(int start, int end);

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
  int get indexUpperLength => 128 + _entries.length * (32 + 8 + 8);

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
        throw ArgumentError(
          'Path too long (must not exceed 4096 UTF-8 bytes).',
        );
      }

      // Writing path as a big-endian length prefix followed by the path bytes.
      final pathLenPrefix = Uint8List(_pathLengthPrefixSize);
      pathLenPrefix.buffer.asByteData().setUint16(0, pathBytes.length);
      _blob.add(pathLenPrefix);
      _offset += _pathLengthPrefixSize;
      _blob.add(pathBytes);
      _offset += pathBytes.length;

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
          blockLength: endOffset - startOffset,
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
  ///    `uint16be(utf8(path).length) + utf8(path) + <raw content bytes>`
  /// 2. **Subindex blocks** (if the index is large) – zero or more secondary
  ///    index blocks appended directly to the blob (see below).
  ///
  /// ## Index file format
  ///
  /// The returned bytes form a single binary buffer with this layout:
  ///
  /// ```
  /// [ HashIndexHeader (17 + blobIdLength bytes) ]
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
  Future<Uint8List> buildIndex(
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
      return HashIndexHeader.empty(blobId: blobId).asBytes();
    }

    final records = _entries.map((e) => e.toRecord(blobIdBytes)).toList();
    records.sort(
      (a, b) => _compareHashWithOffset(
        a.hashPrefix,
        0,
        b.hashPrefix,
        a.hashPrefix.length,
      ),
    );

    var maxCommonHashPrefix = 0;
    for (var i = 1; i < records.length; i++) {
      maxCommonHashPrefix = max(
        maxCommonHashPrefix,
        _commonPrefix(records[i - 1].hashPrefix, records[i].hashPrefix),
      );
    }
    final hashPrefixBytes = max(4, maxCommonHashPrefix + 1);

    final worstCaseIndexSize = (hashPrefixBytes + 8 + 8) * records.length;
    final worstCaseOffset =
        _offset +
        worstCaseIndexSize +
        /* arbitrary padding for headers and other overheads */
        128 * 1024;

    final offsetMinBytes = (worstCaseOffset.bitLength ~/ 8) + 1;
    final offsetBytes = offsetMinBytes <= 2 ? 2 : (offsetMinBytes <= 4 ? 4 : 8);
    // A single file's content cannot exceed the total blob size, so the same
    // byte-width that fits blob offsets also fits content lengths.
    final contentLengthBytes = offsetBytes;

    final recordBytesLength =
        hashPrefixBytes + offsetBytes + contentLengthBytes;

    final subindexCount =
        (records.length * recordBytesLength) ~/ (indexSizeThresholdKiB * 1024);
    final entryPerIndex = (records.length ~/ (subindexCount + 1)) + 1;

    final subindexRecords = <_Record>[];
    final slices = records.slices(entryPerIndex);
    for (final slice in slices.skip(1)) {
      final subindexStartOffset = _offset;

      final subIndexHeader = HashIndexHeader(
        version: 1,
        blobIdBytes: blobIdBytes,
        hashPrefixBytes: hashPrefixBytes,
        offsetBytes: offsetBytes,
        contentLengthBytes: contentLengthBytes,
        entryCount: slice.length,
        subindexCount: 0,
      );
      final headerBytes = subIndexHeader.asBytes();
      _blob.add(headerBytes);
      _offset += headerBytes.length;
      for (final record in slice) {
        final entryBytes = subIndexHeader.encodeRecord(record);
        _blob.add(entryBytes);
        _offset += entryBytes.length;
      }
      final subindexEndOffset = _offset;
      subindexRecords.add(
        _Record(
          hashPrefix: slice.first.hashPrefix,
          offset: subindexStartOffset,
          length: subindexEndOffset - subindexStartOffset,
        ),
      );
    }

    await _blob.close();

    final indexHeader = HashIndexHeader(
      version: 1,
      blobIdBytes: blobIdBytes,
      hashPrefixBytes: hashPrefixBytes,
      offsetBytes: offsetBytes,
      contentLengthBytes: contentLengthBytes,
      entryCount: slices.first.length,
      subindexCount: subindexRecords.length,
    );
    final indexBytesBuilder = BytesBuilder();
    indexBytesBuilder.add(indexHeader.asBytes());
    for (final r in slices.first) {
      indexBytesBuilder.add(indexHeader.encodeRecord(r));
    }
    for (final r in subindexRecords) {
      indexBytesBuilder.add(indexHeader.encodeRecord(r));
    }
    return indexBytesBuilder.toBytes();
  }
}

/// Byte width of the path-length prefix written at the start of every blob entry.
const _pathLengthPrefixSize = 2;

Uint8List _hash(List<int> keyBytes, List<int> pathBytes) {
  final digest = Hmac(sha256, keyBytes).convert(pathBytes);
  return Uint8List.fromList(digest.bytes);
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

/// An accessor for a hash-indexed binary block (main index or subindex).
///
/// Parses the [HashIndexHeader] from the supplied bytes and provides
/// record-level read and search operations.
final class HashIndex {
  final Uint8List _bytes;

  HashIndex(Uint8List bytes) : _bytes = bytes;
  factory HashIndex.empty() =>
      HashIndex(HashIndexHeader.empty(blobId: '').asBytes());

  late final _header = HashIndexHeader.parse(_bytes);
  late final _data = ByteData.sublistView(_bytes);

  String get blobId => _header.blobId;
  Uint8List get _blobIdBytes => _header.blobIdBytes;

  int get _entryCount => _header.entryCount;
  int get _subindexCount => _header.subindexCount;

  /// Returns the blob `(offset, length)` for entry record [i].
  (int offset, int length) _getEntryRecord(int i) {
    var dataOffset = _header.getEntryOffset(i) + _header.hashPrefixBytes;
    final offset = _data.getUint(_header.offsetBytes, dataOffset);
    dataOffset += _header.offsetBytes;
    final length = _data.getUint(_header.contentLengthBytes, dataOffset);
    return (offset, length);
  }

  /// Returns the blob `(offset, length)` for subindex record [i].
  (int offset, int length) _getSubindexRecord(int i) {
    var dataOffset = _header.getSubindexOffset(i) + _header.hashPrefixBytes;
    final offset = _data.getUint(_header.offsetBytes, dataOffset);
    dataOffset += _header.offsetBytes;
    final length = _data.getUint(_header.contentLengthBytes, dataOffset);
    return (offset, length);
  }

  /// Binary-searches entry records for an exact hash match.
  ///
  /// Returns the matched index, or `-1` if not found.
  int _searchEntry(Uint8List hashBytes) => _search(
    _header.entryCount,
    (i) => _compareHashWithOffset(
      _bytes,
      _header.getEntryOffset(i),
      hashBytes,
      _header.hashPrefixBytes,
    ),
  );

  /// Binary-searches subindex records for the largest hash ≤ [hashBytes].
  ///
  /// Returns the matched index, or `-1` if every subindex hash is greater.
  int _searchSubindex(Uint8List hashBytes) => _search(
    _header.subindexCount,
    (i) => _compareHashWithOffset(
      _bytes,
      _header.getSubindexOffset(i),
      hashBytes,
      _header.hashPrefixBytes,
    ),
    exactMatch: false,
  );

  /// Returns `true` if the hash stored for entry [i] matches [hashBytes].
  bool _verifyEntryHash(int i, Uint8List hashBytes) =>
      _compareHashWithOffset(
        _bytes,
        _header.getEntryOffset(i),
        hashBytes,
        _header.hashPrefixBytes,
      ) ==
      0;

  /// Returns the raw bytes of this index block.
  Uint8List asBytes() => _bytes;
}

/// Index for an indexed-blob, can be used to lookup [FileRange].
final class BlobIndex {
  final HashIndex _hashIndex;
  final BlobSliceReader _readBlob;

  /// Create [BlobIndex] from [indexFile] contents, with [readBlob] used to
  /// fetch byte ranges from the associated blob.
  ///
  /// The format of the [indexFile] is internal to [IndexedBlobBuilder] and
  /// [BlobIndex], attempts to read/write the format outside of these classes
  /// is unsupported.
  BlobIndex.fromBytes(List<int> indexFile, BlobSliceReader readBlob)
    : _hashIndex = HashIndex(
        indexFile is Uint8List ? indexFile : Uint8List.fromList(indexFile),
      ),
      _readBlob = readBlob;

  BlobIndex.from(this._hashIndex, this._readBlob);

  factory BlobIndex.empty() => BlobIndex.fromBytes(
    HashIndexHeader.empty(blobId: 'empty').asBytes(),
    (_, __) async => null,
  );

  /// Get the free-form [String] given as `blobId` when the blob was built.
  ///
  /// This is intended for an identifier or URL that can be used to find the
  /// blob indexed by this [BlobIndex].
  String get blobId => _hashIndex.blobId;

  bool get hasSubindexes => _hashIndex._subindexCount > 0;

  /// Looks up [path], automatically resolving subindex blocks when needed.
  ///
  /// Returns a [FileRange] describing where the file lives in the blob,
  /// or `null` if [path] is not stored in this indexed blob.
  Future<FileRange?> lookup(String path) async {
    final pathBytes = utf8.encode(path);
    final hashBytes = _hash(_hashIndex._blobIdBytes, pathBytes);

    final selectedSubindex = _hashIndex._searchSubindex(hashBytes);
    if (selectedSubindex >= 0) {
      final (contentOffset, contentLength) = _hashIndex._getSubindexRecord(
        selectedSubindex,
      );
      final subindexBytes = await _readBlob(
        contentOffset,
        contentOffset + contentLength,
      );
      if (subindexBytes == null) return null;
      return BlobIndex.fromBytes(
        subindexBytes,
        _readBlob,
      )._lookupInEntries(path, pathBytes, hashBytes);
    }

    return _lookupInEntries(path, pathBytes, hashBytes);
  }

  FileRange? _lookupInEntries(
    String path,
    List<int> pathBytes,
    Uint8List hashBytes,
  ) {
    final selectedEntry = _hashIndex._searchEntry(hashBytes);
    if (selectedEntry < 0) return null;
    final (entryOffset, blockLength) = _hashIndex._getEntryRecord(
      selectedEntry,
    );
    return FileRange._(path, entryOffset, entryOffset + blockLength, blobId);
  }

  /// Lists paths of all files stored in the indexed blob.
  ///
  /// Iterates entries in the main index, then fetches and iterates each
  /// subindex block in turn. For every entry, the blob reader is called once
  /// to read its path bytes; for each subindex block it is called once to load
  /// the block itself.
  ///
  /// Paths are yielded in hash order (not lexicographic path order).
  ///
  /// **Caution:** issues one blob-reader call per entry plus one per subindex
  /// block. For remote blobs, callers may want to buffer the stream rather
  /// than issuing large numbers of individual range requests.
  ///
  /// Throws [FormatException] if the path bytes read from the blob do not
  /// match the hash stored in the index for that entry.
  Stream<String> listFiles() async* {
    yield* _listEntries();
    for (var i = 0; i < _hashIndex._subindexCount; i++) {
      final (contentOffset, contentLength) = _hashIndex._getSubindexRecord(i);
      final subindexBytes = await _readBlob(
        contentOffset,
        contentOffset + contentLength,
      );
      if (subindexBytes != null) {
        yield* BlobIndex.fromBytes(subindexBytes, _readBlob)._listEntries();
      }
    }
  }

  Stream<String> _listEntries() async* {
    for (var i = 0; i < _hashIndex._entryCount; i++) {
      final (entryOffset, blockLength) = _hashIndex._getEntryRecord(i);
      final blockBytes = await _readBlob(
        entryOffset,
        entryOffset + blockLength,
      );
      if (blockBytes == null) continue;
      final pathLength = ByteData.sublistView(
        blockBytes,
      ).getUint(_pathLengthPrefixSize, 0);
      final pathBytes = Uint8List.sublistView(blockBytes, 2, 2 + pathLength);
      final computedHash = _hash(_hashIndex._blobIdBytes, pathBytes);
      if (!_hashIndex._verifyEntryHash(i, computedHash)) {
        throw FormatException(
          'Hash mismatch for entry $i: '
          'path bytes in blob do not match the stored hash.',
        );
      }
      yield utf8.decode(pathBytes);
    }
  }

  /// Returns `true` if [path] is stored in the indexed blob **and** the path
  /// bytes read from the blob match the expected value.
  ///
  /// Unlike [lookup], which only checks the hash index, this method also reads
  /// the path bytes from the blob to confirm there is no hash collision or
  /// index/blob mismatch.
  Future<bool> hasFile(String path) async {
    final range = await lookup(path);
    if (range == null) return false;
    final blobPathBytes = await _readBlob(
      range.entryOffset,
      range.contentStart,
    );
    if (blobPathBytes == null) return false;
    return range.matchesPathBytesPrefix(blobPathBytes);
  }

  Uint8List asBytes() => _hashIndex.asBytes();
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
  final int blockLength;

  _Entry({
    required this.startOffset,
    required this.pathBytes,
    required this.blockLength,
  });

  _Record toRecord(List<int> blobIdBytes) => _Record(
    hashPrefix: _hash(blobIdBytes, pathBytes),
    offset: startOffset,
    length: blockLength,
  );
}

/// A serializable index record: either a file entry or a subindex pointer.
///
/// Both kinds share the same byte layout:
/// ```
/// hashPrefixBytes    leading hash bytes (path hash for entries,
///                    first-entry hash for subindex pointers)
/// offsetBytes        blob offset (file entry start, or subindex block start)
/// contentLengthBytes byte length of the entire block starting at offset
///                    (entries: prefix + path + content; subindexes: full block)
/// ```
final class _Record {
  final Uint8List hashPrefix;
  final int offset;
  final int length;

  _Record({
    required this.hashPrefix,
    required this.offset,
    required this.length,
  });

  Uint8List asBytes({
    required int hashPrefixBytes,
    required int offsetBytes,
    required int contentLengthBytes,
  }) {
    final bytes = Uint8List(hashPrefixBytes + offsetBytes + contentLengthBytes);
    for (var i = 0; i < hashPrefixBytes; i++) {
      bytes[i] = hashPrefix[i];
    }
    final data = bytes.buffer.asByteData();
    var off = hashPrefixBytes;
    data.setUint(offsetBytes, off, offset);
    off += offsetBytes;
    data.setUint(contentLengthBytes, off, length);
    return bytes;
  }
}

/// Range of a file in an indexed-blob.
final class FileRange {
  /// Path that was looked up in [BlobIndex].
  final String path;

  /// Start offset of the file entry in the blob.
  ///
  /// The entry begins with a 2-byte big-endian path-length prefix, followed
  /// by `utf8(path)`, then the raw file content.  Use [contentStart] to skip
  /// past the path header and reach the first content byte.
  final int entryOffset;

  /// End offset of file in blob.
  final int end;

  /// Identifier for the blob file associated this [FileRange] is pointing into.
  final String blobId;

  FileRange._(this.path, this.entryOffset, this.end, this.blobId);

  late final _pathBytes = utf8.encode(path);
  late final pathLength = _pathBytes.length;
  late final contentStart = entryOffset + _pathLengthPrefixSize + pathLength;

  /// Checks whether [slice] — which must start at [entryOffset] in the blob —
  /// begins with a 2-byte big-endian length prefix and `utf8(path)`.
  bool matchesPathBytesPrefix(List<int> slice) {
    if (slice.length < _pathLengthPrefixSize + pathLength) {
      return false;
    }
    if (slice[0] != (pathLength >> 8) || slice[1] != (pathLength & 0xFF)) {
      return false;
    }
    for (var i = 0; i < pathLength; i++) {
      if (slice[_pathLengthPrefixSize + i] != _pathBytes[i]) {
        return false;
      }
    }
    return true;
  }

  /// Returns the file-content portion of [slice], where [slice] must start at
  /// [entryOffset] in the blob (i.e. it begins with a 2-byte length prefix
  /// and `utf8(path)`).
  /// Equivalent to `slice.sublist(_kPathLengthPrefixSize + pathLength)`.
  Uint8List contentRange(Uint8List slice) {
    return slice.sublist(_pathLengthPrefixSize + pathLength);
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
/// ## Header layout (17 + blobIdLength bytes, big-endian)
///
/// ```
/// Offset    Size      Field
/// ------    ----      -----
///      0       1      Magic byte 'I' (0x49)
///      1       1      Magic byte 'B' (0x42)
///      2       2      version (uint16); currently always 1
///      4       1      hashPrefixBytes: number of hash bytes stored per entry (≥ 4)
///      5       1      offsetBytes: byte-width used for blob offsets (2, 4, or 8)
///      6       1      contentLengthBytes: byte-width used for block lengths
///      7       4      entryCount (uint32): number of entry records that follow
///     11       4      subindexCount (uint32): number of subindex records that follow
///     15       2      blobIdLength (uint16): byte-length of the blobId UTF-8 string
///     17   [#15]      blobId: UTF-8 encoded, up to 4096 bytes
/// ```
///
/// ## Entry record layout (`entryCount` records after the header)
///
/// Each entry describes one file stored in the blob:
///
/// ```
/// Size               Field
/// ----               -----
/// hashPrefixBytes    leading bytes of SHA-256(blobIdBytes ++ pathBytes)
/// offsetBytes        start offset of the entry in the blob (uint)
/// contentLengthBytes byte-length of the entire entry block (uint):
///                    path-length prefix + utf8(path) + file content
/// ```
///
/// The entry's blob region begins with a 2-byte big-endian path-length prefix,
/// followed by `utf8(path)`, then the raw file content.
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
  final int contentLengthBytes;

  final int entryCount;
  final int subindexCount;

  HashIndexHeader({
    required this.version,
    required List<int> blobIdBytes,
    required this.hashPrefixBytes,
    required this.offsetBytes,
    required this.contentLengthBytes,
    required this.entryCount,
    required this.subindexCount,
  }) : blobIdBytes = Uint8List.fromList(blobIdBytes) {
    assert(hashPrefixBytes >= 4);
    if (blobIdBytes.length > 4096) {
      throw ArgumentError('blobId must not exceed 4096 UTF-8 bytes.');
    }
  }

  factory HashIndexHeader.empty({required String blobId}) {
    return HashIndexHeader(
      version: 1,
      blobIdBytes: utf8.encode(blobId),
      hashPrefixBytes: 4,
      offsetBytes: 4,
      contentLengthBytes: 4,
      entryCount: 0,
      subindexCount: 0,
    );
  }

  static HashIndexHeader parse(Uint8List bytes) {
    if (bytes.length < 17) {
      throw FormatException(
        'Index data too short to contain a valid header '
        '(${bytes.length} bytes, need at least 17).',
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
    final contentLengthBytes = data.getUint8(6);
    final entryCount = data.getUint32(7);
    final subindexCount = data.getUint32(11);
    final blobIdLength = data.getUint16(15);
    if (bytes.length < 17 + blobIdLength) {
      throw FormatException(
        'Index data too short to contain the blobId '
        '(${bytes.length} bytes, need ${17 + blobIdLength}).',
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
    if (contentLengthBytes != 2 &&
        contentLengthBytes != 4 &&
        contentLengthBytes != 8) {
      throw FormatException(
        'Invalid contentLengthBytes: $contentLengthBytes (must be 2, 4, or 8).',
      );
    }
    final blobIdBytes = bytes.sublist(17, 17 + blobIdLength);
    return HashIndexHeader(
      version: version,
      blobIdBytes: blobIdBytes,
      hashPrefixBytes: hashPrefixBytes,
      offsetBytes: offsetBytes,
      contentLengthBytes: contentLengthBytes,
      entryCount: entryCount,
      subindexCount: subindexCount,
    );
  }

  Uint8List asBytes() {
    final bytes = Uint8List(17 + blobIdBytes.length);
    final data = bytes.buffer.asByteData();
    data.setUint8(0, 0x49);
    data.setUint8(1, 0x42);
    data.setUint16(2, version);
    data.setUint8(4, hashPrefixBytes);
    data.setUint8(5, offsetBytes);
    data.setUint8(6, contentLengthBytes);
    data.setUint32(7, entryCount);
    data.setUint32(11, subindexCount);
    data.setUint16(15, blobIdBytes.length);
    for (var i = 0; i < blobIdBytes.length; i++) {
      data.setUint8(17 + i, blobIdBytes[i]);
    }
    return bytes;
  }

  late final entryBlockOffset = 17 + blobIdBytes.length;
  late final recordLength = hashPrefixBytes + offsetBytes + contentLengthBytes;
  late final subindexBlockOffset = entryBlockOffset + entryCount * recordLength;

  int getEntryOffset(int index) => entryBlockOffset + recordLength * index;
  int getSubindexOffset(int index) =>
      subindexBlockOffset + recordLength * index;

  Uint8List encodeRecord(_Record r) => r.asBytes(
    hashPrefixBytes: hashPrefixBytes,
    offsetBytes: offsetBytes,
    contentLengthBytes: contentLengthBytes,
  );

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
