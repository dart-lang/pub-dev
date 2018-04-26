// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:memcache/memcache.dart';

import 'memcache.dart';
import 'search_service.dart';

final Logger _logger = new Logger('pub.search_memcache');

/// Sets the search memcache.
void registerSearchMemcache(SearchMemcache value) =>
    ss.register(#_searchMemcache, value);

/// The active search memcache.
SearchMemcache get searchMemcache => ss.lookup(#_searchMemcache);

class SearchMemcache {
  final SimpleMemcache _pkgSearch;

  SearchMemcache(Memcache memcache)
      : _pkgSearch = new SimpleMemcache(
          _logger,
          memcache,
          searchServiceResultPrefix,
          searchServiceResultExpiration,
        );

  Future<PackageSearchResult> getPackageSearchResult(String url) async {
    final content = await _pkgSearch.getText(url);
    if (content == null) return null;
    try {
      return new PackageSearchResult.fromJson(json.decode(content));
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
