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
  final File _file;

  LocalServerState({String path}) : _file = path == null ? null : File(path);

  bool get hasValidFile => _file != null;

  Future<void> load() async {
    if (_file != null && await _file.exists()) {
      final lines =
          _file.openRead().transform(utf8.decoder).transform(LineSplitter());
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

  Future<void> save() async {
    if (_file == null) return;
    print('Storing state in ${_file.path}...');
    await _file.parent.create(recursive: true);
    final sink = _file.openWrite();

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
