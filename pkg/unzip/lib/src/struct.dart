// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Constants and structures for ZIP files.
///
/// Adapted from Go's `archive/zip`.
library;

abstract final class ZipConstants {
  static const int fileHeaderSignature = 0x04034b50;
  static const int directoryHeaderSignature = 0x02014b50;
  static const int directoryEndSignature = 0x06054b50;
  static const int directory64LocSignature = 0x07064b50;
  static const int directory64EndSignature = 0x06064b50;
  static const int dataDescriptorSignature = 0x08074b50;

  static const int fileHeaderLen = 30;
  static const int directoryHeaderLen = 46;
  static const int directoryEndLen = 22;
  static const int dataDescriptorLen = 16;
  static const int dataDescriptor64Len = 24;
  static const int directory64LocLen = 20;
  static const int directory64EndLen = 56;

  // Compression methods.
  static const int store = 0;
  static const int deflate = 8;
}

/// [FileHeader] describes a file within a ZIP file.
/// See the [ZIP specification](https://support.pkware.com/pkzip/appnote) for details.
final class FileHeader {
  /// Name of the file.
  ///
  /// It must be a relative path, not start with a drive letter (such as "C:"),
  /// and must use forward slashes instead of back slashes. A trailing slash
  /// indicates that this file is a directory and should have no data.
  final String name;

  /// Arbitrary user-defined string shorter than 64KiB.
  final String comment;

  /// Indicates that Name and Comment are not encoded in UTF-8.
  ///
  /// By specification, the only other encoding permitted should be CP-437,
  /// but historically many ZIP readers interpret Name and Comment as whatever
  /// the system's local character encoding happens to be.
  final bool nonUTF8;

  /// The ZIP specification version and the operating system used to create the
  /// file. The upper byte indicates the system (e.g., 0 for FAT/MS-DOS, 3 for
  /// Unix, 19 for macOS), and the lower byte indicates the ZIP specification
  /// version (e.g., 20 for 2.0).
  final int creatorVersion;

  /// The minimum ZIP specification version needed to extract this file (e.g.,
  /// 20 for 2.0, 45 for Zip64).
  final int readerVersion;

  /// General purpose bit flag (e.g., bit 11 for UTF-8 encoding).
  final int flags;

  /// Compression method used (e.g., 0 for Store, 8 for Deflate).
  final int method;

  /// Modified time of the file.
  ///
  /// When reading, an extended timestamp is preferred over the legacy MS-DOS
  /// date field, and the offset between the times is used as the timezone.
  /// If only the MS-DOS date is present, the timezone is assumed to be UTC.
  final DateTime? modified;

  /// CRC32 checksum of the file content.
  final int crc32;

  /// Compressed size of the file in bytes (32-bit).
  final int compressedSize;

  /// Uncompressed size of the file in bytes (32-bit).
  final int uncompressedSize;

  /// Compressed size of the file in bytes (64-bit).
  final int compressedSize64;

  /// Uncompressed size of the file in bytes (64-bit).
  final int uncompressedSize64;

  /// Extra field data (e.g., for high-precision timestamps or Zip64).
  final List<int> extra;

  /// Meaning depends on CreatorVersion.
  final int externalAttrs;

  /// Offset of the local file header from the start of the ZIP file.
  final int localHeaderOffset;

  FileHeader({
    required this.name,
    this.comment = '',
    this.nonUTF8 = false,
    this.creatorVersion = 0,
    this.readerVersion = 0,
    this.flags = 0,
    this.method = 0,
    this.modified,
    this.crc32 = 0,
    this.compressedSize = 0,
    this.uncompressedSize = 0,
    this.compressedSize64 = 0,
    this.uncompressedSize64 = 0,
    this.extra = const [],
    this.externalAttrs = 0,
    this.localHeaderOffset = 0,
  });
}
