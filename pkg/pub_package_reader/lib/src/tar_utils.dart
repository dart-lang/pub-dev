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

  /// The map of files that are symlinks, using normalized names
  /// in both parts of the map entries.
  final Map<String, String> _symlinks;

  TarArchive._(
    this._normalizedNames,
    this._symlinks,
  ) : fileNames = _normalizedNames.keys.toList()..sort();

  TarArchive(List<String> names, Map<String, String> symlinks)
      : this._(
          _normalizeNames(names),
          symlinks.map((key, value) =>
              MapEntry<String, String>(_normalize(key), _normalize(value))),
        );

  static Map<String, String> _normalizeNames(List<String> names) {
    final files = <String, String>{};
    for (final name in names) {
      files[_normalize(name)] = name;
    }
    return files;
  }

  static String _normalize(String path) => p.normalize(path).trim();

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

  /// Returns the brokens links (that point outside, or to a non-existent file).
  Map<String, String> brokenSymlinks() {
    final broken = <String, String>{};
    for (final from in _symlinks.keys) {
      final to = _symlinks[from];
      final toAsUri = Uri.tryParse(to);
      if (toAsUri == null || toAsUri.isAbsolute) {
        broken[from] = to;
        continue;
      }
      final resolvedPath = p.normalize(Uri(path: from).resolve(to).path);
      if (!fileNames.contains(resolvedPath)) {
        broken[from] = to;
      }
    }
    return broken;
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

  _ProcessTarArchive._(
    this._path,
    List<String> names,
    Map<String, String> symlinks,
  ) : super(names, symlinks);

  /// Creates a new instance by scanning the archive at [path].
  static Future<_ProcessTarArchive> _scan(String path) async {
    // normal file list
    final rs1 = await _runTar(['-tzf', path]);
    final names = <String>{};
    for (final name in (rs1.stdout as String).split('\n')) {
      if (!names.add(name)) {
        throw Exception('Duplicate tar entry: `$name`.');
      }
    }

    // symlink file list
    final symlinks = <String, String>{};
    final rs2 = await _runTar(['-tvzf', path]);
    for (final line in (rs2.stdout as String).split('\n')) {
      if (line.startsWith('l')) {
        final parts = line.split(' -> ');
        if (parts.length != 2) {
          throw Exception('Unable to parse symlinks: $line');
        }
        symlinks[parts.first.trim().split(' ').last] = parts.last.trim();
      }
    }

    return _ProcessTarArchive._(path, names.toList(), symlinks);
  }

  static Future<ProcessResult> _runTar(List<String> args) async {
    final rs = await Process.run('tar', args);
    if (rs.exitCode != 0) {
      _logger.warning('The "tar $args" command failed:\n'
          'with exit code: ${rs.exitCode}\n'
          'stdout: ${rs.stdout}\n'
          'stderr: ${rs.stderr}');
      throw Exception('Failed to list tarball contents.');
    }
    return rs;
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
  _PkgTarArchive._(
    this._path,
    List<String> names,
    Map<String, String> symlinks,
  ) : super(names, symlinks);

  /// Creates a new instance by scanning the archive at [path].
  static Future<_PkgTarArchive> _scan(String path) async {
    final names = <String>{};
    final symlinks = <String, String>{};
    final reader = TarReader(
      File(path).openRead().transform(gzip.decoder),
      disallowTrailingData: true,
    );
    while (await reader.moveNext()) {
      final entry = reader.current;
      if (!names.add(entry.name)) {
        throw Exception('Duplicate tar entry: `${entry.name}`.');
      }
      if (entry.header.linkName != null) {
        symlinks[entry.name] = entry.header.linkName;
      }
    }
    await reader.cancel();
    return _PkgTarArchive._(path, names.toList(), symlinks);
  }

  @override
  Future<String> readContentAsString(String name, {int maxLength = 0}) async {
    final mappedName = _normalizedNames[name] ?? name;
    final reader = TarReader(
      File(_path).openRead().transform(gzip.decoder),
      disallowTrailingData: true,
    );
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
