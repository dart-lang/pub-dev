// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Reader implementation for ZIP files, adapted from Go's archive/zip.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'struct.dart';

/// Abstract interface for random access reading, similar to Go's `io.ReaderAt`.
abstract final class RandomAccessReader {
  /// Reads up to [count] bytes from the specified [position] into the given [buffer].
  /// Returns the number of bytes read.
  Future<int> readAt(int position, List<int> buffer, int count);

  /// The total length of the data source.
  Future<int> get length;

  /// Closes the reader and releases any associated resources.
  Future<void> close();
}

/// Implementation of [RandomAccessReader] for a file.
final class FileReader implements RandomAccessReader {
  final RandomAccessFile _file;
  final int _length;

  FileReader(this._file) : _length = _file.lengthSync();

  @override
  Future<int> readAt(int position, List<int> buffer, int count) async {
    await _file.setPosition(position);
    return await _file.readInto(buffer, 0, count);
  }

  @override
  Future<int> get length async => _length;

  @override
  Future<void> close() async {
    await _file.close();
  }
}

/// Implementation of [RandomAccessReader] for a memory buffer.
final class MemoryReader implements RandomAccessReader {
  final Uint8List _buffer;

  MemoryReader(this._buffer);

  /// Reads bytes from the memory buffer.
  ///
  /// Throws [ArgumentError] if [position] is negative.
  @override
  Future<int> readAt(int position, List<int> buffer, int count) async {
    if (position < 0) throw ArgumentError('Negative position not allowed');
    if (position >= _buffer.length) return 0;
    int end = position + count;
    if (end > _buffer.length) end = _buffer.length;
    final int read = end - position;
    buffer.setRange(0, read, _buffer, position);
    return read;
  }

  @override
  Future<int> get length async => _buffer.length;

  @override
  Future<void> close() async {
    // Nothing to close.
  }
}

/// A [ZipReader] provides content from a ZIP archive.
final class ZipReader {
  final RandomAccessReader _reader;
  final List<ZipFile> files = [];
  String comment = '';

  ZipReader(this._reader);

  /// Creates a new [ZipReader] for in-memory ZIP data.
  ///
  /// Throws a [FormatException] if the data is not a valid ZIP file.
  static Future<ZipReader> fromBytes(Uint8List bytes) async {
    final reader = ZipReader(MemoryReader(bytes));
    await reader.init();
    return reader;
  }

  /// Opens a ZIP file from a [File].
  ///
  /// Throws a [FileSystemException] if the file cannot be opened.
  /// Throws a [FormatException] if the file is not a valid ZIP file.
  static Future<ZipReader> openFile(File file) async {
    final randomAccessFile = await file.open();
    final reader = FileReader(randomAccessFile);
    final zipReader = ZipReader(reader);
    await zipReader.init();
    return zipReader;
  }

  /// Closes the reader and releases any associated resources.
  Future<void> close() async {
    await _reader.close();
  }

  /// Initializes the reader by reading the central directory.
  /// This must be called before accessing files.
  ///
  /// Throws [FormatException] if the file is too short, if the directory end record
  /// is not found, or if any signature is invalid.
  /// Throws [Exception] if reading from the source fails.
  Future<void> init() async {
    await _readDirectory();
  }

