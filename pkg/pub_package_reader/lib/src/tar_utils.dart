// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:tar/tar.dart';

final _logger = Logger('package_archive.tar_utils');

/// Shared methods between [_ProcessTarArchive] and [_PkgTarArchive].
abstract class TarArchive {
  /// The list of normalized file names.
  final List<String> fileNames;

  /// Maps the normalized names to their original value;
  final Map<String, String> _normalizedNames;

  TarArchive._(this._normalizedNames)
      : fileNames = _normalizedNames.keys.toList()..sort();

  TarArchive(List<String> names) : this._(_normalizeNames(names));

  static Map<String, String> _normalizeNames(List<String> names) {
    final files = <String, String>{};
    for (final name in names) {
      final normalized = p.normalize(name).trim();
      files[normalized] = name;
    }
    return files;
  }

  /// Reads file content as String.
  Future<String> readContentAsString(String name, {int maxLength = 0});

  // Searches in scanned files for a file name [name] and compare in a
  // case-insensitive manner.
  //
  // Returns `null` if not found otherwise the correct filename.
  String searchForFile(Iterable<String> names) {
    for (String name in names) {
      final String nameLowercase = name.toLowerCase();
      for (final filename in fileNames) {
        if (filename.toLowerCase() == nameLowercase) {
          return filename;
        }
      }
    }
    return null;
  }

  /// Creates a new instance by scanning the archive at [path].
  static Future<TarArchive> scan(String path, {bool useNative = false}) async {
    return useNative
        ? await _PkgTarArchive._scan(path)
        : await _ProcessTarArchive._scan(path);
  }
}

/// Accessing the tar archive, masking internals like filename normalization.
class _ProcessTarArchive extends TarArchive {
  final String _path;

  _ProcessTarArchive._(this._path, List<String> names) : super(names);

  /// Creates a new instance by scanning the archive at [path].
  static Future<_ProcessTarArchive> _scan(String path) async {
    final args = ['-tzf', path];
    final result = await Process.run('tar', args);
    if (result.exitCode != 0) {
      _logger.warning('The "tar $args" command failed:\n'
          'with exit code: ${result.exitCode}\n'
          'stdout: ${result.stdout}\n'
          'stderr: ${result.stderr}');
      throw Exception('Failed to list tarball contents.');
    }

    final names = (result.stdout as String).split('\n').toList();
    return _ProcessTarArchive._(path, names);
  }

  /// Reads a text content of [name] from the tar.gz file identified by [_path].
  ///
  /// When [maxLength] is specified, the text content is cut at [maxLength]
  /// characters (with `[...]\n\n` added to it).
  @override
  Future<String> readContentAsString(String name, {int maxLength = 0}) async {
    final mappedName = _normalizedNames[name] ?? name;
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

class _PkgTarArchive extends TarArchive {
  final String _path;
  _PkgTarArchive._(this._path, List<String> names) : super(names);

  /// Creates a new instance by scanning the archive at [path].
  static Future<_PkgTarArchive> _scan(String path) async {
    final names = <String>[];
    final reader = TarReader(File(path).openRead().transform(gzip.decoder));
    while (await reader.moveNext()) {
      final entry = reader.current;
      names.add(entry.name);
    }
    await reader.cancel();
    return _PkgTarArchive._(path, names);
  }

  @override
  Future<String> readContentAsString(String name, {int maxLength = 0}) async {
    final mappedName = _normalizedNames[name] ?? name;
    final reader = TarReader(File(_path).openRead().transform(gzip.decoder));
    try {
      while (await reader.moveNext()) {
        if (reader.current.name != mappedName) continue;
        final builder = BytesBuilder();
        await for (final chunk in reader.current.contents) {
          builder.add(chunk);
          if (builder.length >= maxLength) break;
        }
        String content = utf8.decode(builder.toBytes(), allowMalformed: true);
        if (maxLength > 0 && content.length > maxLength) {
          content = content.substring(0, maxLength) + '[...]\n\n';
        }
        return content;
      }
    } finally {
      await reader.cancel();
    }
    throw AssertionError('Unable to read $name from $_path.');
  }
}
