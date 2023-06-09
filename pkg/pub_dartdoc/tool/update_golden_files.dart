// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:tar/tar.dart';

Future<void> main() async {
  final tempDir = await Directory.systemTemp.createTemp();
  try {
    final panaVersion = '0.21.32';

    // download
    final rs = await http.get(Uri.parse(
        'https://pub.dev/packages/pana/versions/$panaVersion.tar.gz'));
    if (rs.statusCode != 200) {
      throw AssertionError('Failed to fetch archive.');
    }
    await _extractTarGz(Stream.fromIterable([rs.bodyBytes]), tempDir.path);

    // need to run pub get first
    final pr1 = await Process.run(
      'dart',
      ['pub', 'get'],
      workingDirectory: tempDir.path,
    );
    if (pr1.exitCode != 0) {
      throw AssertionError('Non-zero exit code: ${pr1.stdout}\n${pr1.stderr}');
    }

    // generate
    final pr2 = await Process.run(
      'dart',
      [
        'bin/pub_dartdoc.dart',
        '--rel-canonical-prefix',
        'https://pub.dev/documentation/pana/$panaVersion',
        '--input',
        tempDir.path,
        '--output',
        p.join(tempDir.path, 'doc', 'api'),
      ],
    );
    if (pr2.exitCode != 0) {
      throw AssertionError('Non-zero exit code: ${pr2.stdout}\n${pr2.stderr}');
    }

    // copy
    Future<void> copy(String docPath, String goldenPath) async {
      final docFile = File(p.join(tempDir.path, 'doc', 'api', docPath));
      final goldenFile = File(
          p.join('..', '..', 'app', 'test', 'dartdoc', 'golden', goldenPath));
      await goldenFile.parent.create(recursive: true);
      await docFile.copy(goldenFile.path);
    }

    await copy('index.html', 'pana_${panaVersion}_index.html');
    await copy('models/LicenseFile-class.html',
        'pana_${panaVersion}_license_file_class.html');
    await copy('models/LicenseFile/LicenseFile.html',
        'pana_${panaVersion}_license_file_constructor.html');
    await copy('models/LicenseFile/name.html',
        'pana_${panaVersion}_license_file_name_field.html');
    await copy('pana/runProc.html', 'pana_${panaVersion}_run_proc.html');
  } finally {
    await tempDir.delete(recursive: true);
  }
}

/// Extracts a `.tar.gz` file from [tarball] to [destination].
Future _extractTarGz(Stream<List<int>> tarball, String destination) async {
  final reader = TarReader(tarball.transform(gzip.decoder));
  while (await reader.moveNext()) {
    final entry = reader.current;
    final path = p.join(destination, entry.name);
    if (!p.isWithin(destination, path)) {
      throw ArgumentError('"${entry.name}" is outside of the archive.');
    }
    final dir = File(path).parent;
    await dir.create(recursive: true);
    if (entry.header.linkName != null) {
      final target = p.normalize(p.join(dir.path, entry.header.linkName));
      if (p.isWithin(destination, target)) {
        final link = Link(path);
        if (!link.existsSync()) {
          await link.create(target);
        }
      } else {
        // Note to self: do not create links going outside the package, this is not safe!
      }
    } else {
      await entry.contents.pipe(File(path).openWrite());
    }
  }
}
