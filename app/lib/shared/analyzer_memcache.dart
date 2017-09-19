// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:memcache/memcache.dart';

import 'memcache.dart';

final Logger _logger = new Logger('pub.analyzer_memcache');

/// Sets the analyzer memcache.
void registerAnalyzerMemcache(AnalyzerMemcache value) =>
    ss.register(#_analyzerMemcache, value);

/// The active analyzer memcache.
AnalyzerMemcache get analyzerMemcache => ss.lookup(#_analyzerMemcache);

class AnalyzerMemcache {
  final SimpleMemcache _data;

  AnalyzerMemcache(Memcache memcache)
      : _data = new SimpleMemcache(
          _logger,
          memcache,
          analyzerDataPrefix,
          analyzerDataExpiration,
        );

  Future<String> getContent(
      String package, String version, String panaVersion) {
    return _data.getText(_dataKey(package, version, panaVersion));
  }

  Future setContent(
      String package, String version, String panaVersion, String content) {
    return _data.setText(_dataKey(package, version, panaVersion), content);
  }

  Future invalidateContent(String package, String version, String panaVersion) {
    return _data.invalidate(_dataKey(package, version, panaVersion));
  }

  String _dataKey(String package, String version, String panaVersion) =>
      '/$package/$version/$panaVersion';
}
