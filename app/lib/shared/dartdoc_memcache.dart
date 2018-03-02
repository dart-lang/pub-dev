// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:memcache/memcache.dart';

import 'memcache.dart';

final Logger _logger = new Logger('pub.dartdoc_memcache');

/// Sets the dartdoc memcache.
void registerDartdocMemcache(DartdocMemcache value) =>
    ss.register(#_dartdocMemcache, value);

/// The active dartdoc memcache.
DartdocMemcache get dartdocMemcache => ss.lookup(#_dartdocMemcache);

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

  Future<List<int>> getEntryBytes(
      String package, String version, bool serving) {
    return _entry.getBytes(_entryKey(package, version, serving));
  }

  Future setEntryBytes(
      String package, String version, bool serving, List<int> bytes) {
    return _entry.setBytes(_entryKey(package, version, serving), bytes);
  }

  Future<List<int>> getFileInfoBytes(String objectName) {
    return _fileInfo.getBytes(_fileInfoKey(objectName));
  }

  Future setFileInfoBytes(String objectName, List<int> bytes) {
    return _fileInfo.setBytes(_fileInfoKey(objectName), bytes);
  }

  Future invalidate(String package, String version) {
    return Future.wait([
      _entry.invalidate(_entryKey(package, version, true)),
      _entry.invalidate(_entryKey(package, version, false)),
    ]);
  }

  String _entryKey(String package, String version, bool serving) =>
      '/$package/$version/$serving';

  String _fileInfoKey(String objectName) => objectName;
}
