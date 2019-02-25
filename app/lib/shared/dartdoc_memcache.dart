// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';

import 'dartdoc_client.dart' show DartdocEntry;
import 'redis_cache.dart';
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
  final SimpleMemcache _apiSummary;

  DartdocMemcache()
      : _entry = new SimpleMemcache(
          'DartdocMemcache/entry/',
          _logger,
          Duration(hours: 24),
        ),
        _fileInfo = new SimpleMemcache(
          'DartdocMemcache/fileInfo/',
          _logger,
          Duration(minutes: 60),
        ),
        _apiSummary = new SimpleMemcache(
          'DartdocMemcache/apiSummary/',
          _logger,
          Duration(minutes: 60),
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

  Future<Map<String, dynamic>> getApiSummary(String package) async {
    final text = await _apiSummary.getText(package);
    if (text == null) return null;
    return json.decode(text) as Map<String, dynamic>;
  }

  Future setApiSummary(String package, Map<String, dynamic> data) async {
    if (data == null || data.isEmpty) return;
    final text = json.encode(data);
    await _apiSummary.setText(package, text);
  }

  Future invalidate(String package, String version) {
    return Future.wait([
      _entry.invalidate(_entryKey(package, version)),
      _entry.invalidate(_entryKey(package, 'latest')),
      _apiSummary.invalidate(package),
    ]);
  }

  String _entryKey(String package, String version) => '/$package/$version';

  String _fileInfoKey(String objectName) => objectName;
}
