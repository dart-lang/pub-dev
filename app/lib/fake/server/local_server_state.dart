// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:fake_gcloud/mem_datastore.dart';
import 'package:fake_gcloud/mem_storage.dart';

/// Owns server state, optionally loading / saving state to/from the specified file.
class LocalServerState {
  final datastore = MemDatastore();
  final storage = MemStorage();

  /// Loads state from [path].
  ///
  /// Note: this method does not throw Exception if the file on [path] is missing.
  Future<void> loadIfExists(String path) async {
    final file = File(path);
    if (file.existsSync()) {
      final lines = file
          .openRead()
          .transform(utf8.decoder)
          .transform(LineSplitter());
      var marker = 'start';
      await for (final line in lines) {
        if (line.startsWith('{"marker":')) {
          final map = json.decode(line) as Map<String, dynamic>;
          marker = map['marker'] as String;
          continue;
        }
        switch (marker) {
          case 'datastore':
            datastore.readFrom([line]);
            continue;
          case 'storage':
            storage.readFrom([line]);
            continue;
        }
        throw ArgumentError('Marker not state failed: $marker - $line');
      }
    }
  }

  /// Saves state to [path].
  Future<void> save(String path) async {
    print('Storing state in $path...');
    final file = File(path);
    await file.parent.create(recursive: true);
    final sink = file.openWrite();

    void writeMarker(String marker) {
      sink.writeln(json.encode({'marker': marker}));
    }

    writeMarker('datastore');
    datastore.writeTo(sink);

    writeMarker('storage');
    storage.writeTo(sink);

    writeMarker('end');
    await sink.close();
  }
}
