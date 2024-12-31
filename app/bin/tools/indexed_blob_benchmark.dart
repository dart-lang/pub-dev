// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:indexed_blob/indexed_blob.dart';
import 'package:path/path.dart' as p;
import 'package:pub_dev/shared/utils.dart';

// 27.826 index bytes/entry.
// 0.0647 ms/(load+lookup)
// 0.060964 ms/lookup
Future<void> main() async {
  final index = await withTempDirectory((dir) async {
    final blobFile = File(p.join(dir.path, 'blob.data'));
    final builder = IndexedBlobBuilder(blobFile.openWrite());
    for (var i = 0; i < 1000; i++) {
      await builder.addFile('doc/$i.html', Stream.value(List.filled(2000, 0)));
    }
    final index = await builder.buildIndex('123');

    final blobIndex = File(p.join(dir.path, 'blob.index'));
    await blobIndex.writeAsBytes(index.asBytes());

    print('${blobIndex.lengthSync() / 1000} index bytes/entry.');

    final bytes = await blobIndex.readAsBytes();
    final loadSw = Stopwatch()..start();
    for (var r = 0; r < 10000; r++) {
      final x = BlobIndex.fromBytes(bytes);
      final r = x.lookup('doc/555.html');
      r!.start;
      x.lookup('doc/555.txt');
    }
    loadSw.stop();
    print('${loadSw.elapsedMilliseconds / 10000} ms/(load+lookup)');

    return index;
  });

  final lookupSw = Stopwatch()..start();
  for (var r = 0; r < 1000; r++) {
    for (var i = 0; i < 1000; i++) {
      index.lookup('doc/$i.html');
      index.lookup('doc/$i.txt');
    }
  }
  lookupSw.stop();
  print('${lookupSw.elapsed.inMilliseconds / 1000 / 1000} ms/lookup');
}
