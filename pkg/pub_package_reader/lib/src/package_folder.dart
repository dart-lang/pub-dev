// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'tar_utils.dart';

/// Helper methods to access package content.
abstract class PackageFolder {
  /// Returns and implementation that uses archive.tar.gz to provide access to
  /// the package archive.
  ///
  /// Caches list of files for faster access.
  static PackageFolder tarballPath(String path) =>
      _ArchiveTarGzPackageFolder(path);

  /// List all the file names in the directory.
  Future<List<String>> listFileNames();

  /// Whether the file on the given relative [path] exists.
  Future<bool> exists(String path);

  /// Read the content of the file on the given relative [path].
  Stream<List<int>> read(String path);

  /// Read the content of the file on the given relative [path] as String.
  Future<String> readAsString(
    String path, {
    int maxLength,
    String cutoffPostfix = '[...]',
  }) async {
    String content =
        await Utf8Codec(allowMalformed: true).decodeStream(read(path));
    if (maxLength != null && maxLength > 0 && content.length > maxLength) {
      content = content.substring(0, maxLength);
      if (cutoffPostfix != null) {
        content += cutoffPostfix;
      }
    }
    return content;
  }

  /// Free up resources (if it was extracted to a temp directory).
  Future close();
}

/// Uses archive.tar.gz to provide access to the package archive.
///
/// Caches list of files for faster access.
class _ArchiveTarGzPackageFolder extends PackageFolder {
  final String _path;
  List<String> _fileNames;

  _ArchiveTarGzPackageFolder(this._path);

  @override
  Future<bool> exists(String path) async {
    final names = await listFileNames();
    return names.contains(path);
  }

  @override
  Future<List<String>> listFileNames() async {
    _fileNames ??= await listTarball(_path);
    return _fileNames;
  }

  @override
  Stream<List<int>> read(String path) {
    return openTarballFile(_path, path);
  }

  @override
  Future close() async {
    // nothing to do, we don't delete the archive.tar.gz
  }
}
