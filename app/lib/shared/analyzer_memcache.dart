// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:memcache/memcache.dart';

final Logger _logger = new Logger('pub.analyzer_memcache');

/// Sets the analyzer memcache.
void registerAnalyzerMemcache(AnalyzerMemcache value) =>
    ss.register(#_analyzerMemcache, value);

/// The active analyzer memcache.
AnalyzerMemcache get analyzerMemcache => ss.lookup(#_analyzerMemcache);

class AnalyzerMemcache {
  final Memcache _memcache;
  final String _prefix = 'dart_analyzer_api_';
  final Duration _expiration = new Duration(minutes: 60);

  AnalyzerMemcache(this._memcache);

  Future<String> getContent(
      String package, String version, String panaVersion) async {
    try {
      return await _memcache.get(_key(package, version, panaVersion));
    } catch (e, st) {
      _logger.severe('ERROR', e, st);
      // ignore errors
    }
    _logger.fine('Couldn\'t find memcache entry for $package $version');
    return null;
  }

  Future setContent(String package, String version, String panaVersion,
      String content) async {
    try {
      await _memcache.set(_key(package, version, panaVersion), content,
          expiration: _expiration);
    } catch (e, st) {
      _logger.warning(
          'Couldn\'t set memcache entry for $package $version', e, st);
    }
  }

  Future invalidateContent(
      String package, String version, String panaVersion) async {
    try {
      await _memcache.remove(_key(package, version, panaVersion));
    } catch (e, st) {
      _logger.warning(
          'Couldn\'t remove memcache entry for $package $version', e, st);
    }
  }

  String _key(String package, String version, String panaVersion) =>
      '$_prefix/$package/$version/$panaVersion';
}
