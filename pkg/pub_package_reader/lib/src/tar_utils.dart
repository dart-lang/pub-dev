// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';

final _logger = Logger('package_archive.tar_utils');

Future<List<String>> listTarball(String path) async {
  final args = ['-tzf', path];
  final result = await Process.run('tar', args);
  if (result.exitCode != 0) {
    _logger.warning('The "tar $args" command failed:\n'
        'with exit code: ${result.exitCode}\n'
        'stdout: ${result.stdout}\n'
        'stderr: ${result.stderr}');
    throw Exception('Failed to list tarball contents.');
  }

  return (result.stdout as String)
      .split('\n')
      .where((part) => part != '')
      .toList();
}

/// Reads a text content of [name] from the tar.gz file identified by [path].
///
/// When [maxLength] is specified, the text content is cut at [maxLength]
/// characters (with `[...]\n\n` added to it).
Future<String> readTarballFile(String path, String name,
    {int maxLength = 0}) async {
  final result = await Process.run(
    'tar',
    ['-O', '-xzf', path, name],
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
