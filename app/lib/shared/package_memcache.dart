// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.package_memcache;

import 'dart:async';
import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:memcache/memcache.dart';
import 'package:pub_server/shelf_pubserver.dart';

final Logger _logger = new Logger('pub.package_memcache');

abstract class UIPackageCache {
  // If [version] is `null` then it corresponds to the cache entry which can be
  // invalidated via [invalidateUiPackagePage].
  Future<String> getUIPackagePage(String package, String version);

  // If [version] is `null` then it corresponds to the cache entry which can be
  // invalidated via [invalidateUiPackagePage].
  Future setUIPackagePage(String package, String version, String data);

  Future<String> getUIIndexPage();

  Future setUIIndexPage(String content);

  Future invalidateUIPackagePage(String package);
}

/// Uses a [Memache] to set/get/invalidate metadata for packages.
class AppEnginePackageMemcache implements PackageCache, UIPackageCache {
  static const Duration _cacheExpiration = const Duration(minutes: 10);

  final Memcache _memcache;
  final String _indexKey;
  final String _keyPrefix;
  final String _uiKeyPrefix;

  static String _prefixWithNamespace(String prefix, String namespace) =>
      (namespace == null || namespace.isEmpty)
          ? prefix
          : 'ns_${namespace}_$prefix';

  AppEnginePackageMemcache(this._memcache, String namespace)
      : _keyPrefix = _prefixWithNamespace('package_json_', namespace),
        _uiKeyPrefix = _prefixWithNamespace('package_ui_', namespace),
        _indexKey = _prefixWithNamespace('pub_index', namespace);

  @override
  Future<List<int>> getPackageData(String package) async {
    final result = await _ignoreErrors(
        _memcache.get(_packageKey(package), asBinary: true));

    if (result != null)
      _logger.info('memcache["$package"] found');
    else
      _logger.info('memcache["$package"] not found');

    return result;
  }

  @override
  Future setPackageData(String package, List<int> data) {
    _logger.info('memcache["$package"] setting to new data');
    return _ignoreErrors(_memcache.set(_packageKey(package), data,
        expiration: _cacheExpiration));
  }

  @override
  Future<String> getUIPackagePage(String package, String version) async {
    final result = await _ignoreErrors(
        _memcache.get(_packageUIKey(package, version), asBinary: true));

    if (result != null) {
      _logger.info('memcache["$package"] rendered UI found');
      return UTF8.decode(result);
    }

    _logger.info('memcache["$package"] rendered UI not found');
    return null;
  }

  @override
  Future setUIPackagePage(String package, String version, String data) async {
    _logger.info('memcache["$package"] setting to new rendered UI data');
    return _ignoreErrors(_memcache.set(
        _packageUIKey(package, version), UTF8.encode(data),
        expiration: _cacheExpiration));
  }

  @override
  Future invalidateUIPackagePage(String package) async {
    _logger.info('memcache["$package"] invalidating UI data');
    return _ignoreErrors(Future.wait([
      _memcache.remove(_packageUIKey(package, null)),
      _memcache.remove(_indexKey),
    ]));
  }

  @override
  Future invalidatePackageData(String package) {
    _logger.info('memcache["$package"] invalidate entry');
    return _ignoreErrors(Future.wait([
      _memcache.remove(_packageKey(package)),
      _memcache.remove(_packageUIKey(package, null)),
      _memcache.remove(_indexKey),
    ]));
  }

  @override
  Future<String> getUIIndexPage() async {
    final result = await _ignoreErrors(_memcache.get(_indexKey));
    if (result != null) {
      _logger.info('memcache[index-page] found rendered UI data');
    } else {
      _logger.info('memcache[index-page] no rendered UI data found');
    }
    return result;
  }

  @override
  Future setUIIndexPage(String content) async {
    _logger.info('memcache[index-page] setting to new rendered UI data');
    await _ignoreErrors(
        _memcache.set(_indexKey, content, expiration: _cacheExpiration));
  }

  String _packageKey(String package) => '$_keyPrefix$package';

  String _packageUIKey(String package, String version) {
    if (version == null) return '$_uiKeyPrefix$package';
    return '$_uiKeyPrefix$package**$version';
  }

  // We are ignoring any memcache errors and just return `null` in this case.
  //
  // NOTE: The worst what can happen is that up to `EXPIRATION` time passes
  // before a value gets automatically evicted from memcache
  //    => The duration for inconsistency is limited to 60 minutes ATM.
  Future _ignoreErrors(Future f) {
    return f.catchError((error, stackTrace) {
      _logger.warning('Ignoring failed memcache API call (error: $error)',
          error, stackTrace);
    });
  }
}
