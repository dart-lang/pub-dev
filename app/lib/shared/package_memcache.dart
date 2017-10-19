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

abstract class UIPackageCache {
  // If [version] is `null` then it corresponds to the cache entry which can be
  // invalidated via [invalidateUiPackagePage].
  Future<String> getUIPackagePage(bool isV2, String package, String version);

  // If [version] is `null` then it corresponds to the cache entry which can be
  // invalidated via [invalidateUiPackagePage].
  Future setUIPackagePage(
      bool isV2, String package, String version, String data);

  Future<String> getUIIndexPage(bool isV2, String platform);

  Future setUIIndexPage(bool isV2, String platform, String content);

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
  Future<String> getUIPackagePage(bool isV2, String package, String version) =>
      _uiPage.getText(_pvKey(isV2, package, version));

  @override
  Future setUIPackagePage(
          bool isV2, String package, String version, String data) =>
      _uiPage.setText(_pvKey(isV2, package, version), data);

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
    yield _uiPage.invalidate(_pvKey(false, package, null));
    yield _uiPage.invalidate(_pvKey(true, package, null));
    yield _uiIndexPage.invalidate(_indexPageKey(false, null));
    yield _uiIndexPage.invalidate(_indexPageKey(true, null));
    for (String platform in KnownPlatforms.all) {
      yield _uiIndexPage.invalidate(_indexPageKey(false, platform));
      yield _uiIndexPage.invalidate(_indexPageKey(true, platform));
    }
  }

  @override
  Future<String> getUIIndexPage(bool isV2, String platform) =>
      _uiIndexPage.getText(_indexPageKey(isV2, platform));

  @override
  Future setUIIndexPage(bool isV2, String platform, String content) =>
      _uiIndexPage.setText(_indexPageKey(isV2, platform), content);

  String _indexPageKey(bool isV2, String platform) {
    final String prefix = isV2 ? v2IndexUiPageKey : indexUiPageKey;
    return '$prefix/$platform';
  }

  String _pvKey(bool isV2, String package, String version) {
    final String prefix = isV2 ? '/experimental' : '';
    return '$prefix/$package/$version';
  }
}
