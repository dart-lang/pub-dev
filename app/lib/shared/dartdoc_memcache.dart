// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:memcache/memcache.dart';

import 'dartdoc_client.dart' show DartdocEntry;
import 'memcache.dart';
import 'versions.dart' as versions;

final Logger _logger = new Logger('pub.dartdoc_memcache');

/// Sets the dartdoc memcache.
void registerDartdocMemcache(DartdocMemcache value) =>
    ss.register(#_dartdocMemcache, value);

/// The active dartdoc memcache.
DartdocMemcache get dartdocMemcache =>
    ss.lookup(#_dartdocMemcache) as DartdocMemcache;

class DartdocMemcache {
  final SimpleMemcache _entry;
  final SimpleMemcache _fileInfo;

  DartdocMemcache(Memcache memcache)
      : _entry = new SimpleMemcache(
          _logger,
          memcache,
          dartdocEntryPrefix,
          dartdocEntryExpiration,
        ),
        _fileInfo = new SimpleMemcache(
          _logger,
          memcache,
          dartdocFileInfoPrefix,
          dartdocFileInfoExpiration,
        );

  Future<DartdocEntry> getEntry(String package, String version) async {
    final bytes = await _entry.getBytes(_entryKey(package, version));
    if (bytes == null) return null;
    return new DartdocEntry.fromBytes(bytes);
  }

  Future setEntry(DartdocEntry entry) async {
    if (entry == null) return;
    if (entry.runtimeVersion != versions.runtimeVersion) return;
    final key = _entryKey(entry.packageName, entry.packageVersion);
    final bytes = entry.asBytes();
    await _entry.setBytes(key, bytes);
  }

  Future<List<int>> getFileInfoBytes(String objectName) {
    return _fileInfo.getBytes(_fileInfoKey(objectName));
  }

  Future setFileInfoBytes(String objectName, List<int> bytes) {
    return _fileInfo.setBytes(_fileInfoKey(objectName), bytes);
  }

  Future invalidate(String package, String version) {
    return Future.wait([
      _entry.invalidate(_entryKey(package, version)),
      _entry.invalidate(_entryKey(package, 'latest')),
    ]);
  }

  String _entryKey(String package, String version) =>
      '/$package/$version/${versions.runtimeVersion}';

  String _fileInfoKey(String objectName) => objectName;
}
