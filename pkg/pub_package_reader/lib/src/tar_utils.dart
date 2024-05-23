// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:tar/tar.dart';

/// Abstract interface that once separated process-based tar and package:tar.
class TarArchive {
  final String _path;

  /// Maps the normalized names to their original value;
  final Map<String, String> _normalizedNames;

  /// The map of files that are symlinks, using normalized names
  /// in both parts of the map entries.
  final Map<String, String> _symlinks;

  TarArchive._(
    this._path,
    this._normalizedNames,
    this._symlinks,
  );

  TarArchive._normalize(
      String path, List<String> names, Map<String, String> symlinks)
      : this._(
          path,
          _normalizeNames(names),
          symlinks.map((key, value) =>
              MapEntry<String, String>(_normalize(key), _normalize(value))),
        );

  /// The list of normalized file names.
  late final fileNames = (_normalizedNames.keys.toList()..sort()).toSet();

  /// Scans the tar archive and reads the content of the files identified by [names].
  ///
  /// For each file, if [maxLength] is reached, the content is returned up-to the
  /// current byte buffer.
  Future<Map<String, Uint8List>> scanAndReadFiles(
    List<String> names, {
    required int maxLength,
  }) async {
    if (names.isEmpty) return <String, Uint8List>{};
    final mappedNames =
        names.map((name) => _normalizedNames[name] ?? name).toList();
    final reader = TarReader(
      File(_path).openRead().transform(gzip.decoder),
      disallowTrailingData: true,
    );
    final results = <String, Uint8List>{};
    try {
      while (await reader.moveNext() && results.length < names.length) {
        final currentName = reader.current.name;
        final indexOfMapped = mappedNames.indexOf(currentName);
        if (indexOfMapped < 0) continue;
        final builder = BytesBuilder();
        await for (final chunk in reader.current.contents) {
          // We need to read all content chuncks before proceeding with
          // the next file, however, if the buffer is over the maximum
          // length, we can drop the chunks.
          if (maxLength == 0 || builder.length <= maxLength) {
            builder.add(chunk);
          }
        }
        results[names[indexOfMapped]] = builder.toBytes();
      }
    } finally {
      await reader.cancel();
    }
    if (results.length != mappedNames.length) {
      final missing = {...mappedNames}..removeAll(results.keys);
      throw AssertionError('Unable to read ${missing.join(' ')} from $_path.');
    }
    return results;
  }

  /// Reads file content as String.
  Future<String> readContentAsString(String name, {int maxLength = 0}) async {
    final contents = await scanAndReadFiles([name], maxLength: maxLength);
    String content = utf8.decode(contents.values.single, allowMalformed: true);
    if (maxLength > 0 && content.length > maxLength) {
      content = content.substring(0, maxLength) + '[...]\n\n';
    }
    return content;
  }

  /// Returns the first matching file name from [names], preserving the case.
  ///
  /// Returns `null` if there was no matching file.
  String? firstMatchingFileNameOrNull(Iterable<String> names) {
    for (final name in names) {
      if (fileNames.contains(name)) {
        return name;
      }
    }
    return null;
  }

  /// Returns the broken links (that point outside, or to a non-existent file).
  Map<String, String> brokenSymlinks() {
    final broken = <String, String>{};
    for (final from in _symlinks.keys) {
      final to = _symlinks[from]!;
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
  static Future<TarArchive> scan(
    String path, {
    int? maxFileCount,
    int? maxTotalLengthBytes,
  }) async {
    final names = <String>{};
    final symlinks = <String, String>{};
    final reader = TarReader(
      File(path).openRead().transform(gzip.decoder),
      disallowTrailingData: true,
    );
    int fileCount = 0;
    int totalLengthBytes = 0;
    while (await reader.moveNext()) {
      final entry = reader.current;

      fileCount++;
      if (maxFileCount != null && fileCount > maxFileCount) {
        throw Exception('Maximum file count reached: $maxFileCount.');
      }

      totalLengthBytes += entry.size;
      if (maxTotalLengthBytes != null &&
          totalLengthBytes > maxTotalLengthBytes) {
        throw Exception('Maximum total length reached: $maxTotalLengthBytes.');
      }

      if (!names.add(entry.name)) {
        throw Exception('Duplicate tar entry: `${entry.name}`.');
      }
      if (entry.header.linkName != null) {
        symlinks[entry.name] = entry.header.linkName!;
      }
    }
    await reader.cancel();
    return TarArchive._normalize(path, names.toList(), symlinks);
  }
}

Map<String, String> _normalizeNames(List<String> names) {
  final files = <String, String>{};
  for (final name in names) {
    files[_normalize(name)] = name;
  }
  return files;
}

String _normalize(String path) => p.normalize(path).trim();
