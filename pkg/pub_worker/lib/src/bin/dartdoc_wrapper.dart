// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert' show json, utf8, Utf8Codec;
import 'dart:io';

import 'package:_pub_shared/dartdoc/dartdoc_page.dart';
import 'package:logging/logging.dart' show Logger;
import 'package:path/path.dart' as p;
import 'package:stream_transform/stream_transform.dart';
import 'package:tar/tar.dart';

final _log = Logger('dartdoc');
final _utf8 = Utf8Codec(allowMalformed: true);
final _jsonUtf8 = json.fuse(utf8);

Future<void> postPorcessDartdoc({
  required String outputFolder,
  required String package,
  required String version,
  required String docDir,
  required String dartdocVersion,
}) async {
  _log.info('Running post-processing');
  final tmpOutDir = p.join(outputFolder, '_doc');
  await Directory(tmpOutDir).create(recursive: true);
  final files = Directory(docDir)
      .list(recursive: true, followLinks: false)
      .whereType<File>();
  await for (final file in files) {
    final suffix = file.path.substring(docDir.length + 1);
    final targetFile = File(p.join(tmpOutDir, suffix));
    await targetFile.parent.create(recursive: true);
    final isDartDocSidebar =
        file.path.endsWith('.html') && file.path.endsWith('-sidebar.html');
    final isDartDocPage = file.path.endsWith('.html') && !isDartDocSidebar;
    if (isDartDocPage) {
      final page = DartDocPage.parse(await file.readAsString(encoding: _utf8));
      await targetFile.writeAsBytes(_jsonUtf8.encode(page.toJson()));
    } else if (isDartDocSidebar) {
      final sidebar = DartDocSidebar.parse(
        await file.readAsString(encoding: _utf8),
        removeLeadingHrefParent: dartdocVersion == '8.0.4' &&
            file.path.endsWith('-extension-type-sidebar.html'),
      );
      await targetFile.writeAsBytes(_jsonUtf8.encode(sidebar.toJson()));
    } else {
      await file.copy(targetFile.path);
    }
  }
  // Move from temporary output directory to final one, ensuring that
  // documentation files won't be present unless all files have been processed.
  // This helps if there is a timeout along the way.
  await Directory(tmpOutDir).rename(p.join(outputFolder, 'doc'));
  _log.info('Finished post-processing');

  _log.info('Creating .tar.gz archive');
  Stream<TarEntry> _list() async* {
    final originalDocDir = Directory(docDir);
    final originalFiles = originalDocDir
        .list(recursive: true, followLinks: false)
        .whereType<File>();
    await for (final file in originalFiles) {
      // inside the archive prefix the name with <package>/version/
      final relativePath = p.relative(file.path, from: originalDocDir.path);
      final tarEntryPath = p.join(package, version, relativePath);
      final data = await file.readAsBytes();
      yield TarEntry.data(
        TarHeader(
          name: tarEntryPath,
          size: data.length,
        ),
        data,
      );
    }
  }

  final tmpTar = File(p.join(outputFolder, '_package.tar.gz'));
  await _list()
      .transform(tarWriter)
      .transform(gzip.encoder)
      .pipe(tmpTar.openWrite());
  await tmpTar.rename(p.join(outputFolder, 'doc', 'package.tar.gz'));

  _log.info('Finished .tar.gz archive');
}
