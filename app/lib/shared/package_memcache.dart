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
  Future<String> getUIPageHtml(String url);

  Future setUIPageHtml(String url, String content, {Duration expiration});

  Future invalidateUIPackagePage(String package);
}

/// Uses a [Memache] to set/get/invalidate metadata for packages.
class AppEnginePackageMemcache implements PackageCache, UIPackageCache {
  final SimpleMemcache _json;
  final SimpleMemcache _uiPage;

  AppEnginePackageMemcache(Memcache memcache)
      : _json = new SimpleMemcache(
            _logger, memcache, packageJsonPrefix, packageJsonExpiration),
        _uiPage = new SimpleMemcache(
            _logger, memcache, packageUiPagePrefix, packageUiPageExpiration);

  @override
  Future<List<int>> getPackageData(String package) => _json.getBytes(package);

  @override
  Future setPackageData(String package, List<int> data) =>
      _json.setBytes(package, data);

  @override
  Future<String> getUIPageHtml(String url) => _uiPage.getText(url);

  @override
  Future setUIPageHtml(String url, String content, {Duration expiration}) =>
      _uiPage.setText(url, content, expiration: expiration);

  @override
  Future invalidateUIPackagePage(String package) {
    return Future.wait(_invalidateUrls(package).map(_uiPage.invalidate));
  }

  @override
  Future invalidatePackageData(String package) async {
    await _json.invalidate(package);
    await invalidateUIPackagePage(package);
  }

  List<String> _invalidateUrls(String package) => [
        '/packages/$package',
        '/experimental/packages/$package',
        '/',
        '/experimental',
      ];
}
