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
  Future<String> getUIPackagePage(String package);

  Future setUIPackagePage(String package, String data);

  Future invalidateUIPackagePage(String package);
}

/// Uses a [Memache] to set/get/invalidate metadata for packages.
class AppEnginePackageMemcache implements PackageCache, UIPackageCache {
  static const Duration EXPIRATION = const Duration(minutes: 60);
  static const String KEY_PREFIX = 'dart_package_json';
  static const String UI_KEY_PREFIX = 'dart_package_ui';

  final Memcache memcache;
  final String keyPrefix;
  final String uiKeyPrefix;

  AppEnginePackageMemcache(this.memcache, String namespace)
      : keyPrefix = (namespace == null || namespace.isEmpty)
          ? KEY_PREFIX : 'ns_${namespace}_$KEY_PREFIX',
        uiKeyPrefix = (namespace == null || namespace.isEmpty)
          ? UI_KEY_PREFIX : 'ns_${namespace}_$UI_KEY_PREFIX';

  Future<List<int>> getPackageData(String package) async {
    var result =
        await _ignoreErrors(memcache.get(_packageKey(package), asBinary: true));

    if (result != null) _logger.info('memcache["$package"] found');
    else _logger.info('memcache["$package"] not found');

    return result;
  }

  Future setPackageData(String package, List<int> data) {
    _logger.info('memcache["$package"] setting to new data');
    return _ignoreErrors(
        memcache.set(_packageKey(package), data, expiration: EXPIRATION));
  }

  Future<String> getUIPackagePage(String package) async {
    var result = await _ignoreErrors(
        memcache.get(_packageUIKey(package), asBinary: true));

    if (result != null) {
      _logger.info('memcache["$package"] rendered UI found');
      return UTF8.decode(result);
    }

    _logger.info('memcache["$package"] rendered UI not found');
    return null;
  }

  Future setUIPackagePage(String package, String data) async {
    _logger.info('memcache["$package"] setting to new rendered UI data');
    return _ignoreErrors(
        memcache.set(_packageUIKey(package),
        UTF8.encode(data),
        expiration: EXPIRATION));
  }

  Future invalidateUIPackagePage(String package) async {
    _logger.info('memcache["$package"] invalidating UI data');
    return _ignoreErrors(memcache.remove(_packageUIKey(package)));
  }

  Future invalidatePackageData(String package) {
    _logger.info('memcache["$package"] invalidate entry');
    return _ignoreErrors(Future.wait([
        // TODO: Once the Python version is retired, we can remove this.
        memcache.remove('package_json_$package'),
        memcache.remove(_packageKey(package)),
        memcache.remove(_packageUIKey(package)),
    ]));
  }

  String _packageKey(String package) => '$keyPrefix$package';

  String _packageUIKey(String package) => '$uiKeyPrefix$package';

  // We are ignoring any memcache errors and just return `null` in this case.
  //
  // NOTE: The worst what can happen is that up to `EXPIRATION` time passes
  // before a value gets automatically evicted from memcache
  //    => The duration for inconsistency is limited to 60 minutes ATM.
  Future _ignoreErrors(Future f) {
    return f.catchError((error, stackTrace) {
      _logger.warning(
          'Ignoring failed memcache API call (error: $error)',
          error, stackTrace);
    });
  }
}
