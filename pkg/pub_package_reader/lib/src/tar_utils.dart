// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

final _logger = Logger('package_archive.tar_utils');

/// Accessing the tar archive, masking internals like filename normalization.
class TarArchive {
  final String _path;

  // Maps normalized form of file names to archive format.
  final Map<String, String> _files;

  TarArchive._(this._path, this._files);

  /// Creates a new instance by scanning the archive at [path].
  static Future<TarArchive> scan(String path) async {
    final args = ['-tzf', path];
    final result = await Process.run('tar', args);
    if (result.exitCode != 0) {
      _logger.warning('The "tar $args" command failed:\n'
          'with exit code: ${result.exitCode}\n'
          'stdout: ${result.stdout}\n'
          'stderr: ${result.stderr}');
      throw Exception('Failed to list tarball contents.');
    }

    final files = <String, String>{};
    (result.stdout as String).split('\n').forEach((name) {
      final normalized = p.normalize(name).trim();
      files[normalized] = name;
    });

    final archive = TarArchive._(path, files);
    return archive;
  }

  List<String> get fileNames => _files.keys.toList();

  // Searches in scanned files for a file name [name] and compare in a
  // case-insensitive manner.
  //
  // Returns `null` if not found otherwise the correct filename.
  String searchForFile(Iterable<String> names) {
    for (String name in names) {
      final String nameLowercase = name.toLowerCase();
      for (final filename in _files.keys) {
        if (filename.toLowerCase() == nameLowercase) {
          return filename;
        }
      }
    }
    return null;
  }

  /// Reads a text content of [name] from the tar.gz file identified by [_path].
  ///
  /// When [maxLength] is specified, the text content is cut at [maxLength]
  /// characters (with `[...]\n\n` added to it).
  Future<String> readTarballFile(String name, {int maxLength = 0}) async {
    final mappedName = _files[name] ?? name;
    final result = await Process.run(
      'tar',
      ['-O', '-xzf', _path, mappedName],
      stdoutEncoding: Utf8Codec(allowMalformed: true),
    );
    if (result.exitCode != 0) {
      throw Exception('Failed to read tarball contents.');
    }
    String content = result.stdout as String;
    if (maxLength > 0 && content.length > maxLength) {
      content = content.substring(0, maxLength) + '[...]\n\n';
    }
    return content;
  }
}