  Future<void> _readDirectory() async {
    final int size = await _reader.length;
    if (size < ZipConstants.directoryEndLen) {
      throw ZipFormatException('Not a valid zip file (too short)');
    }

    // Search for directory end signature in the last 1K, then last 65K.
    int dirEndOffset = -1;
    Uint8List? buf;
    for (int bLen in [1024, 65535]) {
      if (bLen > size) bLen = size;
      buf = Uint8List(bLen);
      final int read = await _reader.readAt(size - bLen, buf, bLen);
      if (read != bLen) {
        throw ZipFormatException('Truncated file end');
      }

      dirEndOffset = _findSignatureInBlock(buf);
      if (dirEndOffset >= 0) {
        dirEndOffset += (size - bLen);
        break;
      }
      if (bLen == size) break;
    }

    if (dirEndOffset < 0) {
      throw ZipFormatException('Zip directory end not found');
    }

    // Read directory end record.
    final Uint8List dirEndBuf = Uint8List(ZipConstants.directoryEndLen);
    await _reader.readAt(dirEndOffset, dirEndBuf, ZipConstants.directoryEndLen);
    final ByteData bd = ByteData.view(dirEndBuf.buffer);

    // Verify signature.
    if (bd.getUint32(0, Endian.little) != ZipConstants.directoryEndSignature) {
      throw ZipFormatException('Invalid directory end signature');
    }

    final int directoryRecords = bd.getUint16(10, Endian.little);
    final int directorySize = bd.getUint32(12, Endian.little);
    final int directoryOffset = bd.getUint32(16, Endian.little);
    final int commentLen = bd.getUint16(20, Endian.little);

    if (commentLen > 0) {
      final Uint8List commentBuf = Uint8List(commentLen);
      await _reader.readAt(
        dirEndOffset + ZipConstants.directoryEndLen,
        commentBuf,
        commentLen,
      );
      comment = String.fromCharCodes(commentBuf);
    }

    int records = directoryRecords;
    int dirSize = directorySize;
    int off = directoryOffset;

    if (directoryRecords == 0xffff ||
        directorySize == 0xffff ||
        directoryOffset == 0xffffffff) {
      final int p = await _findDirectory64End(_reader, dirEndOffset);
      if (p >= 0) {
        final (
          diskNbr,
          dirDiskNbr,
          dirRecordsThisDisk,
          dirRecords,
          newDirSize,
          dirOffset,
        ) = await _readDirectory64End(
          _reader,
          p,
        );
        dirEndOffset = p;
        records = dirRecords;
        dirSize = newDirSize;
        off = dirOffset;
      }
    }

    final int baseOffset = dirEndOffset - dirSize - off;

    if (records > 100000) {
      throw ZipFormatException('Too many directory records');
    }

    // Read central directory headers.
    int offset = baseOffset + off;
    ZipFormatException? lastErr;
    for (int i = 0; i < records; i++) {
      try {
        final ZipFileHeader header = await readDirectoryHeader(_reader, offset);
        files.add(
          ZipFile(header, _reader, baseOffset + header.localHeaderOffset),
        );
        offset +=
            ZipConstants.directoryHeaderLen +
            header.name.length +
            header.extra.length +
            header.comment.length;
      } on ZipFormatException catch (e) {
        lastErr = e;
        break;
      }
    }

    if (files.length != records) {
      throw lastErr ?? ZipFormatException('Truncated file count');
    }
  }

  int _findSignatureInBlock(Uint8List buf) {
    // Search from end for directoryEndSignature (0x06054b50 -> P K 0x05 0x06)
    for (int i = buf.length - ZipConstants.directoryEndLen; i >= 0; i--) {
      if (buf[i] == 0x50 &&
          buf[i + 1] == 0x4b &&
          buf[i + 2] == 0x05 &&
          buf[i + 3] == 0x06) {
        // Read comment length (last 2 bytes of the 22-byte header).
        final int commentLen =
            buf[i + ZipConstants.directoryEndLen - 2] |
            (buf[i + ZipConstants.directoryEndLen - 1] << 8);
        if (i + ZipConstants.directoryEndLen + commentLen > buf.length) {
          // Truncated comment.
          return -1;
        }
        return i;
      }
    }
    return -1;
  }

  Future<int> _findDirectory64End(
    RandomAccessReader reader,
    int directoryEndOffset,
  ) async {
    final int locOffset = directoryEndOffset - 20; // directory64LocLen is 20
    if (locOffset < 0) return -1;

    final Uint8List buf = Uint8List(20);
    await reader.readAt(locOffset, buf, 20);
    final ByteData bd = ByteData.view(buf.buffer);

    if (bd.getUint32(0, Endian.little) !=
        ZipConstants.directory64LocSignature) {
      return -1;
    }
    if (bd.getUint32(4, Endian.little) != 0) {
      return -1;
    }
    final int p = bd.getUint64(8, Endian.little);
    if (bd.getUint32(16, Endian.little) != 1) {
      return -1;
    }
    return p;
  }

  Future<(int, int, int, int, int, int)> _readDirectory64End(
    RandomAccessReader reader,
    int offset,
  ) async {
    final Uint8List buf = Uint8List(56); // directory64EndLen is 56
    await reader.readAt(offset, buf, 56);
    final ByteData bd = ByteData.view(buf.buffer);

    if (bd.getUint32(0, Endian.little) !=
        ZipConstants.directory64EndSignature) {
      throw ZipFormatException('Invalid zip64 directory end signature');
    }

    final int diskNbr = bd.getUint32(16, Endian.little);
    final int dirDiskNbr = bd.getUint32(20, Endian.little);
    final int dirRecordsThisDisk = bd.getUint64(24, Endian.little);
    if (dirRecordsThisDisk == -1) {
      throw ArgumentError('Too many directory records on this disk');
    }
    final int directoryRecords = bd.getUint64(32, Endian.little);
    final int directorySize = bd.getUint64(40, Endian.little);
    final int directoryOffset = bd.getUint64(48, Endian.little);

    return (
      diskNbr,
      dirDiskNbr,
      dirRecordsThisDisk,
      directoryRecords,
      directorySize,
      directoryOffset,
    );
  }
}

