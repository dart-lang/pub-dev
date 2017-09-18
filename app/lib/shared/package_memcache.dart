// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.package_memcache;

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:memcache/memcache.dart';
import 'package:pub_server/shelf_pubserver.dart';

import 'memcache.dart';

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
  final SimpleMemcache _json;
  final SimpleMemcache _uiPage;
  final SimpleMemcache _uiIndexPage;

  AppEnginePackageMemcache(Memcache memcache)
      : _json = new SimpleMemcache(
            _logger, memcache, packageJsonPrefix, packageJsonExpiration),
        _uiPage = new SimpleMemcache(
            _logger, memcache, packageUiPagePrefix, packageUiPageExpiration),
        _uiIndexPage =
            new SimpleMemcache(_logger, memcache, '', indexUiPageExpiration);

  @override
  Future<List<int>> getPackageData(String package) => _json.getBytes(package);

  @override
  Future setPackageData(String package, List<int> data) =>
      _json.setBytes(package, data);

  @override
  Future<String> getUIPackagePage(String package, String version) =>
      _uiPage.getText(_pvKey(package, version));

  @override
  Future setUIPackagePage(String package, String version, String data) =>
      _uiPage.setText(_pvKey(package, version), data);

  @override
  Future invalidateUIPackagePage(String package) {
    return Future.wait([
      _uiPage.invalidate(_pvKey(package, null)),
      _uiIndexPage.invalidate(indexUiPageKey),
    ]);
  }

  @override
  Future invalidatePackageData(String package) {
    return Future.wait([
      _json.invalidate(package),
      _uiIndexPage.invalidate(indexUiPageKey),
      _uiPage.invalidate(_pvKey(package, null)),
    ]);
  }

  @override
  Future<String> getUIIndexPage() => _uiIndexPage.getText(indexUiPageKey);

  @override
  Future setUIIndexPage(String content) =>
      _uiIndexPage.setText(indexUiPageKey, content);

  String _pvKey(String package, String version) => '/$package/$version';
}
