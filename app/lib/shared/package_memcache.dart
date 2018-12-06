// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.package_memcache;

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:pub_server/shelf_pubserver.dart';

import 'platform.dart' show KnownPlatforms;
import 'redis_cache.dart';

final Logger _logger = new Logger('pub.package_memcache');

abstract class UIPackageCache {
  // If [version] is `null` then it corresponds to the cache entry which can be
  // invalidated via [invalidateUiPackagePage].
  Future<String> getUIPackagePage(String package, String version);

  // If [version] is `null` then it corresponds to the cache entry which can be
  // invalidated via [invalidateUiPackagePage].
  Future setUIPackagePage(String package, String version, String data);

  Future<String> getUIIndexPage(String platform);

  Future setUIIndexPage(String platform, String content);

  Future invalidateUIPackagePage(String package);
}

/// Uses [SimpleMemcache] to set/get/invalidate metadata for packages.
class AppEnginePackageMemcache implements PackageCache, UIPackageCache {
  final SimpleMemcache _json;
  final SimpleMemcache _uiPage;
  final SimpleMemcache _uiIndexPage;

  AppEnginePackageMemcache()
      : _json = new SimpleMemcache(
          'AppEnginePackageMemcache/json/',
          _logger,
          Duration(minutes: 10),
        ),
        _uiPage = new SimpleMemcache(
          'AppEnginePackageMemcache/ui/',
          _logger,
          Duration(minutes: 10),
        ),
        _uiIndexPage = new SimpleMemcache(
          'AppEnginePackageMemcache/index/',
          _logger,
          Duration(minutes: 10),
        );

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
  Future invalidateUIPackagePage(String package) =>
      Future.wait(_invalidatePackage(package));

  @override
  Future invalidatePackageData(String package) =>
      Future.wait(_invalidatePackage(package, invalidateData: true));

  Iterable<Future> _invalidatePackage(String package,
      {bool invalidateData = false}) sync* {
    if (invalidateData) {
      yield _json.invalidate(package);
    }
    yield _uiPage.invalidate(_pvKey(package, null));
    yield _uiIndexPage.invalidate(_indexPageKey(null));
    for (String platform in KnownPlatforms.all) {
      yield _uiIndexPage.invalidate(_indexPageKey(platform));
    }
  }

  @override
  Future<String> getUIIndexPage(String platform) =>
      _uiIndexPage.getText(_indexPageKey(platform));

  @override
  Future setUIIndexPage(String platform, String content) =>
      _uiIndexPage.setText(_indexPageKey(platform), content);

  String _indexPageKey(String platform) {
    return '$platform';
  }

  String _pvKey(String package, String version) {
    return '$package/$version';
  }
}