/// A [ZipFile] is a single file in a ZIP archive.
/// The file information is in the embedded [ZipFileHeader].
/// The file content can be accessed by calling [open].
final class ZipFile {
  final ZipFileHeader header;
  final RandomAccessReader _reader;
  final int _localHeaderOffset;

  ZipFile(this.header, this._reader, this._localHeaderOffset);

  /// Returns a stream of the file contents.
  ///
  /// > [!WARNING]
  /// > The [Stream] must be read until end, or CRC32 signature will not
  /// > be validated!
  ///
  /// Throws [FormatException] if the compression method is unsupported or if the
  /// local header signature is invalid.
  Stream<List<int>> open() {
    final Stream<List<int>> rawStream = _openRaw().cast<List<int>>();
    final Stream<List<int>> inflatedStream;
    if (header.method == ZipConstants.deflate) {
      inflatedStream = rawStream.transform(ZLibDecoder(raw: true));
    } else if (header.method == ZipConstants.store) {
      inflatedStream = rawStream;
    } else {
      throw ZipFormatException(
        'Unsupported compression method: ${header.method}',
      );
    }
    return inflatedStream.transform(_Crc32Transformer(header.crc32));
  }

  Stream<Uint8List> _openRaw() async* {
    // Read local header.
    final Uint8List buf = Uint8List(ZipConstants.fileHeaderLen);
    await _reader.readAt(_localHeaderOffset, buf, ZipConstants.fileHeaderLen);
    final ByteData bd = ByteData.view(buf.buffer);

    if (bd.getUint32(0, Endian.little) != ZipConstants.fileHeaderSignature) {
      throw ZipFormatException('Invalid local file header signature');
    }

    final int filenameLen = bd.getUint16(26, Endian.little);
    final int extraLen = bd.getUint16(28, Endian.little);

    final int bodyOffset =
        _localHeaderOffset +
        ZipConstants.fileHeaderLen +
        filenameLen +
        extraLen;
    int remaining = header.compressedSize64;
    int offset = bodyOffset;
    final int chunkSize = 4096;

    while (remaining > 0) {
      final int toRead = remaining < chunkSize ? remaining : chunkSize;
      final Uint8List chunk = Uint8List(toRead);
      final int read = await _reader.readAt(offset, chunk, toRead);
      if (read != toRead) {
        throw ZipFormatException('Truncated file content');
      }
      yield chunk;
      remaining -= read;
      offset += read;
    }
  }
}

final class _Crc32 {
  static final List<int> _table = _generateTable();

  static List<int> _generateTable() {
    final table = List<int>.filled(256, 0);
    for (int i = 0; i < 256; i++) {
      int c = i;
      for (int j = 0; j < 8; j++) {
        if ((c & 1) != 0) {
          c = 0xEDB88320 ^ (c >> 1);
        } else {
          c = c >> 1;
        }
      }
      table[i] = c;
    }
    return table;
  }

  int _crc = 0xFFFFFFFF;

  void update(List<int> bytes) {
    for (final int byte in bytes) {
      _crc = (_crc >> 8) ^ _table[(_crc ^ byte) & 0xFF];
    }
  }

  int get value => _crc ^ 0xFFFFFFFF;
}

class _Crc32Transformer extends StreamTransformerBase<List<int>, List<int>> {
  final int expectedCrc;

  _Crc32Transformer(this.expectedCrc);

  @override
  Stream<List<int>> bind(Stream<List<int>> stream) {
    late StreamController<List<int>> controller;
    late StreamSubscription<List<int>> subscription;
    final crc = _Crc32();

    controller = StreamController<List<int>>(
      onListen: () {
        subscription = stream.listen(
          (data) {
            crc.update(data);
            controller.add(data);
          },
          onError: controller.addError,
          onDone: () {
            if (crc.value != expectedCrc) {
              controller.addError(
                ZipFormatException(
                  'CRC32 checksum mismatch: expected 0x${expectedCrc.toRadixString(16)}, got 0x${crc.value.toRadixString(16)}',
                ),
              );
            }
            controller.close();
          },
          cancelOnError: true,
        );
      },
      onPause: () => subscription.pause(),
      onResume: () => subscription.resume(),
      onCancel: () => subscription.cancel(),
    );

    return controller.stream;
  }
}

/// Exception thrown when a ZIP file is malformed or not in the expected format.
final class ZipFormatException implements FormatException {
  @override
  final String message;
  @override
  final dynamic source;
  @override
  final int? offset;

  ZipFormatException(this.message, {this.source, this.offset});

  @override
  String toString() => 'ZipFormatException: $message';
}

