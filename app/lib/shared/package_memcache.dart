// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.package_memcache;

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:memcache/memcache.dart';
import 'package:pub_server/shelf_pubserver.dart';

import 'memcache.dart';
import 'platform.dart' show KnownPlatforms;

final Logger _logger = new Logger('pub.package_memcache');

const _pubHost = 'pub.dartlang.org';

abstract class UIPackageCache {
  // If [version] is `null` then it corresponds to the cache entry which can be
  // invalidated via [invalidateUiPackagePage].
  Future<String> getUIPackagePage(String host, String package, String version);

  // If [version] is `null` then it corresponds to the cache entry which can be
  // invalidated via [invalidateUiPackagePage].
  Future setUIPackagePage(
      String host, String package, String version, String data);

  Future<String> getUIIndexPage(String host, String platform);

  Future setUIIndexPage(String host, String platform, String content);

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
  Future<String> getUIPackagePage(
          String host, String package, String version) =>
      _uiPage.getText(_pvKey(host, package, version));

  @override
  Future setUIPackagePage(
          String host, String package, String version, String data) =>
      _uiPage.setText(_pvKey(host, package, version), data);

  @override
  Future invalidateUIPackagePage(String package) =>
      Future.wait(_invalidatePackage(package));

  @override
  Future invalidatePackageData(String package) =>
      Future.wait(_invalidatePackage(package, invalidateData: true));

  Iterable<Future> _invalidatePackage(String package,
      {bool invalidateData: false}) sync* {
    if (invalidateData) {
      yield _json.invalidate(package);
    }
    yield _uiPage.invalidate(_pvKey(null, package, null));
    yield _uiIndexPage.invalidate(_indexPageKey(null, null));
    for (String platform in KnownPlatforms.all) {
      yield _uiIndexPage.invalidate(_indexPageKey(null, platform));
    }
  }

  @override
  Future<String> getUIIndexPage(String host, String platform) =>
      _uiIndexPage.getText(_indexPageKey(host, platform));

  @override
  Future setUIIndexPage(String host, String platform, String content) =>
      _uiIndexPage.setText(_indexPageKey(host, platform), content);

  String _indexPageKey(String host, String platform) {
    return '$indexUiPageKey/${host ?? _pubHost}/$platform';
  }

  String _pvKey(String host, String package, String version) {
    return '${host ?? _pubHost}/$package/$version';
  }
}
