// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert' show json, utf8, Utf8Codec;
import 'dart:io';
import 'dart:isolate';

import 'package:_pub_shared/dartdoc/dartdoc_page.dart';
import 'package:logging/logging.dart' show Logger;
import 'package:path/path.dart' as p;
import 'package:stream_transform/stream_transform.dart';

final _log = Logger('dartdoc');
final _utf8 = Utf8Codec(allowMalformed: true);
final _jsonUtf8 = json.fuse(utf8);

Future<void> postProcessDartdoc({
  required String outputFolder,
  required String package,
  required String version,
  required String docDir,
}) async {
  _log.info('Running dartdoc post-processing');
  final tmpOutDir = Directory(p.join(outputFolder, '_doc'));
  await tmpOutDir.create(recursive: true);
  final processingFuture =
      Isolate.run(() async {
        final files = Directory(
          docDir,
        ).list(recursive: true, followLinks: false).whereType<File>();
        await for (final file in files) {
          final suffix = file.path.substring(docDir.length + 1);
          final targetFile = File(p.join(tmpOutDir.path, suffix));
          await targetFile.parent.create(recursive: true);
          final isDartDocSidebar =
              file.path.endsWith('.html') &&
              file.path.endsWith('-sidebar.html');
          final isDartDocPage =
              file.path.endsWith('.html') && !isDartDocSidebar;
          if (isDartDocPage) {
            final page = DartDocPage.parse(
              await file.readAsString(encoding: _utf8),
            );
            await targetFile.writeAsBytes(_jsonUtf8.encode(page.toJson()));
          } else if (isDartDocSidebar) {
            final sidebar = DartDocSidebar.parse(
              await file.readAsString(encoding: _utf8),
            );
            await targetFile.writeAsBytes(_jsonUtf8.encode(sidebar.toJson()));
          } else {
            await file.copy(targetFile.path);
          }
        }
      }).whenComplete(() {
        _log.info('Finished post-processing');
      });

  try {
    await processingFuture;

    // Move from temporary output directory to final one, ensuring that
    // documentation files won't be present unless all files have been processed.
    // This helps if there is a timeout along the way.
    await tmpOutDir.rename(p.join(outputFolder, 'doc'));
  } catch (e, st) {
    // We don't know what's wrong with the post-processing, and we treat
    // the output as incorrect. Deleting, so it won't be included in the blob.
    await tmpOutDir.deleteIgnoringErrors(recursive: true);

    _log.shout('Failed to run dartdoc post-processing.', e, st);
    rethrow;
  }
}

extension on FileSystemEntity {
  Future<void> deleteIgnoringErrors({bool recursive = false}) async {
    try {
      await delete(recursive: recursive);
    } catch (_) {
      // ignored
    }
  }
}