Future<ZipFileHeader> readDirectoryHeader(
  RandomAccessReader reader,
  int offset,
) async {
  if (offset < 0) throw ZipFormatException('Negative offset not allowed');
  final Uint8List headerBuf = Uint8List(ZipConstants.directoryHeaderLen);
  await reader.readAt(offset, headerBuf, ZipConstants.directoryHeaderLen);
  final ByteData hbd = ByteData.view(headerBuf.buffer);

  if (hbd.getUint32(0, Endian.little) !=
      ZipConstants.directoryHeaderSignature) {
    throw ZipFormatException('Invalid directory header signature at $offset');
  }

  final int creatorVersion = hbd.getUint16(4, Endian.little);
  final int readerVersion = hbd.getUint16(6, Endian.little);
  final int flags = hbd.getUint16(8, Endian.little);
  final int method = hbd.getUint16(10, Endian.little);
  final int crc32 = hbd.getUint32(16, Endian.little);
  final int compressedSize = hbd.getUint32(20, Endian.little);
  final int uncompressedSize = hbd.getUint32(24, Endian.little);
  final int filenameLen = hbd.getUint16(28, Endian.little);
  final int extraLen = hbd.getUint16(30, Endian.little);
  final int commentLen = hbd.getUint16(32, Endian.little);
  final int externalAttrs = hbd.getUint32(38, Endian.little);
  final int localHeaderOffset = hbd.getUint32(42, Endian.little);

  final Uint8List nameBuf = Uint8List(filenameLen);
  await reader.readAt(
    offset + ZipConstants.directoryHeaderLen,
    nameBuf,
    filenameLen,
  );
  final String name;
  if ((flags & 0x800) != 0) {
    name = utf8.decode(nameBuf);
  } else {
    name = String.fromCharCodes(nameBuf);
  }

  if (name.startsWith('../') ||
      name.contains('/../') ||
      name.startsWith('/') ||
      name.contains('\\')) {
    throw ZipFormatException('Insecure file path: $name');
  }

  final Uint8List extraBuf = Uint8List(extraLen);
  await reader.readAt(
    offset + ZipConstants.directoryHeaderLen + filenameLen,
    extraBuf,
    extraLen,
  );

  // Parse Zip64 extra fields.
  int compressedSize64 = compressedSize;
  int uncompressedSize64 = uncompressedSize;
  int resolvedLocalHeaderOffset = localHeaderOffset;

  if (extraLen >= 4) {
    final ByteData extraBd = ByteData.view(extraBuf.buffer);
    int extraOffset = 0;
    while (extraOffset + 4 <= extraLen) {
      final int tag = extraBd.getUint16(extraOffset, Endian.little);
      final int len = extraBd.getUint16(extraOffset + 2, Endian.little);
      extraOffset += 4;

      if (extraOffset + len > extraLen) break;

      // Tag 0x0001: Zip64 Extended Information Extra Field
      if (tag == 0x0001) {
        int zip64Offset = extraOffset;
        if (uncompressedSize == 0xffffffff &&
            zip64Offset + 8 <= extraOffset + len) {
          uncompressedSize64 = extraBd.getUint64(zip64Offset, Endian.little);
          zip64Offset += 8;
        }
        if (compressedSize == 0xffffffff &&
            zip64Offset + 8 <= extraOffset + len) {
          compressedSize64 = extraBd.getUint64(zip64Offset, Endian.little);
          zip64Offset += 8;
        }
        if (localHeaderOffset == 0xffffffff &&
            zip64Offset + 8 <= extraOffset + len) {
          resolvedLocalHeaderOffset = extraBd.getUint64(
            zip64Offset,
            Endian.little,
          );
          zip64Offset += 8;
        }
      }

      extraOffset += len;
    }
  }

  final Uint8List commentBuf = Uint8List(commentLen);
  await reader.readAt(
    offset + ZipConstants.directoryHeaderLen + filenameLen + extraLen,
    commentBuf,
    commentLen,
  );
  final String comment;
  if ((flags & 0x800) != 0) {
    comment = utf8.decode(commentBuf);
  } else {
    comment = String.fromCharCodes(commentBuf);
  }

  return ZipFileHeader(
    name: name,
    comment: comment,
    creatorVersion: creatorVersion,
    readerVersion: readerVersion,
    flags: flags,
    method: method,
    crc32: crc32,
    compressedSize: compressedSize,
    uncompressedSize: uncompressedSize,
    externalAttrs: externalAttrs,
    localHeaderOffset: resolvedLocalHeaderOffset,
    extra: extraBuf,
    compressedSize64: compressedSize64,
    uncompressedSize64: uncompressedSize64,
  );
}
