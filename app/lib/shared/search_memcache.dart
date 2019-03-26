// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';

import 'redis_cache.dart';
import 'search_service.dart';

final Logger _logger = Logger('pub.search_memcache');

/// Sets the search memcache.
void registerSearchMemcache(SearchMemcache value) =>
    ss.register(#_searchMemcache, value);

/// The active search memcache.
SearchMemcache get searchMemcache =>
    ss.lookup(#_searchMemcache) as SearchMemcache;

class SearchMemcache {
  final SimpleMemcache _pkgSearch;

  SearchMemcache()
      : _pkgSearch = SimpleMemcache(
          'SearchMemcache/',
          _logger,
          Duration(minutes: 10),
        );

  Future<PackageSearchResult> getPackageSearchResult(String url) async {
    final content = await _pkgSearch.getText(url);
    if (content == null) return null;
    try {
      return PackageSearchResult.fromJson(
          json.decode(content) as Map<String, dynamic>);
    } catch (e, st) {
      _logger.warning('Unable to deserialize PackageSearchResult.', e, st);
    }
    return null;
  }

  Future setPackageSearchResult(String url, PackageSearchResult result) async {
    if (result == null || !result.isLegit) return;
    final content = json.encode(result.toJson());
    await _pkgSearch.setText(url, content);
  }
}
